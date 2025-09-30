using Cubes
using Test



## Some examples
state_simple_sol = State(fromPair([[2, 1],[3,2],[7,5]]),5)


@testset "Bases" begin

    @test 1 == 1

end

@testset "Cubes.jl" begin
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
