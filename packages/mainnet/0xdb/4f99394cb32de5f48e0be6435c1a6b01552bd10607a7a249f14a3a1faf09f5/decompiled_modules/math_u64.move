module 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::math_u64 {
    public fun add(arg0: u64, arg1: u64) : u64 {
        let (v0, v1) = overflowing_add(arg0, arg1);
        assert!(!v1, 100);
        v0
    }

    public fun full_mul(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_div_by_zero());
        (((full_mul(arg0, arg1) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    public fun mul_div_floor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_div_by_zero());
        ((full_mul(arg0, arg1) / (arg2 as u128)) as u64)
    }

    public fun mul_div_round(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_div_by_zero());
        (((full_mul(arg0, arg1) + ((arg2 as u128) >> 1)) / (arg2 as u128)) as u64)
    }

    public fun overflowing_add(arg0: u64, arg1: u64) : (u64, bool) {
        let v0 = (arg0 as u128) + (arg1 as u128);
        if (v0 > (18446744073709551615 as u128)) {
            (((v0 & 18446744073709551615) as u64), true)
        } else {
            ((v0 as u64), false)
        }
    }

    public fun overflowing_sub(arg0: u64, arg1: u64) : (u64, bool) {
        if (arg0 >= arg1) {
            (arg0 - arg1, false)
        } else {
            (18446744073709551615 - arg1 + arg0 + 1, true)
        }
    }

    public fun sub(arg0: u64, arg1: u64) : u64 {
        let (v0, v1) = overflowing_sub(arg0, arg1);
        assert!(!v1, 100);
        v0
    }

    // decompiled from Move bytecode v6
}

