module 0x62d2fb1a49e4d827917d6d3a3d3587b4861a398cb16de47f556bfd4af3230f30::deposit {
    public fun deposit<T0, T1, T2>(arg0: &mut 0x62d2fb1a49e4d827917d6d3a3d3587b4861a398cb16de47f556bfd4af3230f30::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        assert!(0x2::coin::value<T0>(&arg3) > 0, 0);
        assert!(0x2::coin::value<T1>(&arg4) > 0, 0);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x62d2fb1a49e4d827917d6d3a3d3587b4861a398cb16de47f556bfd4af3230f30::vault::position_borrow<T0, T1, T2>(arg0));
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0x62d2fb1a49e4d827917d6d3a3d3587b4861a398cb16de47f556bfd4af3230f30::vault::position_borrow_mut<T0, T1, T2>(arg0), 0x2::coin::value<T0>(&arg3), true, arg5);
        let (v2, v3, v4, v5) = take_lp_coins<T0, T1>(&v1, arg3, arg4, arg6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::coin::into_balance<T0>(v2), 0x2::coin::into_balance<T1>(v3), v1);
        (0x62d2fb1a49e4d827917d6d3a3d3587b4861a398cb16de47f556bfd4af3230f30::vault::mint_vault_coin<T0, T1, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x62d2fb1a49e4d827917d6d3a3d3587b4861a398cb16de47f556bfd4af3230f30::vault::position_borrow<T0, T1, T2>(arg0)) - v0, v0, arg6), v4, v5)
    }

    public entry fun deposit_entry<T0, T1, T2>(arg0: &mut 0x62d2fb1a49e4d827917d6d3a3d3587b4861a398cb16de47f556bfd4af3230f30::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v4), 0x2::tx_context::sender(arg6));
        };
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v3), 0x2::tx_context::sender(arg6));
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v4);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg6));
    }

    fun destroy_if_zero<T0>(arg0: 0x2::coin::Coin<T0>) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        let v0 = 0x1::option::none<0x2::coin::Coin<T0>>();
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0, arg0);
        };
        v0
    }

    fun take_lp_coins<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::AddLiquidityReceipt<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) >= v0, 0);
        assert!(0x2::coin::value<T1>(&arg2) > v1, 0);
        (0x2::coin::split<T0>(&mut arg1, v0, arg3), 0x2::coin::split<T1>(&mut arg2, v1, arg3), destroy_if_zero<T0>(arg1), destroy_if_zero<T1>(arg2))
    }

    // decompiled from Move bytecode v6
}

