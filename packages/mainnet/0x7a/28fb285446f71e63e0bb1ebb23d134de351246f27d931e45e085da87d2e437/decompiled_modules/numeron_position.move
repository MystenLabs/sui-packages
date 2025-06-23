module 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_position {
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

