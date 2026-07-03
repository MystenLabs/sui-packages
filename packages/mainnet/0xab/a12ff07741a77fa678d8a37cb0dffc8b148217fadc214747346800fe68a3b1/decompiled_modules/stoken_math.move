module 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_math {
    public fun amount_to_shares(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : u64 {
        assert!(arg1 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_price());
        let v0 = (arg1 as u128) * (pow10(arg2) as u128);
        assert!(v0 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::math_overflow());
        let v1 = (arg0 as u128) * (1000000 as u128) * (pow10(arg3) as u128) / v0;
        assert!(v1 <= 18446744073709551615, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::math_overflow());
        assert!(v1 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::zero_shares_calculated());
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
        (((arg0 as u128) * v1 / ((10000 as u128) * (31536000 as u128) + v1)) as u64)
    }

    public fun calculate_price_deviation(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0 && arg1 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_price());
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
        assert!(arg0 + arg1 <= arg2, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::max_shares_per_user_exceeded());
    }

    public fun check_max_total_idle(arg0: u64, arg1: u64, arg2: u64) {
        if (arg2 == 18446744073709551615) {
            return
        };
        assert!(arg0 + arg1 <= arg2, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::max_total_idle_exceeded());
    }

    public fun check_max_total_shares(arg0: u64, arg1: u64, arg2: u64) {
        if (arg2 == 18446744073709551615) {
            return
        };
        assert!(arg0 + arg1 <= arg2, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::max_total_shares_exceeded());
    }

    public fun default_downside_cap_bps() : u64 {
        500
    }

    public fun default_max_deviation_bps() : u64 {
        100
    }

    public fun default_max_price_staleness_secs() : u64 {
        0
    }

    public fun default_swap_fee_bps() : u64 {
        10
    }

    public fun default_system_penalty_bps() : u64 {
        50
    }

    fun floor_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (10000 as u128);
        assert!(v0 <= 18446744073709551615, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::math_overflow());
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

    public fun max_withdrawal_ttl_secs() : u64 {
        2592000
    }

    public fun min_cooldown_secs() : u64 {
        60
    }

    public fun min_withdrawal_ttl_secs() : u64 {
        60
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::math_overflow());
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::math_overflow());
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

    public fun seconds_per_year() : u64 {
        31536000
    }

    public fun shares_to_amount(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : u64 {
        assert!(arg1 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_price());
        let v0 = (1000000 as u128) * (pow10(arg3) as u128);
        assert!(v0 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::math_overflow());
        let v1 = (arg0 as u128) * (arg1 as u128) * (pow10(arg2) as u128) / v0;
        assert!(v1 <= 18446744073709551615, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::math_overflow());
        assert!(v1 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::zero_amount_calculated());
        (v1 as u64)
    }

    public fun validate_fees(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 <= 1000, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_fee());
        assert!(arg1 <= 1000, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_fee());
        assert!(arg2 <= 500, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_fee());
    }

    public fun validate_new_limits(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        if (arg0 != 18446744073709551615) {
            assert!(arg0 <= 10000000000000000, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::limit_exceeds_maximum());
        };
        if (arg1 != 18446744073709551615) {
            assert!(arg1 <= 100000000000000, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::limit_exceeds_maximum());
        };
        if (arg2 != 18446744073709551615) {
            assert!(arg2 <= 100000000000000000, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::limit_exceeds_maximum());
        };
        assert!(arg3 <= 1000000000000000, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::limit_exceeds_maximum());
        if (arg1 != 18446744073709551615 && arg0 != 18446744073709551615) {
            assert!(arg1 <= arg0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_limit());
        };
        if (arg3 != 0 && arg1 != 18446744073709551615) {
            assert!(arg3 <= arg1, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_limit());
        };
    }

    public fun validate_swap_fee(arg0: u64) {
        assert!(arg0 <= 100, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_fee());
    }

    // decompiled from Move bytecode v7
}

