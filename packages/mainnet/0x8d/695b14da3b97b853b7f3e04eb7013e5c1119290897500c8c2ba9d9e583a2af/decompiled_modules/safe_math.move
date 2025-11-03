module 0x8d695b14da3b97b853b7f3e04eb7013e5c1119290897500c8c2ba9d9e583a2af::safe_math {
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

