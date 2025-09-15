module 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils {
    public fun full_mul(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    public fun mul_div_ceil(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((full_mul(arg0, arg1) + (arg2 as u256) - 1) / (arg2 as u256)) as u128)
    }

    public fun mul_div_floor(arg0: u128, arg1: u128, arg2: u128) : u128 {
        ((full_mul(arg0, arg1) / (arg2 as u256)) as u128)
    }

    public fun mul_div_round(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((full_mul(arg0, arg1) + ((arg2 as u256) >> 1)) / (arg2 as u256)) as u128)
    }

    public fun mul_shl(arg0: u128, arg1: u128, arg2: u8) : u128 {
        ((full_mul(arg0, arg1) << arg2) as u128)
    }

    public fun mul_shr(arg0: u128, arg1: u128, arg2: u8) : u128 {
        ((full_mul(arg0, arg1) >> arg2) as u128)
    }

    public fun pow(arg0: u64, arg1: u64) : u128 {
        let v0 = 1;
        let v1 = (arg0 as u128);
        while (arg1 > 0) {
            if (arg1 % 2 == 1) {
                v0 = v1 * v0;
            };
            v1 = v1 * v1;
            arg1 = arg1 / 2;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

