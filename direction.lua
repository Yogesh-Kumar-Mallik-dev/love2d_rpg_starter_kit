local Vector2 = require("vector2")

local Direction = {}

-- ========================
-- Facing enum (clockwise)
-- ========================

Direction.facing = {
    none = 0,

    north = 1,
    north_east = 2,
    east = 3,
    south_east = 4,
    south = 5,
    south_west = 6,
    west = 7,
    north_west = 8
}

local facing = Direction.facing

-- ========================
-- Facing → Vector
-- ========================

local facing_to_vector = {
    [facing.none] = Vector2.ZERO,

    [facing.north] = Vector2.NORTH,
    [facing.north_east] = Vector2.NORTH_EAST,
    [facing.east] = Vector2.EAST,
    [facing.south_east] = Vector2.SOUTH_EAST,
    [facing.south] = Vector2.SOUTH,
    [facing.south_west] = Vector2.SOUTH_WEST,
    [facing.west] = Vector2.WEST,
    [facing.north_west] = Vector2.NORTH_WEST
}

-- ========================
-- Vector → Facing (NO allocations)
-- ========================

local vector_to_facing = {
    [0] = {
        [-1] = facing.north,
        [0]  = facing.none,
        [1]  = facing.south
    },
    [1] = {
        [-1] = facing.north_east,
        [0]  = facing.east,
        [1]  = facing.south_east
    },
    [-1] = {
        [-1] = facing.north_west,
        [0]  = facing.west,
        [1]  = facing.south_west
    }
}

-- ========================
-- Name cache
-- ========================

local names = {
    [facing.none] = "none",

    [facing.north] = "north",
    [facing.north_east] = "north_east",
    [facing.east] = "east",
    [facing.south_east] = "south_east",
    [facing.south] = "south",
    [facing.south_west] = "south_west",
    [facing.west] = "west",
    [facing.north_west] = "north_west"
}

-- ========================
-- API
-- ========================

function Direction.vector(f)
    return facing_to_vector[f]
end

function Direction.name(f)
    return names[f]
end

function Direction.from_vector(v)
    local sx = (v.x > 0 and 1) or (v.x < 0 and -1) or 0
    local sy = (v.y > 0 and 1) or (v.y < 0 and -1) or 0

    return vector_to_facing[sx][sy]
end

-- ========================
-- Rotation (clockwise system)
-- ========================

function Direction.rotate_cw(f)
    if f == facing.none then return facing.none end
    return (f % 8) + 1
end

function Direction.rotate_acw(f)
    if f == facing.none then return facing.none end
    return (f == 1) and 8 or (f - 1)
end

function Direction.opposite(f)
    if f == facing.none then return facing.none end
    return ((f + 3) % 8) + 1
end

return Direction
