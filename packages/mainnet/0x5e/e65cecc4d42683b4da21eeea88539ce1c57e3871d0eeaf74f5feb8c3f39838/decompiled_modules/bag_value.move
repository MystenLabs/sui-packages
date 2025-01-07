module 0x5ee65cecc4d42683b4da21eeea88539ce1c57e3871d0eeaf74f5feb8c3f39838::bag_value {
    struct Value has copy, store {
        pool_id: 0x2::object::ID,
        x_to_y: bool,
    }

    public fun new(arg0: 0x2::object::ID, arg1: bool) : Value {
        Value{
            pool_id : arg0,
            x_to_y  : arg1,
        }
    }

    public fun unwrap(arg0: Value) : (0x2::object::ID, bool) {
        let Value {
            pool_id : v0,
            x_to_y  : v1,
        } = arg0;
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

