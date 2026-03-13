module 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::cetus_agg {
    public fun swap<T0, T1, T2>(arg0: &mut 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::CustomLiquidateReceipt<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) {
        let (v0, v1) = if (arg3) {
            swap_a2b<T1, T2>(arg1, arg2, 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::take_balance<T0, T1>(arg0, arg4), arg5)
        } else {
            swap_b2a<T1, T2>(arg1, arg2, 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::take_balance<T0, T2>(arg0, arg4), arg5)
        };
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T1>(&v3) > 0) {
            0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::put_balance<T0, T1>(arg0, v3);
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
        if (0x2::balance::value<T2>(&v2) > 0) {
            0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::put_balance<T0, T2>(arg0, v2);
        } else {
            0x2::balance::destroy_zero<T2>(v2);
        };
    }

    fun flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: bool, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg3, arg4, arg2, arg5, arg6);
        let v3 = v2;
        (v0, v1, v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3))
    }

    fun repay_flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = if (arg2) {
            (0x2::balance::split<T0>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v0, v1, arg5);
        (arg3, arg4)
    }

    public fun flash_swap_fixed_output<T0, T1, T2>(arg0: &mut 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::CustomLiquidateReceipt<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T1, T2>, u64) {
        let v0 = if (arg4) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v1, v2, v3, _) = flash_swap<T1, T2>(arg1, arg2, arg3, arg4, false, v0, arg5);
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg4) {
            0x2::balance::value<T2>(&v5)
        } else {
            0x2::balance::value<T1>(&v6)
        };
        if (0x2::balance::value<T1>(&v6) > 0) {
            0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::put_balance<T0, T1>(arg0, v6);
        } else {
            0x2::balance::destroy_zero<T1>(v6);
        };
        if (0x2::balance::value<T2>(&v5) > 0) {
            0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::put_balance<T0, T2>(arg0, v5);
        } else {
            0x2::balance::destroy_zero<T2>(v5);
        };
        (v3, v7)
    }

    public fun repay_flash_swap_fixed_output<T0, T1, T2>(arg0: &mut 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::CustomLiquidateReceipt<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: bool, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T1, T2>) {
        let (v0, v1) = if (arg3) {
            (0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::take_balance<T0, T1>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&arg4)), 0x2::balance::zero<T2>())
        } else {
            (0x2::balance::zero<T1>(), 0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::take_balance<T0, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&arg4)))
        };
        let (v2, v3) = repay_flash_swap<T1, T2>(arg1, arg2, arg3, v0, v1, arg4);
        let v4 = v3;
        let v5 = v2;
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::put_balance<T0, T1>(arg0, v5);
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x3d8977778033ed9f486e3318e3709a78fa595939f54e046388c1501d22ab4aa6::custom_liquidate::put_balance<T0, T2>(arg0, v4);
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let (v1, v2, v3, _) = flash_swap<T0, T1>(arg0, arg1, v0, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let (v5, v6) = repay_flash_swap<T0, T1>(arg0, arg1, true, arg2, 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T1>(v6);
        (v5, v2)
    }

    fun swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let (v1, v2, v3, _) = flash_swap<T0, T1>(arg0, arg1, v0, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let (v5, v6) = repay_flash_swap<T0, T1>(arg0, arg1, false, 0x2::balance::zero<T0>(), arg2, v3);
        0x2::balance::destroy_zero<T1>(v2);
        0x2::balance::destroy_zero<T0>(v5);
        (v1, v6)
    }

    // decompiled from Move bytecode v6
}

