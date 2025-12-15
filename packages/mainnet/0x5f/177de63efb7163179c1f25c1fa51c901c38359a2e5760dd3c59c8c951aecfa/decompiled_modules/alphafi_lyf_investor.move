module 0xff296a9ea1430e47ffc3e0e4e6aa8dd0f821f78ec37daba52dcdc517845559bb::alphafi_lyf_investor {
    struct Investor<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        position_cap: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap,
        cur_debt_a: u64,
        cur_debt_b: u64,
        market_id_a: u64,
        market_id_b: u64,
        current_debt_to_supply_ratio: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        safe_borrow_percentage: u64,
        lower_tick: u32,
        upper_tick: u32,
        free_balance_a: 0x2::balance::Balance<T0>,
        free_balance_b: 0x2::balance::Balance<T1>,
        emergency_balance_a: 0x2::balance::Balance<T0>,
        emergency_balance_b: 0x2::balance::Balance<T1>,
        free_rewards: 0x2::bag::Bag,
        minimum_swap_amount: u64,
        performance_fee: u64,
        performance_fee_max_cap: u64,
        is_emergency: bool,
    }

    struct RebalancePoolEvent has copy, drop {
        investor_id: 0x2::object::ID,
        amount_a_before: u64,
        amount_b_before: u64,
        amount_a_after: u64,
        amount_b_after: u64,
        liquidity_before: u128,
        liquidity_after: u128,
        lower_tick_before: u32,
        upper_tick_before: u32,
        lower_tick_after: u32,
        upper_tick_after: u32,
        sqrt_price_before: u128,
        sqrt_price_after: u128,
        free_balance_a: u64,
        free_balance_b: u64,
        location: u64,
    }

    struct BluefinRewardEvent has copy, drop {
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        total_amount_a: u64,
        total_amount_b: u64,
        cur_debt_a: u64,
        cur_debt_b: u64,
        investor_id: 0x2::object::ID,
    }

    struct AlphalendRewardEvent has copy, drop {
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        total_amount_a: u64,
        total_amount_b: u64,
        cur_debt_a: u64,
        cur_debt_b: u64,
        investor_id: 0x2::object::ID,
    }

    struct BluefinFeesEvent has copy, drop {
        amount_a: u64,
        amount_b: u64,
        total_amount_a: u64,
        total_amount_b: u64,
        cur_debt_a: u64,
        cur_debt_b: u64,
        investor_id: 0x2::object::ID,
    }

    struct AutoCompoundingEvent has copy, drop {
        investor_id: 0x2::object::ID,
        compound_amount_a: u64,
        compound_amount_b: u64,
        accrued_interest_a: u64,
        accrued_interest_b: u64,
        cur_debt_a: u64,
        cur_debt_b: u64,
        total_amount_a: u64,
        total_amount_b: u64,
        current_liquidity: u128,
        fee_collected_a: u64,
        fee_collected_b: u64,
        free_balance_a: u64,
        free_balance_b: u64,
    }

    fun get_liquidity_from_amount<T0, T1>(arg0: &Investor<T0, T1>, arg1: u64, arg2: u64, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (u128, u64, u64) {
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick))) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), arg1, true)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), arg2, false)
        }
    }

    public(friend) fun admin_change_leverage<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::lt(arg1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.safe_borrow_percentage), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(10000))), 13906838903102373887);
        let (v0, v1) = autocompound<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = get_total_invested_in_dollar<T0, T1>(arg0, arg2, arg4, arg7, arg8);
        let v3 = get_total_borrowed_in_dollars<T0, T1>(arg0, arg2, arg7);
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::lt(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg1, v2), v3)) {
            let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg2, &arg0.position_cap, arg8);
            let v6 = v4;
            let (v7, v8) = calculate_token_amounts_from_dollars<T0, T1>(arg0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(v3, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg1, v2)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), arg1)), arg2, arg4, &v6);
            let v9 = &mut v6;
            withdraw_and_repay<T0, T1>(arg0, v7, v8, arg2, arg3, arg4, v9, arg7, arg8);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg2, &arg0.position_cap, arg4, v6, v5, arg7, arg8);
        } else {
            let (v10, v11) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg2, &arg0.position_cap, arg8);
            let v12 = v10;
            let v13 = &mut v12;
            let (v14, v15) = borrow_and_supply<T0, T1>(arg0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg1, v2), v3), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), arg1)), arg2, arg3, arg4, v13, arg5, arg7, arg8);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg2, &arg0.position_cap, arg4, v12, v11, arg7, arg8);
            0x2::coin::destroy_zero<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_repay<T0>(arg2, &arg0.position_cap, v14, arg0.market_id_a, 0x2::coin::zero<T0>(arg8), arg7, arg8));
            0x2::coin::destroy_zero<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_repay<T1>(arg2, &arg0.position_cap, v15, arg0.market_id_b, 0x2::coin::zero<T1>(arg8), arg7, arg8));
        };
        update_debt_to_supply_ratio<T0, T1>(arg0, arg2, arg4, arg7, arg8);
        (v0, v1)
    }

    public(friend) fun autocompound<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg1, &arg0.position_cap, arg7);
        let v2 = v0;
        let v3 = &mut v2;
        let (v4, v5, v6, v7, v8) = autocompound_internal<T0, T1>(arg0, arg1, arg2, arg3, v3, arg4, arg5, arg6, arg7);
        let v9 = &mut v2;
        deposit_to_bluefin<T0, T1>(arg0, arg2, arg3, v4, v5, v9, v6, arg6);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg1, &arg0.position_cap, arg3, v2, v1, arg6, arg7);
        update_debt_to_supply_ratio<T0, T1>(arg0, arg1, arg3, arg6, arg7);
        (v7, v8)
    }

    public(friend) fun autocompound_internal<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, bool, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg7, arg2, arg3, arg4);
        let v4 = v3;
        let v5 = v2;
        let v6 = collect_bluefin_reward<T0, T1, T1>(arg0, arg2, arg3, arg4, arg7);
        0x2::balance::join<T1>(&mut v4, v6);
        let v7 = collect_bluefin_reward<T0, T1, T0>(arg0, arg2, arg3, arg4, arg7);
        0x2::balance::join<T0>(&mut v5, v7);
        let v8 = collect_alphalend_reward<T0, T1, T1>(arg0, arg1, arg5, arg3, arg4, arg7, arg8);
        0x2::balance::join<T1>(&mut v4, v8);
        let v9 = collect_alphalend_reward<T0, T1, T0>(arg0, arg1, arg5, arg3, arg4, arg7, arg8);
        0x2::balance::join<T0>(&mut v5, v9);
        let v10 = 0;
        while (v10 < 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::reward_infos_length(arg4)) {
            assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::coins_owed_reward(arg4, v10) == 0, 1453);
            v10 = v10 + 1;
        };
        let v11 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_claimable_rewards(arg1, &arg0.position_cap, arg7);
        assert!(0x1::vector::length<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward>(&v11) == 0, 13906837563072577535);
        let (v12, v13) = get_borrow_amounts<T0, T1>(arg0, arg1, arg7);
        let v14 = v12 - arg0.cur_debt_a;
        let v15 = v13 - arg0.cur_debt_b;
        let v16 = if (0x2::balance::value<T0>(&v5) > v14) {
            ((0x2::balance::value<T0>(&v5) - v14) as u128) * (arg0.performance_fee as u128) / 10000
        } else {
            0
        };
        let v17 = if (0x2::balance::value<T1>(&v4) > v15) {
            ((0x2::balance::value<T1>(&v4) - v15) as u128) * (arg0.performance_fee as u128) / 10000
        } else {
            0
        };
        let (v18, v19, v20) = if (arg6) {
            0x2::balance::join<T0>(&mut v5, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
            0x2::balance::join<T1>(&mut v4, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
            let (v21, v22) = get_bluefin_sqrt_price_limits<T0, T1>(arg3);
            let (v23, v24) = get_total_balance_in_ratio_with_limit_bluefin<T0, T1>(arg0, arg2, v5, v4, arg3, v21, v22, arg7, arg8);
            let (_, v26, v27, v28) = get_balances_in_ratio<T0, T1>(arg0, v23, v24, arg3, true, arg8);
            (v26, v27, v28)
        } else {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, v5);
            0x2::balance::join<T1>(&mut arg0.free_balance_b, v4);
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), false)
        };
        let v29 = v19;
        let v30 = v18;
        let (v31, v32) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg4), false);
        let v33 = BluefinFeesEvent{
            amount_a       : 0x2::balance::value<T0>(&v5),
            amount_b       : 0x2::balance::value<T1>(&v4),
            total_amount_a : v31,
            total_amount_b : v32,
            cur_debt_a     : arg0.cur_debt_a,
            cur_debt_b     : arg0.cur_debt_b,
            investor_id    : 0x2::object::id<Investor<T0, T1>>(arg0),
        };
        0x2::event::emit<BluefinFeesEvent>(v33);
        let v34 = AutoCompoundingEvent{
            investor_id        : 0x2::object::id<Investor<T0, T1>>(arg0),
            compound_amount_a  : 0x2::balance::value<T0>(&v30),
            compound_amount_b  : 0x2::balance::value<T1>(&v29),
            accrued_interest_a : v14,
            accrued_interest_b : v15,
            cur_debt_a         : arg0.cur_debt_a,
            cur_debt_b         : arg0.cur_debt_b,
            total_amount_a     : v31,
            total_amount_b     : v32,
            current_liquidity  : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg4),
            fee_collected_a    : (v16 as u64),
            fee_collected_b    : (v17 as u64),
            free_balance_a     : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b     : 0x2::balance::value<T1>(&arg0.free_balance_b),
        };
        0x2::event::emit<AutoCompoundingEvent>(v34);
        (v30, v29, v20, 0x2::balance::split<T0>(&mut v5, (v16 as u64)), 0x2::balance::split<T1>(&mut v4, (v17 as u64)))
    }

    fun borrow_and_supply<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::FlashTransactionHotPotato, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::FlashTransactionHotPotato) {
        let (v0, v1) = calculate_token_amounts_from_dollars<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        let (v2, v3) = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_borrow<0x2::sui::SUI>(arg2, &arg0.position_cap, arg0.market_id_a, v0, arg7, arg8);
            let v6 = recast_balance_type<T0, T1, 0x2::sui::SUI, T0>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, v4, arg6, arg7, arg8)));
            (v6, v5)
        } else {
            let (v7, v8) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_borrow<T0>(arg2, &arg0.position_cap, arg0.market_id_a, v0, arg7, arg8);
            let v2 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v7, arg7, arg8));
            (v2, v8)
        };
        let (v9, v10) = if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let (v11, v12) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_borrow<0x2::sui::SUI>(arg2, &arg0.position_cap, arg0.market_id_b, v1, arg7, arg8);
            let v13 = recast_balance_type<T0, T1, 0x2::sui::SUI, T1>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, v11, arg6, arg7, arg8)));
            (v13, v12)
        } else {
            let (v14, v15) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_borrow<T1>(arg2, &arg0.position_cap, arg0.market_id_b, v1, arg7, arg8);
            let v9 = 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg2, v14, arg7, arg8));
            (v9, v15)
        };
        let (_, v17, v18, v19) = get_balances_in_ratio<T0, T1>(arg0, v2, v9, arg4, true, arg8);
        deposit_to_bluefin<T0, T1>(arg0, arg3, arg4, v17, v18, arg5, v19, arg7);
        (v3, v10)
    }

    fun calculate_token_amounts_from_dollars<T0, T1>(arg0: &Investor<T0, T1>, arg1: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (u64, u64) {
        let (v0, v1) = get_amounts<T0, T1>(arg0, arg3, arg4);
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0);
        let v3 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1);
        let v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg1, v2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg2, arg0.market_id_a), v2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg2, arg0.market_id_b), v3)));
        (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v4), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v4, v3), v2)))
    }

    fun close_position<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg3, arg2, arg0, arg1);
    }

    fun collect_alphalend_reward<T0, T1, T2>(arg0: &mut Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = if (0x1::type_name::with_defining_ids<T2>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            let (v1, v2) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<0x2::sui::SUI>(arg1, arg0.market_id_a, &arg0.position_cap, arg5, arg6);
            let v3 = v1;
            0x2::coin::join<0x2::sui::SUI>(&mut v3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg1, v2, arg2, arg5, arg6));
            let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<0x2::sui::SUI>(arg1, arg0.market_id_b, &arg0.position_cap, arg5, arg6);
            0x2::coin::join<0x2::sui::SUI>(&mut v3, v4);
            0x2::coin::join<0x2::sui::SUI>(&mut v3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg1, v5, arg2, arg5, arg6));
            let v6 = recast_balance_type<T0, T1, 0x2::sui::SUI, T2>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
            0x2::coin::from_balance<T2>(v6, arg6)
        } else {
            let (v7, v8) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T2>(arg1, arg0.market_id_a, &arg0.position_cap, arg5, arg6);
            let v9 = v7;
            0x2::coin::join<T2>(&mut v9, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T2>(arg1, v8, arg5, arg6));
            let (v10, v11) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T2>(arg1, arg0.market_id_b, &arg0.position_cap, arg5, arg6);
            0x2::coin::join<T2>(&mut v9, v10);
            0x2::coin::join<T2>(&mut v9, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T2>(arg1, v11, arg5, arg6));
            v9
        };
        let v12 = v0;
        let (v13, v14) = get_amounts<T0, T1>(arg0, arg3, arg4);
        let v15 = AlphalendRewardEvent{
            amount         : 0x2::coin::value<T2>(&v12),
            coin_type      : 0x1::type_name::with_defining_ids<T2>(),
            total_amount_a : v13,
            total_amount_b : v14,
            cur_debt_a     : arg0.cur_debt_a,
            cur_debt_b     : arg0.cur_debt_b,
            investor_id    : 0x2::object::id<Investor<T0, T1>>(arg0),
        };
        0x2::event::emit<AlphalendRewardEvent>(v15);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>())) {
            0x2::coin::join<T2>(&mut v12, 0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>())), arg6));
        };
        0x2::coin::into_balance<T2>(v12)
    }

    public(friend) fun collect_bluefin_reward<T0, T1, T2>(arg0: &mut Investor<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::balance::zero<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>())) {
            0x2::balance::join<T2>(&mut v0, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>())));
        };
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::is_reward_present<T0, T1, T2>(arg2)) {
            let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg4, arg1, arg2, arg3);
            let (v2, v3) = get_amounts<T0, T1>(arg0, arg2, arg3);
            let v4 = BluefinRewardEvent{
                amount         : 0x2::balance::value<T2>(&v1),
                coin_type      : 0x1::type_name::with_defining_ids<T2>(),
                total_amount_a : v2,
                total_amount_b : v3,
                cur_debt_a     : arg0.cur_debt_a,
                cur_debt_b     : arg0.cur_debt_b,
                investor_id    : 0x2::object::id<Investor<T0, T1>>(arg0),
            };
            0x2::event::emit<BluefinRewardEvent>(v4);
            0x2::balance::join<T2>(&mut v0, v1);
        };
        v0
    }

    public(friend) fun collect_reward_and_swap_bluefin<T0, T1, T2, T3>(arg0: &mut Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: bool, arg6: bool, arg7: bool, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_total_invested_in_dollar<T0, T1>(arg0, arg1, arg2, arg9, arg10);
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::eq(v0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0))) {
            return
        };
        let v1 = 0x2::balance::zero<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>()) == true) {
            0x2::balance::join<T2>(&mut v1, 0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>())));
        };
        let v2 = 0x2::balance::zero<T3>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T3>()) == true) {
            0x2::balance::join<T3>(&mut v2, 0x2::balance::withdraw_all<T3>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T3>())));
        };
        let (v3, v4) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg1, &arg0.position_cap, arg10);
        let v5 = v3;
        if (arg5) {
            if (arg7) {
                let v6 = &mut v5;
                let v7 = collect_bluefin_reward<T0, T1, T2>(arg0, arg4, arg2, v6, arg9);
                0x2::balance::join<T2>(&mut v1, v7);
            } else {
                let v8 = collect_alphalend_reward<T0, T1, T2>(arg0, arg1, arg8, arg2, &v5, arg9, arg10);
                0x2::balance::join<T2>(&mut v1, v8);
            };
            let v9 = 0x2::balance::value<T2>(&v1);
            if (v9 >= arg0.minimum_swap_amount && arg6) {
                let (v10, _) = get_bluefin_sqrt_price_limits<T2, T3>(arg3);
                let (v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T2, T3>(arg9, arg4, arg3, v1, 0x2::balance::zero<T3>(), true, true, v9, 0, v10);
                let v14 = v12;
                assert!(0x2::balance::value<T2>(&v14) == 0, 1);
                0x2::balance::destroy_zero<T2>(v14);
                0x2::balance::join<T3>(&mut v2, v13);
                update_free_rewards<T0, T1, T3>(arg0, v2);
            } else {
                update_free_rewards<T0, T1, T2>(arg0, v1);
                update_free_rewards<T0, T1, T3>(arg0, v2);
            };
        } else {
            if (arg7) {
                let v15 = &mut v5;
                let v16 = collect_bluefin_reward<T0, T1, T3>(arg0, arg4, arg2, v15, arg9);
                0x2::balance::join<T3>(&mut v2, v16);
            } else {
                let v17 = collect_alphalend_reward<T0, T1, T3>(arg0, arg1, arg8, arg2, &v5, arg9, arg10);
                0x2::balance::join<T3>(&mut v2, v17);
            };
            let v18 = 0x2::balance::value<T3>(&v2);
            if (v18 >= arg0.minimum_swap_amount && arg6) {
                let (_, v20) = get_bluefin_sqrt_price_limits<T2, T3>(arg3);
                let (v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T2, T3>(arg9, arg4, arg3, 0x2::balance::zero<T2>(), v2, false, true, v18, 0, v20);
                let v23 = v22;
                assert!(0x2::balance::value<T3>(&v23) == 0, 2);
                0x2::balance::destroy_zero<T3>(v23);
                0x2::balance::join<T2>(&mut v1, v21);
                update_free_rewards<T0, T1, T2>(arg0, v1);
            } else {
                update_free_rewards<T0, T1, T3>(arg0, v2);
                update_free_rewards<T0, T1, T2>(arg0, v1);
            };
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg1, &arg0.position_cap, arg2, v5, v4, arg9, arg10);
    }

    public(friend) fun create_investor<T0, T1>(arg0: u32, arg1: u32, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::PartnerCap, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Investor<T0, T1> {
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position_for_partner(arg2, arg5, 0, arg10);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_bluefin_lp_collateral<T0, T1>(arg2, &v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg3, arg0, arg1, arg10), arg3, arg9, arg10);
        Investor<T0, T1>{
            id                           : 0x2::object::new(arg10),
            position_cap                 : v0,
            cur_debt_a                   : 0,
            cur_debt_b                   : 0,
            market_id_a                  : arg6,
            market_id_b                  : arg7,
            current_debt_to_supply_ratio : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            safe_borrow_percentage       : arg8,
            lower_tick                   : arg0,
            upper_tick                   : arg1,
            free_balance_a               : 0x2::balance::zero<T0>(),
            free_balance_b               : 0x2::balance::zero<T1>(),
            emergency_balance_a          : 0x2::balance::zero<T0>(),
            emergency_balance_b          : 0x2::balance::zero<T1>(),
            free_rewards                 : 0x2::bag::new(arg10),
            minimum_swap_amount          : 100000,
            performance_fee              : 1000,
            performance_fee_max_cap      : 5000,
            is_emergency                 : false,
        }
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: bool, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<T0>(&arg4)), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg1, arg0.market_id_a)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<T1>(&arg5)), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg1, arg0.market_id_b)));
        let (v1, v2) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg1, &arg0.position_cap, arg9);
        let v3 = v1;
        let v4 = &mut v3;
        deposit_to_bluefin<T0, T1>(arg0, arg2, arg3, arg4, arg5, v4, arg6, arg8);
        let v5 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v0, arg0.current_debt_to_supply_ratio), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), arg0.current_debt_to_supply_ratio));
        let v6 = &mut v3;
        let (v7, v8) = borrow_and_supply<T0, T1>(arg0, v5, arg1, arg2, arg3, v6, arg7, arg8, arg9);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg1, &arg0.position_cap, arg3, v3, v2, arg8, arg9);
        destroy_potatoes<T0, T1>(arg0, arg1, v7, v8, arg8, arg9);
        update_debt_to_supply_ratio<T0, T1>(arg0, arg1, arg3, arg8, arg9);
    }

    public(friend) fun deposit_to_bluefin<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg6: bool, arg7: &0x2::clock::Clock) {
        if (0x2::balance::value<T0>(&arg3) == 0 && 0x2::balance::value<T1>(&arg4) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            0x2::balance::destroy_zero<T1>(arg4);
            return
        };
        let (v0, v1) = if (0x2::balance::value<T0>(&arg3) == 0 || arg6 == false) {
            let (v2, v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg7, arg1, arg2, arg5, arg3, arg4, 0x2::balance::value<T1>(&arg4), false);
            let _ = v3;
            let _ = v2;
            (v4, v5)
        } else {
            let (v8, v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg7, arg1, arg2, arg5, arg3, arg4, 0x2::balance::value<T0>(&arg3), true);
            let _ = v9;
            let _ = v8;
            (v10, v11)
        };
        0x2::balance::join<T0>(&mut arg0.free_balance_a, v0);
        0x2::balance::join<T1>(&mut arg0.free_balance_b, v1);
    }

    fun destroy_potatoes<T0, T1>(arg0: &Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::FlashTransactionHotPotato, arg3: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::FlashTransactionHotPotato, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_repay<T0>(arg1, &arg0.position_cap, arg2, arg0.market_id_a, 0x2::coin::zero<T0>(arg5), arg4, arg5);
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_repay<T1>(arg1, &arg0.position_cap, arg3, arg0.market_id_b, 0x2::coin::zero<T1>(arg5), arg4, arg5);
        assert!(0x2::coin::value<T0>(&v0) == 0, 13906838001159241727);
        assert!(0x2::coin::value<T1>(&v1) == 0, 13906838005454209023);
        0x2::coin::destroy_zero<T0>(v0);
        0x2::coin::destroy_zero<T1>(v1);
    }

    public(friend) fun emergency_withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.is_emergency = true;
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg1, &arg0.position_cap, arg5);
        let v2 = v0;
        let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg3, &mut v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v2), arg4);
        let v7 = v6;
        let v8 = v5;
        0x2::balance::join<T0>(&mut v8, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        0x2::balance::join<T1>(&mut v7, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg1, &arg0.position_cap, arg0.market_id_a, 0x2::coin::from_balance<T0>(v8, arg5), arg4, arg5);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T1>(arg1, &arg0.position_cap, arg0.market_id_b, 0x2::coin::from_balance<T1>(v7, arg5), arg4, arg5);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg1, &arg0.position_cap, arg3, v2, v1, arg4, arg5);
    }

    public(friend) fun get_amounts<T0, T1>(arg0: &Investor<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg2), false)
    }

    public(friend) fun get_amounts_outer<T0, T1>(arg0: &Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg1, &arg0.position_cap, arg4);
        let v2 = v0;
        let (v3, v4) = get_amounts<T0, T1>(arg0, arg2, &v2);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg1, &arg0.position_cap, arg2, v2, v1, arg3, arg4);
        (v3, v4)
    }

    public(friend) fun get_balances_in_ratio<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : (u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, bool) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        if (0x2::balance::value<T0>(&arg1) == 0 || 0x2::balance::value<T1>(&arg2) == 0) {
            (0, arg1, arg2, !(0x2::balance::value<T0>(&arg1) == 0))
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), v1)) {
            let (v6, _, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T0>(&arg1), true);
            let v9 = 0x2::balance::value<T1>(&arg2);
            if (v8 <= v9) {
                if (arg4 == false) {
                    let v10 = v9 - v8;
                    assert!((v10 as u128) * 1000000000 / (v9 as u128) <= 10000000, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::difference_too_high());
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2, v10), arg5), 0x2::tx_context::sender(arg5));
                };
                0x2::balance::join<T1>(&mut arg0.free_balance_b, arg2);
                (v6, arg1, 0x2::balance::split<T1>(&mut arg2, v8), true)
            } else {
                let (v11, v12, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T1>(&arg2), false);
                let v14 = 0x2::balance::value<T0>(&arg1);
                assert!(v12 <= v14, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_to_add_liquidity());
                if (arg4 == false) {
                    let v15 = v14 - v12;
                    assert!((v15 as u128) * 1000000000 / (v14 as u128) <= 10000000, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::difference_too_high());
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v15), arg5), 0x2::tx_context::sender(arg5));
                };
                0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
                (v11, 0x2::balance::split<T0>(&mut arg1, v12), arg2, false)
            }
        } else {
            let (v16, v17, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T1>(&arg2), false);
            let v19 = 0x2::balance::value<T0>(&arg1);
            assert!(v17 <= v19, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::insufficient_balance_to_add_liquidity());
            if (arg4 == false) {
                let v20 = v19 - v17;
                assert!((v20 as u128) * 1000000000 / (v19 as u128) <= 10000000, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::difference_too_high());
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v20), arg5), 0x2::tx_context::sender(arg5));
            };
            0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
            (v16, 0x2::balance::split<T0>(&mut arg1, v17), arg2, false)
        }
    }

    fun get_bluefin_sqrt_price_limits<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : (u128, u128) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = if (v0 >= 100 && v0 <= 500) {
            v1 * 999499874 / 1000000000
        } else if (v0 > 500 && v0 <= 2500) {
            v1 * 997496867 / 1000000000
        } else if (v0 > 2500 && v0 <= 10000) {
            v1 * 992471662 / 1000000000
        } else {
            v1 * 987420882 / 1000000000
        };
        let v3 = if (v0 >= 100 && v0 <= 500) {
            v1 * 1000499875 / 1000000000
        } else if (v0 > 500 && v0 <= 2500) {
            v1 * 1002496882 / 1000000000
        } else if (v0 > 2500 && v0 <= 10000) {
            v1 * 1007472083 / 1000000000
        } else {
            v1 * 1012422836 / 1000000000
        };
        (v2, v3)
    }

    fun get_borrow_amounts<T0, T1>(arg0: &Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : (u64, u64) {
        (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg1, arg0.market_id_a, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.position_cap), arg2), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg1, arg0.market_id_b, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&arg0.position_cap), arg2))
    }

    fun get_cetus_sqrt_price_limits<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u128, u128) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let v2 = if (v0 == 100) {
            v1 * 999749968 / 1000000000
        } else if (v0 == 10000) {
            v1 * 992471662 / 1000000000
        } else {
            v1 * 994987437 / 1000000000
        };
        let v3 = if (v0 == 100) {
            v1 * 1000249968 / 1000000000
        } else if (v0 == 10000) {
            v1 * 1007472083 / 1000000000
        } else {
            v1 * 1004987562 / 1000000000
        };
        (v2, v3)
    }

    public(friend) fun get_emergency_balances<T0, T1>(arg0: &Investor<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.emergency_balance_a), 0x2::balance::value<T1>(&arg0.emergency_balance_b))
    }

    public(friend) fun get_performance_fee<T0, T1>(arg0: &Investor<T0, T1>) : u64 {
        arg0.performance_fee
    }

    fun get_total_balance_in_ratio_with_limit_bluefin<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg2) == 0 || 0x2::balance::value<T1>(&arg3) == 0) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick)) && 0x2::balance::value<T1>(&arg3) == 0) {
                return (arg2, arg3)
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick)) && 0x2::balance::value<T0>(&arg2) == 0) {
                return (arg2, arg3)
            };
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::balance::withdraw_all<T0>(&mut arg2));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::balance::withdraw_all<T1>(&mut arg3));
        };
        let (_, v1, v2, _) = get_balances_in_ratio<T0, T1>(arg0, arg2, arg3, arg4, true, arg8);
        let v4 = v2;
        let v5 = v1;
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        let (v7, v8) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), v6)) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg4), 1000000000000, true);
            let _ = v9;
            (v10, v11)
        } else {
            let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg4), 1000000000000, false);
            let _ = v13;
            (v14, v15)
        };
        let v16 = 0x2::balance::value<T0>(&arg0.free_balance_a);
        let v17 = 0x2::balance::value<T1>(&arg0.free_balance_b);
        if (v16 > 0) {
            let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg4, true, true, v16 / 2, arg5);
            let v19 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v18) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v18);
            let v20 = (v7 as u256) * (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v18) as u256) + (v19 as u256) * (v8 as u256);
            let v21 = if (v20 > 0) {
                (v16 as u256) * (v8 as u256) * (v19 as u256) / v20
            } else {
                0
            };
            if (v21 >= (arg0.minimum_swap_amount as u256)) {
                let (v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg7, arg1, arg4, 0x2::balance::split<T0>(&mut arg0.free_balance_a, (v21 as u64)), 0x2::balance::zero<T1>(), true, true, (v21 as u64), 0, arg5);
                0x2::balance::destroy_zero<T0>(v22);
                0x2::balance::join<T1>(&mut v4, v23);
                0x2::balance::join<T0>(&mut v5, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
            };
        } else if (v17 > 0) {
            let v24 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg4, false, true, v17 / 2, arg6);
            let v25 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified(&v24) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v24);
            let v26 = (v8 as u256) * (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v24) as u256) + (v25 as u256) * (v7 as u256);
            let v27 = if (v26 > 0) {
                (v17 as u256) * (v7 as u256) * (v25 as u256) / v26
            } else {
                0
            };
            if (v27 >= (arg0.minimum_swap_amount as u256)) {
                let (v28, v29) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg7, arg1, arg4, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.free_balance_b, (v27 as u64)), false, true, (v27 as u64), 0, arg6);
                0x2::balance::destroy_zero<T1>(v29);
                0x2::balance::join<T0>(&mut v5, v28);
                0x2::balance::join<T1>(&mut v4, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
            };
        };
        (v5, v4)
    }

    fun get_total_balance_in_ratio_with_limit_cetus_a2b<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u128, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg2) == 0 || 0x2::balance::value<T1>(&arg3) == 0) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick)) && 0x2::balance::value<T1>(&arg3) == 0) {
                return (arg2, arg3)
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick)) && 0x2::balance::value<T0>(&arg2) == 0) {
                return (arg2, arg3)
            };
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::balance::withdraw_all<T0>(&mut arg2));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::balance::withdraw_all<T1>(&mut arg3));
        };
        let (_, v1, v2, _) = get_balances_in_ratio<T0, T1>(arg0, arg2, arg3, arg4, true, arg9);
        let v4 = v2;
        let v5 = v1;
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        let (v7, v8) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), v6)) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg4), 1000000000000, true);
            let _ = v9;
            (v10, v11)
        } else {
            let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg4), 1000000000000, false);
            let _ = v13;
            (v14, v15)
        };
        let v16 = 0x2::balance::value<T0>(&arg0.free_balance_a);
        let v17 = 0x2::balance::value<T1>(&arg0.free_balance_b);
        if (v16 > 0) {
            let v18 = v16 / 2;
            let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg5, true, true, v18);
            let v20 = (v7 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v19) as u256) + (v18 as u256) * (v8 as u256);
            let v21 = if (v20 > 0) {
                (v16 as u256) * (v8 as u256) * (v18 as u256) / v20
            } else {
                0
            };
            if (v21 >= (arg0.minimum_swap_amount as u256)) {
                let (v22, v23) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_a2b_with_fixed_limit<T0, T1>(arg1, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free_balance_a, (v21 as u64)), arg9), true, (v21 as u64), arg7, arg8, arg9);
                0x2::coin::destroy_zero<T0>(v22);
                0x2::balance::join<T1>(&mut v4, 0x2::coin::into_balance<T1>(v23));
                0x2::balance::join<T0>(&mut v5, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
            };
        } else if (v17 > 0) {
            let v24 = v17 / 2;
            let v25 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg5, false, true, v24);
            let v26 = (v8 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v25) as u256) + (v24 as u256) * (v7 as u256);
            let v27 = if (v26 > 0) {
                (v17 as u256) * (v7 as u256) * (v24 as u256) / v26
            } else {
                0
            };
            if (v27 >= (arg0.minimum_swap_amount as u256)) {
                let (v28, v29) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_b2a_with_fixed_limit<T0, T1>(arg1, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.free_balance_b, (v27 as u64)), arg9), true, (v27 as u64), arg6, arg8, arg9);
                0x2::coin::destroy_zero<T1>(v29);
                0x2::balance::join<T0>(&mut v5, 0x2::coin::into_balance<T0>(v28));
                0x2::balance::join<T1>(&mut v4, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
            };
        };
        (v5, v4)
    }

    fun get_total_balance_in_ratio_with_limit_cetus_b2a<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: u128, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg2) == 0 || 0x2::balance::value<T1>(&arg3) == 0) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick)) && 0x2::balance::value<T1>(&arg3) == 0) {
                return (arg2, arg3)
            };
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick)) && 0x2::balance::value<T0>(&arg2) == 0) {
                return (arg2, arg3)
            };
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::balance::withdraw_all<T0>(&mut arg2));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::balance::withdraw_all<T1>(&mut arg3));
        };
        let (_, v1, v2, _) = get_balances_in_ratio<T0, T1>(arg0, arg2, arg3, arg4, true, arg9);
        let v4 = v2;
        let v5 = v1;
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        let (v7, v8) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), v6)) {
            let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg4), 1000000000000, true);
            let _ = v9;
            (v10, v11)
        } else {
            let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg4), 1000000000000, false);
            let _ = v13;
            (v14, v15)
        };
        let v16 = 0x2::balance::value<T0>(&arg0.free_balance_a);
        let v17 = 0x2::balance::value<T1>(&arg0.free_balance_b);
        if (v16 > 0) {
            let v18 = v16 / 2;
            let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg5, false, true, v18);
            let v20 = (v7 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v19) as u256) + (v18 as u256) * (v8 as u256);
            let v21 = if (v20 > 0) {
                (v16 as u256) * (v8 as u256) * (v18 as u256) / v20
            } else {
                0
            };
            if (v21 >= (arg0.minimum_swap_amount as u256)) {
                let (v22, v23) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_b2a_with_fixed_limit<T1, T0>(arg1, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free_balance_a, (v21 as u64)), arg9), true, (v21 as u64), arg7, arg8, arg9);
                0x2::coin::destroy_zero<T0>(v23);
                0x2::balance::join<T1>(&mut v4, 0x2::coin::into_balance<T1>(v22));
                0x2::balance::join<T0>(&mut v5, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
            };
        } else if (v17 > 0) {
            let v24 = v17 / 2;
            let v25 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg5, true, true, v24);
            let v26 = (v8 as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v25) as u256) + (v24 as u256) * (v7 as u256);
            let v27 = if (v26 > 0) {
                (v17 as u256) * (v7 as u256) * (v24 as u256) / v26
            } else {
                0
            };
            if (v27 >= (arg0.minimum_swap_amount as u256)) {
                let (v28, v29) = 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::converter::swap_a2b_with_fixed_limit<T1, T0>(arg1, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.free_balance_b, (v27 as u64)), arg9), true, (v27 as u64), arg6, arg8, arg9);
                0x2::coin::destroy_zero<T1>(v28);
                0x2::balance::join<T0>(&mut v5, 0x2::coin::into_balance<T0>(v29));
                0x2::balance::join<T1>(&mut v4, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
            };
        };
        (v5, v4)
    }

    public(friend) fun get_total_borrowed_in_dollars<T0, T1>(arg0: &Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let (v0, v1) = get_borrow_amounts<T0, T1>(arg0, arg1, arg2);
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg1, arg0.market_id_a)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg1, arg0.market_id_b)))
    }

    public(friend) fun get_total_invested_in_dollar<T0, T1>(arg0: &Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg1, &arg0.position_cap, arg4);
        let v2 = v0;
        let (v3, v4) = get_amounts<T0, T1>(arg0, arg2, &v2);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg1, &arg0.position_cap, arg2, v2, v1, arg3, arg4);
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v3), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg1, arg0.market_id_a)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v4), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_asset_price(arg1, arg0.market_id_b)))
    }

    public(friend) fun get_total_liquidity<T0, T1>(arg0: &Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u128 {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg1, &arg0.position_cap, arg4);
        let v2 = v0;
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg1, &arg0.position_cap, arg2, v2, v1, arg3, arg4);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v2)
    }

    public(friend) fun is_emergency<T0, T1>(arg0: &Investor<T0, T1>) : bool {
        arg0.is_emergency
    }

    public(friend) fun rebalance_bluefin<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: u32, arg4: u32, arg5: u32, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg1, &arg0.position_cap, arg9);
        let v2 = v0;
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg6, arg3, arg4, arg9);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v2);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg6), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6), v4, false);
        let v7 = arg0.lower_tick;
        let v8 = arg0.upper_tick;
        arg0.lower_tick = arg3;
        arg0.upper_tick = arg4;
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6);
        let (v10, v11) = get_bluefin_sqrt_price_limits<T0, T1>(arg6);
        let v12 = v4 / (arg5 as u128);
        let v13 = v4 % (arg5 as u128);
        let v14 = 0;
        while (v14 < arg5 + 1) {
            if (v14 == arg5) {
                if (v13 == 0) {
                    break
                };
                v12 = v13;
            };
            let (_, _, v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg6, &mut v2, v12, arg8);
            let v19 = v18;
            let v20 = v17;
            0x2::balance::join<T0>(&mut v20, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
            0x2::balance::join<T1>(&mut v19, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
            let (v21, v22) = get_total_balance_in_ratio_with_limit_bluefin<T0, T1>(arg0, arg2, v20, v19, arg6, v10, v11, arg8, arg9);
            let (_, v24, v25, v26) = get_balances_in_ratio<T0, T1>(arg0, v21, v22, arg6, true, arg9);
            let v27 = &mut v3;
            deposit_to_bluefin<T0, T1>(arg0, arg2, arg6, v24, v25, v27, v26, arg8);
            v14 = v14 + 1;
        };
        let v28 = &mut v2;
        let (v29, v30, v31, v32, v33) = autocompound_internal<T0, T1>(arg0, arg1, arg2, arg6, v28, arg7, true, arg8, arg9);
        let v34 = &mut v3;
        deposit_to_bluefin<T0, T1>(arg0, arg2, arg6, v29, v30, v34, v31, arg8);
        close_position<T0, T1>(arg6, v2, arg2, arg8);
        let v35 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v3);
        let (v36, v37) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg6), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6), v35, false);
        let v38 = RebalancePoolEvent{
            investor_id       : 0x2::object::uid_to_inner(&arg0.id),
            amount_a_before   : v5,
            amount_b_before   : v6,
            amount_a_after    : v36,
            amount_b_after    : v37,
            liquidity_before  : v4,
            liquidity_after   : v35,
            lower_tick_before : v7,
            upper_tick_before : v8,
            lower_tick_after  : arg0.lower_tick,
            upper_tick_after  : arg0.upper_tick,
            sqrt_price_before : v9,
            sqrt_price_after  : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6),
            free_balance_a    : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b    : 0x2::balance::value<T1>(&arg0.free_balance_b),
            location          : 1,
        };
        0x2::event::emit<RebalancePoolEvent>(v38);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6) >= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick)) && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6) < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick)), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::out_of_range());
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg1, &arg0.position_cap, arg6, v3, v1, arg8, arg9);
        update_debt_to_supply_ratio<T0, T1>(arg0, arg1, arg6, arg8, arg9);
        (v32, v33)
    }

    public(friend) fun rebalance_cetus_a2b<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u32, arg5: u32, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg1, &arg0.position_cap, arg10);
        let v2 = v0;
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg6, arg4, arg5, arg10);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v2);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg6), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6), v4, false);
        let v7 = arg0.lower_tick;
        let v8 = arg0.upper_tick;
        arg0.lower_tick = arg4;
        arg0.upper_tick = arg5;
        let v9 = &mut v2;
        let (v10, v11, _, v13, v14) = autocompound_internal<T0, T1>(arg0, arg1, arg2, arg6, v9, arg8, true, arg9, arg10);
        let v15 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6);
        let (v16, v17) = get_cetus_sqrt_price_limits<T0, T1>(arg7);
        let (_, _, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg6, &mut v2, v4, arg9);
        let v22 = v21;
        let v23 = v20;
        0x2::balance::join<T0>(&mut v23, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        0x2::balance::join<T1>(&mut v22, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        0x2::balance::join<T0>(&mut v23, v10);
        0x2::balance::join<T1>(&mut v22, v11);
        let (v24, v25) = get_total_balance_in_ratio_with_limit_cetus_a2b<T0, T1>(arg0, arg3, v23, v22, arg6, arg7, v16, v17, arg9, arg10);
        let (_, v27, v28, v29) = get_balances_in_ratio<T0, T1>(arg0, v24, v25, arg6, true, arg10);
        let v30 = &mut v3;
        deposit_to_bluefin<T0, T1>(arg0, arg2, arg6, v27, v28, v30, v29, arg9);
        close_position<T0, T1>(arg6, v2, arg2, arg9);
        let v31 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v3);
        let (v32, v33) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg6), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6), v31, false);
        let v34 = RebalancePoolEvent{
            investor_id       : 0x2::object::uid_to_inner(&arg0.id),
            amount_a_before   : v5,
            amount_b_before   : v6,
            amount_a_after    : v32,
            amount_b_after    : v33,
            liquidity_before  : v4,
            liquidity_after   : v31,
            lower_tick_before : v7,
            upper_tick_before : v8,
            lower_tick_after  : arg0.lower_tick,
            upper_tick_after  : arg0.upper_tick,
            sqrt_price_before : v15,
            sqrt_price_after  : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6),
            free_balance_a    : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b    : 0x2::balance::value<T1>(&arg0.free_balance_b),
            location          : 1,
        };
        0x2::event::emit<RebalancePoolEvent>(v34);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6) >= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick)) && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6) < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick)), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::out_of_range());
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg1, &arg0.position_cap, arg6, v3, v1, arg9, arg10);
        update_debt_to_supply_ratio<T0, T1>(arg0, arg1, arg6, arg9, arg10);
        (v13, v14)
    }

    public(friend) fun rebalance_cetus_b2a<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: u32, arg5: u32, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg1, &arg0.position_cap, arg10);
        let v2 = v0;
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg6, arg4, arg5, arg10);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v2);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg6), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6), v4, false);
        let v7 = arg0.lower_tick;
        let v8 = arg0.upper_tick;
        arg0.lower_tick = arg4;
        arg0.upper_tick = arg5;
        let v9 = &mut v2;
        let (v10, v11, _, v13, v14) = autocompound_internal<T0, T1>(arg0, arg1, arg2, arg6, v9, arg8, true, arg9, arg10);
        let v15 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6);
        let (v16, v17) = get_cetus_sqrt_price_limits<T1, T0>(arg7);
        let (_, _, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg6, &mut v2, v4, arg9);
        let v22 = v21;
        let v23 = v20;
        0x2::balance::join<T0>(&mut v23, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        0x2::balance::join<T1>(&mut v22, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        0x2::balance::join<T0>(&mut v23, v10);
        0x2::balance::join<T1>(&mut v22, v11);
        let (v24, v25) = get_total_balance_in_ratio_with_limit_cetus_b2a<T0, T1>(arg0, arg3, v23, v22, arg6, arg7, v16, v17, arg9, arg10);
        let (_, v27, v28, v29) = get_balances_in_ratio<T0, T1>(arg0, v24, v25, arg6, true, arg10);
        let v30 = &mut v3;
        deposit_to_bluefin<T0, T1>(arg0, arg2, arg6, v27, v28, v30, v29, arg9);
        close_position<T0, T1>(arg6, v2, arg2, arg9);
        let v31 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v3);
        let (v32, v33) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg6), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6), v31, false);
        let v34 = RebalancePoolEvent{
            investor_id       : 0x2::object::uid_to_inner(&arg0.id),
            amount_a_before   : v5,
            amount_b_before   : v6,
            amount_a_after    : v32,
            amount_b_after    : v33,
            liquidity_before  : v4,
            liquidity_after   : v31,
            lower_tick_before : v7,
            upper_tick_before : v8,
            lower_tick_after  : arg0.lower_tick,
            upper_tick_after  : arg0.upper_tick,
            sqrt_price_before : v15,
            sqrt_price_after  : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6),
            free_balance_a    : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b    : 0x2::balance::value<T1>(&arg0.free_balance_b),
            location          : 1,
        };
        0x2::event::emit<RebalancePoolEvent>(v34);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6) >= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick)) && 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg6) < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick)), 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::out_of_range());
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg1, &arg0.position_cap, arg6, v3, v1, arg9, arg10);
        update_debt_to_supply_ratio<T0, T1>(arg0, arg1, arg6, arg9, arg10);
        (v13, v14)
    }

    public(friend) fun rebalance_debts<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u64, arg2: bool, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg1 >= arg0.minimum_swap_amount, 13906839062016163839);
        let (v0, v1) = autocompound<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let (v2, v3) = get_bluefin_sqrt_price_limits<T0, T1>(arg5);
        if (arg2) {
            let (v4, v5) = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
                let (v6, v7) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_borrow<0x2::sui::SUI>(arg3, &arg0.position_cap, arg0.market_id_a, arg1, arg8, arg9);
                let v8 = recast_balance_type<T0, T1, 0x2::sui::SUI, T0>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg3, v6, arg6, arg8, arg9)));
                (v8, v7)
            } else {
                let (v9, v10) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_borrow<T0>(arg3, &arg0.position_cap, arg0.market_id_a, arg1, arg8, arg9);
                (0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, v9, arg8, arg9)), v10)
            };
            let v11 = v4;
            let (v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg8, arg4, arg5, v11, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&v11), 0, v2);
            let v14 = v12;
            assert!(0x2::balance::value<T0>(&v14) == 0, 1);
            0x2::balance::destroy_zero<T0>(v14);
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_repay<T1>(arg3, &arg0.position_cap, v5, arg0.market_id_b, 0x2::coin::from_balance<T1>(v13, arg9), arg8, arg9)));
        } else {
            let (v15, v16) = if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
                let (v17, v18) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_borrow<0x2::sui::SUI>(arg3, &arg0.position_cap, arg0.market_id_b, arg1, arg8, arg9);
                let v19 = recast_balance_type<T0, T1, 0x2::sui::SUI, T1>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg3, v17, arg6, arg8, arg9)));
                (v19, v18)
            } else {
                let (v20, v21) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_borrow<T1>(arg3, &arg0.position_cap, arg0.market_id_b, arg1, arg8, arg9);
                (0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg3, v20, arg8, arg9)), v21)
            };
            let v22 = v15;
            let (v23, v24) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg8, arg4, arg5, 0x2::balance::zero<T0>(), v22, false, true, 0x2::balance::value<T1>(&v22), 0, v3);
            let v25 = v24;
            assert!(0x2::balance::value<T1>(&v25) == 0, 2);
            0x2::balance::destroy_zero<T1>(v25);
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::flash_repay<T0>(arg3, &arg0.position_cap, v16, arg0.market_id_a, 0x2::coin::from_balance<T0>(v23, arg9), arg8, arg9)));
        };
        update_debt_to_supply_ratio<T0, T1>(arg0, arg3, arg5, arg8, arg9);
        (v0, v1)
    }

    fun recast_balance_type<T0, T1, T2, T3>(arg0: &mut Investor<T0, T1>, arg1: 0x2::balance::Balance<T2>) : 0x2::balance::Balance<T3> {
        update_free_rewards<T0, T1, T2>(arg0, arg1);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T3>()) == true, 13906838477900611583);
        0x2::balance::split<T3>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T3>()), 0x2::balance::value<T2>(&arg1))
    }

    public(friend) fun set_minimum_swap_amount<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u64) {
        arg0.minimum_swap_amount = arg1;
    }

    public(friend) fun set_performance_fee<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u64) {
        assert!(arg1 <= arg0.performance_fee_max_cap, 0x9bbd650b8442abb082c20f3bc95a9434a8d47b4bef98b0832dab57c1a8ba7123::error::fee_too_high_error());
        arg0.performance_fee = arg1;
    }

    public(friend) fun set_safe_borrow_percentage<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u64) {
        assert!(arg1 <= 9500, 13906834805703573503);
        arg0.safe_borrow_percentage = arg1;
    }

    public(friend) fun update_debt_to_supply_ratio<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        update_debts<T0, T1>(arg0, arg1, arg3);
        let v0 = get_total_borrowed_in_dollars<T0, T1>(arg0, arg1, arg3);
        let v1 = get_total_invested_in_dollar<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::eq(v1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0))) {
            arg0.current_debt_to_supply_ratio = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        } else {
            arg0.current_debt_to_supply_ratio = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(v0, v1);
        };
    }

    fun update_debts<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) {
        let (v0, v1) = get_borrow_amounts<T0, T1>(arg0, arg1, arg2);
        arg0.cur_debt_a = v0;
        arg0.cur_debt_b = v1;
    }

    fun update_free_rewards<T0, T1, T2>(arg0: &mut Investor<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>()) == true) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>()), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.free_rewards, 0x1::type_name::with_defining_ids<T2>(), arg1);
        };
    }

    public(friend) fun user_emergency_withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u128, arg2: u128) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::balance::split<T0>(&mut arg0.emergency_balance_a, (((arg1 as u256) * (0x2::balance::value<T0>(&arg0.emergency_balance_a) as u256) / (arg2 as u256)) as u64)), 0x2::balance::split<T1>(&mut arg0.emergency_balance_b, (((arg1 as u256) * (0x2::balance::value<T1>(&arg0.emergency_balance_b) as u256) / (arg2 as u256)) as u64)))
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u128, arg2: u128, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow_bluefin_lp_collateral(arg3, &arg0.position_cap, arg7);
        let v2 = v0;
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v2) * arg1 / arg2, false);
        let v5 = get_total_borrowed_in_dollars<T0, T1>(arg0, arg3, arg6);
        let (v6, v7) = calculate_token_amounts_from_dollars<T0, T1>(arg0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v5, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(arg1)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(arg2)), arg3, arg5, &v2);
        let (v8, _, _) = get_liquidity_from_amount<T0, T1>(arg0, v3 - v6, v4 - v7, arg5);
        let (_, _, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg4, arg5, &mut v2, v8, arg6);
        let v15 = &mut v2;
        withdraw_and_repay<T0, T1>(arg0, v6, v7, arg3, arg4, arg5, v15, arg6, arg7);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::return_bluefin_lp_collateral<T0, T1>(arg3, &arg0.position_cap, arg5, v2, v1, arg6, arg7);
        update_debt_to_supply_ratio<T0, T1>(arg0, arg3, arg5, arg6, arg7);
        (v13, v14)
    }

    public(friend) fun withdraw_and_repay<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _) = get_liquidity_from_amount<T0, T1>(arg0, arg1, arg2, arg5);
        if (v0 == 0) {
            return
        };
        let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg4, arg5, arg6, v0, arg7);
        let v7 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::repay<T0>(arg3, &arg0.position_cap, arg0.market_id_a, 0x2::coin::from_balance<T0>(v5, arg8), arg7, arg8);
        let v8 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::repay<T1>(arg3, &arg0.position_cap, arg0.market_id_b, 0x2::coin::from_balance<T1>(v6, arg8), arg7, arg8);
        let (v9, v10) = get_bluefin_sqrt_price_limits<T0, T1>(arg5);
        let v11 = 0x2::coin::value<T0>(&v7);
        let v12 = 0x2::coin::value<T1>(&v8);
        if (v11 > 0) {
            0x2::coin::destroy_zero<T1>(v8);
            let (v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg7, arg4, arg5, 0x2::coin::into_balance<T0>(v7), 0x2::balance::zero<T1>(), true, true, v11, 0, v9);
            let v15 = v13;
            assert!(0x2::balance::value<T0>(&v15) == 0, 1);
            0x2::balance::destroy_zero<T0>(v15);
            let v16 = 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::repay<T1>(arg3, &arg0.position_cap, arg0.market_id_b, 0x2::coin::from_balance<T1>(v14, arg8), arg7, arg8));
            update_free_rewards<T0, T1, T1>(arg0, v16);
        } else if (v12 > 0) {
            0x2::coin::destroy_zero<T0>(v7);
            let (v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg7, arg4, arg5, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v8), false, true, v12, 0, v10);
            let v19 = v18;
            assert!(0x2::balance::value<T1>(&v19) == 0, 2);
            0x2::balance::destroy_zero<T1>(v19);
            let v20 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::repay<T0>(arg3, &arg0.position_cap, arg0.market_id_a, 0x2::coin::from_balance<T0>(v17, arg8), arg7, arg8));
            update_free_rewards<T0, T1, T0>(arg0, v20);
        } else {
            0x2::coin::destroy_zero<T0>(v7);
            0x2::coin::destroy_zero<T1>(v8);
        };
    }

    // decompiled from Move bytecode v6
}

