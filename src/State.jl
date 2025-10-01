## --------------------------------------------------------
## -------------------State struct ------------------------
## --------------------------------------------------------
struct State
    cubes::ListOfCubes   # Cubes with the capacities and amounts
    goal::Capacity       # Which is our goal
end
# is a solution
isSolutionQ(state::State, goal::Capacity) = any(cube -> cube.amount == goal, state.cubes)

isSolutionQ(state::State) = any(cube -> cube.amount == state.goal, state.cubes)


addStateToVisited(set::Visited, state::State) = add_to_visited(set, state.cubes)

hasBeenVisited(set::Visited, state::State)    = in(state.cubes |> cubes_hash, set)

## To see if a list of cubes has been visited
hasBeenVisited(set::Visited, cubes)    = in(cubes |> cubes_hash, set)

