module 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::omm {
    struct OracleQuoter has store {
        version: 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::version::Version,
        oracle_registry_id: 0x2::object::ID,
        oracle_index_a: u64,
        oracle_index_b: u64,
        decimals_a: u8,
        decimals_b: u8,
    }

    struct NewOracleQuoter has copy, drop, store {
        pool_id: 0x2::object::ID,
        oracle_registry_id: 0x2::object::ID,
        oracle_index_a: u64,
        oracle_index_b: u64,
    }

    public fun swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::Pool<T3, T4, OracleQuoter, T5>, arg1: &0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::bank::Bank<T0, T1, T3>, arg2: &0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &mut 0x2::coin::Coin<T3>, arg7: &mut 0x2::coin::Coin<T4>, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::SwapResult {
        0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::version::assert_version_and_upgrade(&mut 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::quoter_mut<T3, T4, OracleQuoter, T5>(arg0).version, 1);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(&arg4) == 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::quoter<T3, T4, OracleQuoter, T5>(arg0).oracle_registry_id, 2);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(&arg4) == 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::quoter<T3, T4, OracleQuoter, T5>(arg0).oracle_index_a, 1);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(&arg5) == 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::quoter<T3, T4, OracleQuoter, T5>(arg0).oracle_registry_id, 2);
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(&arg5) == 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::quoter<T3, T4, OracleQuoter, T5>(arg0).oracle_index_b, 1);
        0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::swap<T3, T4, OracleQuoter, T5>(arg0, arg6, arg7, quote_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg9, arg8, arg11), arg10, arg12)
    }

    public fun new<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::registry::Registry, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &0x2::coin::CoinMetadata<T2>, arg4: &0x2::coin::CoinMetadata<T3>, arg5: &0x2::coin::CoinMetadata<T4>, arg6: &mut 0x2::coin::CoinMetadata<T5>, arg7: 0x2::coin::TreasuryCap<T5>, arg8: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::Pool<T3, T4, OracleQuoter, T5> {
        assert!(0x1::type_name::get<T3>() == 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::registry::btoken_type(0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::registry::get_bank_data<T1>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1))), 0);
        assert!(0x1::type_name::get<T4>() == 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::registry::btoken_type(0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::registry::get_bank_data<T2>(arg0, 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg1))), 0);
        let v0 = OracleQuoter{
            version            : 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::version::new(1),
            oracle_registry_id : 0x2::object::id<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry>(arg8),
            oracle_index_a     : arg9,
            oracle_index_b     : arg10,
            decimals_a         : 0x2::coin::get_decimals<T1>(arg2),
            decimals_b         : 0x2::coin::get_decimals<T2>(arg3),
        };
        let v1 = 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::new<T3, T4, OracleQuoter, T5>(arg0, arg11, v0, arg4, arg5, arg6, arg7, arg12);
        let v2 = NewOracleQuoter{
            pool_id            : 0x2::object::id<0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::Pool<T3, T4, OracleQuoter, T5>>(&v1),
            oracle_registry_id : 0x2::object::id<0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry>(arg8),
            oracle_index_a     : arg9,
            oracle_index_b     : arg10,
        };
        0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::events::emit_event<NewOracleQuoter>(v2);
        v1
    }

    fun oracle_decimal_to_decimal(arg0: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::OracleDecimal) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        if (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::is_expo_negative(&arg0)) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_u128(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::base(&arg0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::expo(&arg0) as u8))))
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_u128(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::base(&arg0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::expo(&arg0) as u8))))
        }
    }

    public fun quote_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::Pool<T3, T4, OracleQuoter, T5>, arg1: &0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::bank::Bank<T0, T1, T3>, arg2: &0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock) : 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::quote::SwapQuote {
        let v0 = 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::quoter<T3, T4, OracleQuoter, T5>(arg0);
        let (v1, v2) = 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::bank::get_btoken_ratio<T0, T1, T3>(arg1, arg3, arg8);
        let (v3, v4) = 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::bank::get_btoken_ratio<T0, T2, T4>(arg2, arg3, arg8);
        let v5 = if (arg7) {
            quote_swap_impl(arg6, v0.decimals_a, v0.decimals_b, oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg4)), oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg5)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v1, v2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v3, v4))
        } else {
            quote_swap_impl(arg6, v0.decimals_b, v0.decimals_a, oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg5)), oracle_decimal_to_decimal(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(&arg4)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v3, v4), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(v1, v2))
        };
        let v6 = if (arg7) {
            if (v5 >= 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::balance_amount_b<T3, T4, OracleQuoter, T5>(arg0)) {
                0
            } else {
                v5
            }
        } else if (v5 >= 0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::balance_amount_a<T3, T4, OracleQuoter, T5>(arg0)) {
            0
        } else {
            v5
        };
        0x89f70ccda4cead29bb0cad2b6a46679a8358823fb9bb8e4d766cf1eaececaa3b::pool::get_quote<T3, T4, OracleQuoter, T5>(arg0, arg6, v6, arg7, 0x1::option::none<u64>())
    }

    public(friend) fun quote_swap_impl(arg0: u64, arg1: u8, arg2: u8, arg3: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg4: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg5: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg6: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : u64 {
        if (arg1 > arg2) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0), arg5), arg3), arg4), arg6), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, ((arg1 - arg2) as u8)))))
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0), arg5), arg3), arg4), arg6), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, ((arg2 - arg1) as u8)))))
        }
    }

    // decompiled from Move bytecode v6
}

