module Cubes
export Cube, to_full, to_zero, isSolutionQ, fromList, fromPair, State, 
       isSolutionQ, cubes_hash, Visited, add_to_visited, addStateToVisited, hasBeenVisited
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

to_full(cube::Cube) = Cube(cube.capacity, cube.capacity)
to_zero(cube::Cube) = Cube(cube.capacity, 0)

fromList(a) = sort(map(e -> Cube(e,0),a), by=cube -> cube.capacity)
fromPair(pairs) = sort(map(p -> Cube(p...),pairs), by=cube -> cube.capacity)

## --------------------------------------------------------
## -------------------State struct ------------------------
## --------------------------------------------------------
struct State
    cubes::ListOfCubes   # Cubes with the capacities and amounts
    goal::Capacity       # Which is our goal
end
# is a solution
isSolutionQ(state::State, goal::Capacity) = any(cube -> cube.amount == goal, state.cubes)

addStateToVisited(set::Visited, state::State) = add_to_visited(set, state.cubes)

hasBeenVisited(set::Visited, state::State)    = in(state.cubes |> cubes_hash, set)


# Basic functionality for checking if a state has been in the space of states
# Consider for easy a set of flatted arrays sorted








end
