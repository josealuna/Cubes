module Cubes
export Cube, to_full, to_zero, isSolutionQ, fromList, fromPair, State, isSolutionQ
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



end
