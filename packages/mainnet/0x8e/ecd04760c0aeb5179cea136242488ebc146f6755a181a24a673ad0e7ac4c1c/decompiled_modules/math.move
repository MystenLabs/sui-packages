module 0x8eecd04760c0aeb5179cea136242488ebc146f6755a181a24a673ad0e7ac4c1c::math {
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

