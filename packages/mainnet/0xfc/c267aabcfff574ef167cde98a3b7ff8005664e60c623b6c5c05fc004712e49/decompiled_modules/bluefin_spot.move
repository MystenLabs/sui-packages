module 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::bluefin_spot {
    struct RebalanceReceipt<phantom T0, phantom T1> {
        position_id: 0x2::object::ID,
        batch_swap_to_x: vector<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>,
        batch_swap_to_y: vector<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>,
        f_x64: u128,
        p_x128: u256,
        collected_x: 0x2::balance::Balance<T0>,
        collected_y: 0x2::balance::Balance<T1>,
    }

    public fun rebalance_add_liquidity<T0, T1>(arg0: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::Position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg1: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::PositionConfig, arg2: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::RebalanceReceipt, arg3: &0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::pyth::PythPriceInfo, arg4: &0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::debt_info::DebtInfo, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, _, _) = calc_max_add_liquidity_amounts<T0, T1>(0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::lp_position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0), arg5, 0x2::balance::value<T0>(&arg7), 0x2::balance::value<T1>(&arg8));
        if (v0 == 0) {
            return (arg7, arg8)
        };
        let (v3, v4) = 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::bluefin_spot::position_tick_range(0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::lp_position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0));
        let (v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_amount_by_liquidity(v3, v4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg5), v0, true);
        0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::bluefin_spot::rebalance_add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, 0x2::balance::split<T0>(&mut arg7, v5), 0x2::balance::split<T1>(&mut arg8, v6), arg9);
        (arg7, arg8)
    }

    public fun calc_max_add_liquidity_amounts<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u64, arg3: u64) : (u128, u64, u64) {
        let (v0, v1) = 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::bluefin_spot::position_tick_range(arg0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg1);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v2, v0)) {
            return 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(v0, v1, v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), arg2, true)
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v2, v1)) {
            return 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(v0, v1, v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), arg3, false)
        };
        let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(v0, v1, v2, v3, arg2, true);
        let (v7, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(v0, v1, v2, v3, arg3, false);
        if (v4 < v7) {
            (v4, v5, v6)
        } else {
            (v7, v8, v9)
        }
    }

    public fun create_rebalance_receipt<T0, T1>(arg0: &0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::Position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : RebalanceReceipt<T0, T1> {
        let v0 = 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::lp_position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(v0) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1);
        let (v2, v3) = 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::bluefin_spot::position_tick_range(v0);
        RebalanceReceipt<T0, T1>{
            position_id     : 0x2::object::id<0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::Position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(arg0),
            batch_swap_to_x : 0x1::vector::empty<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(),
            batch_swap_to_y : 0x1::vector::empty<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(),
            f_x64           : 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::rebalance_util::calc_f_x64(v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v3)),
            p_x128          : (v1 as u256) * (v1 as u256),
            collected_x     : 0x2::balance::zero<T0>(),
            collected_y     : 0x2::balance::zero<T1>(),
        }
    }

    public fun owner_add_liquidity<T0, T1>(arg0: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::Position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg1: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::PositionConfig, arg2: &0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::PositionCap, arg3: &0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::pyth::PythPriceInfo, arg4: &0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::debt_info::DebtInfo, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, _, _) = calc_max_add_liquidity_amounts<T0, T1>(0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::lp_position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0), arg5, 0x2::balance::value<T0>(&arg7), 0x2::balance::value<T1>(&arg8));
        if (v0 == 0) {
            return (arg7, arg8)
        };
        let (v3, v4) = 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::bluefin_spot::position_tick_range(0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::lp_position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0));
        let (v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_amount_by_liquidity(v3, v4, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg5), v0, true);
        0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::bluefin_spot::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, 0x2::balance::split<T0>(&mut arg7, v5), 0x2::balance::split<T1>(&mut arg8, v6), arg9);
        (arg7, arg8)
    }

    public fun rebalance_claim_batch_swap_to_x<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0, T1>, arg1: &mut 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwap<T2, T0>) {
        let v0 = 0x1::vector::length<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&arg0.batch_swap_to_x);
        if (v0 == 0) {
            return
        };
        let v1 = v0 - 1;
        loop {
            let (v2, v3) = 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::claim_if_matches<T2, T0>(arg1, 0x1::vector::swap_remove<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&mut arg0.batch_swap_to_x, v1));
            0x2::balance::join<T0>(&mut arg0.collected_x, v2);
            let v4 = v3;
            if (0x1::option::is_some<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&v4)) {
                0x1::vector::push_back<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&mut arg0.batch_swap_to_x, 0x1::option::destroy_some<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(v4));
            } else {
                0x1::option::destroy_none<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(v4);
            };
            if (v1 == 0) {
                break
            };
            v1 = v1 - 1;
        };
    }

    public fun rebalance_claim_batch_swap_to_y<T0, T1, T2>(arg0: &mut RebalanceReceipt<T0, T1>, arg1: &mut 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwap<T2, T1>) {
        let v0 = 0x1::vector::length<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&arg0.batch_swap_to_y);
        if (v0 == 0) {
            return
        };
        let v1 = v0 - 1;
        loop {
            let (v2, v3) = 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::claim_if_matches<T2, T1>(arg1, 0x1::vector::swap_remove<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&mut arg0.batch_swap_to_y, v1));
            0x2::balance::join<T1>(&mut arg0.collected_y, v2);
            let v4 = v3;
            if (0x1::option::is_some<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&v4)) {
                0x1::vector::push_back<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&mut arg0.batch_swap_to_y, 0x1::option::destroy_some<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(v4));
            } else {
                0x1::option::destroy_none<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(v4);
            };
            if (v1 == 0) {
                break
            };
            v1 = v1 - 1;
        };
    }

    public fun rebalance_collect_lp_fees_for_batch_selling<T0, T1>(arg0: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::Position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg1: &0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::PositionConfig, arg2: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::RebalanceReceipt, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut RebalanceReceipt<T0, T1>, arg6: &mut 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwap<T0, T1>, arg7: &mut 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwap<T1, T0>, arg8: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::Position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(arg0) == arg5.position_id, 1);
        let (v0, v1) = 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::bluefin_spot::rebalance_collect_fee<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg8);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::rebalance_util::calc_x_and_y_sell_amounts(0x2::balance::value<T0>(&v3), 0x2::balance::value<T1>(&v2), arg5.f_x64, arg5.p_x128);
        if (v4 > 0) {
            0x1::vector::push_back<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&mut arg5.batch_swap_to_y, 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::deposit<T0, T1>(arg6, 0x2::balance::split<T0>(&mut v3, v4)));
        } else if (v5 > 0) {
            0x1::vector::push_back<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&mut arg5.batch_swap_to_x, 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::deposit<T1, T0>(arg7, 0x2::balance::split<T1>(&mut v2, v5)));
        };
        0x2::balance::join<T0>(&mut arg5.collected_x, v3);
        0x2::balance::join<T1>(&mut arg5.collected_y, v2);
    }

    public fun rebalance_collect_reward_for_batch_selling<T0, T1, T2>(arg0: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::Position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg1: &0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::PositionConfig, arg2: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::RebalanceReceipt, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut RebalanceReceipt<T0, T1>, arg6: u256, arg7: u256, arg8: &mut 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwap<T2, T0>, arg9: &mut 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwap<T2, T1>, arg10: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::Position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(arg0) == arg5.position_id, 1);
        let v0 = 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::bluefin_spot::rebalance_collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg10);
        let (v1, v2) = 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::rebalance_util::calc_reward_sell_amounts(0x2::balance::value<T2>(&v0), arg5.f_x64, arg5.p_x128, arg6, arg7);
        if (v1 > 0) {
            0x1::vector::push_back<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&mut arg5.batch_swap_to_x, 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::deposit<T2, T0>(arg8, 0x2::balance::split<T2>(&mut v0, v1)));
        };
        if (v2 > 0) {
            0x1::vector::push_back<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&mut arg5.batch_swap_to_y, 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::deposit<T2, T1>(arg9, 0x2::balance::split<T2>(&mut v0, v2)));
        };
        0x2::balance::destroy_zero<T2>(v0);
    }

    public fun rebalance_finalize_add_liquidity<T0, T1>(arg0: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::Position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg1: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::PositionConfig, arg2: &mut 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::RebalanceReceipt, arg3: &0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::pyth::PythPriceInfo, arg4: &0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::debt_info::DebtInfo, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: RebalanceReceipt<T0, T1>, arg8: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::position_core_clmm::Position<T0, T1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(arg0) == arg7.position_id, 1);
        assert!(0x1::vector::is_empty<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&arg7.batch_swap_to_x) && 0x1::vector::is_empty<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(&arg7.batch_swap_to_y), 2);
        let RebalanceReceipt {
            position_id     : _,
            batch_swap_to_x : v1,
            batch_swap_to_y : v2,
            f_x64           : _,
            p_x128          : _,
            collected_x     : v5,
            collected_y     : v6,
        } = arg7;
        0x1::vector::destroy_empty<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(v1);
        0x1::vector::destroy_empty<0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::batch_swap::BatchSwapClaim>(v2);
        rebalance_add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v5, v6, arg8)
    }

    // decompiled from Move bytecode v6
}

