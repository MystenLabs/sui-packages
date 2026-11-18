module 0x725ae39fb1afcd41b71e89dfddfd8bfb1eab7f839d2831b5a6d63cc9527d44a7::steamm {
    fun assert_spent<T0>(arg0: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg0) == 0, 3);
        0x2::coin::destroy_zero<T0>(arg0);
    }

    public fun swap_a2b<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::coin::from_balance<T1>(arg5, arg6);
        let v1 = 0x2::coin::zero<T2>(arg6);
        0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, &mut v0, &mut v1, true, 0x2::balance::value<T1>(&arg5), 0, arg4, arg6);
        assert_spent<T1>(v0);
        0x2::coin::into_balance<T2>(v1)
    }

    public fun swap_b2a<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T2>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::zero<T1>(arg6);
        let v1 = 0x2::coin::from_balance<T2>(arg5, arg6);
        0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, &mut v0, &mut v1, false, 0x2::balance::value<T2>(&arg5), 0, arg4, arg6);
        assert_spent<T2>(v1);
        0x2::coin::into_balance<T1>(v0)
    }

    // decompiled from Move bytecode v7
}

