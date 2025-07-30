module 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2 {
    struct UpdateFlag has copy, drop, store {
        dummy_field: bool,
    }

    struct OracleQuoterV2 has store {
        version: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::Version,
        oracle_registry_id: 0x2::object::ID,
        oracle_index_a: u64,
        oracle_index_b: u64,
        decimals_a: u8,
        decimals_b: u8,
        amp: u64,
    }

    struct NewOracleQuoterV2 has copy, drop, store {
        pool_id: 0x2::object::ID,
        oracle_registry_id: 0x2::object::ID,
        oracle_index_a: u64,
        oracle_index_b: u64,
        amplifier: u64,
    }

    public fun swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &mut 0x2::coin::Coin<T3>, arg7: &mut 0x2::coin::Coin<T4>, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::SwapResult {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter_mut<T3, T4, OracleQuoterV2, T5>(arg0).version, 4);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(&arg4) == 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_registry_id, 2);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(&arg4) == 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_index_a, 1);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(&arg5) == 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_registry_id, 2);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(&arg5) == 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_index_b, 1);
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0);
        let v1 = v0.decimals_b;
        let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg4));
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg5));
        let (v4, v5) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::get_btoken_ratio<T0, T1, T3>(arg1, arg3, arg11);
        let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v4, v5);
        let (v7, v8) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::get_btoken_ratio<T0, T2, T4>(arg2, arg3, arg11);
        let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v7, v8);
        let v10 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amount_a<T3, T4, OracleQuoterV2, T5>(arg0)), v6);
        let v11 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amount_b<T3, T4, OracleQuoterV2, T5>(arg0)), v9);
        try_update_or_noop<T3, T4, T5>(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(v10, v2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, v0.decimals_a))), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(v11, v3), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, v1))));
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::swap<T3, T4, OracleQuoterV2, T5>(arg0, arg6, arg7, quote_swap_<T3, T4, T5>(arg0, v2, v3, price_uncertainty_ratio(arg4), price_uncertainty_ratio(arg5), v6, v9, v10, v11, arg9, arg8), arg10, arg12)
    }

    fun compute_f(arg0: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64, arg1: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64, arg2: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64) : (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64, bool) {
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::one();
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::mul(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from_raw_value(12786308645202655660), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from(64));
        let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::div(v0, arg1);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::ln_plus_64ln2(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::sub(v0, arg0));
        assert!(!0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::gt(v3, v1), 999);
        let v4 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::add(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::mul(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::sub(v0, v2), arg0), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::mul(v2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::sub(v1, v3)));
        if (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::gte(v4, arg2)) {
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::sub(v4, arg2), true)
        } else {
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::sub(arg2, v4), false)
        }
    }

    fun compute_f_prime(arg0: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64, arg1: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64) : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64 {
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::one();
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::add(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::sub(v0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::div(v0, arg1)), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::div(v0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::mul(arg1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::sub(v0, arg0))))
    }

    fun from_usd(arg0: u256, arg1: u256, arg2: 0x1::option::Option<u256>) : u256 {
        if (0x1::option::is_some<u256>(&arg2)) {
            let v1 = 0x1::option::destroy_some<u256>(arg2);
            arg0 * v1 / (arg1 * v1 + 1)
        } else {
            arg0 / arg1
        }
    }

    fun get_d(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 + arg1;
        let v1 = arg2 * 2;
        let v2 = v0;
        let v3 = 255;
        while (v3 > 0) {
            let v4 = v2 * v2 / arg0 * v2 / arg1 / 4;
            let v5 = v2;
            v2 = (v1 * v0 / 100 + v4 * 2) * v2 / ((v1 - 100) * v2 / 100 + 3 * v4);
            if (v2 > v5) {
                if (v2 - v5 <= 1) {
                    return v2
                };
            } else if (v5 - v2 <= 1) {
                return v2
            };
            v3 = v3 - 1;
        };
        abort 0
    }

    fun get_swap_output(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg3: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg4: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg5: u64, arg6: u64, arg7: u64, arg8: bool) : u64 {
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::decimal_to_fixedpoint64(arg1);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::decimal_to_fixedpoint64(arg2);
        let v2 = if (arg5 >= arg6) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::pow(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from(10), arg5 - arg6)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::div(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::one(), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::pow(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from(10), arg6 - arg5))
        };
        let v3 = if (arg8) {
            let v4 = 0x1::vector::empty<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>();
            let v5 = &mut v4;
            0x1::vector::push_back<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>(v5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::decimal_to_fixedpoint64(arg0));
            0x1::vector::push_back<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>(v5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::decimal_to_fixedpoint64(arg3));
            let v6 = 0x1::vector::empty<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>();
            let v7 = &mut v6;
            0x1::vector::push_back<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>(v7, v1);
            0x1::vector::push_back<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>(v7, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::decimal_to_fixedpoint64(arg4));
            0x1::vector::push_back<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>(v7, v2);
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::multiply_divide(&mut v4, &mut v6)
        } else {
            let v8 = 0x1::vector::empty<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>();
            let v9 = &mut v8;
            0x1::vector::push_back<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>(v9, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::decimal_to_fixedpoint64(arg0));
            0x1::vector::push_back<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>(v9, v2);
            0x1::vector::push_back<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>(v9, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::decimal_to_fixedpoint64(arg4));
            let v10 = 0x1::vector::empty<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>();
            let v11 = &mut v10;
            0x1::vector::push_back<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>(v11, v0);
            0x1::vector::push_back<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64>(v11, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::decimal_to_fixedpoint64(arg3));
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::multiply_divide(&mut v8, &mut v10)
        };
        let v12 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::min(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from_rational(9999999999, 10000000000), v3);
        let v13 = newton_raphson(v3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from((arg7 as u128)), v12);
        assert!(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::lt(v13, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::one()), 4);
        let v14 = if (arg8) {
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::to_u128_down(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::mul(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::min(v13, v12), v1)) as u64)
        } else {
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::to_u128_down(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::mul(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::min(v13, v12), v0)) as u64)
        };
        if (arg8) {
            if (v14 >= 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(arg2)) {
                return 0
            };
        } else if (v14 >= 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(arg1)) {
            return 0
        };
        v14
    }

    fun get_swap_output_v2(arg0: u64, arg1: u64, arg2: u64, arg3: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg4: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg5: u8, arg6: u8, arg7: u64, arg8: bool) : u64 {
        let (v0, v1) = split_price(arg3);
        let (v2, v3) = split_price(arg4);
        let v4 = to_usd((arg1 as u256) * 10000000000, v0, v1) / (0x1::u64::pow(10, arg5) as u256);
        let v5 = to_usd((arg2 as u256) * 10000000000, v2, v3) / (0x1::u64::pow(10, arg6) as u256);
        let v6 = ((arg7 * 2) as u256) * 100;
        let v7 = if (arg8) {
            arg2 - ((from_usd(get_y(v4 + to_usd((arg0 as u256) * 10000000000, v0, v1) / (0x1::u64::pow(10, arg5) as u256), v6, get_d(v4, v5, v6)), v2, v3) * (0x1::u64::pow(10, arg6) as u256) / (10000000000 as u256)) as u64)
        } else {
            arg1 - ((from_usd(get_y(v5 + to_usd((arg0 as u256) * 10000000000, v2, v3) / (0x1::u64::pow(10, arg6) as u256), v6, get_d(v4, v5, v6)), v0, v1) * (0x1::u64::pow(10, arg5) as u256) / (10000000000 as u256)) as u64)
        };
        let v8 = v7;
        if (v7 > 0) {
            v8 = v7 - 1;
        };
        v8
    }

    fun get_y(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg1 * 2;
        let v1 = arg2;
        let v2 = 255;
        while (v2 > 0) {
            let v3 = v1;
            v1 = (v1 * v1 + 0x1::u256::pow(arg2, 2) / 2 * arg0 * arg2 * 100 / v0 * 2) / (2 * v1 + arg0 + arg2 * 100 / v0 - arg2);
            if (v1 > v3) {
                if (v1 - v3 <= 1) {
                    return v1
                };
            } else if (v3 - v1 <= 1) {
                return v1
            };
            v2 = v2 - 1;
        };
        abort 0
    }

    fun is_latest(arg0: &0x2::object::UID) : bool {
        let v0 = UpdateFlag{dummy_field: false};
        0x2::dynamic_field::exists_<UpdateFlag>(arg0, v0)
    }

    public fun new<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::Registry, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &0x2::coin::CoinMetadata<T2>, arg4: &0x2::coin::CoinMetadata<T3>, arg5: &0x2::coin::CoinMetadata<T4>, arg6: &mut 0x2::coin::CoinMetadata<T5>, arg7: 0x2::coin::TreasuryCap<T5>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, OracleQuoterV2, T5> {
        assert!(0x1::type_name::get<T3>() == 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::btoken_type(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::get_bank_data<T1>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1))), 0);
        assert!(0x1::type_name::get<T4>() == 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::btoken_type(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::get_bank_data<T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1))), 0);
        let v0 = 0x2::coin::get_decimals<T1>(arg2);
        let v1 = 0x2::coin::get_decimals<T2>(arg3);
        if (v0 >= v1) {
            assert!(v0 - v1 <= 10, 3);
        } else {
            assert!(v1 - v0 <= 10, 3);
        };
        let v2 = OracleQuoterV2{
            version            : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::new(4),
            oracle_registry_id : 0x2::object::id<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry>(arg8),
            oracle_index_a     : arg9,
            oracle_index_b     : arg10,
            decimals_a         : 0x2::coin::get_decimals<T1>(arg2),
            decimals_b         : 0x2::coin::get_decimals<T2>(arg3),
            amp                : arg11,
        };
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::new<T3, T4, OracleQuoterV2, T5>(arg0, arg12, v2, arg4, arg5, arg6, arg7, arg13);
        let v4 = NewOracleQuoterV2{
            pool_id            : 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, OracleQuoterV2, T5>>(&v3),
            oracle_registry_id : 0x2::object::id<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry>(arg8),
            oracle_index_a     : arg9,
            oracle_index_b     : arg10,
            amplifier          : arg11,
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::events::emit_event<NewOracleQuoterV2>(v4);
        let v5 = UpdateFlag{dummy_field: false};
        0x2::dynamic_field::add<UpdateFlag, u64>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::uid_mut<T3, T4, OracleQuoterV2, T5>(&mut v3), v5, 0);
        v3
    }

    fun newton_raphson(arg0: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64, arg1: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64, arg2: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64) : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64 {
        newton_raphson_(arg0, arg1, arg2, 20)
    }

    fun newton_raphson_(arg0: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64, arg1: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64, arg2: 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64, arg3: u64) : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::FixedPoint64 {
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::one();
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from_rational(1, 100000);
        let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from_rational(999999999999999999, 1000000000000000000);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from_rational(1, 100000000000000);
        let v4 = if (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::gte(arg2, v0)) {
            v2
        } else {
            arg2
        };
        let v5 = v4;
        let v6 = 0;
        while (v6 < arg3) {
            let (v7, v8) = compute_f(v5, arg1, arg0);
            if (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::lt(v7, v3)) {
                break
            };
            let v9 = compute_f_prime(v5, arg1);
            assert!(!0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::lt(v9, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from_rational(1, 10000000000)), 1001);
            let v10 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::div(v7, v9);
            let v11 = if (v8) {
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::sub(v5, v10)
            } else {
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::add(v5, v10)
            };
            let v12 = v11;
            if (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::lte(v11, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::zero()) || 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::gte(v11, v0)) {
                let v13 = if (v8) {
                    0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::sub(v4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::mul(v10, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from_rational(1, 2)))
                } else {
                    0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::add(v4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::mul(v10, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::from_rational(1, 2)))
                };
                let v14 = if (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::lt(v13, v1)) {
                    v1
                } else if (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::gt(v13, v2)) {
                    v2
                } else {
                    v13
                };
                v12 = v14;
            };
            let v15 = if (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::gte(v12, v4)) {
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::sub(v12, v4)
            } else {
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::sub(v4, v12)
            };
            if (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fixed_point64::lt(v15, v3)) {
                break
            };
            v5 = v12;
            v6 = v6 + 1;
        };
        v5
    }

    public fun pause_pool<T0, T1, T2: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, OracleQuoterV2, T2>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::global_admin::GlobalAdmin) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter_mut<T0, T1, OracleQuoterV2, T2>(arg0).version, 4);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::pause_pool<T0, T1, OracleQuoterV2, T2>(arg0, arg1);
    }

    fun price_uncertainty_ratio(arg0: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate) : u64 {
        let v0 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::metadata(&arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::metadata_pyth(&v0));
        let v2 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::metadata(&arg0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::metadata_pyth(&v2));
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v3);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v1) * 10000 / 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4)
    }

    public fun quote_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock) : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::SwapQuote {
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(&arg4) == 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_registry_id, 2);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(&arg4) == 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_index_a, 1);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(&arg5) == 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_registry_id, 2);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(&arg5) == 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_index_b, 1);
        let (v0, v1) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::get_btoken_ratio<T0, T1, T3>(arg1, arg3, arg8);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v0, v1);
        let (v3, v4) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::get_btoken_ratio<T0, T2, T4>(arg2, arg3, arg8);
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v3, v4);
        quote_swap_<T3, T4, T5>(arg0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg4)), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils::oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg5)), price_uncertainty_ratio(arg4), price_uncertainty_ratio(arg5), v2, v5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amount_a<T3, T4, OracleQuoterV2, T5>(arg0)), v2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amount_b<T3, T4, OracleQuoterV2, T5>(arg0)), v5), arg6, arg7)
    }

    fun quote_swap_<T0, T1, T2: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, OracleQuoterV2, T2>, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg3: u64, arg4: u64, arg5: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg6: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg7: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg8: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg9: u64, arg10: bool) : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::SwapQuote {
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T0, T1, OracleQuoterV2, T2>(arg0);
        let v1 = v0.decimals_a;
        let v2 = v0.decimals_b;
        let v3 = if (arg10) {
            let v4 = if (!is_latest(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::uid<T0, T1, OracleQuoterV2, T2>(arg0))) {
                get_swap_output(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg9), arg5), arg7, arg8, arg1, arg2, (v1 as u64), (v2 as u64), v0.amp, true)
            } else {
                get_swap_output_v2(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg9), arg5)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(arg7), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(arg8), arg1, arg2, v1, v2, v0.amp, true)
            };
            let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v4), arg6));
            let v6 = v5;
            if (v5 >= 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amount_b<T0, T1, OracleQuoterV2, T2>(arg0)) {
                v6 = 0;
            };
            v6
        } else {
            let v7 = if (!is_latest(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::uid<T0, T1, OracleQuoterV2, T2>(arg0))) {
                get_swap_output(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg9), arg6), arg7, arg8, arg1, arg2, (v1 as u64), (v2 as u64), v0.amp, false)
            } else {
                get_swap_output_v2(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg9), arg6)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(arg7), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(arg8), arg1, arg2, v1, v2, v0.amp, false)
            };
            let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v7), arg5));
            let v9 = v8;
            if (v8 >= 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amount_a<T0, T1, OracleQuoterV2, T2>(arg0)) {
                v9 = 0;
            };
            v9
        };
        if (!is_latest(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::uid<T0, T1, OracleQuoterV2, T2>(arg0))) {
            let v10 = if (arg10) {
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::quote_swap_impl(arg9, v1, v2, arg1, arg2, arg5, arg6)
            } else {
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::quote_swap_impl(arg9, v2, v1, arg2, arg1, arg6, arg5)
            };
            assert!(v3 < v10, 5);
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::get_quote<T0, T1, OracleQuoterV2, T2>(arg0, arg9, v3, arg10, 0x1::option::some<u64>(0x1::u64::max(arg3, arg4)))
    }

    public fun resume_pool<T0, T1, T2: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, OracleQuoterV2, T2>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::global_admin::GlobalAdmin) {
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::version::assert_version_and_upgrade(&mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter_mut<T0, T1, OracleQuoterV2, T2>(arg0).version, 4);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::resume_pool<T0, T1, OracleQuoterV2, T2>(arg0, arg1);
    }

    fun split_price(arg0: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : (u256, 0x1::option::Option<u256>) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::sub(arg0, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(arg0)));
        let v1 = if (v0 == 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)) {
            0x1::option::none<u256>()
        } else {
            0x1::option::some<u256>((0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(1), v0)) as u256))
        };
        ((0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(arg0) as u256), v1)
    }

    fun to_usd(arg0: u256, arg1: u256, arg2: 0x1::option::Option<u256>) : u256 {
        if (0x1::option::is_some<u256>(&arg2)) {
            arg0 * arg1 + arg0 / 0x1::option::destroy_some<u256>(arg2)
        } else {
            0x1::option::destroy_none<u256>(arg2);
            arg0 * arg1
        }
    }

    fun try_update_or_noop<T0, T1, T2: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, OracleQuoterV2, T2>, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) {
        let v0 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::uid_mut<T0, T1, OracleQuoterV2, T2>(arg0);
        if (is_latest(v0)) {
            return
        };
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(100)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(arg1, arg2));
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ge(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(40)) && 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::le(v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(60))) {
            let v2 = UpdateFlag{dummy_field: false};
            0x2::dynamic_field::add<UpdateFlag, u64>(v0, v2, 0);
            let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T0, T1, OracleQuoterV2, T2>(arg0).amp;
            let v4 = &v3;
            let v5 = if (*v4 == 20) {
                50
            } else if (*v4 == 30) {
                100
            } else if (*v4 == 1000) {
                1000
            } else {
                0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T0, T1, OracleQuoterV2, T2>(arg0).amp
            };
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter_mut<T0, T1, OracleQuoterV2, T2>(arg0).amp = v5;
        };
    }

    // decompiled from Move bytecode v6
}

