module 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::full_math_u64 {
    public fun add_check(arg0: u64, arg1: u64) : bool {
        18446744073709551615 - arg0 >= arg1
    }

    public fun full_mul(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((full_mul(arg0, arg1) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    public fun mul_div_floor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((full_mul(arg0, arg1) / (arg2 as u128)) as u64)
    }

    public fun mul_div_round(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((full_mul(arg0, arg1) + ((arg2 as u128) >> 1)) / (arg2 as u128)) as u64)
    }

    public fun mul_shl(arg0: u64, arg1: u64, arg2: u8) : u64 {
        ((full_mul(arg0, arg1) << arg2) as u64)
    }

    public fun mul_shr(arg0: u64, arg1: u64, arg2: u8) : u64 {
        ((full_mul(arg0, arg1) >> arg2) as u64)
    }

    // decompiled from Move bytecode v6
}

