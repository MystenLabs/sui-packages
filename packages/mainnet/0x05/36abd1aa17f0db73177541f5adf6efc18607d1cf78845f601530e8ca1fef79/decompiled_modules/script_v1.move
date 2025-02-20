module 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::script_v1 {
    public fun deposit_liquidity<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &mut 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::pool::Pool<T3, T4, T5, T6>, arg1: &mut 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T1, T3>, arg2: &mut 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T2, T4>, arg3: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T6> {
        let v0 = 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::mint_btokens<T0, T1, T3>(arg1, arg3, arg4, arg6, arg8, arg9);
        let v1 = 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::mint_btokens<T0, T2, T4>(arg2, arg3, arg5, arg7, arg8, arg9);
        let (v2, _) = 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::pool::deposit_liquidity<T3, T4, T5, T6>(arg0, &mut v0, &mut v1, 0x2::coin::value<T3>(&v0), 0x2::coin::value<T4>(&v1), arg9);
        let v4 = 0x2::coin::value<T3>(&v0);
        let v5 = 0x2::coin::value<T4>(&v1);
        if (v4 > 0) {
            0x2::coin::join<T1>(arg4, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::burn_btokens<T0, T1, T3>(arg1, arg3, &mut v0, v4, arg8, arg9));
        };
        if (v5 > 0) {
            0x2::coin::join<T2>(arg5, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::burn_btokens<T0, T2, T4>(arg2, arg3, &mut v1, v5, arg8, arg9));
        };
        destroy_or_transfer<T3, T4>(v0, v1, arg9);
        v2
    }

    public fun quote_deposit<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::pool::Pool<T3, T4, T5, T6>, arg1: &0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T1, T3>, arg2: &0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T2, T4>, arg3: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::DepositQuote {
        0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::compound_interest_if_any<T0, T1, T3>(arg1, arg3, arg6);
        0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::compound_interest_if_any<T0, T2, T4>(arg2, arg3, arg6);
        let v0 = 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::pool::quote_deposit<T3, T4, T5, T6>(arg0, 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg4, arg6)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg5, arg6)));
        let v1 = 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::deposit_quote(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::initial_deposit(&v0), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::deposit_a(&v0), arg6)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::deposit_b(&v0), arg6)), 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::mint_lp(&v0));
        0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::events::emit_event<0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::DepositQuote>(v1);
        v1
    }

    public fun quote_redeem<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::pool::Pool<T3, T4, T5, T6>, arg1: &0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T1, T3>, arg2: &0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T2, T4>, arg3: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock) : 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::RedeemQuote {
        let v0 = 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::pool::quote_redeem<T3, T4, T5, T6>(arg0, arg4);
        let v1 = 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::redeem_quote(0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::withdraw_a(&v0), arg5)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::withdraw_b(&v0), arg5)), 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::burn_lp(&v0));
        0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::events::emit_event<0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::RedeemQuote>(v1);
        v1
    }

    public fun redeem_liquidity<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &mut 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::pool::Pool<T3, T4, T5, T6>, arg1: &mut 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T1, T3>, arg2: &mut 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T2, T4>, arg3: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: 0x2::coin::Coin<T6>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let (v0, v1, _) = 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::pool::redeem_liquidity<T3, T4, T5, T6>(arg0, arg4, arg5, arg6, arg8);
        let v3 = v1;
        let v4 = v0;
        destroy_or_transfer<T3, T4>(v4, v3, arg8);
        (0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::burn_btokens<T0, T1, T3>(arg1, arg3, &mut v4, 0x2::coin::value<T3>(&v4), arg7, arg8), 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::burn_btokens<T0, T2, T4>(arg2, arg3, &mut v3, 0x2::coin::value<T4>(&v3), arg7, arg8))
    }

    public fun cpmm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::pool::Pool<T3, T4, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::cpmm::CpQuoter, T5>, arg1: &mut 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T1, T3>, arg2: &mut 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T2, T4>, arg3: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg6) {
            (0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::mint_btokens<T0, T1, T3>(arg1, arg3, arg4, arg7, arg9, arg10), 0x2::coin::zero<T4>(arg10))
        } else {
            (0x2::coin::zero<T3>(arg10), 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::mint_btokens<T0, T2, T4>(arg2, arg3, arg5, arg7, arg9, arg10))
        };
        let v2 = v1;
        let v3 = v0;
        0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::cpmm::swap<T3, T4, T5>(arg0, &mut v3, &mut v2, arg6, arg7, arg8, arg10);
        let v4 = 0x2::coin::value<T3>(&v3);
        let v5 = 0x2::coin::value<T4>(&v2);
        if (v4 > 0) {
            0x2::coin::join<T1>(arg4, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::burn_btokens<T0, T1, T3>(arg1, arg3, &mut v3, v4, arg9, arg10));
        };
        if (v5 > 0) {
            0x2::coin::join<T2>(arg5, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::burn_btokens<T0, T2, T4>(arg2, arg3, &mut v2, v5, arg9, arg10));
        };
        destroy_or_transfer<T3, T4>(v3, v2, arg10);
    }

    fun destroy_or_transfer<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
        if (0x2::coin::value<T1>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<T1>(arg1);
        };
    }

    public fun quote_cpmm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::pool::Pool<T3, T4, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::cpmm::CpQuoter, T5>, arg1: &0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T1, T3>, arg2: &0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::Bank<T0, T2, T4>, arg3: &mut 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::lending_market::LendingMarket<T0>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) : 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::SwapQuote {
        0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::compound_interest_if_any<T0, T1, T3>(arg1, arg3, arg6);
        0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::compound_interest_if_any<T0, T2, T4>(arg2, arg3, arg6);
        let v0 = if (arg4) {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg5, arg6))
        } else {
            0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg5, arg6))
        };
        let v1 = 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::cpmm::quote_swap<T3, T4, T5>(arg0, v0, arg4);
        let (v2, v3, v4, v5) = if (arg4) {
            (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::amount_in(&v1), arg6)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::amount_out(&v1), arg6)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::protocol_fees(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::output_fees(&v1)), arg6)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::pool_fees(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::output_fees(&v1)), arg6)))
        } else {
            (0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::amount_in(&v1), arg6)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::amount_out(&v1), arg6)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::protocol_fees(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::output_fees(&v1)), arg6)), 0x1f54a9a2d71799553197e9ea24557797c6398d6a65f2d4d3818c9304b75d5e21::decimal::floor(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::pool_fees(0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::output_fees(&v1)), arg6)))
        };
        let v6 = 0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::quote(v2, v3, v4, v5, arg4);
        0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::events::emit_event<0x536abd1aa17f0db73177541f5adf6efc18607d1cf78845f601530e8ca1fef79::quote::SwapQuote>(v6);
        v6
    }

    // decompiled from Move bytecode v6
}

