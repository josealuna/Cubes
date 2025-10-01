using Cubes
using Test
using Combinatorics

test_name_b = "Cubes generated-------"
test_name_s = "Solving---------------"
test_name_a = "All new possible cubes"
test_name_0 = "Generating -----------"
test_name_1 = "Bases ----------------"
test_name_2 = "Transfering operations"
test_name_3 = "Cubes functionality---"
test_name_4 = "Visited States--------"


@testset "$test_name_s" begin
    cubes = fromPair([[2, 0],[3,0],[7,0]])
    initial_state = State(cubes,5)
    visited::Visited = Set()
    
    @test visited |> length == 0


    first_iteration = nextStates(initial_state, visited)
    # we can generate the next states
    #@test first_iteration |> length == 12

    # tendremos que iterar
    filter(isSolutionQ, first_iteration) |> println
    #for s in first_iteration println(s) end 
end

@testset "$test_name_b" begin
    ## Some examples
    cubes = fromPair([[2, 0],[3,0],[7,0]])
    state_simple_sol = State(cubes,5)
    visited::Visited = Set()
    @test visited |> length == 0
    newCubes = generatesNewCubes(cubes, visited)
    @test  newCubes |> length == 4 
    @test visited   |> length == 4
    #for c in newCubes println(c) end
    solving(state_simple_sol, visited, 0) |> println
    
end

@testset "$test_name_a" begin
    ## Some examples
    cubes = fromPair([[2, 1],[3,2],[7,5]])
    state_simple_sol = State(cubes,7)
    visited::Visited = Set()
    solving(state_simple_sol, visited, 0)[1]  |> println
    
end

@testset "$test_name_0" begin
    # nextCubes(cubes::ListOfCubes,cube::Cube, uniOP) 
    cubes = fromPair([[2, 1],[3,2],[7,5]])
    element = Cube(2,1)
    @test nextCubesUniOP(cubes, element, to_full) == 
            [Cube(2, 2), Cube(3, 2), Cube(7, 5)] # Cube(2,1) is full  now
    
    @test nextCubesUniOP(cubes, element, to_zero) == 
            [Cube(2, 0), Cube(3, 2), Cube(7, 5)] # Cube(2,1) is empty  now


    @test nextCubesBinaryOP(cubes, fromPair([[7,5],[3,2]]), pourAtoB) ==
        [Cube(2, 1), Cube(3, 0), Cube(7, 7)] # transfer from 3,0 to 7,5
   # transfer from Cube(7,5) --> Cube(3,2)
    @test nextCubesBinaryOP(cubes, [Cube([7,5]...),Cube([3,2]...)], pourAtoB) ==
        [Cube(2, 1), Cube(3, 3), Cube(7, 4)] 


    #allCubesFromUniOP(cubes, to_full)   |> println
    #allCubesUniOP(cubes)                |> println

    #allCubesBinaryOP(cubes)              |> println
end
    
@testset "$test_name_1" begin
    # some test data
    cubes = fromPair([[2, 1],[3,2],[7,5]])
    # checking the behabiour of the combinations with cubes
    @test (collect(combinations([1,2, 3],2))) == [[1,2], [1,3], [2,3]]
    @test allCombinations(cubes) == 
        [[Cube(2,1), Cube(3,2)],
         [Cube(2,1), Cube(7,5)],
         [Cube(3,2), Cube(7,5)],
         [Cube(3,2), Cube(2,1)],
         [Cube(7,5), Cube(2,1)],
         [Cube(7,5), Cube(3,2)]
        ]
    # Cubes are equals
    @test Cube(1,2) == Cube(1,2)
    # member of a array3
    # Idea using set
    set_test = Set([Cube(1,0),Cube(3,1)])
    @test Cube(1,0) in set_test
    # the rest of the set
    @test setdiff(set_test,Set([Cube(1,0)])) == Set([Cube(3,1)])

    # testing some any. No one can have amount bigger than capacity
    @test !any(cube -> cube.amount > cube.capacity, fromPair([[2, 1],[3,2],[7,5]]))
end

@testset "$test_name_2"  begin
    
    A = Cube(5, 3)  # 3 to transfer
    B = Cube(3, 1)  # 2 to recieve
    Anew, Bnew = pourAtoB(A,B)

    @test A.capacity == Anew.capacity
    @test B.capacity == Bnew.capacity

    @test A.amount == 3
    @test B.amount == 1

    @test Anew.amount == 1
    @test Bnew.amount == 3 # full


end

@testset "$test_name_3" begin
    # Some data
    state_simple_sol = State(fromPair([[2, 1],[3,2],[7,5]]),5)

    # Write your tests here.
    @test fromList([1, 2]) == [Cube(1,0),Cube(2,0)]                         # ordered
    @test fromList([9,2,3]) == [Cube(2,0),Cube(3,0),Cube(9,0)]              # not ordered
    @test fromPair([[2, 1],[3,2]]) == [Cube(2,1),Cube(3,2)]                 # ordered
    @test fromPair([[2, 1],[3,2],[7,5]]) == [Cube(2,1),Cube(3,2),Cube(7,5)] # ordered
    @test fromPair([[7,5],[2, 1],[3,2]]) == [Cube(2,1),Cube(3,2),Cube(7,5)] # not ordered
    @test state_simple_sol.goal == 5
    @test isSolutionQ(state_simple_sol,5)
    @test !isSolutionQ(state_simple_sol,3)

end

@testset "$test_name_4" begin
    ## Some examples
    state_simple_sol = State(fromPair([[2, 1],[3,2],[7,5]]),5)
    visited::Visited = Set()

    # At the very begining the state has not been visited
    @test !hasBeenVisited(visited, state_simple_sol)
    @test (state_simple_sol.cubes |> cubes_hash) == [2, 1, 3, 2, 7, 5]
    # See how the set track the states which has been visited
    @test (state_simple_sol.cubes |> cubes_hash) == reduce(vcat, [[2, 1],[3,2],[7,5]])
    add_to_visited(visited, state_simple_sol.cubes)
    @test length(visited) == 1
    addStateToVisited(visited, state_simple_sol)
    @test length(visited) == 1
    @test hasBeenVisited(visited, state_simple_sol)
    add_to_visited(visited,fromPair([[2, 1],[3,2],[7,5]]))
    @test length(visited) == 1
    add_to_visited(visited,fromPair([[2, 1],[3,2],[7,7]]))
    @test length(visited) == 2


end
