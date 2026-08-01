module 0xe338cb78badd67607b64c62661534572248a23500503c7e65f56bdba68e71952::math {
    public fun abs_diff_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun bps_complement_of(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 102);
        mul_div_u64(arg0, 10000 - arg1, 10000)
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun bps_of(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 102);
        mul_div_u64(arg0, arg1, 10000)
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 100);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 101);
        (v0 as u128)
    }

    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 100);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 18446744073709551615, 101);
        (v0 as u64)
    }

    public fun pow10(arg0: u8) : u256 {
        assert!(arg0 <= 77, 103);
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun rescale(arg0: u128, arg1: u8, arg2: u8) : u128 {
        let v0 = if (arg2 >= arg1) {
            (arg0 as u256) * pow10(arg2 - arg1)
        } else {
            (arg0 as u256) / pow10(arg1 - arg2)
        };
        assert!(v0 <= 340282366920938463463374607431768211455, 101);
        (v0 as u128)
    }

    public fun to_bps(arg0: u128, arg1: u128) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (10000 as u256) / (arg1 as u256);
        if (v0 > 18446744073709551615) {
            return (18446744073709551615 as u64)
        };
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

