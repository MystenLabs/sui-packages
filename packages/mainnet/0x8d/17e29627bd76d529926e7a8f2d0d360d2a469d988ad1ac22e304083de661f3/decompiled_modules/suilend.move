module 0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::suilend {
    fun liquidate_coll<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T2>(arg0, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T2>(arg0, arg3, arg4, v0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v1), arg6), arg6)
    }

    fun liquidate_sui<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg3, arg4, v0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, 0x2::sui::SUI>>(v1), arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, arg3, &v2, arg6, arg7);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg0, arg3, v2, arg7)
    }

    public fun sui_coll_ab<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::borrow_ab<T1>(arg0, arg1, arg8, arg2);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg10);
        let v3 = &mut v2;
        let v4 = liquidate_sui<T0, T1>(arg3, arg4, arg5, arg6, arg2, v3, arg7, arg10);
        0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::settle_ab<T1>(arg0, arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(v4), 0x2::coin::into_balance<T1>(v2), v1, arg9, arg10);
    }

    public fun sui_coll_ba<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::borrow_ba<T1>(arg0, arg1, arg8, arg2);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg10);
        let v3 = &mut v2;
        let v4 = liquidate_sui<T0, T1>(arg3, arg4, arg5, arg6, arg2, v3, arg7, arg10);
        0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::settle_ba<T1>(arg0, arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(v4), 0x2::coin::into_balance<T1>(v2), v1, arg9, arg10);
    }

    public fun swap_ab_ab<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::borrow_ab<T1>(arg0, arg1, arg8, arg3);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg10);
        let v3 = &mut v2;
        let v4 = liquidate_coll<T0, T1, T2>(arg4, arg5, arg6, arg7, arg3, v3, arg10);
        let (v5, v6) = 0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::sell_ab<T2>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), arg3);
        0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::keep<T2>(v6, arg10);
        0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::settle_ab<T1>(arg0, arg1, arg3, v5, 0x2::coin::into_balance<T1>(v2), v1, arg9, arg10);
    }

    public fun swap_ab_ba<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::borrow_ab<T1>(arg0, arg1, arg8, arg3);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg10);
        let v3 = &mut v2;
        let v4 = liquidate_coll<T0, T1, T2>(arg4, arg5, arg6, arg7, arg3, v3, arg10);
        let (v5, v6) = 0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::sell_ba<T2>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), arg3);
        0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::keep<T2>(v6, arg10);
        0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::settle_ab<T1>(arg0, arg1, arg3, v5, 0x2::coin::into_balance<T1>(v2), v1, arg9, arg10);
    }

    public fun swap_ba_ab<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::borrow_ba<T1>(arg0, arg1, arg8, arg3);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg10);
        let v3 = &mut v2;
        let v4 = liquidate_coll<T0, T1, T2>(arg4, arg5, arg6, arg7, arg3, v3, arg10);
        let (v5, v6) = 0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::sell_ab<T2>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), arg3);
        0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::keep<T2>(v6, arg10);
        0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::settle_ba<T1>(arg0, arg1, arg3, v5, 0x2::coin::into_balance<T1>(v2), v1, arg9, arg10);
    }

    public fun swap_ba_ba<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg3: &0x2::clock::Clock, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::borrow_ba<T1>(arg0, arg1, arg8, arg3);
        let v2 = 0x2::coin::from_balance<T1>(v0, arg10);
        let v3 = &mut v2;
        let v4 = liquidate_coll<T0, T1, T2>(arg4, arg5, arg6, arg7, arg3, v3, arg10);
        let (v5, v6) = 0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::sell_ba<T2>(arg0, arg2, 0x2::coin::into_balance<T2>(v4), arg3);
        0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::keep<T2>(v6, arg10);
        0x8d17e29627bd76d529926e7a8f2d0d360d2a469d988ad1ac22e304083de661f3::flash::settle_ba<T1>(arg0, arg1, arg3, v5, 0x2::coin::into_balance<T1>(v2), v1, arg9, arg10);
    }

    // decompiled from Move bytecode v7
}

