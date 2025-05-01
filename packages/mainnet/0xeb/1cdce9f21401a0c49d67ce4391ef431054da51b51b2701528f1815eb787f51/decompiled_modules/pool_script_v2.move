module 0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::pool_script_v2 {
    fun to_btokens<T0, T1, T2, T3, T4>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg2: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, u64) {
        let (v0, v1) = if (arg5) {
            (0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::mint_btoken<T0, T1, T3>(arg0, arg2, arg3, arg6, arg7, arg8), 0x2::coin::zero<T4>(arg8))
        } else {
            (0x2::coin::zero<T3>(arg8), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::mint_btoken<T0, T2, T4>(arg1, arg2, arg4, arg6, arg7, arg8))
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

    public fun deposit_liquidity<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, T5, T6>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T6> {
        let v0 = 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::mint_btoken<T0, T1, T3>(arg1, arg3, arg4, arg6, arg8, arg9);
        let v1 = 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::mint_btoken<T0, T2, T4>(arg2, arg3, arg5, arg7, arg8, arg9);
        let (v2, _) = 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::deposit_liquidity<T3, T4, T5, T6>(arg0, &mut v0, &mut v1, 0x2::coin::value<T3>(&v0), 0x2::coin::value<T4>(&v1), arg9);
        let v4 = 0x2::coin::value<T3>(&v0);
        let v5 = 0x2::coin::value<T4>(&v1);
        if (v4 > 0) {
            0x2::coin::join<T1>(arg4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::burn_btoken<T0, T1, T3>(arg1, arg3, &mut v0, v4, arg8, arg9));
        };
        if (v5 > 0) {
            0x2::coin::join<T2>(arg5, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::burn_btoken<T0, T2, T4>(arg2, arg3, &mut v1, v5, arg8, arg9));
        };
        0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::pool_script::destroy_or_transfer<T3>(v0, arg9);
        0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::pool_script::destroy_or_transfer<T4>(v1, arg9);
        v2
    }

    public fun quote_deposit<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, T5, T6>, arg1: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::DepositQuote {
        let v0 = 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::quote_deposit<T3, T4, T5, T6>(arg0, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg4, arg6), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg5, arg6));
        let v1 = 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::deposit_quote(0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::initial_deposit(&v0), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::deposit_a(&v0), arg6), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::deposit_b(&v0), arg6), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::mint_lp(&v0));
        0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::script_events::emit_event<0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::DepositQuote>(v1);
        v1
    }

    public fun quote_redeem<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, T5, T6>, arg1: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock) : 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::RedeemQuote {
        let v0 = 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::quote_redeem<T3, T4, T5, T6>(arg0, arg4);
        let v1 = 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::redeem_quote(0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::withdraw_a(&v0), arg5), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::withdraw_b(&v0), arg5), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::burn_lp(&v0));
        0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::script_events::emit_event<0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::RedeemQuote>(v1);
        v1
    }

    public fun redeem_liquidity<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, T5, T6>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T6>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let (v0, v1, _) = 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::redeem_liquidity<T3, T4, T5, T6>(arg0, arg4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg5, arg7), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg6, arg7), arg8);
        let v3 = v1;
        let v4 = v0;
        0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::pool_script::destroy_or_transfer<T3>(v4, arg8);
        0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::pool_script::destroy_or_transfer<T4>(v3, arg8);
        (0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::burn_btoken<T0, T1, T3>(arg1, arg3, &mut v4, 0x2::coin::value<T3>(&v4), arg7, arg8), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::burn_btoken<T0, T2, T4>(arg2, arg3, &mut v3, 0x2::coin::value<T4>(&v3), arg7, arg8))
    }

    fun cleanup_swap<T0, T1, T2, T3, T4>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg2: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T3>(&arg5);
        let v1 = 0x2::coin::value<T4>(&arg6);
        if (v0 > 0) {
            let v2 = 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::burn_btoken<T0, T1, T3>(arg0, arg2, &mut arg5, v0, arg8, arg9);
            assert!(0x2::coin::value<T1>(&v2) >= arg7, 0);
            0x2::coin::join<T1>(arg3, v2);
        };
        if (v1 > 0) {
            let v3 = 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::burn_btoken<T0, T2, T4>(arg1, arg2, &mut arg6, v1, arg8, arg9);
            assert!(0x2::coin::value<T2>(&v3) >= arg7, 0);
            0x2::coin::join<T2>(arg4, v3);
        };
        0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::pool_script::destroy_or_transfer<T3>(arg5, arg9);
        0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::pool_script::destroy_or_transfer<T4>(arg6, arg9);
    }

    public fun cpmm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::cpmm::CpQuoter, T5>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        let v3 = v1;
        let v4 = v0;
        0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::cpmm::swap<T3, T4, T5>(arg0, &mut v4, &mut v3, arg6, v2, 0, arg10);
        cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, v4, v3, arg8, arg9, arg10);
    }

    public fun omm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm::OracleQuoter, T5>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg11, arg12);
        let v3 = v1;
        let v4 = v0;
        0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v4, &mut v3, arg8, v2, 0, arg11, arg12);
        cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, v4, v3, arg10, arg11, arg12);
    }

    public fun omm_v2_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm_v2::OracleQuoterV2, T5>, arg1: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &mut 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg11, arg12);
        let v3 = v1;
        let v4 = v0;
        0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v4, &mut v3, arg8, v2, 0, arg11, arg12);
        cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, v4, v3, arg10, arg11, arg12);
    }

    public fun quote_cpmm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::cpmm::CpQuoter, T5>, arg1: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) : 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::SwapQuote {
        to_underlying_quote<T0, T1, T2, T3, T4>(0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::cpmm::quote_swap<T3, T4, T5>(arg0, to_btoken_amount_in<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6), arg4), arg1, arg2, arg3, arg4, arg6)
    }

    public fun quote_omm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm::OracleQuoter, T5>, arg1: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock) : 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::SwapQuote {
        to_underlying_quote<T0, T1, T2, T3, T4>(0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm::quote_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, to_btoken_amount_in<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg7, arg6, arg8), arg7, arg8), arg1, arg2, arg3, arg7, arg8)
    }

    public fun quote_omm_v2_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::pool::Pool<T3, T4, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm_v2::OracleQuoterV2, T5>, arg1: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock) : 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::SwapQuote {
        to_underlying_quote<T0, T1, T2, T3, T4>(0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::omm_v2::quote_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, to_btoken_amount_in<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg7, arg6, arg8), arg7, arg8), arg1, arg2, arg3, arg7, arg8)
    }

    fun to_btoken_amount_in<T0, T1, T2, T3, T4>(arg0: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg1: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg2: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        if (arg3) {
            0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::to_btokens<T0, T1, T3>(arg0, arg2, arg4, arg5)
        } else {
            0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::to_btokens<T0, T2, T4>(arg1, arg2, arg4, arg5)
        }
    }

    fun to_underlying_quote<T0, T1, T2, T3, T4>(arg0: 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::SwapQuote, arg1: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T1, T3>, arg2: &0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::Bank<T0, T2, T4>, arg3: &0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: bool, arg5: &0x2::clock::Clock) : 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::SwapQuote {
        let (v0, v1, v2, v3) = if (arg4) {
            (0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::amount_in(&arg0), arg5), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::amount_out(&arg0), arg5), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::protocol_fees(0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::output_fees(&arg0)), arg5), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::pool_fees(0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::output_fees(&arg0)), arg5))
        } else {
            (0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::amount_in(&arg0), arg5), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::amount_out(&arg0), arg5), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::protocol_fees(0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::output_fees(&arg0)), arg5), 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::pool_fees(0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::output_fees(&arg0)), arg5))
        };
        let v4 = 0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::quote(v0, v1, v2, v3, arg4);
        0xeb1cdce9f21401a0c49d67ce4391ef431054da51b51b2701528f1815eb787f51::script_events::emit_event<0xc765782a3e13ca6d89880433bcd7137bf368860038bc52513f4e4710a92b9d13::quote::SwapQuote>(v4);
        v4
    }

    // decompiled from Move bytecode v6
}

