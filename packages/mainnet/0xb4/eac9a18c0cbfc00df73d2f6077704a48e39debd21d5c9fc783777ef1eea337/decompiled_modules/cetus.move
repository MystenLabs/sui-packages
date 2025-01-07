module 0xb4eac9a18c0cbfc00df73d2f6077704a48e39debd21d5c9fc783777ef1eea337::cetus {
    public fun swap<T0, T1>(arg0: &mut 0xb4eac9a18c0cbfc00df73d2f6077704a48e39debd21d5c9fc783777ef1eea337::fund::Take_1_Liquidity_For_1_Liquidity_Request<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock) {
        let v0 = if (arg6) {
            0x2::balance::value<T0>(arg1)
        } else {
            0x2::balance::value<T1>(arg2)
        };
        let v1 = if (arg5) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg3, arg4, arg5, arg6, v0, v1, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        if (arg5) {
        };
        let (v8, v9) = if (arg5) {
            (0x2::balance::split<T0>(arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v5)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg3, arg4, v8, v9, v5);
        0x2::balance::join<T0>(arg1, v7);
        0x2::balance::join<T1>(arg2, v6);
        0xb4eac9a18c0cbfc00df73d2f6077704a48e39debd21d5c9fc783777ef1eea337::fund::supported_defi_confirm_1l_for_1l<T0, T1>(arg0, 0x2::balance::value<T1>(arg2));
    }

    public fun drop_zero_balance<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun take_zero_balance<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v6
}

