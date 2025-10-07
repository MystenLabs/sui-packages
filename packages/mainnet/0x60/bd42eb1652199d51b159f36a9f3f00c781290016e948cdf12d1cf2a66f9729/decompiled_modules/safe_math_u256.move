module 0x60bd42eb1652199d51b159f36a9f3f00c781290016e948cdf12d1cf2a66f9729::safe_math_u256 {
    public fun checked_add(arg0: u256, arg1: u256) : 0x1::option::Option<u256> {
        let v0 = arg0 + arg1;
        if (v0 < arg0 || v0 < arg1) {
            0x1::option::none<u256>()
        } else {
            0x1::option::some<u256>(v0)
        }
    }

    public fun checked_div(arg0: u256, arg1: u256) : 0x1::option::Option<u256> {
        if (arg1 == 0) {
            0x1::option::none<u256>()
        } else {
            0x1::option::some<u256>(arg0 / arg1)
        }
    }

    public fun checked_mul(arg0: u256, arg1: u256) : 0x1::option::Option<u256> {
        if (arg0 == 0 || arg1 == 0) {
            return 0x1::option::some<u256>(0)
        };
        let v0 = arg0 * arg1;
        if (arg1 != 0 && v0 / arg1 != arg0) {
            0x1::option::none<u256>()
        } else {
            0x1::option::some<u256>(v0)
        }
    }

    // decompiled from Move bytecode v6
}

