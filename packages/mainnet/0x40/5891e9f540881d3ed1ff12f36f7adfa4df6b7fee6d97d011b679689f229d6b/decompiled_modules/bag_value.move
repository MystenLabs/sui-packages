module 0x405891e9f540881d3ed1ff12f36f7adfa4df6b7fee6d97d011b679689f229d6b::bag_value {
    struct Value has store {
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

