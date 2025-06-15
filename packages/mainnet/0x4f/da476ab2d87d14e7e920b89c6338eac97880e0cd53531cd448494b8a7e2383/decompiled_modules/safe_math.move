module 0x4fda476ab2d87d14e7e920b89c6338eac97880e0cd53531cd448494b8a7e2383::safe_math {
    public fun checked_add(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = arg0 + arg1;
        if (v0 < arg0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(v0)
        }
    }

    public fun checked_mul(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        if (arg0 == 0 || arg1 == 0) {
            0x1::option::some<u64>(0)
        } else {
            let v1 = arg0 * arg1;
            if (v1 / arg0 != arg1) {
                0x1::option::none<u64>()
            } else {
                0x1::option::some<u64>(v1)
            }
        }
    }

    public fun checked_sub(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        if (arg0 >= arg1) {
            0x1::option::some<u64>(arg0 - arg1)
        } else {
            0x1::option::none<u64>()
        }
    }

    // decompiled from Move bytecode v6
}

