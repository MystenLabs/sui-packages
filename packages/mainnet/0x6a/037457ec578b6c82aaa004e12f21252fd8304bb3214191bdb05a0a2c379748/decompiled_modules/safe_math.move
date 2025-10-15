module 0x6a037457ec578b6c82aaa004e12f21252fd8304bb3214191bdb05a0a2c379748::safe_math {
    public fun checked_add(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = arg0 + arg1;
        if (v0 < arg0 || v0 < arg1) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(v0)
        }
    }

    public fun checked_div(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        if (arg1 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg0 / arg1)
        }
    }

    public fun checked_mul(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        if (arg0 == 0 || arg1 == 0) {
            return 0x1::option::some<u64>(0)
        };
        let v0 = arg0 * arg1;
        if (v0 / arg0 != arg1) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(v0)
        }
    }

    public fun checked_sub(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        if (arg0 < arg1) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg0 - arg1)
        }
    }

    // decompiled from Move bytecode v6
}

