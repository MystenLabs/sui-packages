module 0xe509e90368e1a54163874cdc879f65fb6807e973da2fdc32a03b5ffd5a02061::adapter {
    public fun swap_a2b<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::SwapContext, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::take_balance<T1>(arg0);
        let v1 = 0x2::coin::from_balance<T1>(v0, arg6);
        0x2::coin::destroy_zero<T1>(v1);
        let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T1, T3>(arg2, arg4, &mut v1, 0x2::balance::value<T1>(&v0), arg5, arg6);
        let v3 = 0x2::coin::zero<T4>(arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg1, &mut v2, &mut v3, true, 0, 0, arg6);
        0x2::coin::destroy_zero<T3>(v2);
        0x2::coin::destroy_zero<T4>(v3);
        0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::merge_balance<T2>(arg0, 0x2::coin::into_balance<T2>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T2, T4>(arg3, arg4, &mut v3, 0x2::coin::value<T4>(&v3), arg5, arg6)));
    }

    public fun swap_b2a<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::SwapContext, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::take_balance<T2>(arg0);
        let v1 = 0x2::coin::from_balance<T2>(v0, arg6);
        0x2::coin::destroy_zero<T2>(v1);
        let v2 = 0x2::coin::zero<T3>(arg6);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T2, T4>(arg3, arg4, &mut v1, 0x2::balance::value<T2>(&v0), arg5, arg6);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg1, &mut v2, &mut v3, false, 0, 0, arg6);
        0x2::coin::destroy_zero<T3>(v2);
        0x2::coin::destroy_zero<T4>(v3);
        0x3a8311cb46fdbec581a94288b3a4aa6b63d1ceda4e806b3706cabf2296d1e41::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T1, T3>(arg2, arg4, &mut v2, 0x2::coin::value<T3>(&v2), arg5, arg6)));
    }

    // decompiled from Move bytecode v6
}

