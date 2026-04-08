module 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::omm {
    struct OracleQuoter has store {
        oracle_registry_id: 0x2::object::ID,
        oracle_index_a: u64,
        oracle_index_b: u64,
        decimals_a: u8,
        decimals_b: u8,
        amp: u64,
        lending_market_a: 0x2::object::ID,
        lending_market_b: 0x2::object::ID,
        bank_a: 0x2::object::ID,
        bank_b: 0x2::object::ID,
        extension_fields: 0x2::bag::Bag,
    }

    struct NewOracleQuoter has copy, drop, store {
        pool_id: 0x2::object::ID,
        oracle_registry_id: 0x2::object::ID,
        oracle_index_a: u64,
        oracle_index_b: u64,
        amplifier: u64,
        lending_market_a: 0x2::object::ID,
        lending_market_b: 0x2::object::ID,
        bank_a: 0x2::object::ID,
        bank_b: 0x2::object::ID,
    }

    struct AmplifierUpdatedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        old_amplifier: u64,
        new_amplifier: u64,
    }

    public fun swap<T0, T1, T2, T3, T4: drop, T5, T6>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T2, T3, OracleQuoter, T4>, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::Bank<T0, T2>, arg3: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::Bank<T1, T3>, arg4: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T5>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T1, T6>, arg6: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg7: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg8: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::OraclePriceUpdate, arg9: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::OraclePriceUpdate, arg10: &mut 0x2::coin::Coin<T2>, arg11: &mut 0x2::coin::Coin<T3>, arg12: bool, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::SwapResult {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        assert!(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::oracle_registry_id(&arg8) == 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T2, T3, OracleQuoter, T4>(arg0).oracle_registry_id, 2);
        assert!(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::oracle_index(&arg8) == 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T2, T3, OracleQuoter, T4>(arg0).oracle_index_a, 1);
        assert!(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::oracle_registry_id(&arg9) == 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T2, T3, OracleQuoter, T4>(arg0).oracle_registry_id, 2);
        assert!(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::oracle_index(&arg9) == 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T2, T3, OracleQuoter, T4>(arg0).oracle_index_b, 1);
        let (v0, v1) = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::get_btoken_ratio<T0, T2, T5>(arg2, arg4, arg6, arg15);
        let v2 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(v0, v1);
        let (v3, v4) = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::get_btoken_ratio<T1, T3, T6>(arg3, arg5, arg7, arg15);
        let v5 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(v3, v4);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::swap<T2, T3, OracleQuoter, T4>(arg0, arg10, arg11, quote_swap_<T2, T3, T4>(arg0, arg1, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::oracle_decimal_to_decimal(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::price(&arg8)), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::oracle_decimal_to_decimal(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::price(&arg9)), price_uncertainty_ratio(&arg8), price_uncertainty_ratio(&arg9), v2, v5, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::balance_amount_a<T2, T3, OracleQuoter, T4>(arg0)), v2), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::balance_amount_b<T2, T3, OracleQuoter, T4>(arg0)), v5), arg13, arg12), arg14, arg16)
    }

    public fun new<T0, T1, T2, T3, T4: drop>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::registry::Registry, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x2::coin::CoinMetadata<T2>, arg7: &0x2::coin::CoinMetadata<T3>, arg8: &mut 0x2::coin::CoinMetadata<T4>, arg9: 0x2::coin::TreasuryCap<T4>, arg10: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::OracleRegistry, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T2, T3, OracleQuoter, T4> {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg15));
        let v0 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::registry::get_bank_data<T0>(arg0, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg2));
        assert!(0x1::type_name::with_defining_ids<T2>() == 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::registry::btoken_type(v0), 0);
        let v1 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::registry::get_bank_data<T1>(arg0, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>>(arg3));
        assert!(0x1::type_name::with_defining_ids<T3>() == 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::registry::btoken_type(v1), 0);
        let v2 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg2);
        let v3 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>>(arg3);
        let v4 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::registry::bank_id(v0);
        let v5 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::registry::bank_id(v1);
        let v6 = 0x2::coin::get_decimals<T0>(arg4);
        let v7 = 0x2::coin::get_decimals<T1>(arg5);
        assert!(arg13 >= 1 && arg13 <= 1000, 6);
        if (v6 >= v7) {
            assert!(v6 - v7 <= 10, 3);
        } else {
            assert!(v7 - v6 <= 10, 3);
        };
        let v8 = OracleQuoter{
            oracle_registry_id : 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::OracleRegistry>(arg10),
            oracle_index_a     : arg11,
            oracle_index_b     : arg12,
            decimals_a         : 0x2::coin::get_decimals<T0>(arg4),
            decimals_b         : 0x2::coin::get_decimals<T1>(arg5),
            amp                : arg13,
            lending_market_a   : v2,
            lending_market_b   : v3,
            bank_a             : v4,
            bank_b             : v5,
            extension_fields   : 0x2::bag::new(arg15),
        };
        let v9 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::new<T2, T3, OracleQuoter, T4>(arg0, arg14, v8, arg6, arg7, arg8, arg9, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg15);
        let v10 = NewOracleQuoter{
            pool_id            : 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T2, T3, OracleQuoter, T4>>(&v9),
            oracle_registry_id : 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::OracleRegistry>(arg10),
            oracle_index_a     : arg11,
            oracle_index_b     : arg12,
            amplifier          : arg13,
            lending_market_a   : v2,
            lending_market_b   : v3,
            bank_a             : v4,
            bank_b             : v5,
        };
        0x2::event::emit<NewOracleQuoter>(v10);
        v9
    }

    fun compute_f(arg0: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64, arg1: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64, arg2: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64) : (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64, bool) {
        let v0 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::one();
        let v1 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from_raw_value(12786308645202655660), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from(64));
        let v2 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::div(v0, arg1);
        let v3 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::ln_plus_64ln2(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::sub(v0, arg0));
        assert!(!0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::gt(v3, v1), 999);
        let v4 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::add(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::sub(v0, v2), arg0), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::mul(v2, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::sub(v1, v3)));
        if (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::gte(v4, arg2)) {
            (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::sub(v4, arg2), true)
        } else {
            (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::sub(arg2, v4), false)
        }
    }

    fun compute_f_prime(arg0: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64, arg1: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64 {
        let v0 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::one();
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::add(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::sub(v0, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::div(v0, arg1)), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::div(v0, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::mul(arg1, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::sub(v0, arg0))))
    }

    fun get_swap_output(arg0: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg1: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg2: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg3: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg4: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg5: u64, arg6: u64, arg7: u64, arg8: bool) : u64 {
        let v0 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::decimal_to_fixedpoint64(arg1);
        let v1 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::decimal_to_fixedpoint64(arg2);
        let v2 = if (arg5 >= arg6) {
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::pow(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from(10), arg5 - arg6)
        } else {
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::div(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::one(), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::pow(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from(10), arg6 - arg5))
        };
        let v3 = if (arg8) {
            let v4 = 0x1::vector::empty<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>();
            let v5 = &mut v4;
            0x1::vector::push_back<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>(v5, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::decimal_to_fixedpoint64(arg0));
            0x1::vector::push_back<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>(v5, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::decimal_to_fixedpoint64(arg3));
            let v6 = 0x1::vector::empty<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>();
            let v7 = &mut v6;
            0x1::vector::push_back<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>(v7, v1);
            0x1::vector::push_back<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>(v7, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::decimal_to_fixedpoint64(arg4));
            0x1::vector::push_back<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>(v7, v2);
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::multiply_divide(&mut v4, &mut v6)
        } else {
            let v8 = 0x1::vector::empty<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>();
            let v9 = &mut v8;
            0x1::vector::push_back<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>(v9, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::decimal_to_fixedpoint64(arg0));
            0x1::vector::push_back<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>(v9, v2);
            0x1::vector::push_back<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>(v9, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::decimal_to_fixedpoint64(arg4));
            let v10 = 0x1::vector::empty<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>();
            let v11 = &mut v10;
            0x1::vector::push_back<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>(v11, v0);
            0x1::vector::push_back<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64>(v11, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::decimal_to_fixedpoint64(arg3));
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::multiply_divide(&mut v8, &mut v10)
        };
        let v12 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::min(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from_rational(9999999999, 10000000000), v3);
        let v13 = newton_raphson(v3, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from((arg7 as u128)), v12);
        assert!(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::lt(v13, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::one()), 4);
        let v14 = if (arg8) {
            (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::to_u128_down(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::min(v13, v12), v1)) as u64)
        } else {
            (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::to_u128_down(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::min(v13, v12), v0)) as u64)
        };
        if (arg8) {
            assert!(v14 < 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::floor(arg2), 7);
        } else {
            assert!(v14 < 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::floor(arg1), 7);
        };
        v14
    }

    public fun new_and_share<T0, T1, T2, T3, T4: drop>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::registry::Registry, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x2::coin::CoinMetadata<T2>, arg7: &0x2::coin::CoinMetadata<T3>, arg8: &mut 0x2::coin::CoinMetadata<T4>, arg9: 0x2::coin::TreasuryCap<T4>, arg10: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::OracleRegistry, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T2, T3, OracleQuoter, T4>>(new<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15));
    }

    fun newton_raphson(arg0: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64, arg1: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64, arg2: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64 {
        newton_raphson_(arg0, arg1, arg2, 20)
    }

    fun newton_raphson_(arg0: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64, arg1: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64, arg2: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64, arg3: u64) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64 {
        let v0 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::one();
        let v1 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from_rational(1, 100000);
        let v2 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from_rational(999999999999999999, 1000000000000000000);
        let v3 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from_rational(1, 100000000000000);
        let v4 = if (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::gte(arg2, v0)) {
            v2
        } else {
            arg2
        };
        let v5 = v4;
        let v6 = 0;
        while (v6 < arg3) {
            let (v7, v8) = compute_f(v5, arg1, arg0);
            if (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::lt(v7, v3)) {
                break
            };
            let v9 = compute_f_prime(v5, arg1);
            assert!(!0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::lt(v9, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from_rational(1, 10000000000)), 1001);
            let v10 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::div(v7, v9);
            let v11 = if (v8) {
                0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::sub(v5, v10)
            } else {
                0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::add(v5, v10)
            };
            let v12 = v11;
            if (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::lte(v11, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::zero()) || 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::gte(v11, v0)) {
                let v13 = if (v8) {
                    0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::sub(v4, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::mul(v10, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from_rational(1, 2)))
                } else {
                    0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::add(v4, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::mul(v10, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from_rational(1, 2)))
                };
                let v14 = if (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::lt(v13, v1)) {
                    v1
                } else if (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::gt(v13, v2)) {
                    v2
                } else {
                    v13
                };
                v12 = v14;
            };
            let v15 = if (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::gte(v12, v4)) {
                0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::sub(v12, v4)
            } else {
                0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::sub(v4, v12)
            };
            if (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::lt(v15, v3)) {
                break
            };
            v5 = v12;
            v6 = v6 + 1;
        };
        v5
    }

    public fun pause_pool<T0, T1, T2: drop>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, OracleQuoter, T2>, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_pause_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::pause_pool<T0, T1, OracleQuoter, T2>(arg0, arg1);
    }

    fun price_uncertainty_ratio(arg0: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::OraclePriceUpdate) : u64 {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::confidence(arg0) * 10000 / 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::price_magnitude(arg0)
    }

    public fun quote_swap<T0, T1, T2, T3, T4: drop, T5, T6>(arg0: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T2, T3, OracleQuoter, T4>, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::Bank<T0, T2>, arg3: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::Bank<T1, T3>, arg4: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T0, T5>, arg5: &0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_vault::Vault<T1, T6>, arg6: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg7: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg8: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::OraclePriceUpdate, arg9: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::OraclePriceUpdate, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::quote::SwapQuote {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        assert!(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::oracle_registry_id(&arg8) == 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T2, T3, OracleQuoter, T4>(arg0).oracle_registry_id, 2);
        assert!(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::oracle_index(&arg8) == 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T2, T3, OracleQuoter, T4>(arg0).oracle_index_a, 1);
        assert!(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::oracle_registry_id(&arg9) == 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T2, T3, OracleQuoter, T4>(arg0).oracle_registry_id, 2);
        assert!(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::oracle_index(&arg9) == 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T2, T3, OracleQuoter, T4>(arg0).oracle_index_b, 1);
        let (v0, v1) = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::get_btoken_ratio<T0, T2, T5>(arg2, arg4, arg6, arg12);
        let v2 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(v0, v1);
        let (v3, v4) = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::bank::get_btoken_ratio<T1, T3, T6>(arg3, arg5, arg7, arg12);
        let v5 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(v3, v4);
        quote_swap_<T2, T3, T4>(arg0, arg1, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::oracle_decimal_to_decimal(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::price(&arg8)), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils::oracle_decimal_to_decimal(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracles::price(&arg9)), price_uncertainty_ratio(&arg8), price_uncertainty_ratio(&arg9), v2, v5, 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::balance_amount_a<T2, T3, OracleQuoter, T4>(arg0)), v2), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::balance_amount_b<T2, T3, OracleQuoter, T4>(arg0)), v5), arg10, arg11)
    }

    fun quote_swap_<T0, T1, T2: drop>(arg0: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, OracleQuoter, T2>, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg3: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg4: u64, arg5: u64, arg6: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg7: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg8: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg9: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg10: u64, arg11: bool) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::quote::SwapQuote {
        let v0 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T0, T1, OracleQuoter, T2>(arg0);
        let v1 = if (arg11) {
            let v2 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::floor(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(get_swap_output(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(arg10), arg6), arg8, arg9, arg2, arg3, (v0.decimals_a as u64), (v0.decimals_b as u64), v0.amp, true)), arg7));
            let v3 = v2;
            if (v2 >= 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::balance_amount_b<T0, T1, OracleQuoter, T2>(arg0)) {
                v3 = 0;
            };
            v3
        } else {
            let v4 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::floor(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(get_swap_output(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(arg10), arg7), arg8, arg9, arg2, arg3, (v0.decimals_a as u64), (v0.decimals_b as u64), v0.amp, false)), arg6));
            let v5 = v4;
            if (v4 >= 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::balance_amount_a<T0, T1, OracleQuoter, T2>(arg0)) {
                v5 = 0;
            };
            v5
        };
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::get_quote<T0, T1, OracleQuoter, T2>(arg0, arg1, arg10, v1, arg11, 0x1::option::some<u64>(0x1::u64::max(arg4, arg5)))
    }

    public(friend) fun quote_swap_impl(arg0: u64, arg1: u8, arg2: u8, arg3: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg4: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg5: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal, arg6: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal) : u64 {
        if (arg1 > arg2) {
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::floor(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(arg0), arg5), arg3), arg4), arg6), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(0x1::u64::pow(10, ((arg1 - arg2) as u8)))))
        } else {
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::floor(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(arg0), arg5), arg3), arg4), arg6), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(0x1::u64::pow(10, ((arg2 - arg1) as u8)))))
        }
    }

    public fun resume_pool<T0, T1, T2: drop>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, OracleQuoter, T2>, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_pause_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::resume_pool<T0, T1, OracleQuoter, T2>(arg0, arg1);
    }

    public fun update_amplifier<T0, T1, T2: drop>(arg0: &mut 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, OracleQuoter, T2>, arg1: &0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_package_version(arg1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::global_config::check_bank_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 >= 1 && arg2 <= 10000, 6);
        let v0 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter<T0, T1, OracleQuoter, T2>(arg0).amp;
        if (v0 != arg2) {
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::quoter_mut<T0, T1, OracleQuoter, T2>(arg0).amp = arg2;
            let v1 = AmplifierUpdatedEvent{
                pool_id       : 0x2::object::id<0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::pool::Pool<T0, T1, OracleQuoter, T2>>(arg0),
                old_amplifier : v0,
                new_amplifier : arg2,
            };
            0x2::event::emit<AmplifierUpdatedEvent>(v1);
        };
    }

    // decompiled from Move bytecode v6
}

