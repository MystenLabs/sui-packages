module 0x2bc50698b26faad5988f58313e2fc347f85b6b6554cde120504c58f6bc057c30::converter {
    public(friend) fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (0x2::coin::value<T0>(&arg2) == 0 || arg4 == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return (0x2::coin::zero<T0>(arg6), 0x2::coin::zero<T1>(arg6))
        };
        let v0 = 0x2::coin::zero<T1>(arg6);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1);
        let v2 = if (v1 == 100) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) * 999749968 / 1000000000
        } else if (v1 == 10000) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) * 992471662 / 1000000000
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) * 994987437 / 1000000000
        };
        let v3 = v2;
        if (v2 < 4295048016) {
            v3 = 4295048016;
        };
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, arg3, arg4, v3, arg5);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7);
        if (arg3 == true) {
            assert!(v9 == 0x2::coin::value<T0>(&arg2), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::high_slippage());
        } else {
            assert!(arg4 == 0x2::balance::value<T1>(&v8), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::high_slippage());
            assert!(0x2::coin::value<T0>(&arg2) >= v9, 1230);
        };
        0x2::coin::join<T1>(&mut v0, 0x2::coin::from_balance<T1>(v8, arg6));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v4, arg6));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v9, arg6)), 0x2::balance::zero<T1>(), v7);
        (arg2, v0)
    }

    // decompiled from Move bytecode v6
}

