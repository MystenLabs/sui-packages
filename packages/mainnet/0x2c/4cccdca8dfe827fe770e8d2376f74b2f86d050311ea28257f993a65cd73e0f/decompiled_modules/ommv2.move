module 0x2c4cccdca8dfe827fe770e8d2376f74b2f86d050311ea28257f993a65cd73e0f::ommv2 {
    public fun swap_oracle<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x2c4cccdca8dfe827fe770e8d2376f74b2f86d050311ea28257f993a65cd73e0f::swap_context::SwapContext, arg1: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: u64, arg6: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg7: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg8: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg9: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x2c4cccdca8dfe827fe770e8d2376f74b2f86d050311ea28257f993a65cd73e0f::swap_context::take_balance<T1>(arg0), arg12);
        let v1 = 0x2::coin::from_balance<T2>(0x2c4cccdca8dfe827fe770e8d2376f74b2f86d050311ea28257f993a65cd73e0f::swap_context::take_balance<T2>(arg0), arg12);
        let v2 = if (arg10) {
            0x2::coin::value<T1>(&v0)
        } else {
            0x2::coin::value<T2>(&v1)
        };
        0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::omm_v2_swap<T0, T1, T2, T3, T4, T5>(arg6, arg7, arg8, arg9, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg1, arg2, arg4, arg11), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg1, arg3, arg5, arg11), &mut v0, &mut v1, arg10, v2, 0, arg11, arg12);
        0x2c4cccdca8dfe827fe770e8d2376f74b2f86d050311ea28257f993a65cd73e0f::swap_context::merge_coin_balance<T1>(arg0, v0);
        0x2c4cccdca8dfe827fe770e8d2376f74b2f86d050311ea28257f993a65cd73e0f::swap_context::merge_coin_balance<T2>(arg0, v1);
    }

    // decompiled from Move bytecode v6
}

