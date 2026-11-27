module 0x9a5d43fb6a498c0e65bd4e274bd38a36cc266ed72bd85b13775dfc8333ade14d::pay {
    struct PopBoostPaid<phantom T0> has copy, drop {
        payer: address,
        curve_id: 0x2::object::ID,
        kind: u8,
        pool_id: 0x2::object::ID,
        paid: u64,
        sold: u64,
        burned: u64,
        season_sui: u64,
    }

    public fun pay_boost<T0>(arg0: &0x9a5d43fb6a498c0e65bd4e274bd38a36cc266ed72bd85b13775dfc8333ade14d::config::Config, arg1: &0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Config, arg2: &mut 0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::Treasury, arg3: &mut 0x2::coin_registry::Currency<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: 0x2::object::ID, arg7: u8, arg8: 0x2::coin::Coin<T0>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x9a5d43fb6a498c0e65bd4e274bd38a36cc266ed72bd85b13775dfc8333ade14d::config::assert_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg8);
        assert!(arg9 > 0, 300);
        assert!(arg9 <= v0, 303);
        let v1 = 0x2::coin::into_balance<T0>(arg8);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg5);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, true, true, arg9, v2 - v2 * 500 / 10000, arg11);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, 0x2::balance::split<T0>(&mut v1, v8), 0x2::balance::zero<0x2::sui::SUI>(), v6);
        0x2::balance::destroy_zero<T0>(v3);
        assert!(v8 > 0, 302);
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&v7);
        assert!(v9 >= arg10 && v9 >= 1000000, 301);
        0x918d32f8a0b349584e96113ec425708374161d4798f8c28d63362602831b33ef::config::donate_season(arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v7, arg12));
        0x2::coin_registry::burn_balance<T0>(arg3, v1);
        let v10 = PopBoostPaid<T0>{
            payer      : 0x2::tx_context::sender(arg12),
            curve_id   : arg6,
            kind       : arg7,
            pool_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg5),
            paid       : v0,
            sold       : v8,
            burned     : 0x2::balance::value<T0>(&v1),
            season_sui : v9,
        };
        0x2::event::emit<PopBoostPaid<T0>>(v10);
    }

    // decompiled from Move bytecode v7
}

