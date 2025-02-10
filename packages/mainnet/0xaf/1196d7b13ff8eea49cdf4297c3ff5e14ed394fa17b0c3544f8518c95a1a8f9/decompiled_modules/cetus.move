module 0xaf1196d7b13ff8eea49cdf4297c3ff5e14ed394fa17b0c3544f8518c95a1a8f9::cetus {
    public fun flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u128, arg3: u128, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, bool, u64, u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, v2, v3, v4, v5, v6) = if (v0 > arg2) {
            let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 18446744073709551615, arg2, arg4);
            let v10 = v9;
            (true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10), 0, v7, v8, v10)
        } else {
            let (v11, v12, v13, v14, v15, v16) = if (v0 < arg3) {
                let (v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 18446744073709551615, arg3, arg4);
                let v20 = v19;
                (v17, v18, v20, false, 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v20))
            } else {
                let (v21, v22, v23) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 1, 4295048016, arg4);
                let v24 = v23;
                (v21, v22, v24, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v24), 0)
            };
            (v14, v15, v16, v11, v12, v13)
        };
        (v4, v5, v6, v1, v2, v3)
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg5: bool) {
        if (arg5) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg4)), 0x2::balance::zero<T1>(), arg4);
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg4)), arg4);
        };
    }

    public fun handle_initial_balanace<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, bool) {
        if (arg4) {
            let v2 = 0x2::balance::value<T0>(arg2);
            if (v2 > arg5) {
                let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v2 - arg5, 4295048016, arg6);
                0x2::balance::join<T0>(arg2, v3);
                0x2::balance::join<T1>(arg3, v4);
                (v5, true)
            } else {
                let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, false, 0x1::u64::max(arg5 - v2, 1), 79226673515401279992447579055, arg6);
                0x2::balance::join<T0>(arg2, v6);
                0x2::balance::join<T1>(arg3, v7);
                (v8, false)
            }
        } else {
            let v9 = 0x2::balance::value<T1>(arg3);
            if (v9 > arg5) {
                let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v9 - arg5, 79226673515401279992447579055, arg6);
                0x2::balance::join<T0>(arg2, v10);
                0x2::balance::join<T1>(arg3, v11);
                (v12, false)
            } else {
                let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, false, 0x1::u64::max(arg5 - v9, 1), 4295048016, arg6);
                0x2::balance::join<T0>(arg2, v13);
                0x2::balance::join<T1>(arg3, v14);
                (v15, true)
            }
        }
    }

    // decompiled from Move bytecode v6
}

