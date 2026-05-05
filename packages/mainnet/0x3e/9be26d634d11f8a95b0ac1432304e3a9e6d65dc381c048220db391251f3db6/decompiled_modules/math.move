module 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math {
    public fun abs_diff_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun bps_denominator() : u128 {
        10000
    }

    public fun deviation_within_bps(arg0: u128, arg1: u128, arg2: u64) : bool {
        if (arg0 == 0) {
            return true
        };
        abs_diff_u128(arg0, arg1) <= mul_div(arg0, (arg2 as u128), 10000)
    }

    public fun ms_per_year() : u128 {
        31536000000
    }

    public fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::division_by_zero());
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::arithmetic_overflow());
        (v0 as u128)
    }

    public fun mul_mul_div(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        assert!(arg3 != 0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::division_by_zero());
        let v0 = (arg0 as u256) * (arg1 as u256) * (arg2 as u256) / (arg3 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::arithmetic_overflow());
        (v0 as u128)
    }

    public fun nav_scaled_to_usdc(arg0: u128) : u128 {
        arg0 / 1000000000000
    }

    public fun precision() : u128 {
        1000000000000000000
    }

    public fun share_price_scaled(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        mul_div(arg1, 1000000000, arg0)
    }

    public fun shares_for_deposit(arg0: u64, arg1: u128, arg2: u128) : u128 {
        if (arg1 == 0 && arg2 == 0) {
            return (arg0 as u128) * 1000000000 / 1000000
        };
        assert!(arg1 > 0 && arg2 > 0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::vault_bricked());
        mul_mul_div((arg0 as u128), 1000000000000, arg1, arg2)
    }

    public fun shares_scale() : u128 {
        1000000000
    }

    public fun usdc_to_nav_multiplier() : u128 {
        1000000000000
    }

    public fun usdc_to_nav_scaled(arg0: u128) : u128 {
        arg0 * 1000000000000
    }

    // decompiled from Move bytecode v7
}

