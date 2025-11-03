module 0xa327c5227064c6bc0e6cf6c78c3099c96654e7a71354d54f5506dc423cdc3571::safe_math {
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

