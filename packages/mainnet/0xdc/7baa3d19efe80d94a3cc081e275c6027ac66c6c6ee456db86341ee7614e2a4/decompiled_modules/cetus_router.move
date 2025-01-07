module 0xdc7baa3d19efe80d94a3cc081e275c6027ac66c6c6ee456db86341ee7614e2a4::cetus_router {
    fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v6, arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v6, arg10)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg10));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg10));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v3);
        assert!(arg5 && v7 >= arg7 || v6 <= arg7, 1);
        if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg10));
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        if (0x2::coin::value<T1>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2::tx_context::sender(arg10));
        } else {
            0x2::coin::destroy_zero<T1>(arg3);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun swap_a2b<T0, T1>(arg0: &0xdc7baa3d19efe80d94a3cc081e275c6027ac66c6c6ee456db86341ee7614e2a4::bkswap::GlobalStatus, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg9);
        0x2::pay::join_vec<T0>(&mut v0, arg3);
        let v1 = 0xdc7baa3d19efe80d94a3cc081e275c6027ac66c6c6ee456db86341ee7614e2a4::bkswap::collect_fee<T0>(arg0, &mut v0, arg5, arg9);
        let v2 = 0x2::coin::zero<T1>(arg9);
        swap<T0, T1>(arg1, arg2, v0, v2, true, arg4, v1, arg6, arg7, arg8, arg9);
    }

    public entry fun swap_b2a<T0, T1>(arg0: &0xdc7baa3d19efe80d94a3cc081e275c6027ac66c6c6ee456db86341ee7614e2a4::bkswap::GlobalStatus, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg9);
        0x2::pay::join_vec<T1>(&mut v0, arg3);
        let v1 = 0xdc7baa3d19efe80d94a3cc081e275c6027ac66c6c6ee456db86341ee7614e2a4::bkswap::collect_fee<T1>(arg0, &mut v0, arg5, arg9);
        let v2 = 0x2::coin::zero<T0>(arg9);
        swap<T0, T1>(arg1, arg2, v2, v0, false, arg4, v1, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

