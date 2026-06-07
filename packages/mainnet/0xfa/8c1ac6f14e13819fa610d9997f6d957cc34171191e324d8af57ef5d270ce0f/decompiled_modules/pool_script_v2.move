module 0xfa8c1ac6f14e13819fa610d9997f6d957cc34171191e324d8af57ef5d270ce0f::pool_script_v2 {
    fun cleanup_swap<T0, T1, T2, T3, T4, T5: store, T6: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, T5, T6>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: 0x2::coin::Coin<T3>, arg7: 0x2::coin::Coin<T4>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T3>(&arg6);
        let v1 = 0x2::coin::value<T4>(&arg7);
        if (v0 > 0) {
            let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T3>(arg1, arg3, &mut arg6, v0, arg9, arg10);
            assert!(0x2::coin::value<T1>(&v2) >= arg8, 0);
            0x2::coin::join<T1>(arg4, v2);
        };
        if (v1 > 0) {
            let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T2, T4>(arg2, arg3, &mut arg7, v1, arg9, arg10);
            assert!(0x2::coin::value<T2>(&v3) >= arg8, 0);
            0x2::coin::join<T2>(arg5, v3);
        };
        destroy_or_transfer<T3>(arg6, arg10);
        destroy_or_transfer<T4>(arg7, arg10);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fee_crank::crank_fees<T0, T1, T2, T5, T6, T3, T4>(arg0, arg1, arg2);
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun omm_v2_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg11, arg12);
        let v3 = v1;
        let v4 = v0;
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v4, &mut v3, arg8, v2, 0, arg11, arg12);
        cleanup_swap<T0, T1, T2, T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>(arg0, arg1, arg2, arg3, arg6, arg7, v4, v3, arg10, arg11, arg12);
    }

    fun to_btokens<T0, T1, T2, T3, T4>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>, u64) {
        let (v0, v1) = if (arg5) {
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg0, arg2, arg3, arg6, arg7, arg8), 0x2::coin::zero<T4>(arg8))
        } else {
            (0x2::coin::zero<T3>(arg8), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg1, arg2, arg4, arg6, arg7, arg8))
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

    // decompiled from Move bytecode v7
}

