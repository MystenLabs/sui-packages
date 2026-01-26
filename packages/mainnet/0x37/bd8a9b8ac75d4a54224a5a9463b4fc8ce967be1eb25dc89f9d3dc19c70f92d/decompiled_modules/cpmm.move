module 0x37bd8a9b8ac75d4a54224a5a9463b4fc8ce967be1eb25dc89f9d3dc19c70f92d::cpmm {
    public fun swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            swap_a2b<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        } else {
            swap_b2a<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::rebalance<T0, T1, T3>(arg2, arg4, arg7, arg8);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::rebalance<T0, T2, T4>(arg3, arg4, arg7, arg8);
    }

    fun execute_cpmm_swap<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::balance::Balance<T1>, arg5: 0x2::balance::Balance<T2>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::coin::from_balance<T1>(arg4, arg10);
        let v1 = 0x2::coin::from_balance<T2>(arg5, arg10);
        let v2 = &mut v0;
        let v3 = &mut v1;
        execute_cpmm_swap_with_coins<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, v2, v3, arg8, arg6, arg7, arg9, arg10);
        (0x2::coin::into_balance<T1>(v0), 0x2::coin::into_balance<T2>(v1))
    }

    fun execute_cpmm_swap_with_coins<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x37bd8a9b8ac75d4a54224a5a9463b4fc8ce967be1eb25dc89f9d3dc19c70f92d::utils::to_btokens<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        let v3 = v1;
        let v4 = v0;
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg0, &mut v4, &mut v3, arg6, v2, arg8, arg10);
        0x37bd8a9b8ac75d4a54224a5a9463b4fc8ce967be1eb25dc89f9d3dc19c70f92d::utils::cleanup_swap<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, v4, v3, arg9, arg10);
    }

    fun swap_a2b<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::take_balance<T1>(arg0, arg5);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3) = execute_cpmm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, v0, 0x2::balance::zero<T2>(), v1, 0, true, arg6, arg7);
        if (arg5 == 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::max_amount_in()) {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::transfer_balance<T1>(v2, 0x2::tx_context::sender(arg7), arg7);
        } else {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T1>(arg0, v2);
        };
        0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T2>(arg0, v3);
    }

    fun swap_b2a<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::take_balance<T2>(arg0, arg5);
        let v1 = 0x2::balance::value<T2>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T2>(v0);
            return
        };
        let (v2, v3) = execute_cpmm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, 0x2::balance::zero<T1>(), v0, v1, 0, false, arg6, arg7);
        if (arg5 == 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::max_amount_in()) {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::transfer_balance<T2>(v3, 0x2::tx_context::sender(arg7), arg7);
        } else {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T2>(arg0, v3);
        };
        0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T1>(arg0, v2);
    }

    // decompiled from Move bytecode v6
}

