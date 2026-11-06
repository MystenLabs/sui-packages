module 0x180db51f4748adfc085e10f132729a0529886e0e86bf10939e42400a55b50c92::steamm_recall {
    public fun swap_a2b<T0, T1, T2, T3, T4, T5, T6: drop>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T4>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T3, T5>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: 0x2::balance::Balance<T2>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T3>, 0x2::balance::Balance<T2>) {
        let (v0, v1) = 0x180db51f4748adfc085e10f132729a0529886e0e86bf10939e42400a55b50c92::steamm::checked<T1, T2, T3, T4, T5, T6>(arg1, arg2, arg3);
        let v2 = 0x2::coin::from_balance<T2>(arg9, arg10);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T1, T2, T4>(arg2, arg4, &mut v2, 0x2::coin::value<T2>(&v2), arg8, arg10);
        0x2::coin::destroy_zero<T2>(v2);
        let v4 = 0x2::coin::zero<T5>(arg10);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T1, T2, T3, T4, T5, T6>(arg1, arg2, arg3, arg4, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg5, arg6, v0, arg8), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg5, arg7, v1, arg8), &mut v3, &mut v4, true, 0x2::coin::value<T4>(&v3), 0, arg8, arg10);
        0x2::coin::destroy_zero<T4>(v3);
        let v5 = 0x2::coin::into_balance<T3>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T1, T3, T5>(arg3, arg4, &mut v4, 0x2::coin::value<T5>(&v4), arg8, arg10));
        0x2::coin::destroy_zero<T5>(v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>>(arg1), true, 0x2::balance::value<T3>(&v5));
        (v5, 0x2::balance::zero<T2>())
    }

    public fun swap_b2a<T0, T1, T2, T3, T4, T5, T6: drop>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T4>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T3, T5>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: 0x2::balance::Balance<T3>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        let (v0, v1) = 0x180db51f4748adfc085e10f132729a0529886e0e86bf10939e42400a55b50c92::steamm::checked<T1, T2, T3, T4, T5, T6>(arg1, arg2, arg3);
        let v2 = 0x2::coin::from_balance<T3>(arg9, arg10);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T1, T3, T5>(arg3, arg4, &mut v2, 0x2::coin::value<T3>(&v2), arg8, arg10);
        0x2::coin::destroy_zero<T3>(v2);
        let v4 = 0x2::coin::zero<T4>(arg10);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T1, T2, T3, T4, T5, T6>(arg1, arg2, arg3, arg4, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg5, arg6, v0, arg8), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg5, arg7, v1, arg8), &mut v4, &mut v3, false, 0x2::coin::value<T5>(&v3), 0, arg8, arg10);
        0x2::coin::destroy_zero<T5>(v3);
        let v5 = 0x2::coin::into_balance<T2>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T1, T2, T4>(arg2, arg4, &mut v4, 0x2::coin::value<T4>(&v4), arg8, arg10));
        0x2::coin::destroy_zero<T4>(v4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>>(arg1), false, 0x2::balance::value<T2>(&v5));
        (v5, 0x2::balance::zero<T3>())
    }

    // decompiled from Move bytecode v7
}

