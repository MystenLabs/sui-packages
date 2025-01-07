module 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::cetus {
    struct WrappedFlashSwapReceipt<phantom T0, phantom T1> {
        inner: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>,
    }

    public fun calc_max_add_liquidity_amounts<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: u64) : (u128, u64, u64) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v2, v0)) {
            return 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2, true)
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v2, v1)) {
            return 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg3, false)
        };
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, v2, v3, arg2, true);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, v2, v3, arg3, false);
        if (v4 < v7) {
            (v4, v5, v6)
        } else {
            (v7, v8, v9)
        }
    }

    public fun flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, WrappedFlashSwapReceipt<T0, T1>) {
        if (arg4 == 0) {
            let v0 = WrappedFlashSwapReceipt<T0, T1>{inner: 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>()};
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), v0)
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v4 = WrappedFlashSwapReceipt<T0, T1>{inner: 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v3)};
        (v1, v2, v4)
    }

    public fun owner_add_liquidity<T0, T1>(arg0: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::Position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::PositionConfig, arg2: &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::PositionCap, arg3: &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::pyth::PythPriceInfo, arg4: &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt_info::DebtInfo, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = calc_max_add_liquidity_amounts<T0, T1>(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::lp_position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0), arg5, 0x2::balance::value<T0>(&arg7), 0x2::balance::value<T1>(&arg8));
        if (v0 == 0) {
            return (arg7, arg8)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg6, arg5, 0x2::balance::split<T0>(&mut arg7, v1), 0x2::balance::split<T1>(&mut arg8, v2), 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::cetus::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg9));
        (arg7, arg8)
    }

    public fun rebalance_add_liquidity<T0, T1>(arg0: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::Position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::PositionConfig, arg2: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::RebalanceReceipt, arg3: &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::pyth::PythPriceInfo, arg4: &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt_info::DebtInfo, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2) = calc_max_add_liquidity_amounts<T0, T1>(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::lp_position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0), arg5, 0x2::balance::value<T0>(&arg7), 0x2::balance::value<T1>(&arg8));
        if (v0 == 0) {
            return (arg7, arg8)
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg6, arg5, 0x2::balance::split<T0>(&mut arg7, v1), 0x2::balance::split<T1>(&mut arg8, v2), 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::cetus::rebalance_add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg9));
        (arg7, arg8)
    }

    public fun repay_flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: WrappedFlashSwapReceipt<T0, T1>) {
        let WrappedFlashSwapReceipt { inner: v0 } = arg4;
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&v0)) {
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v0);
            0x2::balance::destroy_zero<T0>(arg2);
            0x2::balance::destroy_zero<T1>(arg3);
            return
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, arg2, arg3, 0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(v0));
    }

    public fun swap_pay_amount<T0, T1>(arg0: &WrappedFlashSwapReceipt<T0, T1>) : u64 {
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&arg0.inner)) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>(&arg0.inner))
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

