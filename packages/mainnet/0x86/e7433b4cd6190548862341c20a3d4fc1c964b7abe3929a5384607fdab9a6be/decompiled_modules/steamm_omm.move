module 0x493d7f1c702adc568b784196769b06057bc6cdee1cbe9760575bcc0972c67902::steamm_omm {
    public fun swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::SwapContext, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg7) {
            swap_a2b<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg10);
        } else {
            swap_b2a<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg10);
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::rebalance<T0, T1, T3>(arg2, arg4, arg9, arg10);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::rebalance<T0, T2, T4>(arg3, arg4, arg9, arg10);
    }

    public fun omm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0x2::balance::Balance<T1>, arg7: 0x2::balance::Balance<T2>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::coin::from_balance<T1>(arg6, arg10);
        let v1 = 0x2::coin::from_balance<T2>(arg7, arg10);
        let v2 = if (arg8) {
            0x2::coin::value<T1>(&v0)
        } else {
            0x2::coin::value<T2>(&v1)
        };
        let v3 = &mut v0;
        let v4 = &mut v1;
        omm_swap_<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, v3, v4, arg8, v2, arg9, arg10);
        (0x2::coin::into_balance<T1>(v0), 0x2::coin::into_balance<T2>(v1))
    }

    public fun omm_swap_<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x493d7f1c702adc568b784196769b06057bc6cdee1cbe9760575bcc0972c67902::utils::to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11);
        let v3 = v1;
        let v4 = v0;
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, &mut v4, &mut v3, arg8, v2, 0, arg10, arg11);
        0x493d7f1c702adc568b784196769b06057bc6cdee1cbe9760575bcc0972c67902::utils::cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg6, arg7, v4, v3, arg10, arg11);
    }

    fun swap_a2b<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::SwapContext, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::take_balance<T1>(arg0, arg7);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3) = omm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, v0, 0x2::balance::zero<T2>(), true, arg8, arg9);
        let v4 = v3;
        let v5 = 0x2::balance::value<T2>(&v4);
        if (arg7 == 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::max_amount_in()) {
            0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::transfer_balance<T1>(v2, 0x2::tx_context::sender(arg9), arg9);
        } else {
            0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::merge_balance<T1>(arg0, v2);
        };
        0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::merge_balance<T2>(arg0, v4);
        0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::emit_swap_event<T1, T2>(arg0, b"STEAMM_OMM", 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>>(arg1), v1 - v5, 0x2::balance::value<T2>(&v4), v5, true);
    }

    fun swap_b2a<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::SwapContext, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::take_balance<T2>(arg0, arg7);
        let v1 = 0x2::balance::value<T2>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T2>(v0);
            return
        };
        let (v2, v3) = omm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, 0x2::balance::zero<T1>(), v0, false, arg8, arg9);
        let v4 = v2;
        let v5 = 0x2::balance::value<T1>(&v4);
        if (arg7 == 0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::max_amount_in()) {
            0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::transfer_balance<T2>(v3, 0x2::tx_context::sender(arg9), arg9);
        } else {
            0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::merge_balance<T2>(arg0, v3);
        };
        0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::merge_balance<T1>(arg0, v4);
        0x7c27e879ba9282506284b0fef26d393978906fc9496550d978c6f493dbfa3e5::router::emit_swap_event<T1, T2>(arg0, b"STEAMM_OMM", 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>>(arg1), v1 - v5, 0x2::balance::value<T1>(&v4), v5, false);
    }

    // decompiled from Move bytecode v6
}

