module 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math {
    public fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div_down(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
    }

    public fun sub(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun sub_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

