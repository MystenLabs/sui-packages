module 0x180db51f4748adfc085e10f132729a0529886e0e86bf10939e42400a55b50c92::cpmm_recall {
    public fun swap_a2b<T0, T1, T2, T3, T4, T5, T6: drop>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T6>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T4>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T3, T5>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0x2::clock::Clock, arg6: 0x2::balance::Balance<T2>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T3>, 0x2::balance::Balance<T2>) {
        0x180db51f4748adfc085e10f132729a0529886e0e86bf10939e42400a55b50c92::cpmm::checked<T1, T2, T3, T4, T5, T6>(arg1, arg2, arg3);
        let v0 = 0x2::coin::from_balance<T2>(arg6, arg7);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T1, T2, T4>(arg2, arg4, &mut v0, 0x2::coin::value<T2>(&v0), arg5, arg7);
        0x2::coin::destroy_zero<T2>(v0);
        let v2 = 0x2::coin::zero<T5>(arg7);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T4, T5, T6>(arg1, &mut v1, &mut v2, true, 0x2::coin::value<T4>(&v1), 0, arg7);
        0x2::coin::destroy_zero<T4>(v1);
        let v3 = 0x2::coin::into_balance<T3>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T1, T3, T5>(arg3, arg4, &mut v2, 0x2::coin::value<T5>(&v2), arg5, arg7));
        0x2::coin::destroy_zero<T5>(v2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T6>>(arg1), true, 0x2::balance::value<T3>(&v3));
        (v3, 0x2::balance::zero<T2>())
    }

    public fun swap_b2a<T0, T1, T2, T3, T4, T5, T6: drop>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T6>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T4>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T3, T5>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0x2::clock::Clock, arg6: 0x2::balance::Balance<T3>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        0x180db51f4748adfc085e10f132729a0529886e0e86bf10939e42400a55b50c92::cpmm::checked<T1, T2, T3, T4, T5, T6>(arg1, arg2, arg3);
        let v0 = 0x2::coin::from_balance<T3>(arg6, arg7);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T1, T3, T5>(arg3, arg4, &mut v0, 0x2::coin::value<T3>(&v0), arg5, arg7);
        0x2::coin::destroy_zero<T3>(v0);
        let v2 = 0x2::coin::zero<T4>(arg7);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T4, T5, T6>(arg1, &mut v2, &mut v1, false, 0x2::coin::value<T5>(&v1), 0, arg7);
        0x2::coin::destroy_zero<T5>(v1);
        let v3 = 0x2::coin::into_balance<T2>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T1, T2, T4>(arg2, arg4, &mut v2, 0x2::coin::value<T4>(&v2), arg5, arg7));
        0x2::coin::destroy_zero<T4>(v2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T6>>(arg1), false, 0x2::balance::value<T2>(&v3));
        (v3, 0x2::balance::zero<T3>())
    }

    // decompiled from Move bytecode v7
}

