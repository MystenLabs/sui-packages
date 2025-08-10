module 0x26496015cb830a48f4585a1192015fb4b7208e4067cfa21108f7092ad97a93ef::full_math_u64 {
    public fun full_mul(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((full_mul(arg0, arg1) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    public fun mul_div_floor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0x26496015cb830a48f4585a1192015fb4b7208e4067cfa21108f7092ad97a93ef::integer_error::div_by_zero());
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

