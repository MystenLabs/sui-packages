module 0x6c96c6b158985dc23d3332aae182850c00e61f8d7711fefd61353cd8b6b84323::s {
    public fun ab<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T0, T3>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T1, T4>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg6);
        let v0 = 0x2::coin::from_balance<T0>(arg4, arg6);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T2, T0, T3>(arg0, arg2, &mut v0, 0x2::coin::value<T0>(&v0), arg5, arg6);
        settle<T0>(v0, arg6);
        let v2 = 0x2::coin::zero<T4>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg3, &mut v1, &mut v2, true, 0x2::coin::value<T3>(&v1), 0, arg6);
        settle<T3>(v1, arg6);
        settle<T4>(v2, arg6);
        0x2::coin::into_balance<T1>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T2, T1, T4>(arg1, arg2, &mut v2, 0x2::coin::value<T4>(&v2), arg5, arg6))
    }

    public fun ba<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T0, T3>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T1, T4>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg6);
        let v0 = 0x2::coin::from_balance<T1>(arg4, arg6);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T2, T1, T4>(arg1, arg2, &mut v0, 0x2::coin::value<T1>(&v0), arg5, arg6);
        settle<T1>(v0, arg6);
        let v2 = 0x2::coin::zero<T3>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg3, &mut v2, &mut v1, false, 0x2::coin::value<T4>(&v1), 0, arg6);
        settle<T4>(v1, arg6);
        settle<T3>(v2, arg6);
        0x2::coin::into_balance<T0>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T2, T0, T3>(arg0, arg2, &mut v2, 0x2::coin::value<T3>(&v2), arg5, arg6))
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    fun settle<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(0x2::coin::into_balance<T0>(arg0), 0x2::tx_context::sender(arg1));
        };
    }

    public fun sx<T0, T1, T2, T3, T4: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T0, T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, 0x2::sui::SUI, T3>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T2, T3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T4>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg6);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(arg4, arg6);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T1, 0x2::sui::SUI, T3>(arg1, arg2, &mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0), arg5, arg6);
        settle<0x2::sui::SUI>(v0, arg6);
        let v2 = 0x2::coin::zero<T2>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T2, T3, T4>(arg3, &mut v2, &mut v1, false, 0x2::coin::value<T3>(&v1), 0, arg6);
        settle<T3>(v1, arg6);
        settle<T2>(v2, arg6);
        0x2::coin::into_balance<T0>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T1, T0, T2>(arg0, arg2, &mut v2, 0x2::coin::value<T2>(&v2), arg5, arg6))
    }

    public fun xs<T0, T1, T2, T3, T4: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T0, T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, 0x2::sui::SUI, T3>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T2, T3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T4>, arg4: 0x2::balance::Balance<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg6);
        let v0 = 0x2::coin::from_balance<T0>(arg4, arg6);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T1, T0, T2>(arg0, arg2, &mut v0, 0x2::coin::value<T0>(&v0), arg5, arg6);
        settle<T0>(v0, arg6);
        let v2 = 0x2::coin::zero<T3>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T2, T3, T4>(arg3, &mut v1, &mut v2, true, 0x2::coin::value<T2>(&v1), 0, arg6);
        settle<T2>(v1, arg6);
        settle<T3>(v2, arg6);
        0x2::coin::into_balance<0x2::sui::SUI>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T1, 0x2::sui::SUI, T3>(arg1, arg2, &mut v2, 0x2::coin::value<T3>(&v2), arg5, arg6))
    }

    // decompiled from Move bytecode v7
}

