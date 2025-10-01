## --------------------------------------------------------
## -------------------Cube struct -------------------------
## --------------------------------------------------------
const Capacity = Int64     # Alias for the type

struct Cube                # Basic structure for the cubes
    capacity::Capacity     # Total capacity
    amount::Capacity       # How much is carrying
end

# To simplify the creation of states
const ListOfCubes = Vector{Cube}

cubes_hash(cubes::ListOfCubes) = reduce(vcat, map(cube->[cube.capacity, cube.amount],cubes))

const Visited = Set{Vector{Capacity}}

function add_to_visited(set::Visited, cubes::ListOfCubes)
    hash = cubes_hash(cubes)
    push!(set, hash)
end


## Operation on cubes
to_full(cube::Cube) = Cube(cube.capacity, cube.capacity)
to_zero(cube::Cube) = Cube(cube.capacity, 0)

# all posible combinations

## Creation of cubes from list
fromList(a::Vector{Capacity})::ListOfCubes = sort(map(e -> Cube(e,0),a), by=cube -> cube.capacity)
fromPair(pairs) = sort(map(p -> Cube(p...),pairs), by=cube -> cube.capacity)

## Functionality
function pourAtoB(A::Cube,B::Cube)::ListOfCubes
   toTransfer =  min(A.amount, (B.capacity - B.amount))
   [Cube(A.capacity, A.amount - toTransfer) ,
    Cube(B.capacity, B.amount + toTransfer)]
end


## All combinatios of two cubes
function allCombinations(cubes::ListOfCubes)
    all = collect(combinations(cubes,2))
    vcat(all, map(reverse,all))
end


## All combinations of cubes


# We need to create all the different combination 
# so from a list of Cubes, we need to create the
# for each cube in the list of cubes we need to 
# 1. create a state where one is change and the are the same
# 2. for each pair of cubes we create a new state where two cubes
# change and the rest remaing the same.
# 1 -- We need to change one take the rest and create a list with 
# the new and the rest.

## listOfCubes -> (uniOP -> Cube -> Cube) -> ListOfCubes
## Just makes one change 
## must order
function nextCubesUniOP(cubes::ListOfCubes,cube::Cube, uniOP) 
    set_test   = Set(cubes)
    element    = Set([cube])
    newElement = Set([uniOP(cube)])
    # substract the element
    rest       = setdiff(set_test,element)
    # add the new element
    sort(union(newElement, rest) |> collect, by=e -> e.capacity)
end

## listOfCubes -> (binaryOP -> [Cube, Cube] -> [Cube, Cube]) -> ListOfCubes
## Just makes one change 
## must order
function nextCubesBinaryOP(cubes::ListOfCubes,two::ListOfCubes, binaryOP) 
    set_test   = Set(cubes)
    elements   = Set(two)
    new_eles   = Set(binaryOP(two...))  # apply
    # substract the element
    rest       = setdiff(set_test,elements)
    # add the new element
    sort(union(new_eles, rest) |> collect, by=e -> e.capacity)
end

## Obtaining all possibilities for applying the uniOperator
function allCubesFromUniOP(cubes::ListOfCubes, uniOP)
        [nextCubesUniOP(cubes, cube, uniOP) for cube in cubes]
end

## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## obtaining all the  combinations using  the unary operators
function allCubesUniOP(cubes::ListOfCubes) 
    vcat(allCubesFromUniOP(cubes,to_full), allCubesFromUniOP(cubes,to_zero))
end

## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## all combinatios for binary operations
function allCubesBinaryOP(cubes::ListOfCubes)
    [nextCubesBinaryOP(cubes,par, pourAtoB) for par in  allCombinations(cubes)]
end


## Generate all possible cubes from a list of cubes
function generatesNewCubes(cubes::ListOfCubes, visited::Visited)

    uni = filter(l -> !hasBeenVisited(visited,l), allCubesUniOP(cubes))
    bin = filter(l -> !hasBeenVisited(visited,l), allCubesBinaryOP(cubes))
    

    no_inconsistence = cubes -> !any(cube -> cube.amount > cube.capacity,cubes)

    uni = filter(no_inconsistence, uni)
    bin = filter(no_inconsistence, bin)
    
    res = vcat(uni,bin)
    # adding to our visited space
    for cubes in res add_to_visited(visited, cubes) end
    res

end

