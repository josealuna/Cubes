module Cubes
using Combinatorics
export Cube, to_full, to_zero, isSolutionQ, fromList, fromPair, State, 
       isSolutionQ, cubes_hash, Visited, add_to_visited, addStateToVisited,      hasBeenVisited, pourAtoB, nextCubesUniOP, nextCubesBinaryOP, allCubesFromUniOP,
allCubesUniOP, allCombinations, allCubesBinaryOP, generatesNewCubes, nextStates, solving


include("Cube.jl")
include("State.jl")



function solving(initialState, visited, act = 0, iter=100)

   if isSolutionQ(initialState)
       initialState
   elseif act > iter
       "No solution found in $iter iterations"
   else 
       
       next_States = nextStates(initialState, visited)
       #println("Go in iter: $act $next_States")
       map(n-> solving(n, visited, act + 1, iter), next_States) 
   end
end

end #end of module
