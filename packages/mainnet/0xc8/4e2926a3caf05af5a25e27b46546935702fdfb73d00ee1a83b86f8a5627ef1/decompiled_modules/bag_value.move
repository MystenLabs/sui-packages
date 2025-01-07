module 0xc84e2926a3caf05af5a25e27b46546935702fdfb73d00ee1a83b86f8a5627ef1::bag_value {
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

