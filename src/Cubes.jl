module Cubes

# Write your package code here.

const Capacity = Int64

struct Cubes
    capacity::Capacity
    amount::Capacity
end
const ListOfCubes = Array{Cube,1s}

to_full(cube::Cube) = Cube(cube.capacity, cube.capacity)
to_zero(cube::Cube) = Cube(cube.capacity, 0)



end
