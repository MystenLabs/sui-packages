module 0x97861353551b5edd639abb9d444c1f9d74d4d9de0b126456d3e4a8dbb39dddfb::stoken_math {
    public fun amount_to_shares(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : u64 {
        assert!(arg1 > 0, 3);
        let v0 = (arg1 as u128) * (pow10(arg2) as u128);
        assert!(v0 > 0, 8);
        let v1 = (arg0 as u128) * (1000000 as u128) * (pow10(arg3) as u128) / v0;
        assert!(v1 <= 18446744073709551615, 8);
        assert!(v1 > 0, 26);
        (v1 as u64)
    }

    public fun apply_basis_points(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        floor_fee(arg0, arg1)
    }

    public fun apply_fee(arg0: u64, arg1: u64) : (u64, u64) {
        if (arg1 == 0 || arg0 == 0) {
            return (arg0, 0)
        };
        let v0 = floor_fee(arg0, arg1);
        (arg0 - v0, v0)
    }

    public fun bps_precision() : u64 {
        10000
    }

    public fun calculate_management_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg0 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = (arg1 as u128) * (arg2 as u128);
        let v2 = (10000 as u128) * (31536000 as u128);
        assert!(v1 < v2, 8);
        let v3 = (arg0 as u128) * v1 / (v2 - v1);
        assert!(v3 <= 18446744073709551615, 8);
        (v3 as u64)
    }

    public fun calculate_management_fee_paid_secs(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = ((arg0 as u128) + (arg2 as u128)) * (arg1 as u128);
        let v1 = ((arg2 as u128) * (10000 as u128) * (31536000 as u128) + v0 - 1) / v0;
        assert!(v1 <= 18446744073709551615, 8);
        (v1 as u64)
    }

    public fun calculate_price_deviation(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0 && arg1 > 0, 3);
        let v0 = if (arg1 > arg0) {
            arg1 - arg0
        } else {
            arg0 - arg1
        };
        mul_div(v0, 10000, arg0)
    }

    public fun check_max_shares_per_user(arg0: u64, arg1: u64, arg2: u64) {
        if (arg2 == 18446744073709551615) {
            return
        };
        assert!(arg0 + arg1 <= arg2, 37);
    }

    public fun check_max_total_idle(arg0: u64, arg1: u64, arg2: u64) {
        if (arg2 == 18446744073709551615) {
            return
        };
        assert!(arg0 + arg1 <= arg2, 38);
    }

    public fun check_max_total_shares(arg0: u64, arg1: u64, arg2: u64) {
        if (arg2 == 18446744073709551615) {
            return
        };
        assert!(arg0 + arg1 <= arg2, 36);
    }

    public fun default_downside_cap_bps() : u64 {
        500
    }

    public fun default_max_deviation_bps() : u64 {
        100
    }

    public fun default_max_price_staleness_secs() : u64 {
        86400
    }

    public fun default_swap_fee_bps() : u64 {
        10
    }

    public fun default_system_penalty_bps() : u64 {
        50
    }

    fun floor_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (10000 as u128);
        assert!(v0 <= 18446744073709551615, 8);
        (v0 as u64)
    }

    public fun max_allowed_deviation_bps() : u64 {
        2000
    }

    public fun max_allowed_min_shares_to_mint() : u64 {
        1000000000000000
    }

    public fun max_allowed_shares_per_user() : u64 {
        100000000000000
    }

    public fun max_allowed_total_idle() : u64 {
        100000000000000000
    }

    public fun max_allowed_total_shares() : u64 {
        10000000000000000
    }

    public fun max_cooldown_secs() : u64 {
        31536000
    }

    public fun max_fee_bps() : u64 {
        1000
    }

    public fun max_management_fee_bps_per_year() : u64 {
        500
    }

    public fun max_manager_bypass_deviation_bps() : u64 {
        2000
    }

    public fun max_swap_fee_bps() : u64 {
        100
    }

    public fun max_system_penalty_bps() : u64 {
        500
    }

    public fun max_withdrawal_ttl_secs() : u64 {
        2592000
    }

    public fun min_cooldown_secs() : u64 {
        5
    }

    public fun min_withdrawal_ttl_secs() : u64 {
        60
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 8);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 8);
        (v0 as u64)
    }

    public fun no_limit() : u64 {
        18446744073709551615
    }

    fun pow10(arg0: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_precision() : u64 {
        1000000
    }

    public fun scale_nav_for_price(arg0: u64, arg1: u8, arg2: u8) : u64 {
        if (arg1 >= arg2) {
            arg0 * (pow10(arg1 - arg2) as u64)
        } else {
            arg0 / (pow10(arg2 - arg1) as u64)
        }
    }

    public fun seconds_per_year() : u64 {
        31536000
    }

    public fun select_swap_fee_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun shares_to_amount(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : u64 {
        assert!(arg1 > 0, 3);
        let v0 = (1000000 as u128) * (pow10(arg3) as u128);
        assert!(v0 > 0, 8);
        let v1 = (arg0 as u128) * (arg1 as u128) * (pow10(arg2) as u128) / v0;
        assert!(v1 <= 18446744073709551615, 8);
        assert!(v1 > 0, 27);
        (v1 as u64)
    }

    public fun validate_fees(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 <= 1000, 2);
        assert!(arg1 <= 1000, 2);
        assert!(arg2 <= 500, 2);
    }

    public fun validate_new_limits(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        if (arg0 != 18446744073709551615) {
            assert!(arg0 <= 10000000000000000, 44);
        };
        if (arg1 != 18446744073709551615) {
            assert!(arg1 <= 100000000000000, 44);
        };
        if (arg2 != 18446744073709551615) {
            assert!(arg2 <= 100000000000000000, 44);
        };
        assert!(arg3 <= 1000000000000000, 44);
        if (arg1 != 18446744073709551615 && arg0 != 18446744073709551615) {
            assert!(arg1 <= arg0, 43);
        };
        if (arg3 != 0 && arg1 != 18446744073709551615) {
            assert!(arg3 <= arg1, 43);
        };
    }

    public fun validate_swap_fee(arg0: u64) {
        assert!(arg0 <= 100, 2);
    }

    // decompiled from Move bytecode v7
}

