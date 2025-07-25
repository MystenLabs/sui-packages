module 0xd09797cb4aa265618098c188f572607e2062594ae984af497d44a922ae979cd7::router {
    struct FullSailRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut FullSailRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut FullSailRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FullSailRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<FullSailRouterWrapper>(v0);
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut FullSailRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::config::GlobalConfig, arg4: &mut 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::rewarder::RewarderGlobalVault, arg5: &mut 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::pool::Pool<T1, T2>, arg6: &mut 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::stats::Stats, arg7: &0x344d812144c8e85d3c8b19c227a896c6b361124a1907e330c99070e070b95ef9::price_provider::PriceProvider, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T1>(arg1, &arg2);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x2::tx_context::sender(arg9);
        let (v2, v3, v4) = 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::pool::flash_swap<T1, T2>(arg3, arg4, arg5, true, true, v0, 4295048016, arg6, arg7, arg8);
        let v5 = v4;
        let v6 = v2;
        let v7 = 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::pool::swap_pay_amount<T1, T2>(&v5);
        let v8 = if (v7 == v0) {
            0x2::coin::into_balance<T1>(arg2)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v1);
            0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg2), v7)
        };
        0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::pool::repay_flash_swap<T1, T2>(arg3, arg5, v8, 0x2::balance::zero<T2>(), v5);
        if (0x2::balance::value<T1>(&v6) == 0) {
            0x2::balance::destroy_zero<T1>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg9), v1);
        };
        let v9 = 0x2::coin::from_balance<T2>(v3, arg9);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v9));
        v9
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut FullSailRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::config::GlobalConfig, arg4: &mut 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::rewarder::RewarderGlobalVault, arg5: &mut 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::pool::Pool<T2, T1>, arg6: &mut 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::stats::Stats, arg7: &0x344d812144c8e85d3c8b19c227a896c6b361124a1907e330c99070e070b95ef9::price_provider::PriceProvider, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T1>(arg1, &arg2);
        let (v0, v1, v2) = 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::pool::flash_swap<T2, T1>(arg3, arg4, arg5, false, true, 0x2::coin::value<T1>(&arg2), 79226673515401279992447579055, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::pool::swap_pay_amount<T2, T1>(&v3);
        let v6 = if (v5 == 0x2::coin::value<T1>(&arg2)) {
            0x2::coin::into_balance<T1>(arg2)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg9));
            0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut arg2), v5)
        };
        0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::pool::repay_flash_swap<T2, T1>(arg3, arg5, 0x2::balance::zero<T2>(), v6, v3);
        if (0x2::balance::value<T1>(&v4) == 0) {
            0x2::balance::destroy_zero<T1>(v4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg9), 0x2::tx_context::sender(arg9));
        };
        let v7 = 0x2::coin::from_balance<T2>(v0, arg9);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v7));
        v7
    }

    // decompiled from Move bytecode v6
}

