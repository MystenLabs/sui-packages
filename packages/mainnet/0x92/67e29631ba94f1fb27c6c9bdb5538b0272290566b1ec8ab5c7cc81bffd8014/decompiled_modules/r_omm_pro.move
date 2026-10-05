module 0x3cf434dcc55a0b2f24e87f7952ba8262a40271e88fbb6937abbc661a10dd0317::r_omm_pro {
    public(friend) fun pro_prices(arg0: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg1: u64, arg2: u64, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) : (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate) {
        (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg0, arg3, arg1, arg5), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg0, arg4, arg2, arg5))
    }

    public fun steamm_omm_v2_pro_a2b<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: u64, arg7: u64, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u8, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return
        };
        let v0 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<T1>(arg0, arg10);
        let (v1, v2) = pro_prices(arg5, arg6, arg7, arg8, arg9, arg12);
        let v3 = 0x2::coin::from_balance<T1>(v0, arg13);
        let v4 = 0x2::coin::zero<T2>(arg13);
        0x87b4289a2d040d37a05fa7839267c2b579d9437c4ba1a4a35c681f80431d9233::steamm_omm_v2::omm_swap_v2_<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, v1, v2, &mut v3, &mut v4, true, 0x2::balance::value<T1>(&v0), arg12, arg13);
        0x2::coin::destroy_zero<T1>(v3);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T2>(arg0, arg10, 0x2::coin::into_balance<T2>(v4), arg11);
    }

    public fun steamm_omm_v2_pro_a2b_recall<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: u64, arg7: u64, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u8, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return
        };
        let v0 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<T1>(arg0, arg10);
        let (v1, v2) = pro_prices(arg5, arg6, arg7, arg8, arg9, arg12);
        let v3 = 0x2::coin::from_balance<T1>(v0, arg13);
        let v4 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T3>(arg2, arg4, &mut v3, 0x2::balance::value<T1>(&v0), arg12, arg13);
        0x2::coin::destroy_zero<T1>(v3);
        let v5 = 0x2::coin::zero<T4>(arg13);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, v1, v2, &mut v4, &mut v5, true, 0x2::coin::value<T3>(&v4), 0, arg12, arg13);
        0x2::coin::destroy_zero<T3>(v4);
        0x2::coin::destroy_zero<T4>(v5);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T2>(arg0, arg10, 0x2::coin::into_balance<T2>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T2, T4>(arg3, arg4, &mut v5, 0x2::coin::value<T4>(&v5), arg12, arg13)), arg11);
    }

    public fun steamm_omm_v2_pro_b2a<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: u64, arg7: u64, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u8, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return
        };
        let v0 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<T2>(arg0, arg10);
        let (v1, v2) = pro_prices(arg5, arg6, arg7, arg8, arg9, arg12);
        let v3 = 0x2::coin::zero<T1>(arg13);
        let v4 = 0x2::coin::from_balance<T2>(v0, arg13);
        0x87b4289a2d040d37a05fa7839267c2b579d9437c4ba1a4a35c681f80431d9233::steamm_omm_v2::omm_swap_v2_<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, v1, v2, &mut v3, &mut v4, false, 0x2::balance::value<T2>(&v0), arg12, arg13);
        0x2::coin::destroy_zero<T2>(v4);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T1>(arg0, arg10, 0x2::coin::into_balance<T1>(v3), arg11);
    }

    public fun steamm_omm_v2_pro_b2a_recall<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::Session, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: u64, arg7: u64, arg8: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg9: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg10: u8, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (!0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::armed(arg0)) {
            return
        };
        let v0 = 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::take<T2>(arg0, arg10);
        let (v1, v2) = pro_prices(arg5, arg6, arg7, arg8, arg9, arg12);
        let v3 = 0x2::coin::from_balance<T2>(v0, arg13);
        let v4 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T2, T4>(arg3, arg4, &mut v3, 0x2::balance::value<T2>(&v0), arg12, arg13);
        0x2::coin::destroy_zero<T2>(v3);
        let v5 = 0x2::coin::zero<T3>(arg13);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, v1, v2, &mut v5, &mut v4, false, 0x2::coin::value<T4>(&v4), 0, arg12, arg13);
        0x2::coin::destroy_zero<T4>(v4);
        0x2::coin::destroy_zero<T3>(v5);
        0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::session::put<T1>(arg0, arg10, 0x2::coin::into_balance<T1>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T1, T3>(arg2, arg4, &mut v5, 0x2::coin::value<T3>(&v5), arg12, arg13)), arg11);
    }

    // decompiled from Move bytecode v7
}

