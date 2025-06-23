module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position {
    struct Position has copy, drop, store {
        map_id: u64,
        x: u64,
        y: u64,
    }

    public fun get(arg0: &Position) : (u64, u64, u64) {
        (arg0.map_id, arg0.x, arg0.y)
    }

    public fun get_map_id(arg0: &Position) : u64 {
        arg0.map_id
    }

    public fun get_x(arg0: &Position) : u64 {
        arg0.x
    }

    public fun get_y(arg0: &Position) : u64 {
        arg0.y
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64) : Position {
        Position{
            map_id : arg0,
            x      : arg1,
            y      : arg2,
        }
    }

    public(friend) fun set(arg0: &mut Position, arg1: u64, arg2: u64, arg3: u64) {
        arg0.map_id = arg1;
        arg0.x = arg2;
        arg0.y = arg3;
    }

    public(friend) fun set_map_id(arg0: &mut Position, arg1: u64) {
        arg0.map_id = arg1;
    }

    public(friend) fun set_x(arg0: &mut Position, arg1: u64) {
        arg0.x = arg1;
    }

    public(friend) fun set_y(arg0: &mut Position, arg1: u64) {
        arg0.y = arg1;
    }

    // decompiled from Move bytecode v6
}

