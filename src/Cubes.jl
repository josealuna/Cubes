module Cubes
using Combinatorics
export Cube, to_full, to_zero, isSolutionQ, fromList, fromPair, State, 
       isSolutionQ, cubes_hash, Visited, add_to_visited, addStateToVisited,      hasBeenVisited, pourAtoB, nextCubesUniOP, nextCubesBinaryOP, allCubesFromUniOP,
allCubesUniOP, allCombinations


include("Cube.jl")
include("State.jl")




end
