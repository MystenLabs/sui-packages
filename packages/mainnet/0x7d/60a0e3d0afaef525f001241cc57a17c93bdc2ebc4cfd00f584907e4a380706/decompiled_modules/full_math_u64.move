module 0x7d60a0e3d0afaef525f001241cc57a17c93bdc2ebc4cfd00f584907e4a380706::full_math_u64 {
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

