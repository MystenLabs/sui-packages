module 0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::pool_script_v2 {
    fun cleanup_swap<T0, T1, T2, T3, T4>(arg0: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg1: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg2: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T3>(&arg5);
        let v1 = 0x2::coin::value<T4>(&arg6);
        if (v0 > 0) {
            let v2 = 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::burn_btoken<T0, T1, T3>(arg0, arg2, &mut arg5, v0, arg8, arg9);
            assert!(0x2::coin::value<T1>(&v2) >= arg7, 0);
            0x2::coin::join<T1>(arg3, v2);
        };
        if (v1 > 0) {
            let v3 = 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::burn_btoken<T0, T2, T4>(arg1, arg2, &mut arg6, v1, arg8, arg9);
            assert!(0x2::coin::value<T2>(&v3) >= arg7, 0);
            0x2::coin::join<T2>(arg4, v3);
        };
        0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::pool_script::destroy_or_transfer<T3>(arg5, arg9);
        0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::pool_script::destroy_or_transfer<T4>(arg6, arg9);
    }

    public fun cpmm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::Pool<T3, T4, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::cpmm::CpQuoter, T5>, arg1: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg2: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        let v3 = v1;
        let v4 = v0;
        0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::cpmm::swap<T3, T4, T5>(arg0, &mut v4, &mut v3, arg6, v2, 0, arg10);
        cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, v4, v3, arg8, arg9, arg10);
    }

    public fun deposit_liquidity<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::Pool<T3, T4, T5, T6>, arg1: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg2: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T6> {
        let v0 = 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::mint_btoken<T0, T1, T3>(arg1, arg3, arg4, arg6, arg8, arg9);
        let v1 = 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::mint_btoken<T0, T2, T4>(arg2, arg3, arg5, arg7, arg8, arg9);
        let (v2, _) = 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::deposit_liquidity<T3, T4, T5, T6>(arg0, &mut v0, &mut v1, 0x2::coin::value<T3>(&v0), 0x2::coin::value<T4>(&v1), arg9);
        let v4 = 0x2::coin::value<T3>(&v0);
        let v5 = 0x2::coin::value<T4>(&v1);
        if (v4 > 0) {
            0x2::coin::join<T1>(arg4, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::burn_btoken<T0, T1, T3>(arg1, arg3, &mut v0, v4, arg8, arg9));
        };
        if (v5 > 0) {
            0x2::coin::join<T2>(arg5, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::burn_btoken<T0, T2, T4>(arg2, arg3, &mut v1, v5, arg8, arg9));
        };
        0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::pool_script::destroy_or_transfer<T3>(v0, arg9);
        0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::pool_script::destroy_or_transfer<T4>(v1, arg9);
        v2
    }

    public fun omm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::Pool<T3, T4, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::omm::OracleQuoter, T5>, arg1: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg2: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg11, arg12);
        let v3 = v1;
        let v4 = v0;
        0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::omm::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v4, &mut v3, arg8, v2, 0, arg11, arg12);
        cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, v4, v3, arg10, arg11, arg12);
    }

    public fun quote_cpmm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::Pool<T3, T4, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::cpmm::CpQuoter, T5>, arg1: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg2: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) : 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::SwapQuote {
        to_underlying_quote<T0, T1, T2, T3, T4>(0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::cpmm::quote_swap<T3, T4, T5>(arg0, to_btoken_amount_in<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6), arg4), arg1, arg2, arg3, arg4, arg6)
    }

    public fun quote_deposit<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::Pool<T3, T4, T5, T6>, arg1: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg2: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::DepositQuote {
        let v0 = 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::quote_deposit<T3, T4, T5, T6>(arg0, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg4, arg6), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg5, arg6));
        let v1 = 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::deposit_quote(0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::initial_deposit(&v0), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::deposit_a(&v0), arg6), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::deposit_b(&v0), arg6), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::mint_lp(&v0));
        0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::script_events::emit_event<0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::DepositQuote>(v1);
        v1
    }

    public fun quote_omm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::Pool<T3, T4, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::omm::OracleQuoter, T5>, arg1: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg2: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock) : 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::SwapQuote {
        to_underlying_quote<T0, T1, T2, T3, T4>(0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::omm::quote_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, to_btoken_amount_in<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg7, arg6, arg8), arg7, arg8), arg1, arg2, arg3, arg7, arg8)
    }

    public fun quote_redeem<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::Pool<T3, T4, T5, T6>, arg1: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg2: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock) : 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::RedeemQuote {
        let v0 = 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::quote_redeem<T3, T4, T5, T6>(arg0, arg4);
        let v1 = 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::redeem_quote(0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::withdraw_a(&v0), arg5), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::withdraw_b(&v0), arg5), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::burn_lp(&v0));
        0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::script_events::emit_event<0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::RedeemQuote>(v1);
        v1
    }

    public fun quote_stable_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::Pool<T3, T4, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::stable::StableQuoter, T5>, arg1: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg2: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock) : 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::SwapQuote {
        to_underlying_quote<T0, T1, T2, T3, T4>(0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::stable::quote_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, to_btoken_amount_in<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg7, arg6, arg8), arg7, arg8), arg1, arg2, arg3, arg7, arg8)
    }

    public fun redeem_liquidity<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::Pool<T3, T4, T5, T6>, arg1: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg2: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T6>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let (v0, v1, _) = 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::redeem_liquidity<T3, T4, T5, T6>(arg0, arg4, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg5, arg7), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg6, arg7), arg8);
        let v3 = v1;
        let v4 = v0;
        0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::pool_script::destroy_or_transfer<T3>(v4, arg8);
        0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::pool_script::destroy_or_transfer<T4>(v3, arg8);
        (0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::burn_btoken<T0, T1, T3>(arg1, arg3, &mut v4, 0x2::coin::value<T3>(&v4), arg7, arg8), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::burn_btoken<T0, T2, T4>(arg2, arg3, &mut v3, 0x2::coin::value<T4>(&v3), arg7, arg8))
    }

    public fun stable_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::pool::Pool<T3, T4, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::stable::StableQuoter, T5>, arg1: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg2: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg11, arg12);
        let v3 = v1;
        let v4 = v0;
        0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::stable::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v4, &mut v3, arg8, v2, 0, arg11, arg12);
        cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, v4, v3, arg10, arg11, arg12);
    }

    fun to_btoken_amount_in<T0, T1, T2, T3, T4>(arg0: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg1: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg2: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        if (arg3) {
            0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::to_btokens<T0, T1, T3>(arg0, arg2, arg4, arg5)
        } else {
            0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::to_btokens<T0, T2, T4>(arg1, arg2, arg4, arg5)
        }
    }

    fun to_btokens<T0, T1, T2, T3, T4>(arg0: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg1: &mut 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg2: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, u64) {
        let (v0, v1) = if (arg5) {
            (0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::mint_btoken<T0, T1, T3>(arg0, arg2, arg3, arg6, arg7, arg8), 0x2::coin::zero<T4>(arg8))
        } else {
            (0x2::coin::zero<T3>(arg8), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::mint_btoken<T0, T2, T4>(arg1, arg2, arg4, arg6, arg7, arg8))
        };
        let v2 = v1;
        let v3 = v0;
        let v4 = if (arg5) {
            0x2::coin::value<T3>(&v3)
        } else {
            0x2::coin::value<T4>(&v2)
        };
        (v3, v2, v4)
    }

    fun to_underlying_quote<T0, T1, T2, T3, T4>(arg0: 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::SwapQuote, arg1: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T1, T3>, arg2: &0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: bool, arg5: &0x2::clock::Clock) : 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::SwapQuote {
        let (v0, v1, v2, v3) = if (arg4) {
            (0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::amount_in(&arg0), arg5), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::amount_out(&arg0), arg5), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::protocol_fees(0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::output_fees(&arg0)), arg5), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::pool_fees(0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::output_fees(&arg0)), arg5))
        } else {
            (0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::amount_in(&arg0), arg5), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::amount_out(&arg0), arg5), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::protocol_fees(0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::output_fees(&arg0)), arg5), 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::pool_fees(0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::output_fees(&arg0)), arg5))
        };
        let v4 = 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::quote(v0, v1, v2, v3, arg4);
        0x3dd4aabf6eab35209df26932781ab3e4edaa0cdbfcba92585725e463dfb41b40::script_events::emit_event<0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::quote::SwapQuote>(v4);
        v4
    }

    // decompiled from Move bytecode v6
}

