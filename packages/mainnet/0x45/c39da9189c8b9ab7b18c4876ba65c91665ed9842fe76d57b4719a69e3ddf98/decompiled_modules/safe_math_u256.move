module 0x45c39da9189c8b9ab7b18c4876ba65c91665ed9842fe76d57b4719a69e3ddf98::safe_math_u256 {
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

