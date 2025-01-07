module 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::cetus {
    struct RebalanceReceipt<phantom T0, phantom T1> {
        position_id: 0x2::object::ID,
        batch_swap_to_x: vector<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>,
        batch_swap_to_y: vector<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>,
        f_x64: u128,
        p_x128: u256,
        collected_x: 0x2::balance::Balance<T0>,
        collected_y: 0x2::balance::Balance<T1>,
    }

    struct WrappedFlashSwapReceipt<phantom T0, phantom T1> {
        inner: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>,
    }

    fun calc_f_x64(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg0 < arg1) {
            return 0
        };
        if (arg0 > arg2) {
            return 18446744073709551616
        };
        (((18446744073709551616 as u256) * ((arg0 - arg1) as u256) / (((arg0 - arg1) as u256) + ((arg0 - 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::util::muldiv_u128(arg0, arg0, arg2)) as u256))) as u128)
    }

    public fun calc_max_add_liquidity_amounts<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: u64) : (u128, u64, u64) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v2, v0)) {
            return 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2, true)
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v2, v1)) {
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

    fun calc_reward_sell_amounts(arg0: u64, arg1: u128, arg2: u256, arg3: u256) : (u64, u64) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = ((arg2 >> 64) as u256);
        let v3 = ((arg3 >> 64) as u256);
        let v4 = (18446744073709551616 as u256);
        let v5 = if (v2 > v3) {
            v3 + v1 * (v2 - v3) / v4
        } else {
            v3 - v1 * (v3 - v2) / v4
        };
        let v6 = ((v0 * v1 * v2 / v5 / v4) as u64);
        ((v0 as u64) - v6, v6)
    }

    fun calc_x_and_y_sell_amounts(arg0: u64, arg1: u64, arg2: u128, arg3: u256) : (u64, u64) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg2 as u256);
        let v3 = arg3 >> 64;
        let v4 = (18446744073709551616 as u256);
        let v5 = if (v0 > 0 || v1 > 0) {
            (v1 << 128) / (v1 * v4 + v0 * v3)
        } else {
            v2
        };
        if ((v5 as u256) < v2) {
            ((((v2 * (v1 * v4 + v0 * v3) - v1 * v4 * v4) / arg3) as u64), 0)
        } else {
            (0, ((v1 - (v2 * (v1 * v4 + v0 * v3) >> 128)) as u64))
        }
    }

    public fun create_rebalance_receipt<T0, T1>(arg0: &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::Position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : RebalanceReceipt<T0, T1> {
        let v0 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::lp_position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v0);
        RebalanceReceipt<T0, T1>{
            position_id     : 0x2::object::id<0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::Position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0),
            batch_swap_to_x : 0x1::vector::empty<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(),
            batch_swap_to_y : 0x1::vector::empty<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(),
            f_x64           : calc_f_x64(v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v3)),
            p_x128          : (v1 as u256) * (v1 as u256),
            collected_x     : 0x2::balance::zero<T0>(),
            collected_y     : 0x2::balance::zero<T1>(),
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
        let (v0, _, _) = calc_max_add_liquidity_amounts<T0, T1>(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::lp_position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0), arg5, 0x2::balance::value<T0>(&arg7), 0x2::balance::value<T1>(&arg8));
        if (v0 == 0) {
            return (arg7, arg8)
        };
        let v3 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::cetus::rebalance_add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg9);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg6, arg5, 0x2::balance::split<T0>(&mut arg7, v4), 0x2::balance::split<T1>(&mut arg8, v5), v3);
        (arg7, arg8)
    }

    public fun rebalance_claim_batch_swap_to_x<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0, T1>, arg1: &mut 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwap<T2, T0>) {
        let v0 = 0x1::vector::length<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&arg0.batch_swap_to_x);
        if (v0 == 0) {
            return
        };
        let v1 = v0 - 1;
        loop {
            let (v2, v3) = 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::claim_if_matches<T2, T0>(arg1, 0x1::vector::swap_remove<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&mut arg0.batch_swap_to_x, v1));
            0x2::balance::join<T0>(&mut arg0.collected_x, v2);
            let v4 = v3;
            if (0x1::option::is_some<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&v4)) {
                0x1::vector::push_back<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&mut arg0.batch_swap_to_x, 0x1::option::destroy_some<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(v4));
            } else {
                0x1::option::destroy_none<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(v4);
            };
            if (v1 == 0) {
                break
            };
            v1 = v1 - 1;
        };
    }

    public fun rebalance_claim_batch_swap_to_y<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0, T1>, arg1: &mut 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwap<T2, T1>) {
        let v0 = 0x1::vector::length<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&arg0.batch_swap_to_y);
        if (v0 == 0) {
            return
        };
        let v1 = v0 - 1;
        loop {
            let (v2, v3) = 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::claim_if_matches<T2, T1>(arg1, 0x1::vector::swap_remove<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&mut arg0.batch_swap_to_y, v1));
            0x2::balance::join<T1>(&mut arg0.collected_y, v2);
            let v4 = v3;
            if (0x1::option::is_some<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&v4)) {
                0x1::vector::push_back<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&mut arg0.batch_swap_to_y, 0x1::option::destroy_some<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(v4));
            } else {
                0x1::option::destroy_none<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(v4);
            };
            if (v1 == 0) {
                break
            };
            v1 = v1 - 1;
        };
    }

    public fun rebalance_collect_lp_fees_for_batch_selling<T0, T1>(arg0: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::Position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::PositionConfig, arg2: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::RebalanceReceipt, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut RebalanceReceipt<T0, T1>, arg6: &mut 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwap<T0, T1>, arg7: &mut 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwap<T1, T0>) {
        assert!(0x2::object::id<0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::Position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0) == arg5.position_id, 1);
        let (v0, v1) = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::cetus::rebalance_collect_fee<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = calc_x_and_y_sell_amounts(0x2::balance::value<T0>(&v3), 0x2::balance::value<T1>(&v2), arg5.f_x64, arg5.p_x128);
        if (v4 > 0) {
            0x1::vector::push_back<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&mut arg5.batch_swap_to_y, 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::deposit<T0, T1>(arg6, 0x2::balance::split<T0>(&mut v3, v4)));
        } else if (v5 > 0) {
            0x1::vector::push_back<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&mut arg5.batch_swap_to_x, 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::deposit<T1, T0>(arg7, 0x2::balance::split<T1>(&mut v2, v5)));
        };
        0x2::balance::join<T0>(&mut arg5.collected_x, v3);
        0x2::balance::join<T1>(&mut arg5.collected_y, v2);
    }

    public fun rebalance_collect_reward_for_batch_selling<T0, T1, T2>(arg0: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::Position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::PositionConfig, arg2: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::RebalanceReceipt, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &mut RebalanceReceipt<T0, T1>, arg7: u256, arg8: u256, arg9: &mut 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwap<T2, T0>, arg10: &mut 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwap<T2, T1>, arg11: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::Position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0) == arg6.position_id, 1);
        let v0 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::cetus::rebalance_collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg11);
        let (v1, v2) = calc_reward_sell_amounts(0x2::balance::value<T2>(&v0), arg6.f_x64, arg7, arg8);
        if (v1 > 0) {
            0x1::vector::push_back<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&mut arg6.batch_swap_to_x, 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::deposit<T2, T0>(arg9, 0x2::balance::split<T2>(&mut v0, v1)));
        };
        if (v2 > 0) {
            0x1::vector::push_back<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&mut arg6.batch_swap_to_y, 0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::deposit<T2, T1>(arg10, 0x2::balance::split<T2>(&mut v0, v2)));
        };
        0x2::balance::destroy_zero<T2>(v0);
    }

    public fun rebalance_finalize_add_liquidity<T0, T1>(arg0: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::Position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::PositionConfig, arg2: &mut 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::RebalanceReceipt, arg3: &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::pyth::PythPriceInfo, arg4: &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt_info::DebtInfo, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: RebalanceReceipt<T0, T1>, arg8: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::position_core_clmm::Position<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0) == arg7.position_id, 1);
        assert!(0x1::vector::is_empty<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&arg7.batch_swap_to_x) && 0x1::vector::is_empty<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(&arg7.batch_swap_to_y), 2);
        let RebalanceReceipt {
            position_id     : _,
            batch_swap_to_x : v1,
            batch_swap_to_y : v2,
            f_x64           : _,
            p_x128          : _,
            collected_x     : v5,
            collected_y     : v6,
        } = arg7;
        0x1::vector::destroy_empty<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(v1);
        0x1::vector::destroy_empty<0x1e8e36d73a53f7eaeba0d9913714c4727b6b667eede79ea2d5c7af14fa94d2a4::batch_swap::BatchSwapClaim>(v2);
        rebalance_add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v5, v6, arg8)
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

