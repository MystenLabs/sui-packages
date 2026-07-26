module 0x5b4dd326d191ad5ff9d7dfd3f135c676e26cb9ed4f96827e4bfaa680f4394163::v {
    public fun ba<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u128) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, arg3, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&arg3), arg4, arg5);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    public fun bb<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u128) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), arg3, false, true, 0x2::balance::value<T1>(&arg3), arg4, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    public fun gb<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert!(arg2 && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0) >= arg1 || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0) <= arg1, 101);
    }

    public fun gc<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert!(arg2 && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) >= arg1 || 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) <= arg1, 101);
    }

    public fun gm<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert!(arg2 && 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0) >= arg1 || 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0) <= arg1, 101);
    }

    public fun ka<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::from_balance<T0>(arg1, arg3);
        0x2::coin::into_balance<T1>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg0, v0, 0x2::coin::value<T0>(&v0), arg2, arg3))
    }

    public fun kb<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::from_balance<T1>(arg1, arg3);
        0x2::coin::into_balance<T0>(0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg0, v0, 0x2::coin::value<T1>(&v0), arg2, arg3))
    }

    public fun ma<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::balance::value<T0>(&arg3), arg4, arg2, arg1, arg5);
        0x2::balance::destroy_zero<T0>(v0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, arg3, 0x2::balance::zero<T1>(), arg1, arg5);
        v1
    }

    public fun mb<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::balance::value<T1>(&arg3), arg4, arg2, arg1, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, 0x2::balance::zero<T0>(), arg3, arg1, arg5);
        v0
    }

    public fun ta<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::coin::from_balance<T1>(arg5, arg7);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T1, T3>(arg0, arg2, &mut v0, 0x2::coin::value<T1>(&v0), arg4, arg7);
        0x2::coin::destroy_zero<T1>(v0);
        let v2 = 0x2::coin::zero<T4>(arg7);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg3, &mut v1, &mut v2, true, 0x2::coin::value<T3>(&v1), arg6, arg7);
        0x2::coin::destroy_zero<T3>(v1);
        0x2::coin::destroy_zero<T4>(v2);
        0x2::coin::into_balance<T2>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T2, T4>(arg1, arg2, &mut v2, 0x2::coin::value<T4>(&v2), arg4, arg7))
    }

    public fun tb<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T2>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::from_balance<T2>(arg5, arg7);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T2, T4>(arg1, arg2, &mut v0, 0x2::coin::value<T2>(&v0), arg4, arg7);
        0x2::coin::destroy_zero<T2>(v0);
        let v2 = 0x2::coin::zero<T3>(arg7);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T3, T4, T5>(arg3, &mut v2, &mut v1, false, 0x2::coin::value<T4>(&v1), arg6, arg7);
        0x2::coin::destroy_zero<T4>(v1);
        0x2::coin::destroy_zero<T3>(v2);
        0x2::coin::into_balance<T1>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T1, T3>(arg0, arg2, &mut v2, 0x2::coin::value<T3>(&v2), arg4, arg7))
    }

    public fun wa<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: 0x2::balance::Balance<T1>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::coin::from_balance<T1>(arg10, arg12);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T1, T3>(arg0, arg2, &mut v0, 0x2::coin::value<T1>(&v0), arg9, arg12);
        0x2::coin::destroy_zero<T1>(v0);
        let v2 = 0x2::coin::zero<T4>(arg12);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg3, arg0, arg1, arg2, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg4, arg5, arg7, arg9), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg4, arg6, arg8, arg9), &mut v1, &mut v2, true, 0x2::coin::value<T3>(&v1), arg11, arg9, arg12);
        0x2::coin::destroy_zero<T3>(v1);
        0x2::coin::destroy_zero<T4>(v2);
        0x2::coin::into_balance<T2>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T2, T4>(arg1, arg2, &mut v2, 0x2::coin::value<T4>(&v2), arg9, arg12))
    }

    public fun wb<T0, T1, T2, T3, T4, T5: drop>(arg0: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: 0x2::balance::Balance<T2>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::from_balance<T2>(arg10, arg12);
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T0, T2, T4>(arg1, arg2, &mut v0, 0x2::coin::value<T2>(&v0), arg9, arg12);
        0x2::coin::destroy_zero<T2>(v0);
        let v2 = 0x2::coin::zero<T3>(arg12);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T0, T1, T2, T3, T4, T5>(arg3, arg0, arg1, arg2, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg4, arg5, arg7, arg9), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price(arg4, arg6, arg8, arg9), &mut v2, &mut v1, false, 0x2::coin::value<T4>(&v1), arg11, arg9, arg12);
        0x2::coin::destroy_zero<T4>(v1);
        0x2::coin::destroy_zero<T3>(v2);
        0x2::coin::into_balance<T1>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T0, T1, T3>(arg0, arg2, &mut v2, 0x2::coin::value<T3>(&v2), arg9, arg12))
    }

    // decompiled from Move bytecode v7
}

