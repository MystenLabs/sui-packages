module 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::omm_v2 {
    struct OracleQuoterV2 has store {
        version: 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::version::Version,
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

    public fun swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::Pool<T3, T4, OracleQuoterV2, T5>, arg1: &0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::bank::Bank<T0, T1, T3>, arg2: &0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &mut 0x2::coin::Coin<T3>, arg7: &mut 0x2::coin::Coin<T4>, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::SwapResult {
        0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::version::assert_version_and_upgrade(&mut 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::quoter_mut<T3, T4, OracleQuoterV2, T5>(arg0).version, 1);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(&arg4) == 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_registry_id, 2);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(&arg4) == 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_index_a, 1);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(&arg5) == 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_registry_id, 2);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(&arg5) == 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0).oracle_index_b, 1);
        0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::swap<T3, T4, OracleQuoterV2, T5>(arg0, arg6, arg7, quote_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg9, arg8, arg11), arg10, arg12)
    }

    public fun new<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::registry::Registry, arg1: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &0x2::coin::CoinMetadata<T2>, arg4: &0x2::coin::CoinMetadata<T3>, arg5: &0x2::coin::CoinMetadata<T4>, arg6: &mut 0x2::coin::CoinMetadata<T5>, arg7: 0x2::coin::TreasuryCap<T5>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::Pool<T3, T4, OracleQuoterV2, T5> {
        assert!(0x1::type_name::get<T3>() == 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::registry::btoken_type(0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::registry::get_bank_data<T1>(arg0, 0x2::object::id<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>>(arg1))), 0);
        assert!(0x1::type_name::get<T4>() == 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::registry::btoken_type(0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::registry::get_bank_data<T2>(arg0, 0x2::object::id<0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>>(arg1))), 0);
        let v0 = OracleQuoterV2{
            version            : 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::version::new(1),
            oracle_registry_id : 0x2::object::id<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry>(arg8),
            oracle_index_a     : arg9,
            oracle_index_b     : arg10,
            decimals_a         : 0x2::coin::get_decimals<T1>(arg2),
            decimals_b         : 0x2::coin::get_decimals<T2>(arg3),
            amp                : arg11,
        };
        let v1 = 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::new<T3, T4, OracleQuoterV2, T5>(arg0, arg12, v0, arg4, arg5, arg6, arg7, arg13);
        let v2 = NewOracleQuoterV2{
            pool_id            : 0x2::object::id<0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::Pool<T3, T4, OracleQuoterV2, T5>>(&v1),
            oracle_registry_id : 0x2::object::id<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry>(arg8),
            oracle_index_a     : arg9,
            oracle_index_b     : arg10,
            amplifier          : arg11,
        };
        0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::events::emit_event<NewOracleQuoterV2>(v2);
        v1
    }

    public fun quote_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::Pool<T3, T4, OracleQuoterV2, T5>, arg1: &0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::bank::Bank<T0, T1, T3>, arg2: &0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock) : 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::quote::SwapQuote {
        let v0 = 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::quoter<T3, T4, OracleQuoterV2, T5>(arg0);
        let (v1, v2) = 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::bank::get_btoken_ratio<T0, T1, T3>(arg1, arg3, arg8);
        let v3 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(v1, v2);
        let (v4, v5) = 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::bank::get_btoken_ratio<T0, T2, T4>(arg2, arg3, arg8);
        let v6 = 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(v4, v5);
        let v7 = if (arg7) {
            quote_swap_impl(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg6), v3), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::balance_amount_a<T3, T4, OracleQuoterV2, T5>(arg0)), v3), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::balance_amount_b<T3, T4, OracleQuoterV2, T5>(arg0)), v6), v0.decimals_a, v0.decimals_b, 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::utils::oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg4)), 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::utils::oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg5)), v0.amp, arg7)
        } else {
            quote_swap_impl(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(arg6), v6), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::balance_amount_b<T3, T4, OracleQuoterV2, T5>(arg0)), v6), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::mul(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::balance_amount_a<T3, T4, OracleQuoterV2, T5>(arg0)), v3), v0.decimals_b, v0.decimals_a, 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::utils::oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg5)), 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::utils::oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg4)), v0.amp, arg7)
        };
        let v8 = if (arg7) {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(v7), v6))
        } else {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::div(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::from(v7), v3))
        };
        let v9 = if (arg7) {
            if (v8 >= 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::balance_amount_b<T3, T4, OracleQuoterV2, T5>(arg0)) {
                0
            } else {
                v8
            }
        } else if (v8 >= 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::balance_amount_a<T3, T4, OracleQuoterV2, T5>(arg0)) {
            0
        } else {
            v8
        };
        0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::pool::get_quote<T3, T4, OracleQuoterV2, T5>(arg0, arg6, v9, arg7)
    }

    fun quote_swap_impl(arg0: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, arg1: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, arg2: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, arg3: u8, arg4: u8, arg5: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, arg6: 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::Decimal, arg7: u64, arg8: bool) : u64 {
        if (arg8) {
            0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::quoter_math::swap(arg0, arg1, arg2, arg5, arg6, (arg3 as u64), (arg4 as u64), arg7, true)
        } else {
            0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::quoter_math::swap(arg0, arg2, arg1, arg6, arg5, (arg4 as u64), (arg3 as u64), arg7, false)
        }
    }

    // decompiled from Move bytecode v6
}

