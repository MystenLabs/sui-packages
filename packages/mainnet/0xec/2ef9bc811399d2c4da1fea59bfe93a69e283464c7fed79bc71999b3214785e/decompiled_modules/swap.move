module 0xec2ef9bc811399d2c4da1fea59bfe93a69e283464c7fed79bc71999b3214785e::swap {
    public entry fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v3 = v2;
        let (v4, v5) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg10)))
        };
        0x2::coin::join<T1>(arg3, 0x2::coin::from_balance<T1>(v1, arg10));
        0x2::coin::join<T0>(arg2, 0x2::coin::from_balance<T0>(v0, arg10));
        if (arg4) {
            0x2::coin::join<T0>(arg2, 0x2::coin::zero<T0>(arg10));
        } else {
            0x2::coin::join<T1>(arg3, 0x2::coin::zero<T1>(arg10));
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v4, v5, v3);
    }

    // decompiled from Move bytecode v6
}

