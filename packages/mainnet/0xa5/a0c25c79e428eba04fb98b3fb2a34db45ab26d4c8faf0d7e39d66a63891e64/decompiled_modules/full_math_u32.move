module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u32 {
    public fun full_mul(arg0: u32, arg1: u32) : u64 {
        (arg0 as u64) * (arg1 as u64)
    }

    public fun mul_div_ceil(arg0: u32, arg1: u32, arg2: u32) : u32 {
        (((full_mul(arg0, arg1) + (arg2 as u64) - 1) / (arg2 as u64)) as u32)
    }

    public fun mul_div_floor(arg0: u32, arg1: u32, arg2: u32) : u32 {
        ((full_mul(arg0, arg1) / (arg2 as u64)) as u32)
    }

    public fun mul_div_round(arg0: u32, arg1: u32, arg2: u32) : u32 {
        (((full_mul(arg0, arg1) + ((arg2 as u64) >> 1)) / (arg2 as u64)) as u32)
    }

    public fun mul_shl(arg0: u32, arg1: u32, arg2: u8) : u32 {
        ((full_mul(arg0, arg1) << arg2) as u32)
    }

    public fun mul_shr(arg0: u32, arg1: u32, arg2: u8) : u32 {
        ((full_mul(arg0, arg1) >> arg2) as u32)
    }

    // decompiled from Move bytecode v6
}

