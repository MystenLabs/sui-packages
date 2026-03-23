module 0x264576274f48457869114070ed7c7e33a953b09544a43cacdc7f5e0e18e42439::cetus_agg {
    struct CetusAgg has drop {
        dummy_field: bool,
    }

    public fun swap<T0, T1>(arg0: &0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::router::Router, arg1: &mut 0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::SwapContext, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) {
        let (v0, v1) = if (arg4) {
            let v2 = CetusAgg{dummy_field: false};
            swap_a2b<T0, T1>(arg2, arg3, 0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::take_balance<CetusAgg, T0>(arg1, arg0, v2, arg5), arg6)
        } else {
            let v3 = CetusAgg{dummy_field: false};
            swap_b2a<T0, T1>(arg2, arg3, 0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::take_balance<CetusAgg, T1>(arg1, arg0, v3, arg5), arg6)
        };
        let v4 = v1;
        let v5 = v0;
        if (0x2::balance::value<T0>(&v5) > 0) {
            0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::put_balance<T0>(arg1, v5);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::put_balance<T1>(arg1, v4);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
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

    public fun flash_swap_fixed_output<T0, T1>(arg0: &mut 0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::SwapContext, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, u64) {
        let v0 = if (arg4) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v1, v2, v3, _) = flash_swap<T0, T1>(arg1, arg2, arg3, arg4, false, v0, arg5);
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        if (0x2::balance::value<T0>(&v6) > 0) {
            0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::put_balance<T0>(arg0, v6);
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        if (0x2::balance::value<T1>(&v5) > 0) {
            0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::put_balance<T1>(arg0, v5);
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        (v3, v7)
    }

    public fun repay_flash_swap_fixed_output<T0, T1>(arg0: &0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::router::Router, arg1: &mut 0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::SwapContext, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1) = if (arg4) {
            let v2 = CetusAgg{dummy_field: false};
            (0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::take_balance<CetusAgg, T0>(arg1, arg0, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5)), 0x2::balance::zero<T1>())
        } else {
            let v3 = CetusAgg{dummy_field: false};
            (0x2::balance::zero<T0>(), 0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::take_balance<CetusAgg, T1>(arg1, arg0, v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5)))
        };
        let (v4, v5) = repay_flash_swap<T0, T1>(arg2, arg3, arg4, v0, v1, arg5);
        let v6 = v5;
        let v7 = v4;
        if (0x2::balance::value<T0>(&v7) > 0) {
            0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::put_balance<T0>(arg1, v7);
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
        if (0x2::balance::value<T1>(&v6) > 0) {
            0xdff285b435d5c3f25c9dc0d820e1ac3aa34195b43677ae9a519c5d7ad60cd63d::swap::put_balance<T1>(arg1, v6);
        } else {
            0x2::balance::destroy_zero<T1>(v6);
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

