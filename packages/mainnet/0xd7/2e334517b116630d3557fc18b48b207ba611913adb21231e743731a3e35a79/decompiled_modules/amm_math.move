module 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::amm_math {
    struct PreparedRateAnchor has copy, drop {
        value: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign,
        lower: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign,
        upper: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign,
    }

    struct YtRefundInterval has drop {
        low: u64,
        high: u64,
    }

    struct RefundLines has copy, drop {
        first: u64,
        left: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::modular_bounds::FloorLine,
        right: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::modular_bounds::FloorLine,
    }

    fun affine_rate_excludes_refund(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: PreparedRateAnchor, arg6: u256) : bool {
        let v0 = (18446744073709551616 as u256);
        let v1 = (arg0 as u256) + (arg1 as u256);
        let v2 = ((arg0 as u256) + (arg2 as u256)) * v0 / v1;
        if (v2 < v0 / 2) {
            return false
        };
        let v3 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg4) as u256);
        let v4 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((4 * v2 - 2 * v0) * v0, v3);
        let v5 = v4 + ((arg3 - arg2) as u256) * 4 * v0 / v1 * v0 / v3;
        let v6 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg5.upper) as u256);
        let (v7, v8) = if (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg5.upper)) {
            (v6 + v4, v6 + v5)
        } else {
            let v9 = if (v4 > v6) {
                v4 - v6
            } else {
                0
            };
            let v10 = if (v5 > v6) {
                v5 - v6
            } else {
                0
            };
            (v9, v10)
        };
        if (v7 * arg6 > (arg2 as u256) * v0 && v8 * arg6 > (arg3 as u256) * v0) {
            return true
        };
        let v11 = 4 * v2 - 2 * v0;
        let v12 = (v11 + refund_log_bonus(v11, 4 * ((arg0 as u256) + (arg3 as u256)) * v0 / v1 - 2 * v0)) * v1;
        let v13 = 4 * (v1 - 1);
        rational_refund_endpoint_excluded(v12 * v0, v13 * v0, v1 * v3, arg5.upper, arg2, arg6) && rational_refund_endpoint_excluded((v12 + 4 * ((arg3 - arg2) as u256) * v0) * v0, v13 * v0, v1 * v3, arg5.upper, arg3, arg6)
    }

    fun amount_to_fp(arg0: u64, arg1: bool) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign {
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::create_from_raw_value((arg0 as u128) * 18446744073709551616, arg1)
    }

    fun amount_to_unsigned_fp(arg0: u64) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64 {
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::from_uint64(arg0)
    }

    public(friend) fun apply_fee(arg0: u64, arg1: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64) : (u64, u64) {
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::truncate(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::mul(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::from_uint64(arg0), arg1));
        (arg0 - v0, v0)
    }

    public fun assert_valid_market_parameters(arg0: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg3: u64) {
        assert!(arg3 > 0, 1406);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg0) && !0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_zero(arg0), 1408);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::greater_or_equal(arg1, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::one()), 1409);
        assert!((0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg0) as u256) * (31536000000 as u256) <= 340282366920938463463374607431768211455, 1410);
        assert!((0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg0) as u256) * (31536000000 as u256) * (18446744073709551616 as u256) / (arg3 as u256) / (18446744073709551616 as u256) > 0, 1408);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_exp_input_supported(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::ln(arg1)), 1411);
        let v0 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg2) as u256) * (arg3 as u256);
        let v1 = if (v0 % (31536000000 as u256) == 0) {
            0
        } else {
            1
        };
        let v2 = v0 / (31536000000 as u256) + v1;
        assert!(v2 <= 340282366920938463463374607431768211455, 1410);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_exp_positive_ceil_supported((v2 as u128)), 1411);
    }

    fun asset_in_at_rate(arg0: u64, arg1: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign) : 0x1::option::Option<u64> {
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::div(arg1, arg2);
        if (!0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::greater_or_equal(v0, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::one())) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((arg0 as u128), 18446744073709551616, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v0)) as u64))
    }

    fun asset_in_for_pt_out(arg0: u64, arg1: u64, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg3: PreparedRateAnchor, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: u64) : 0x1::option::Option<u64> {
        let (v0, v1) = try_get_exchange_rate(arg0, arg1, arg2, arg3, amount_to_fp(arg5, true));
        if (!v0) {
            return 0x1::option::none<u64>()
        };
        asset_in_at_rate(arg5, v1, arg4)
    }

    public(friend) fun asset_to_sy_amount_ceil(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 1407);
        (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((arg0 as u128), 18446744073709551616, arg1) as u64)
    }

    public(friend) fun asset_to_sy_amount_floor(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 1407);
        (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg0 as u128), 18446744073709551616, arg1) as u64)
    }

    public fun below_pt_limit(arg0: u64, arg1: u64, arg2: u128) : bool {
        let v0 = (arg1 as u256) * (arg2 as u256) / (18446744073709551616 as u256);
        if (arg0 == 0 || v0 == 0) {
            return false
        };
        let v1 = (arg0 as u256) * (18446744073709551616 as u256) / ((arg0 as u256) + v0);
        v1 > 0 && v1 < ((18446744073709551616 * 96 / 100) as u256)
    }

    fun buy_yt_asset_loss_prepared(arg0: u64, arg1: u64, arg2: u128, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg4: PreparedRateAnchor, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: u64) : (u64, u64, u64) {
        let v0 = (((arg6 as u256) * (arg2 as u256) / (18446744073709551616 as u256)) as u64);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let (v1, v2) = try_get_exchange_rate(arg0, arg1, arg3, arg4, amount_to_fp(v0, false));
        if (!v1) {
            return (v0, 0, v0)
        };
        let v3 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((v0 as u128), 18446744073709551616, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v2)), 18446744073709551616, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg5)) as u64);
        (v0, v3, v0 - v3)
    }

    public(friend) fun buy_yt_mint_limit(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 <= 1) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg4 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = (18446744073709551616 as u256);
        let v2 = 18446744073709551615;
        let v3 = (((18446744073709551616 * 96 / 100) as u256) * ((arg0 as u256) + (arg2 as u256)) - 1) / v1;
        if (v3 <= (arg0 as u256)) {
            return 0
        };
        (0x1::u256::min(0x1::u256::min(v2, ((0x1::u256::min(v2 - (arg0 as u256), v3 - (arg0 as u256)) + 1) * v1 - 1) / (arg3 as u256)), (arg4 as u256) + (arg1 as u256) - 1) as u64)
    }

    public fun calc_lp_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg0 == 0) {
            (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::sqrt::sqrt_u128((arg3 as u128) * (arg4 as u128)) as u64)
        } else {
            let v1 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg3 as u128), (arg0 as u128), (arg1 as u128));
            let v2 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg4 as u128), (arg0 as u128), (arg2 as u128));
            let v3 = if (v1 < v2) {
                v1
            } else {
                v2
            };
            (v3 as u64)
        }
    }

    public(friend) fun calc_proportion(arg0: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg1: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64 {
        let (v0, v1) = try_calc_trade_proportion(arg0, arg1, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::zero());
        assert!(v0, 1402);
        v1
    }

    fun current_rate_anchor(arg0: u64, arg1: u64, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: u64) : PreparedRateAnchor {
        assert!(arg0 > 0 && arg1 > 0, 1412);
        get_rate_anchor(arg0, arg1, arg3, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg2), arg5)
    }

    public(friend) fun fee_rate_factor(arg0: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg1: u64) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign {
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::exp_positive_ceil(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg0), (arg1 as u128), (31536000000 as u128)))
    }

    public(friend) fun get_exchange_rate(arg0: u64, arg1: u64, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg3: PreparedRateAnchor, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign {
        let (v0, v1) = try_get_exchange_rate(arg0, arg1, arg2, arg3, arg4);
        assert!(v0, 1401);
        v1
    }

    public(friend) fun get_exchange_rate_from_implied_rate(arg0: u128, arg1: u64) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign {
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::exp(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::create_from_raw_value(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor(arg0, (arg1 as u128), (31536000000 as u128)), true))
    }

    public fun get_initial_ln_implied_rate(arg0: u64, arg1: u64, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg4: u64) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64 {
        assert!(arg0 > 0 && arg1 > 0, 1412);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg2) && !0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_zero(arg2), 1408);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::greater_or_equal(arg3, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::one()), 1409);
        let (v0, v1) = try_calc_trade_proportion(amount_to_unsigned_fp(arg0), amount_to_unsigned_fp(arg1), 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::zero());
        let v2 = if (v0) {
            if (!0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::is_zero(v1)) {
                0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(v1) < 18446744073709551616 * 96 / 100
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 1412);
        let v3 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::add(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::div(log_proportion(v1), get_rate_scalar(arg2, arg4)), arg3);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::greater_or_equal(v3, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::one()), 1412);
        let v4 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::ln(v3);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_exp_input_supported(v4), 1411);
        let v5 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v4) as u256) * (31536000000 as u256) / (arg4 as u256);
        assert!(v5 <= 340282366920938463463374607431768211455, 1410);
        let v6 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::create_from_raw_value((v5 as u128));
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_exp_input_supported(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::create_from_raw_value(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(v6), (arg4 as u128), (31536000000 as u128)), true)), 1411);
        v6
    }

    public(friend) fun get_ln_implied_rate(arg0: u64, arg1: u64, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg3: PreparedRateAnchor, arg4: u64) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64 {
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::create_from_raw_value(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::ln(get_exchange_rate(arg0, arg1, arg2, arg3, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::zero()))), (31536000000 as u128), (arg4 as u128)))
    }

    public(friend) fun get_rate_anchor(arg0: u64, arg1: u64, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg3: u128, arg4: u64) : PreparedRateAnchor {
        let v0 = log_proportion_argument(calc_proportion(amount_to_unsigned_fp(arg0), amount_to_unsigned_fp(arg1)));
        let (v1, v2) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::ln_bounds(v0);
        let v3 = if (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v0) >= 18446744073709551616) {
            v1
        } else {
            v2
        };
        let v4 = get_exchange_rate_from_implied_rate(arg3, arg4);
        PreparedRateAnchor{
            value : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::sub(v4, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::div(v3, arg2)),
            lower : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::sub(v4, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::div_bound(v2, arg2, true)),
            upper : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::sub(v4, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::div_bound(v1, arg2, false)),
        }
    }

    public(friend) fun get_rate_scalar(arg0: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u64) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(arg1 > 0, 1406);
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::mul(arg0, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::div(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::create_from_raw_value((31536000000 as u128) * 18446744073709551616, true), 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::create_from_raw_value((arg1 as u128) * 18446744073709551616, true)));
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(v0) && !0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_zero(v0), 1404);
        v0
    }

    public(friend) fun has_buy_yt_refund(arg0: u64, arg1: u64, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg3: PreparedRateAnchor, arg4: u256, arg5: u64, arg6: &0x1::option::Option<0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::log_exp::LnUpperContext>) : bool {
        let v0 = (18446744073709551616 as u256);
        let v1 = (arg5 as u256) * v0 / arg4;
        if (v1 < v0) {
            return false
        };
        let v2 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg3.upper) as u256);
        if (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg3.upper) && v2 >= v0) {
            let v3 = ((arg0 as u256) + (arg5 as u256)) * v0 / ((arg0 as u256) + (arg1 as u256));
            if (v3 >= v0) {
                return false
            };
            if (v3 >= v0 / 2) {
                if (v1 < v2) {
                    return false
                };
                let v4 = (v1 - v2) * (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg2) as u256) / v0;
                if (v4 >= 340282366920938463463374607431768211455) {
                    return true
                };
                return 0x1::option::is_some<0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::log_exp::LnUpperContext>(arg6) && 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::log_exp::ln_upper_le_cached(0x1::option::borrow<0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::log_exp::LnUpperContext>(arg6), ((v3 * v0 / (v0 - v3)) as u128), (v4 as u128)) || 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::log_exp::ln_upper_le(((v3 * v0 / (v0 - v3)) as u128), (v4 as u128))
            };
        };
        let (v5, v6) = try_get_exchange_rate(arg0, arg1, arg2, arg3, amount_to_fp(arg5, false));
        v5 && (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v6) as u256) <= v1
    }

    fun last_floor_refund_candidate(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: PreparedRateAnchor, arg6: u256) : 0x1::option::Option<u64> {
        let v0 = (18446744073709551616 as u256);
        let v1 = (arg0 as u256) + (arg1 as u256);
        let v2 = ((arg0 as u256) + (arg2 as u256)) * v0 / v1;
        if (v2 < v0 / 2) {
            return 0x1::option::some<u64>(arg3)
        };
        let v3 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg4) as u256);
        let v4 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg5.upper);
        let v5 = if (v4) {
            v3 * (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg5.upper) as u256) / v0
        } else {
            0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(v3 * (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg5.upper) as u256), v0)
        };
        let v6 = arg6 * v5;
        let v7 = arg6 * (2 * v0 - refund_log_bonus(4 * v2 - 2 * v0, 4 * ((arg0 as u256) + (arg3 as u256)) * v0 / v1 - 2 * v0));
        let v8 = v7;
        let v9 = 4 * arg6;
        let v10 = v9 * ((arg0 as u256) + (arg3 as u256)) * v0 / v1;
        let v11 = v3 * (arg3 as u256);
        if (!v4) {
            let v12 = if (v6 >= v10) {
                true
            } else if (v7 >= v10) {
                true
            } else {
                v11 >= v10
            };
            if (v12) {
                return 0x1::option::some<u64>(arg3)
            };
            v8 = v7 + v6;
        };
        let v13 = if (v4) {
            v6
        } else {
            0
        };
        let v14 = v11 + v8;
        if (v14 < v13) {
            return 0x1::option::none<u64>()
        };
        if (v14 - v13 >= v10) {
            return 0x1::option::some<u64>(arg3)
        };
        let v15 = arg2;
        if (v3 * (arg2 as u256) + v8 < v13) {
            v15 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(v13 - v8, v3) as u64);
        };
        let v16 = ((arg0 as u256) + (v15 as u256)) * v0;
        let v17 = v3 * (v15 as u256) + v8 - v13;
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::modular_bounds::last_floor_leq(v15, arg3, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::modular_bounds::floor_line(((v16 / v1) as u128), 18446744073709551616, ((v16 % v1) as u128), (v1 as u128)), 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::modular_bounds::floor_line(((v17 / v9) as u128), (v3 as u128), ((v17 % v9) as u128), (v9 as u128)))
    }

    fun last_local_refund_candidate(arg0: &0x1::option::Option<RefundLines>, arg1: u64) : 0x1::option::Option<u64> {
        if (0x1::option::is_none<RefundLines>(arg0)) {
            return 0x1::option::some<u64>(arg1)
        };
        let v0 = 0x1::option::borrow<RefundLines>(arg0);
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::modular_bounds::last_floor_leq(v0.first, arg1, v0.left, v0.right)
    }

    fun last_refundable_buy_yt_prepared(arg0: u64, arg1: u64, arg2: u128, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg4: PreparedRateAnchor, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: u64) : 0x1::option::Option<u64> {
        let v0 = (18446744073709551616 as u256);
        let v1 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((arg2 as u256), v0);
        let v2 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(v1 * (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg5) as u256), v0);
        if (v2 > 18446744073709551615) {
            return 0x1::option::none<u64>()
        };
        let v3 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(v1 * v0, (arg2 as u256));
        if (v3 > (arg6 as u256)) {
            return 0x1::option::none<u64>()
        };
        let v4 = YtRefundInterval{
            low  : (v3 as u64),
            high : arg6,
        };
        let v5 = 0x1::vector::empty<YtRefundInterval>();
        0x1::vector::push_back<YtRefundInterval>(&mut v5, v4);
        while (!0x1::vector::is_empty<YtRefundInterval>(&v5)) {
            let YtRefundInterval {
                low  : v6,
                high : v7,
            } = 0x1::vector::pop_back<YtRefundInterval>(&mut v5);
            if (v7 - v6 < 4096) {
                let v8 = v7;
                let v9 = (((v7 as u256) * (arg2 as u256) / v0) as u64);
                let v10 = (((v6 as u256) * (arg2 as u256) / v0) as u64);
                let v11 = prepare_refund_lines(arg0, arg1, v10, v9, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::create_from_raw_value(((((arg0 as u256) + (v10 as u256)) * v0 / ((arg0 as u256) + (arg1 as u256))) as u128)), arg3, arg4, v2);
                let v12 = ((arg0 as u256) + (v9 as u256)) * v0 / ((arg0 as u256) + (arg1 as u256));
                let v13 = if (v12 >= v0 / 2) {
                    if (v12 < v0) {
                        if (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg4.upper)) {
                            0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg4.upper) >= 18446744073709551616
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                let v14 = if (v13) {
                    0x1::option::some<0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::log_exp::LnUpperContext>(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::log_exp::prepare_ln_upper(((v12 * v0 / (v0 - v12)) as u128)))
                } else {
                    0x1::option::none<0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::log_exp::LnUpperContext>()
                };
                let v15 = v14;
                loop {
                    let v16 = last_local_refund_candidate(&v11, (((v8 as u256) * (arg2 as u256) / v0) as u64));
                    if (0x1::option::is_none<u64>(&v16)) {
                        break
                    };
                    let v17 = ((((0x1::u256::min((v8 as u256), (((0x1::option::destroy_some<u64>(v16) as u256) + 1) * v0 - 1) / (arg2 as u256)) as u64) as u256) * (arg2 as u256) / v0) as u64);
                    if (v17 == 0) {
                        break
                    };
                    let v18 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((v17 as u256) * v0, (arg2 as u256)) as u64);
                    if (v18 < v6) {
                        break
                    };
                    if (has_buy_yt_refund(arg0, arg1, arg3, arg4, v2, v17, &v15)) {
                        return 0x1::option::some<u64>(v18)
                    };
                    if (v18 == v6) {
                        break
                    };
                    v8 = v18 - 1;
                };
            } else {
                let v19 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((((v6 - 1) as u256) * (arg2 as u256) / v0 + 1) * v0, (arg2 as u256));
                let v20 = (v7 as u256) * (arg2 as u256) / v0;
                let v21 = v20;
                let v22 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(v20 * v0, (arg2 as u256));
                if (v19 > v22 || v19 > (v7 as u256)) {
                    continue
                };
                let v23 = (v19 as u64);
                let v24 = (v22 as u64);
                let v25 = (((v23 as u256) * (arg2 as u256) / v0) as u64);
                if (affine_rate_excludes_refund(arg0, arg1, v25, (v20 as u64), arg3, arg4, v2)) {
                    continue
                };
                let v26 = last_floor_refund_candidate(arg0, arg1, v25, (v20 as u64), arg3, arg4, v2);
                if (0x1::option::is_none<u64>(&v26)) {
                    continue
                };
                let v27 = (0x1::option::destroy_some<u64>(v26) as u256);
                if (v27 < v20) {
                    let v28 = ((v27 + 1) * v0 - 1) / (arg2 as u256);
                    if (v28 < (v23 as u256)) {
                        continue
                    };
                    let v29 = v28 * (arg2 as u256) / v0;
                    v21 = v29;
                    v24 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(v29 * v0, (arg2 as u256)) as u64);
                };
                let (v30, v31) = try_calc_trade_proportion(amount_to_unsigned_fp(arg0), amount_to_unsigned_fp(arg1), amount_to_fp(v25, false));
                assert!(v30, 1412);
                let (v32, v33) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::ln_bounds(log_proportion_argument(v31));
                if (local_tangent_excludes_refund(arg0, arg1, v25, (v21 as u64), v31, v32, arg3, arg4, v2)) {
                    continue
                };
                let v34 = prepare_refund_lines(arg0, arg1, v25, (v21 as u64), v31, arg3, arg4, v2);
                let v35 = last_local_refund_candidate(&v34, (v21 as u64));
                if (0x1::option::is_none<u64>(&v35)) {
                    continue
                };
                let v36 = (0x1::option::destroy_some<u64>(v35) as u256);
                if (v36 < v21) {
                    let v37 = ((v36 + 1) * v0 - 1) / (arg2 as u256);
                    if (v37 < (v23 as u256)) {
                        continue
                    };
                    let v38 = v37 * (arg2 as u256) / v0;
                    v21 = v38;
                    v24 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(v38 * v0, (arg2 as u256)) as u64);
                };
                let (v39, v40) = try_rate_from_log_bound(v33, arg4.upper, arg3, true);
                if (!v39) {
                    continue
                };
                let v41 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v40) as u256);
                if (v41 > v21 * v0) {
                    continue
                };
                let v42 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(v2 * v41, v0);
                if (v42 > v21) {
                    continue
                };
                let (_, v44, _) = buy_yt_asset_loss_prepared(arg0, arg1, arg2, arg3, arg4, arg5, v24);
                if ((v44 as u256) >= v1) {
                    return 0x1::option::some<u64>(v24)
                };
                if (v23 == v24) {
                    continue
                };
                let v46 = 0x1::u64::max(v23, (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(v42 * v0, (arg2 as u256)) as u64));
                let v47 = v46 + (v24 - v46) / 2;
                let v48 = YtRefundInterval{
                    low  : v46,
                    high : v47,
                };
                0x1::vector::push_back<YtRefundInterval>(&mut v5, v48);
                if (v47 < v24) {
                    let v49 = YtRefundInterval{
                        low  : v47 + 1,
                        high : v24,
                    };
                    0x1::vector::push_back<YtRefundInterval>(&mut v5, v49);
                };
            };
        };
        0x1::option::none<u64>()
    }

    public fun ln_rate_after_reserve_change(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg7: u64) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64 {
        let v0 = get_rate_scalar(arg6, arg7);
        get_ln_implied_rate(arg2, sy_to_asset_amount(arg3, arg4), v0, get_rate_anchor(arg0, sy_to_asset_amount(arg1, arg4), v0, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg5), arg7), arg7)
    }

    fun local_tangent_excludes_refund(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg7: PreparedRateAnchor, arg8: u256) : bool {
        let v0 = (18446744073709551616 as u256);
        let v1 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg4) as u256);
        if (v1 < v0 / 2) {
            return false
        };
        let v2 = (arg0 as u256) + (arg1 as u256);
        let v3 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg6) as u256);
        let v4 = v0 * v0 * v0 / v1 * (v0 - v1);
        let v5 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg5) as u256) * v0 * v2;
        let v6 = v0 * v2 + v4 * (v2 - 1 - ((arg0 as u256) + (arg2 as u256)) * v0 % v2);
        rational_refund_endpoint_excluded(v5, v6, v2 * v3, arg7.upper, arg2, arg8) && rational_refund_endpoint_excluded(v5 + v4 * ((arg3 - arg2) as u256) * v0, v6, v2 * v3, arg7.upper, arg3, arg8)
    }

    public(friend) fun log_proportion(arg0: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign {
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::ln(log_proportion_argument(arg0))
    }

    fun log_proportion_argument(arg0: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::one();
        assert!(!0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::is_zero(arg0), 1405);
        assert!(!0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::equal(arg0, v0), 1403);
        assert!(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::less(arg0, v0), 1402);
        to_positive_signed(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::div(arg0, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::sub(v0, arg0)))
    }

    fun non_keep_yt_split_is_repayable_prepared(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: PreparedRateAnchor, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg7: u64) : bool {
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg7 as u128), arg3, 18446744073709551616);
        let v1 = if (v0 == 0) {
            true
        } else if (v0 > 18446744073709551615) {
            true
        } else {
            v0 >= (arg0 as u128)
        };
        if (v1) {
            return false
        };
        let v2 = (v0 as u64);
        let v3 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((v2 as u128), 18446744073709551616, arg3);
        if (v3 == 0 || v3 > 18446744073709551615) {
            return false
        };
        let (v4, _) = quote_sy_for_exact_pt_prepared(arg0, arg1, arg2, arg4, arg5, arg6, v2);
        v4 > 0 && v4 <= (v3 as u64)
    }

    fun prepare_refund_lines(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: PreparedRateAnchor, arg7: u256) : 0x1::option::Option<RefundLines> {
        if (arg3 - arg2 > 1048576) {
            return 0x1::option::none<RefundLines>()
        };
        let v0 = (18446744073709551616 as u256);
        let v1 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg4) as u256);
        if (v1 < v0 / 2) {
            return 0x1::option::none<RefundLines>()
        };
        let v2 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg5) as u256);
        let v3 = 4294967296;
        let v4 = v1 * v0 / (v0 - v1);
        let v5 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::log_exp::prepare_ln_upper((v4 as u128));
        let v6 = ((arg0 as u256) + (arg3 as u256)) * v0 / ((arg0 as u256) + (arg1 as u256));
        let v7 = if (v6 * v0 / (v0 - v6) - v4 == v0 * v0 / (v0 - v1) * (v0 - v1) * (v6 - v1)) {
            0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(v6 * v0 % (v0 - v6) << 96, (v0 - v6) * v4)
        } else {
            0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(79228162514264337593543950336, v4)
        };
        let v8 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::log_exp::lower_q96(&v5) + (v1 * v0 % (v0 - v1) << 96) / (v0 - v1) * (v4 + 1);
        if (v8 <= v7) {
            return 0x1::option::none<RefundLines>()
        };
        let v9 = v0 * v0 * v0 / v1 * (v0 - v1) / v3;
        let v10 = arg7 * v9;
        if (v10 > 340282366920938463463374607431768211455) {
            return 0x1::option::none<RefundLines>()
        };
        let v11 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v12 = if (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg6.upper)) {
            (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg6.upper) as u256) * v2 / v3
        } else {
            0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg6.upper) as u256) * v2, v3)
        };
        let v13 = v8 - v7;
        let v14 = v9 * v1;
        let v15 = if (v12 > v11 / arg7) {
            true
        } else if (v13 > v11 / arg7) {
            true
        } else {
            v14 > v11 / arg7
        };
        if (v15) {
            return 0x1::option::none<RefundLines>()
        };
        let v16 = v14 * arg7;
        let v17 = (arg2 as u256) * v2 * v3;
        if (v16 > v11 - v17) {
            return 0x1::option::none<RefundLines>()
        };
        let v18 = v16 + v17;
        let v19 = v18;
        let v20 = v13 * arg7;
        let v21 = v20;
        let v22 = v12 * arg7;
        if (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg6.upper)) {
            if (v20 > v11 - v22) {
                return 0x1::option::none<RefundLines>()
            };
            v21 = v20 + v22;
        } else {
            if (v18 > v11 - v22) {
                return 0x1::option::none<RefundLines>()
            };
            v19 = v18 + v22;
        };
        if (v19 < v21) {
            return 0x1::option::none<RefundLines>()
        };
        let v23 = v19 - v21;
        let v24 = v2 * v3;
        if (v24 > 340282366920938463463374607431768211455 || v23 / v10 > 340282366920938463463374607431768211455) {
            return 0x1::option::none<RefundLines>()
        };
        let v25 = (arg0 as u256) + (arg1 as u256);
        let v26 = ((arg0 as u256) + (arg2 as u256)) * v0;
        let v27 = RefundLines{
            first : arg2,
            left  : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::modular_bounds::floor_line(((v26 / v25) as u128), 18446744073709551616, ((v26 % v25) as u128), (v25 as u128)),
            right : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::modular_bounds::floor_line(((v23 / v10) as u128), (v24 as u128), ((v23 % v10) as u128), (v10 as u128)),
        };
        0x1::option::some<RefundLines>(v27)
    }

    public fun quote_exact_pt_for_sy_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg7: u64, arg8: u64) : (u64, u64, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64) {
        let v0 = sy_to_asset_amount(arg1, arg2);
        let v1 = if (arg7 == 0) {
            true
        } else if (arg0 == 0) {
            true
        } else if (v0 == 0) {
            true
        } else {
            arg7 > 18446744073709551615 - arg0
        };
        if (v1) {
            return (0, 0, arg3)
        };
        let v2 = get_rate_scalar(arg4, arg8);
        let v3 = current_rate_anchor(arg0, v0, arg3, v2, arg5, arg8);
        let (v4, v5) = quote_exact_pt_for_sy_prepared(arg0, arg1, v0, arg2, v2, v3, fee_rate_factor(arg6, arg8), arg7);
        if (v4 == 0 || !below_pt_limit(arg0 + arg7, arg1 - v4, arg2)) {
            return (0, 0, arg3)
        };
        (v4, v5, get_ln_implied_rate(arg0 + arg7, sy_to_asset_amount(arg1 - v4, arg2), v2, v3, arg8))
    }

    fun quote_exact_pt_for_sy_prepared(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: PreparedRateAnchor, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg7: u64) : (u64, u64) {
        if (arg7 == 0 || arg7 > 18446744073709551615 - arg0) {
            return (0, 0)
        };
        let (v0, v1) = try_get_exchange_rate(arg0, arg2, arg4, arg5, amount_to_fp(arg7, false));
        if (!v0) {
            return (0, 0)
        };
        let v2 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg7 as u128), 18446744073709551616, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v1)) as u64);
        let v3 = asset_to_sy_amount_floor((0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((v2 as u128), 18446744073709551616, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg6)) as u64), arg3);
        if (v3 == 0 || v3 >= arg1) {
            return (0, 0)
        };
        let v4 = asset_to_sy_amount_floor(v2, arg3);
        let v5 = if (v4 > v3) {
            v4 - v3
        } else {
            0
        };
        (v3, v5)
    }

    public fun quote_exact_sy_for_pt_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg7: u64, arg8: u64) : (u64, u64, u64, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64) {
        let v0 = sy_to_asset_amount(arg1, arg2);
        let v1 = if (arg7 == 0) {
            true
        } else if (arg0 <= 1) {
            true
        } else {
            v0 == 0
        };
        if (v1) {
            return (0, 0, 0, arg3)
        };
        let v2 = get_rate_scalar(arg4, arg8);
        let v3 = current_rate_anchor(arg0, v0, arg3, v2, arg5, arg8);
        let v4 = fee_rate_factor(arg6, arg8);
        let v5 = if (arg2 <= 18446744073709551616) {
            18446744073709551615
        } else {
            (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor(18446744073709551615, 18446744073709551616, arg2) as u64)
        };
        let v6 = if (arg7 < v5) {
            arg7
        } else {
            v5
        };
        let v7 = sy_to_asset_amount(v6, arg2);
        if (v7 == 0) {
            return (0, 0, 0, arg3)
        };
        let (v8, v9) = try_get_exchange_rate(arg0, v0, v2, v3, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::zero());
        if (!v8) {
            return (0, 0, 0, arg3)
        };
        let v10 = 0;
        let v11 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((v7 as u128), 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v9), 18446744073709551616);
        let v12 = if (v11 < (arg0 as u128)) {
            (v11 as u64)
        } else {
            arg0 - 1
        };
        let v13 = v12;
        if (v12 == 0) {
            return (0, 0, 0, arg3)
        };
        let v14 = 0;
        while (v14 < 64 && v10 < v13) {
            let v15 = v13 - v10;
            let v16 = v10 + v15 / 2 + v15 % 2;
            let (v17, v18) = try_get_exchange_rate(arg0, v0, v2, v3, amount_to_fp(v16, true));
            if (v17 && 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::pt_fits_budget(v16, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v18), 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v4), (0x1::u256::min((arg7 as u256) * (arg2 as u256) / (18446744073709551616 as u256), 18446744073709551615) as u64))) {
                v10 = v16;
            } else {
                v13 = v16 - 1;
            };
            v14 = v14 + 1;
        };
        if (v10 == 0) {
            return (0, 0, 0, arg3)
        };
        let (v19, v20) = try_get_exchange_rate(arg0, v0, v2, v3, amount_to_fp(v10, true));
        if (!v19) {
            return (0, 0, 0, arg3)
        };
        let v21 = asset_in_at_rate(v10, v20, v4);
        if (0x1::option::is_none<u64>(&v21)) {
            return (0, 0, 0, arg3)
        };
        let v22 = asset_to_sy_amount_ceil(0x1::option::destroy_some<u64>(v21), arg2);
        let v23 = asset_to_sy_amount_ceil((0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((v10 as u128), 18446744073709551616, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v20)) as u64), arg2);
        let v24 = if (v22 > v23) {
            v22 - v23
        } else {
            0
        };
        (v10, v22, v24, get_ln_implied_rate(arg0 - v10, sy_to_asset_amount(arg1 + v22, arg2), v2, v3, arg8))
    }

    public fun quote_exact_sy_for_yt_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg7: u64, arg8: u64) : (u64, u64) {
        let v0 = if (arg7 == 0) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1 <= 1) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return (0, 0)
        };
        let v1 = sy_to_asset_amount(arg1, arg2);
        if (v1 == 0) {
            return (0, 0)
        };
        let v2 = get_rate_scalar(arg4, arg8);
        let v3 = current_rate_anchor(arg0, v1, arg3, v2, arg5, arg8);
        let v4 = fee_rate_factor(arg6, arg8);
        let (v5, v6) = select_equal_buy_yt_prepared(arg0, v1, arg2, v2, v3, v4, arg7, buy_yt_mint_limit(arg0, arg1, v1, arg2, arg7));
        let v7 = if (v6 > 0) {
            let v8 = last_refundable_buy_yt_prepared(arg0, v1, arg2, v2, v3, v4, v6);
            if (0x1::option::is_none<u64>(&v8)) {
                return (0, 0)
            };
            let (v9, v10) = select_equal_buy_yt_prepared(arg0, v1, arg2, v2, v3, v4, arg7, 0x1::option::destroy_some<u64>(v8));
            assert!(v10 == 0, 1412);
            v9
        } else {
            v5
        };
        let v11 = v7;
        if (0x1::option::is_none<u64>(&v11)) {
            return (0, 0)
        };
        let (v12, _, _, v15) = quote_sy_for_exact_yt_prepared(arg0, arg1, v1, arg2, v2, v3, v4, (((0x1::option::destroy_some<u64>(v11) as u256) * (arg2 as u256) / (18446744073709551616 as u256)) as u64));
        if (v12 == 0 || v15 > arg7) {
            (0, 0)
        } else {
            (v12, v15)
        }
    }

    fun quote_lp_split_for_exact_pt_prepared(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: PreparedRateAnchor, arg7: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg8: u64, arg9: u64) : (bool, u64, u64) {
        let (v0, _) = quote_sy_for_exact_pt_prepared(arg1, arg3, arg4, arg5, arg6, arg7, arg9);
        let v2 = if (v0 == 0) {
            true
        } else if (v0 >= arg8) {
            true
        } else {
            arg9 >= arg1
        };
        if (v2) {
            return (false, 0, 0)
        };
        let v3 = (arg2 as u128) + (v0 as u128);
        if (v3 > 18446744073709551615) {
            return (false, 0, 0)
        };
        let v4 = arg8 - v0;
        let v5 = (v3 as u64);
        let v6 = arg1 - arg9;
        if (v6 == 0) {
            return (false, 0, 0)
        };
        let v7 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((v4 as u128), (v6 as u128), (v5 as u128));
        let v8 = if (v7 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v7 as u64)
        };
        if (arg9 > v8) {
            return (false, v0, 0)
        };
        (true, v0, calc_lp_amount(arg0, v5, v6, v4, arg9))
    }

    public fun quote_lp_sy_swap_indexed(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg7: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg8: u64, arg9: u64) : (u64, u64, u64) {
        let v0 = if (arg8 <= 1) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1 <= 1) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return (0, 0, 0)
        };
        let v1 = sy_to_asset_amount(arg2, arg3);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let v2 = get_rate_scalar(arg5, arg9);
        let v3 = 1;
        let v4 = arg1 - 1;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < 64 && v3 <= v4) {
            let v9 = v3 + (v4 - v3) / 2;
            let (v10, v11, v12) = quote_lp_split_for_exact_pt_prepared(arg0, arg1, arg2, v1, arg3, v2, current_rate_anchor(arg1, v1, arg4, v2, arg6, arg9), fee_rate_factor(arg7, arg9), arg8, v9);
            if (v10) {
                v5 = v9;
                v6 = v11;
                v7 = v12;
                v3 = v9 + 1;
            } else {
                if (v9 == 0) {
                    break
                };
                v4 = v9 - 1;
            };
            v8 = v8 + 1;
        };
        if (v5 == 0 || v7 == 0) {
            return (0, 0, 0)
        };
        (v5, v6, v7)
    }

    public fun quote_non_keep_yt_split_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg7: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg8: u64, arg9: u64) : u64 {
        let v0 = if (arg8 == 0) {
            true
        } else if (arg0 <= 1) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = sy_to_asset_amount(arg1, arg2);
        if (v1 == 0) {
            return 0
        };
        let v2 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil(18446744073709551616, 1, arg3);
        let v3 = if (v2 == 0) {
            true
        } else if (v2 > (arg8 as u128)) {
            true
        } else {
            v2 > 18446744073709551615
        };
        if (v3) {
            return 0
        };
        let v4 = get_rate_scalar(arg5, arg9);
        let v5 = current_rate_anchor(arg0, v1, arg4, v4, arg6, arg9);
        let v6 = fee_rate_factor(arg7, arg9);
        let v7 = (0x1::u256::min((arg8 as u256), 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((arg0 as u256) * (18446744073709551616 as u256), (arg3 as u256)) - 1) as u64);
        while (v7 >= (v2 as u64)) {
            if (non_keep_yt_split_is_repayable_prepared(arg0, v1, arg2, arg3, v4, v5, v6, v7)) {
                return v7
            };
            let v8 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((v7 as u128), arg3, 18446744073709551616) as u64);
            if (v8 == 0) {
                return 0
            };
            let v9 = 0;
            let v10 = v8 - 1;
            while (v9 < v10) {
                let v11 = v10 - v9;
                let v12 = v9 + v11 / 2 + v11 % 2;
                let (v13, _) = quote_sy_for_exact_pt_prepared(arg0, v1, arg2, v4, v5, v6, v12);
                if (v13 > 0 && v13 <= (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((v8 as u128), 18446744073709551616, arg3) as u64)) {
                    v9 = v12;
                    continue
                };
                v10 = v12 - 1;
            };
            if (v9 == 0) {
                return 0
            };
            let v15 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(((v9 as u256) + 1) * (18446744073709551616 as u256), (arg3 as u256)) - 1;
            assert!(v15 < (v7 as u256), 1412);
            v7 = (v15 as u64);
        };
        0
    }

    public fun quote_pt_for_exact_sy_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg7: u64, arg8: u64) : (u64, u64, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64) {
        let v0 = if (arg7 == 0) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg7 >= arg1
        };
        if (v0) {
            return (0, 0, arg3)
        };
        let v1 = sy_to_asset_amount(arg1, arg2);
        if (v1 == 0) {
            return (0, 0, arg3)
        };
        let v2 = get_rate_scalar(arg4, arg8);
        let v3 = current_rate_anchor(arg0, v1, arg3, v2, arg5, arg8);
        let v4 = fee_rate_factor(arg6, arg8);
        let v5 = 18446744073709551615 - arg0;
        let v6 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v4);
        let v7 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::pt_input_bound(arg7, arg2, v6, 18446744073709551616);
        if (v7 == 0 || v7 > (v5 as u256)) {
            return (0, 0, arg3)
        };
        let v8 = (v7 as u64);
        loop {
            let (v9, v10) = try_get_exchange_rate(arg0, v1, v2, v3, amount_to_fp(v8, false));
            if (!v9) {
                return (0, 0, arg3)
            };
            let v11 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::pt_input_bound(arg7, arg2, v6, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v10));
            if (v11 <= (v8 as u256)) {
                break
            };
            if (v11 > (v5 as u256)) {
                return (0, 0, arg3)
            };
            v8 = (v11 as u64);
        };
        let (v12, v13) = quote_exact_pt_for_sy_prepared(arg0, arg1, v1, arg2, v2, v3, v4, v8);
        if (v12 < arg7 || !below_pt_limit(arg0 + v8, arg1 - arg7, arg2)) {
            return (0, 0, arg3)
        };
        (v8, v13, get_ln_implied_rate(arg0 + v8, sy_to_asset_amount(arg1 - arg7, arg2), v2, v3, arg8))
    }

    public fun quote_sy_for_exact_pt_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg7: u64, arg8: u64) : (u64, u64, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64) {
        let v0 = sy_to_asset_amount(arg1, arg2);
        let v1 = if (arg7 == 0) {
            true
        } else if (arg0 <= arg7) {
            true
        } else {
            v0 == 0
        };
        if (v1) {
            return (0, 0, arg3)
        };
        let v2 = get_rate_scalar(arg4, arg8);
        let v3 = current_rate_anchor(arg0, v0, arg3, v2, arg5, arg8);
        let (v4, v5) = quote_sy_for_exact_pt_prepared(arg0, v0, arg2, v2, v3, fee_rate_factor(arg6, arg8), arg7);
        if (v4 == 0) {
            return (0, 0, arg3)
        };
        if (v4 > 18446744073709551615 - arg1) {
            return (0, 0, arg3)
        };
        (v4, v5, get_ln_implied_rate(arg0 - arg7, sy_to_asset_amount(arg1 + v4, arg2), v2, v3, arg8))
    }

    fun quote_sy_for_exact_pt_prepared(arg0: u64, arg1: u64, arg2: u128, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg4: PreparedRateAnchor, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: u64) : (u64, u64) {
        if (arg6 == 0 || arg0 <= arg6) {
            return (0, 0)
        };
        let (v0, v1) = try_get_exchange_rate(arg0, arg1, arg3, arg4, amount_to_fp(arg6, true));
        if (!v0) {
            return (0, 0)
        };
        let v2 = asset_in_at_rate(arg6, v1, arg5);
        if (0x1::option::is_none<u64>(&v2)) {
            return (0, 0)
        };
        let v3 = asset_to_sy_amount_ceil(0x1::option::destroy_some<u64>(v2), arg2);
        let v4 = asset_to_sy_amount_ceil((0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((arg6 as u128), 18446744073709551616, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(v1)) as u64), arg2);
        let v5 = if (v3 > v4) {
            v3 - v4
        } else {
            0
        };
        (v3, v5)
    }

    public fun quote_sy_for_exact_yt_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg7: u64, arg8: u64) : (u64, u64, u64, u64) {
        let v0 = if (arg7 == 0) {
            true
        } else if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return (0, 0, 0, 0)
        };
        let v1 = sy_to_asset_amount(arg1, arg2);
        if (v1 == 0) {
            return (0, 0, 0, 0)
        };
        let v2 = get_rate_scalar(arg4, arg8);
        quote_sy_for_exact_yt_prepared(arg0, arg1, v1, arg2, v2, current_rate_anchor(arg0, v1, arg3, v2, arg5, arg8), fee_rate_factor(arg6, arg8), arg7)
    }

    fun quote_sy_for_exact_yt_prepared(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: PreparedRateAnchor, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg7: u64) : (u64, u64, u64, u64) {
        if (arg7 == 0 || arg3 == 0) {
            return (0, 0, 0, 0)
        };
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((arg7 as u128), 18446744073709551616, arg3);
        if (v0 > 18446744073709551615) {
            return (0, 0, 0, 18446744073709551615)
        };
        let v1 = (v0 as u64);
        let v2 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((v1 as u128), arg3, 18446744073709551616);
        if (v2 < (arg7 as u128) || v2 > 18446744073709551615) {
            return (0, v1, 0, 18446744073709551615)
        };
        let v3 = (v2 as u64);
        let (v4, _) = quote_exact_pt_for_sy_prepared(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v3);
        let v6 = if (v4 == 0) {
            true
        } else if (v4 >= v1) {
            true
        } else {
            !below_pt_limit(arg0 + v3, arg1 - v4, arg3)
        };
        if (v6) {
            return (0, v1, v4, 18446744073709551615)
        };
        (v3, v1, v4, v1 - v4)
    }

    public fun quote_yt_for_exact_sy_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg7: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg8: u64, arg9: u64, arg10: u64) : (u64, u64, u64, u64) {
        let v0 = if (arg8 == 0) {
            true
        } else if (arg9 == 0) {
            true
        } else if (arg0 <= 1) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            return (0, 0, 0, 0)
        };
        let v1 = sy_to_asset_amount(arg1, arg2);
        if (v1 == 0) {
            return (0, 0, 0, 0)
        };
        let v2 = get_rate_scalar(arg5, arg10);
        let v3 = current_rate_anchor(arg0, v1, arg4, v2, arg6, arg10);
        let v4 = fee_rate_factor(arg7, arg10);
        let v5 = 0x1::u64::min(arg9, arg0 - 1);
        let v6 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::yt_repayment_bound(arg8, 1, arg3);
        if (v6 > (v5 as u256)) {
            return (0, 0, 0, 0)
        };
        let v7 = (v6 as u64);
        loop {
            let (v8, v9, v10) = quote_yt_sale_prepared(arg0, v1, arg2, arg3, v2, v3, v4, v7);
            if (v9 == 0) {
                break
            };
            if (v10 >= arg8) {
                return (v7, v8, v9, v10)
            };
            let (_, v12) = try_get_exchange_rate(arg0, v1, v2, v3, amount_to_fp(v7, true));
            let v13 = 0x1::u256::max(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::yt_repayment_bound(arg8, v9, arg3), 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::yt_rate_bound(arg8, arg3, arg2, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::div(v12, v4))));
            if (v13 > (v5 as u256)) {
                return (0, 0, 0, 0)
            };
            assert!(v13 > (v7 as u256), 1412);
            v7 = (v13 as u64);
        };
        (0, 0, 0, 0)
    }

    fun quote_yt_sale_prepared(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: PreparedRateAnchor, arg6: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg7: u64) : (u64, u64, u64) {
        if (arg7 == 0 || arg3 == 0) {
            return (0, 0, 0)
        };
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg7 as u128), 18446744073709551616, arg3);
        if (v0 > 18446744073709551615) {
            return (0, 0, 0)
        };
        let v1 = (v0 as u64);
        let (v2, _) = quote_sy_for_exact_pt_prepared(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        let v4 = if (v2 > 0 && v1 > v2) {
            v1 - v2
        } else {
            0
        };
        (v1, v2, v4)
    }

    fun rational_refund_endpoint_excluded(arg0: u256, arg1: u256, arg2: u256, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg4: u64, arg5: u256) : bool {
        let v0 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg3) as u256);
        let v1 = if (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg3)) {
            v0
        } else {
            0
        };
        let v2 = v1;
        let v3 = if (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg3)) {
            0
        } else {
            v0
        };
        let v4 = v3;
        if (arg0 >= arg1) {
            v2 = v1 + (arg0 - arg1) / arg2;
        } else {
            v4 = v3 + 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(arg1 - arg0, arg2);
        };
        v2 > v4 && (v2 - v4) * arg5 > (arg4 as u256) * (18446744073709551616 as u256)
    }

    fun refund_log_bonus(arg0: u256, arg1: u256) : u256 {
        let v0 = (18446744073709551616 as u256);
        let v1 = arg0 * arg0 * arg0 / 12 * v0 * v0;
        let v2 = arg0 * arg0 / (2 * v0 - arg0);
        let v3 = arg1 + v1;
        let v4 = if (v2 > v1) {
            if (v3 < 3 * v0) {
                (v2 - v1) * 2 * (3 * v0 - v3) > 3 * v3 * v3
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            v1 + 1
        } else {
            v1
        }
    }

    public(friend) fun select_equal_buy_yt_prepared(arg0: u64, arg1: u64, arg2: u128, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg4: PreparedRateAnchor, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: u64, arg7: u64) : (0x1::option::Option<u64>, u64) {
        if (arg7 == 0 || arg6 == 0) {
            return (0x1::option::none<u64>(), 0)
        };
        let v0 = (18446744073709551616 as u256);
        let v1 = (arg6 as u256) * (arg2 as u256);
        let v2 = v1 / v0;
        let v3 = 0;
        while (v3 < arg7) {
            let v4 = arg7 - v3;
            let v5 = v3 + v4 / 2 + v4 % 2;
            let (_, _, v8) = buy_yt_asset_loss_prepared(arg0, arg1, arg2, arg3, arg4, arg5, v5);
            if ((v8 as u256) <= v2) {
                v3 = v5;
                continue
            };
            arg7 = v5 - 1;
        };
        if (v3 == 0) {
            return (0x1::option::none<u64>(), 0)
        };
        let (v9, v10, v11) = buy_yt_asset_loss_prepared(arg0, arg1, arg2, arg3, arg4, arg5, v3);
        let v12 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((arg2 as u256), v0);
        if (v9 > 0 && (v10 as u256) >= v12) {
            let v13 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((v9 as u256) * v0, (arg2 as u256));
            let v14 = (v11 as u256) * v0 + v13 * (arg2 as u256) % v0;
            if (v14 > 0 && v14 <= v1) {
                return (0x1::option::some<u64>((v13 as u64)), 0)
            };
        };
        let v15 = v3;
        if ((v11 as u256) == v2) {
            let v16 = 1;
            let v17 = v3;
            while (v16 < v17) {
                v17 = v16 + (v17 - v16) / 2;
                let (_, _, v20) = buy_yt_asset_loss_prepared(arg0, arg1, arg2, arg3, arg4, arg5, v17);
                if ((v20 as u256) < v2) {
                    v16 = v17 + 1;
                    continue
                };
            };
            let v21 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((v2 + v12) * v0, (arg2 as u256));
            if (v21 <= (v3 as u256)) {
                let v22 = if (v2 == 0) {
                    1
                } else {
                    0
                };
                let v23 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::modular_bounds::last_canonical_mint(0x1::u64::max(v16, (v21 as u64)), v3, arg2, v22, ((v1 % v0) as u128));
                if (0x1::option::is_some<u64>(&v23)) {
                    return (v23, 0)
                };
            };
            if (v2 == 0) {
                return (0x1::option::none<u64>(), 0)
            };
            v15 = v16 - 1;
        };
        if (v15 == 0) {
            return (0x1::option::none<u64>(), 0)
        };
        let (v24, v25, v26) = buy_yt_asset_loss_prepared(arg0, arg1, arg2, arg3, arg4, arg5, v15);
        if (v26 == 0) {
            let v27 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div(v12 * v0, (arg2 as u256));
            if (v27 > (v15 as u256)) {
                return (0x1::option::none<u64>(), 0)
            };
            return (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::modular_bounds::last_canonical_mint((v27 as u64), v15, arg2, 1, 18446744073709551616 - 1), 0)
        };
        if ((v25 as u256) < v12) {
            (0x1::option::none<u64>(), (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((v24 as u256) * v0, (arg2 as u256)) as u64))
        } else {
            (0x1::option::some<u64>((0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((v24 as u256) * v0, (arg2 as u256)) as u64)), 0)
        }
    }

    public fun spot_pt_price_in_sy_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg6: u64) : u128 {
        let v0 = sy_to_asset_amount(arg1, arg2);
        let v1 = get_rate_scalar(arg4, arg6);
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor(18446744073709551616, 18446744073709551616, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(get_exchange_rate(arg0, v0, v1, current_rate_anchor(arg0, v0, arg3, v1, arg5, arg6), 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::zero()))), 18446744073709551616, arg2)
    }

    public fun sy_to_asset_amount(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 1407);
        (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg0 as u128), arg1, 18446744073709551616) as u64)
    }

    fun to_positive_signed(arg0: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64) : 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign {
        0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::create_from_raw_value(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg0), true)
    }

    public fun trade_reserves(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool) : (u64, u64) {
        if (arg5) {
            (arg0 + arg2, arg1 - arg3 - arg4)
        } else {
            (arg0 - arg2, arg1 + arg3 - arg4)
        }
    }

    fun try_calc_trade_proportion(arg0: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg1: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign) : (bool, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64) {
        let v0 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg0) as u256) + (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg1) as u256);
        if (v0 == 0) {
            return (false, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::zero())
        };
        let (v1, v2) = try_net_pt_numerator(arg0, arg2);
        if (!v1) {
            return (false, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::zero())
        };
        let v3 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(v2) as u256) * (18446744073709551616 as u256) / v0;
        let v4 = if (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_zero(arg2) || 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg2)) {
            18446744073709551616
        } else {
            18446744073709551616 * 96 / 100
        };
        if (v3 == 0 || v3 >= (v4 as u256)) {
            return (false, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::zero())
        };
        (true, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::create_from_raw_value((v3 as u128)))
    }

    fun try_get_exchange_rate(arg0: u64, arg1: u64, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg3: PreparedRateAnchor, arg4: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign) : (bool, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign) {
        let (v0, v1) = try_calc_trade_proportion(amount_to_unsigned_fp(arg0), amount_to_unsigned_fp(arg1), arg4);
        if (!v0) {
            return (false, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::zero())
        };
        if (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_zero(arg4)) {
            let v2 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::add(0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::div(log_proportion(v1), arg2), arg3.value);
            if (!0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::greater_or_equal(v2, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::one())) {
                return (false, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::zero())
            };
            return (true, v2)
        };
        let v3 = !0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg4);
        let (v4, v5) = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::ln_bounds(log_proportion_argument(v1));
        let v6 = if (v3) {
            v5
        } else {
            v4
        };
        let v7 = if (v3) {
            arg3.upper
        } else {
            arg3.lower
        };
        try_rate_from_log_bound(v6, v7, arg2, v3)
    }

    fun try_net_pt_numerator(arg0: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64, arg1: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign) : (bool, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::FixedPoint64) {
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::get_raw_value(arg0);
        let v1 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg1);
        if (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg1)) {
            if (v0 <= v1) {
                return (false, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::zero())
            };
            return (true, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::create_from_raw_value(v0 - v1))
        };
        let v2 = (v0 as u256) + (v1 as u256);
        if (v2 > 340282366920938463463374607431768211455) {
            return (false, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::zero())
        };
        (true, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64::create_from_raw_value((v2 as u128)))
    }

    fun try_rate_from_log_bound(arg0: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg1: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign, arg3: bool) : (bool, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::FixedPoint64WithSign) {
        let v0 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg0);
        let v1 = 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::is_positive(arg1);
        let v2 = if (arg3 == v0) {
            0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds::ceil_div((0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg0) as u256) * (18446744073709551616 as u256), (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg2) as u256))
        } else {
            (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg0) as u256) * (18446744073709551616 as u256) / (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg2) as u256)
        };
        let v3 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::get_raw_value(arg1) as u256);
        let v4 = if (v0) {
            v2
        } else {
            0
        };
        let v5 = if (v1) {
            v3
        } else {
            0
        };
        let v6 = v4 + v5;
        let v7 = if (v0) {
            0
        } else {
            v2
        };
        let v8 = if (v1) {
            0
        } else {
            v3
        };
        let v9 = v7 + v8;
        let v10 = if (v6 < v9) {
            true
        } else if (v6 - v9 < (18446744073709551616 as u256)) {
            true
        } else {
            v6 - v9 > 340282366920938463463374607431768211455
        };
        if (v10) {
            return (false, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::zero())
        };
        (true, 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::fixed_point64_with_sign::create_from_raw_value(((v6 - v9) as u128), true))
    }

    // decompiled from Move bytecode v7
}

