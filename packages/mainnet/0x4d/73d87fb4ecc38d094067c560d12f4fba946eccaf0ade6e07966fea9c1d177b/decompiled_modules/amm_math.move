module 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::amm_math {
    fun amount_to_fp(arg0: u64, arg1: bool) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::create_from_raw_value((arg0 as u128) * 18446744073709551616, arg1)
    }

    fun amount_to_unsigned_fp(arg0: u64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::from_uint64(arg0)
    }

    public(friend) fun apply_fee(arg0: u64, arg1: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64) : (u64, u64) {
        let v0 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::truncate(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::mul(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::from_uint64(arg0), arg1));
        (arg0 - v0, v0)
    }

    public(friend) fun asset_to_sy_amount_ceil(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 1407);
        (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_ceil((arg0 as u128), 18446744073709551616, arg1) as u64)
    }

    public(friend) fun asset_to_sy_amount_floor(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 1407);
        (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor((arg0 as u128), 18446744073709551616, arg1) as u64)
    }

    public(friend) fun calc_lp_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg0 == 0) {
            (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::sqrt::sqrt_u128((arg3 as u128) * (arg4 as u128)) as u64)
        } else {
            let v1 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor((arg3 as u128), (arg0 as u128), (arg1 as u128));
            let v2 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor((arg4 as u128), (arg0 as u128), (arg2 as u128));
            let v3 = if (v1 < v2) {
                v1
            } else {
                v2
            };
            (v3 as u64)
        }
    }

    public(friend) fun calc_proportion(arg0: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg1: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        calc_trade_proportion(arg0, arg1, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::zero())
    }

    fun calc_trade_proportion(arg0: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg1: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg2: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        let v0 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::add(arg0, arg1);
        assert!(!0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::is_zero(v0), 1405);
        let (v1, v2) = try_net_pt_numerator(arg0, arg2);
        assert!(v1, 1405);
        let v3 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::div(v2, v0);
        assert!(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::less(v3, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::create_from_raw_value(18446744073709551616 * 96 / 100)), 1402);
        v3
    }

    fun current_rate_anchor(arg0: u64, arg1: u64, arg2: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg4: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg5: u64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign {
        if (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::is_zero(arg2)) {
            arg4
        } else {
            get_rate_anchor(arg0, arg1, arg3, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(arg2), arg5)
        }
    }

    fun fee_rate_factor(arg0: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg1: u64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign {
        get_exchange_rate_from_implied_rate(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(arg0), arg1)
    }

    public(friend) fun get_exchange_rate(arg0: u64, arg1: u64, arg2: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg4: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign {
        let (v0, v1) = try_get_exchange_rate(arg0, arg1, arg2, arg3, arg4);
        assert!(v0, 1401);
        v1
    }

    public(friend) fun get_exchange_rate_from_implied_rate(arg0: u128, arg1: u64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::exp(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::create_from_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(arg0, (arg1 as u128), (31536000000 as u128)), true))
    }

    public(friend) fun get_initial_ln_implied_rate(arg0: u64, arg1: u64, arg2: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg4: u64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        get_ln_implied_rate(arg0, arg1, get_rate_scalar(arg2, arg4), arg3, arg4)
    }

    public(friend) fun get_ln_implied_rate(arg0: u64, arg1: u64, arg2: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg4: u64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64 {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::create_from_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::get_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::ln(get_exchange_rate(arg0, arg1, arg2, arg3, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::zero()))), (31536000000 as u128), (arg4 as u128)))
    }

    public(friend) fun get_rate_anchor(arg0: u64, arg1: u64, arg2: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg3: u128, arg4: u64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::sub(get_exchange_rate_from_implied_rate(arg3, arg4), 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::div(log_proportion(calc_proportion(amount_to_unsigned_fp(arg0), amount_to_unsigned_fp(arg1))), arg2))
    }

    public(friend) fun get_rate_scalar(arg0: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg1: u64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign {
        assert!(arg1 > 0, 1406);
        let v0 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::mul(arg0, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::div(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::create_from_raw_value((31536000000 as u128) * 18446744073709551616, true), 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::create_from_raw_value((arg1 as u128) * 18446744073709551616, true)));
        assert!(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::is_positive(v0), 1404);
        v0
    }

    public(friend) fun log_proportion(arg0: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign {
        let v0 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::one();
        assert!(!0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::is_zero(arg0), 1405);
        assert!(!0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::equal(arg0, v0), 1403);
        assert!(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::less(arg0, v0), 1402);
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::ln(to_positive_signed(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::div(arg0, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::sub(v0, arg0))))
    }

    public(friend) fun quote_exact_pt_for_sy_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg4: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg7: u64, arg8: u64) : (u64, u64, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64) {
        let v0 = sy_to_asset_amount(arg1, arg2);
        let v1 = if (arg7 == 0) {
            true
        } else if (arg0 == 0) {
            true
        } else {
            v0 == 0
        };
        if (v1) {
            return (0, 0, arg3)
        };
        let v2 = get_rate_scalar(arg4, arg8);
        let v3 = current_rate_anchor(arg0, v0, arg3, v2, arg5, arg8);
        let (v4, v5) = try_get_exchange_rate(arg0, v0, v2, v3, amount_to_fp(arg7, false));
        if (!v4) {
            return (0, 0, arg3)
        };
        let v6 = (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor((arg7 as u128), 18446744073709551616, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::get_raw_value(v5)) as u64);
        let v7 = asset_to_sy_amount_floor((0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor((v6 as u128), 18446744073709551616, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::get_raw_value(fee_rate_factor(arg6, arg8))) as u64), arg2);
        if (v7 == 0 || v7 >= arg1) {
            return (0, 0, arg3)
        };
        let v8 = asset_to_sy_amount_floor(v6, arg2);
        let v9 = if (v8 > v7) {
            v8 - v7
        } else {
            0
        };
        (v7, v9, get_ln_implied_rate(arg0 + arg7, sy_to_asset_amount(arg1 - v7, arg2), v2, v3, arg8))
    }

    public(friend) fun quote_exact_sy_for_pt_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg4: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg7: u64, arg8: u64) : (u64, u64, u64, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64) {
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
        let v5 = sy_to_asset_amount(arg7, arg2);
        if (v5 == 0) {
            return (0, 0, 0, arg3)
        };
        let (v6, v7) = try_get_exchange_rate(arg0, v0, v2, v3, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::zero());
        if (!v6) {
            return (0, 0, 0, arg3)
        };
        let v8 = 0;
        let v9 = (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_ceil((v5 as u128), 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::get_raw_value(v7), 18446744073709551616) as u64);
        let v10 = if (v9 < arg0) {
            v9
        } else {
            arg0 - 1
        };
        let v11 = v10;
        if (v10 == 0) {
            return (0, 0, 0, arg3)
        };
        let v12 = 0;
        while (v12 < 64 && v8 < v11) {
            let v13 = v8 + (v11 - v8 + 1) / 2;
            let v14 = sy_in_for_pt_out(arg0, v0, v2, v3, v4, v13);
            let v15 = if (0x1::option::is_none<u64>(&v14)) {
                false
            } else {
                let v16 = asset_to_sy_amount_ceil(0x1::option::destroy_some<u64>(v14), arg2);
                v16 > 0 && v16 <= arg7
            };
            if (v15) {
                v8 = v13;
            } else {
                v11 = v13 - 1;
            };
            v12 = v12 + 1;
        };
        if (v8 == 0) {
            return (0, 0, 0, arg3)
        };
        let (v17, v18) = try_get_exchange_rate(arg0, v0, v2, v3, amount_to_fp(v8, true));
        if (!v17) {
            return (0, 0, 0, arg3)
        };
        let v19 = sy_in_for_pt_out(arg0, v0, v2, v3, v4, v8);
        if (0x1::option::is_none<u64>(&v19)) {
            return (0, 0, 0, arg3)
        };
        let v20 = asset_to_sy_amount_ceil(0x1::option::destroy_some<u64>(v19), arg2);
        let v21 = asset_to_sy_amount_ceil((0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_ceil((v8 as u128), 18446744073709551616, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::get_raw_value(v18)) as u64), arg2);
        let v22 = if (v20 > v21) {
            v20 - v21
        } else {
            0
        };
        (v8, v20, v22, get_ln_implied_rate(arg0 - v8, sy_to_asset_amount(arg1 + v20, arg2), v2, v3, arg8))
    }

    public(friend) fun quote_pt_for_exact_sy_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg4: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg7: u64, arg8: u64) : (u64, u64, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64) {
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
        let v1 = 1;
        let v2 = 1;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 64) {
            let (v5, _, _) = quote_exact_pt_for_sy_indexed(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v2, arg8);
            v3 = v5;
            if (v5 >= arg7) {
                break
            };
            if (v2 > 9223372036854775807) {
                break
            };
            v2 = v2 * 2;
            v4 = v4 + 1;
        };
        if (v3 < arg7) {
            return (0, 0, arg3)
        };
        v4 = 0;
        while (v4 < 64 && v1 < v2) {
            let v8 = v1 + (v2 - v1) / 2;
            let (v9, _, _) = quote_exact_pt_for_sy_indexed(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v8, arg8);
            if (v9 >= arg7) {
                v2 = v8;
            } else {
                v1 = v8 + 1;
            };
            v4 = v4 + 1;
        };
        let (v12, v13, v14) = quote_exact_pt_for_sy_indexed(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v1, arg8);
        if (v12 < arg7) {
            return (0, 0, arg3)
        };
        (v1, v13, v14)
    }

    public(friend) fun quote_sy_for_exact_pt_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg4: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg6: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg7: u64, arg8: u64) : (u64, u64, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64) {
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
        let (v4, v5) = try_get_exchange_rate(arg0, v0, v2, v3, amount_to_fp(arg7, true));
        if (!v4) {
            return (0, 0, arg3)
        };
        let v6 = sy_in_for_pt_out(arg0, v0, v2, v3, fee_rate_factor(arg6, arg8), arg7);
        if (0x1::option::is_none<u64>(&v6)) {
            return (0, 0, arg3)
        };
        let v7 = asset_to_sy_amount_ceil(0x1::option::destroy_some<u64>(v6), arg2);
        let v8 = asset_to_sy_amount_ceil((0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_ceil((arg7 as u128), 18446744073709551616, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::get_raw_value(v5)) as u64), arg2);
        let v9 = if (v7 > v8) {
            v7 - v8
        } else {
            0
        };
        (v7, v9, get_ln_implied_rate(arg0 - arg7, sy_to_asset_amount(arg1 + v7, arg2), v2, v3, arg8))
    }

    public(friend) fun spot_pt_price_in_sy_indexed(arg0: u64, arg1: u64, arg2: u128, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg4: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg5: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg6: u64) : u128 {
        let v0 = sy_to_asset_amount(arg1, arg2);
        let v1 = get_rate_scalar(arg4, arg6);
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor(18446744073709551616, 18446744073709551616, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::get_raw_value(get_exchange_rate(arg0, v0, v1, current_rate_anchor(arg0, v0, arg3, v1, arg5, arg6), 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::zero()))), 18446744073709551616, arg2)
    }

    fun sy_in_for_pt_out(arg0: u64, arg1: u64, arg2: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg4: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg5: u64) : 0x1::option::Option<u64> {
        let (v0, v1) = try_get_exchange_rate(arg0, arg1, arg2, arg3, amount_to_fp(arg5, true));
        if (!v0) {
            return 0x1::option::none<u64>()
        };
        let v2 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::div(v1, arg4);
        if (!0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::greater_or_equal(v2, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::one())) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>((0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_ceil((arg5 as u128), 18446744073709551616, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::get_raw_value(v2)) as u64))
    }

    public(friend) fun sy_to_asset_amount(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 1407);
        (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128::mul_div_floor((arg0 as u128), arg1, 18446744073709551616) as u64)
    }

    fun to_positive_signed(arg0: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64) : 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign {
        0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::create_from_raw_value(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(arg0), true)
    }

    fun try_calc_trade_proportion(arg0: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg1: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg2: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign) : (bool, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64) {
        let v0 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::add(arg0, arg1);
        if (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::is_zero(v0)) {
            return (false, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::zero())
        };
        let (v1, v2) = try_net_pt_numerator(arg0, arg2);
        if (!v1) {
            return (false, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::zero())
        };
        let v3 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::div(v2, v0);
        if (!0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::less(v3, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::create_from_raw_value(18446744073709551616 * 96 / 100))) {
            return (false, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::zero())
        };
        (true, v3)
    }

    fun try_get_exchange_rate(arg0: u64, arg1: u64, arg2: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign, arg4: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign) : (bool, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign) {
        let (v0, v1) = try_calc_trade_proportion(amount_to_unsigned_fp(arg0), amount_to_unsigned_fp(arg1), arg4);
        if (!v0) {
            return (false, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::zero())
        };
        let v2 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::add(0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::div(log_proportion(v1), arg2), arg3);
        if (!0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::greater_or_equal(v2, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::one())) {
            return (false, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::zero())
        };
        (true, v2)
    }

    fun try_net_pt_numerator(arg0: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64, arg1: 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::FixedPoint64WithSign) : (bool, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::FixedPoint64) {
        let v0 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::get_raw_value(arg0);
        let v1 = 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::get_raw_value(arg1);
        if (0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64_with_sign::is_positive(arg1)) {
            if (v0 <= v1) {
                return (false, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::zero())
            };
            return (true, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::create_from_raw_value(v0 - v1))
        };
        let v2 = (v0 as u256) + (v1 as u256);
        if (v2 > 340282366920938463463374607431768211455) {
            return (false, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::zero())
        };
        (true, 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::fixed_point64::create_from_raw_value((v2 as u128)))
    }

    // decompiled from Move bytecode v7
}

