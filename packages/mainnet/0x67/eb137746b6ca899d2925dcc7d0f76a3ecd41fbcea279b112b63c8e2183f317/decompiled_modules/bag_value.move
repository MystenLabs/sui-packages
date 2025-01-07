module 0x67eb137746b6ca899d2925dcc7d0f76a3ecd41fbcea279b112b63c8e2183f317::bag_value {
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

