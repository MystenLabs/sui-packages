module 0x222363c2aa700b387914d26441ea45f1caaec1219105c8c2efaf7f2ba643a52f::full_math_u64 {
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

