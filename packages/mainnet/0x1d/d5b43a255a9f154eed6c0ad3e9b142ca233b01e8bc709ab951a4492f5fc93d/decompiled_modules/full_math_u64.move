module 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::full_math_u64 {
    public fun full_mul(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        (((full_mul(arg0, arg1) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    public fun mul_div_floor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        ((full_mul(arg0, arg1) / (arg2 as u128)) as u64)
    }

    public fun mul_div_round(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        (((full_mul(arg0, arg1) + ((arg2 as u128) >> 1)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

