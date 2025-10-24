module 0x936ece5943bd0359541c9aab5b7e9211f0547e90db7e761c92e11d43603eaf71::safe_math_u256 {
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

