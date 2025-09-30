using Cubes
using Test
using Combinatorics
    
@testset "Bases" begin
    # some test data
    cubes = fromPair([[2, 1],[3,2],[7,5]])
    # checking the behabiour of the combinations with cubes
    @test (collect(combinations([1,2, 3],2))) == [[1,2], [1,3], [2,3]]
    @test (collect(combinations(cubes,2))) == 
        [[Cube(2,1), Cube(3,2)],
         [Cube(2,1), Cube(7,5)],
         [Cube(3,2), Cube(7,5)]
        ]
end

@testset "Cubes.jl" begin
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

@testset "Visited States" begin
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
