module 0xdbbf6848ae454663012ac7da73b670e6646eabb0e722b18af57a732ee31c2794::bluefin_rewards {
    struct BluefinPositionOpened has copy, drop {
        tick_lower: u32,
        tick_upper: u32,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct BluefinPositionHarvested has copy, drop {
        reward_amount: u64,
        returned_a: u64,
        returned_b: u64,
    }

    struct PositionToppedUp has copy, drop {
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct RewardCollectedOnly has copy, drop {
        reward_amount: u64,
    }

    struct AtomicCapitalConveyor has copy, drop {
        reward_amount: u64,
        closed_a: u64,
        closed_b: u64,
        swap_input_a: u64,
        swap_output_b: u64,
        tick_lower: u32,
        tick_upper: u32,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct AtomicFeeLoopMeasured has copy, drop {
        initial_a: u64,
        initial_b: u64,
        final_a: u64,
        final_b: u64,
        first_swap_b: u64,
        second_swap_a: u64,
    }

    struct BluefinPositionRebalanced has copy, drop {
        tick_lower: u32,
        tick_upper: u32,
        reward_amount: u64,
        closed_a: u64,
        closed_b: u64,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct SpacingPositionRebalanced has copy, drop {
        tick_lower: u32,
        tick_upper: u32,
        reward_amount: u64,
        reward_compounded: bool,
        closed_a: u64,
        closed_b: u64,
        swap_a_to_b: bool,
        swap_input: u64,
        swap_output: u64,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    fun assert_active_one_tick<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32, arg2: u32) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)), v1), 0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v2, v0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v2, v1), 1);
    }

    public entry fun atomic_fee_loop_probe<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T0>, arg6: u32, arg7: u32, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        assert_active_one_tick<T0, T1>(arg2, arg6, arg7);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg6, arg7, arg12);
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v0, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg8, arg9);
        let v5 = 0x2::coin::into_balance<T0>(arg5);
        let (v6, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, 0x2::balance::value<T0>(&v5), 4295048017 + 1);
        let v9 = v7;
        0x2::balance::join<T0>(&mut v5, v6);
        let v10 = 0x2::balance::value<T1>(&v9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v5, 0x2::balance::zero<T1>(), v8);
        let (v11, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, v10, 79226673515401279992447579055 - 1);
        let v14 = v11;
        0x2::balance::join<T1>(&mut v9, v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v9, v13);
        let (v15, v16) = close_and_collect<T0, T1>(arg0, arg1, arg2, v0);
        let v17 = v16;
        let v18 = v15;
        0x2::balance::join<T0>(&mut v18, v3);
        0x2::balance::join<T0>(&mut v18, v14);
        0x2::balance::join<T1>(&mut v17, v4);
        let v19 = 0x2::balance::value<T0>(&v18);
        let v20 = 0x2::balance::value<T1>(&v17);
        assert!(v19 >= arg10, 3);
        assert!(v20 >= arg11, 4);
        let v21 = AtomicFeeLoopMeasured{
            initial_a     : 0x2::coin::value<T0>(&arg3) + 0x2::coin::value<T0>(&arg5),
            initial_b     : 0x2::coin::value<T1>(&arg4),
            final_a       : v19,
            final_b       : v20,
            first_swap_b  : v10,
            second_swap_a : 0x2::balance::value<T0>(&v14),
        };
        0x2::event::emit<AtomicFeeLoopMeasured>(v21);
        let v22 = 0x2::tx_context::sender(arg12);
        transfer_nonzero<T0>(v18, v22, arg12);
        let v23 = 0x2::tx_context::sender(arg12);
        transfer_nonzero<T1>(v17, v23, arg12);
    }

    public entry fun atomic_reward_growth_probe<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 7);
        assert_active_one_tick<T0, T1>(arg2, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg11);
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v0, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg7, arg8);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut v0);
        let v6 = 0x2::balance::value<T2>(&v5);
        assert!(v6 >= arg9, 2);
        let (v7, v8) = close_and_collect<T0, T1>(arg0, arg1, arg2, v0);
        let v9 = v8;
        let v10 = v7;
        0x2::balance::join<T0>(&mut v10, v3);
        0x2::balance::join<T1>(&mut v9, v4);
        let v11 = BluefinPositionHarvested{
            reward_amount : v6,
            returned_a    : 0x2::balance::value<T0>(&v10),
            returned_b    : 0x2::balance::value<T1>(&v9),
        };
        0x2::event::emit<BluefinPositionHarvested>(v11);
        let v12 = 0x2::tx_context::sender(arg11);
        transfer_nonzero<T0>(v10, v12, arg11);
        let v13 = 0x2::tx_context::sender(arg11);
        transfer_nonzero<T1>(v9, v13, arg11);
        transfer_nonzero<T2>(v5, arg10, arg11);
    }

    fun close_and_collect<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3), arg0);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg3);
        if (v6 > 0 || v7 > 0) {
            let (_, _, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, &mut arg3);
            0x2::balance::join<T0>(&mut v5, v10);
            0x2::balance::join<T1>(&mut v4, v11);
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg0, arg1, arg2, arg3);
        (v5, v4)
    }

    public entry fun collect_reward_into_coin<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::coin::Coin<T2>, arg5: u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg5, 2);
        let v2 = RewardCollectedOnly{reward_amount: v1};
        0x2::event::emit<RewardCollectedOnly>(v2);
        0x2::balance::send_funds<T2>(v0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public entry fun collect_reward_only<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 7);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg4, 2);
        let v2 = RewardCollectedOnly{reward_amount: v1};
        0x2::event::emit<RewardCollectedOnly>(v2);
        0x2::balance::send_funds<T2>(v0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public entry fun collect_two_rewards_into_coin<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg6: &mut 0x2::coin::Coin<T4>, arg7: u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T4>(arg0, arg1, arg2, arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T2, T3, T4>(arg0, arg1, arg4, arg5);
        let v2 = 0x2::balance::value<T4>(&v0) + 0x2::balance::value<T4>(&v1);
        assert!(v2 >= arg7, 2);
        0x2::balance::join<T4>(&mut v0, v1);
        let v3 = RewardCollectedOnly{reward_amount: v2};
        0x2::event::emit<RewardCollectedOnly>(v3);
        0x2::balance::send_funds<T4>(v0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public fun harvest_balances<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg4, 2);
        let (v2, v3) = close_and_collect<T0, T1>(arg0, arg1, arg2, arg3);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        assert!(v6 >= arg5, 3);
        assert!(v7 >= arg6, 4);
        let v8 = BluefinPositionHarvested{
            reward_amount : v1,
            returned_a    : v6,
            returned_b    : v7,
        };
        0x2::event::emit<BluefinPositionHarvested>(v8);
        (v5, v4, v0)
    }

    public entry fun harvest_one_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 7);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg4, 2);
        let (v2, v3) = close_and_collect<T0, T1>(arg0, arg1, arg2, arg3);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        assert!(v6 >= arg5, 3);
        assert!(v7 >= arg6, 4);
        let v8 = BluefinPositionHarvested{
            reward_amount : v1,
            returned_a    : v6,
            returned_b    : v7,
        };
        0x2::event::emit<BluefinPositionHarvested>(v8);
        let v9 = 0x2::tx_context::sender(arg8);
        transfer_nonzero<T0>(v5, v9, arg8);
        let v10 = 0x2::tx_context::sender(arg8);
        transfer_nonzero<T1>(v4, v10, arg8);
        transfer_nonzero<T2>(v0, arg7, arg8);
    }

    public entry fun harvest_rebalance_a_to_b_reopen_current<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 >= arg6, 2);
        let (v2, v3) = close_and_collect<T0, T1>(arg0, arg1, arg2, arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::join<T0>(&mut v5, v0);
        assert!(0x2::balance::value<T0>(&v5) >= arg4, 3);
        let (v6, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, arg4, 4295048017 + 1);
        let v9 = v7;
        let v10 = 0x2::balance::split<T0>(&mut v5, arg4);
        0x2::balance::join<T0>(&mut v10, v6);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v10, 0x2::balance::zero<T1>(), v8);
        0x2::balance::join<T1>(&mut v4, v9);
        let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v12 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v11);
        let v13 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v11, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)));
        let v14 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, v12, v13, arg11);
        let (v15, v16, v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v14, v5, v4, arg5, false);
        let v19 = v18;
        let v20 = v17;
        let v21 = 0x2::balance::value<T0>(&v20);
        let v22 = 0x2::balance::value<T1>(&v19);
        assert!(v15 >= arg7, 5);
        assert!(v16 >= arg8, 6);
        assert!(v21 >= arg9, 3);
        assert!(v22 >= arg10, 4);
        let v23 = AtomicCapitalConveyor{
            reward_amount : v1,
            closed_a      : 0x2::balance::value<T0>(&v5),
            closed_b      : 0x2::balance::value<T1>(&v4),
            swap_input_a  : arg4,
            swap_output_b : 0x2::balance::value<T1>(&v9),
            tick_lower    : v12,
            tick_upper    : v13,
            deposited_a   : v15,
            deposited_b   : v16,
            residual_a    : v21,
            residual_b    : v22,
        };
        0x2::event::emit<AtomicCapitalConveyor>(v23);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v14, 0x2::tx_context::sender(arg11));
        let v24 = 0x2::tx_context::sender(arg11);
        transfer_nonzero<T0>(v20, v24, arg11);
        let v25 = 0x2::tx_context::sender(arg11);
        transfer_nonzero<T1>(v19, v25, arg11);
    }

    public entry fun open_one_tick<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        assert_active_one_tick<T0, T1>(arg2, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg9);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v0, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg7, arg8);
        let v5 = v4;
        let v6 = v3;
        let v7 = BluefinPositionOpened{
            tick_lower  : arg5,
            tick_upper  : arg6,
            deposited_a : v1,
            deposited_b : v2,
            residual_a  : 0x2::balance::value<T0>(&v6),
            residual_b  : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<BluefinPositionOpened>(v7);
        let v8 = 0x2::tx_context::sender(arg9);
        transfer_nonzero<T0>(v6, v8, arg9);
        let v9 = 0x2::tx_context::sender(arg9);
        transfer_nonzero<T1>(v5, v9, arg9);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::tx_context::sender(arg9));
    }

    public entry fun rebalance_current_spacing<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u32, arg5: bool, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: address, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg15 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 7);
        assert!(!arg9, 7);
        assert!(arg4 > 0, 0);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 >= arg10, 2);
        let (v2, v3) = close_and_collect<T0, T1>(arg0, arg1, arg2, arg3);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::zero<T0>();
        if (arg9) {
            0x2::balance::join<T0>(&mut v5, v0);
        } else {
            0x2::balance::join<T0>(&mut v6, v0);
        };
        let v7 = 0;
        if (arg6 > 0) {
            if (arg5) {
                assert!(0x2::balance::value<T0>(&v5) >= arg6, 3);
                let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, arg6, 4295048017 + 1);
                let v11 = v9;
                let v12 = 0x2::balance::split<T0>(&mut v5, arg6);
                0x2::balance::join<T0>(&mut v12, v8);
                v7 = 0x2::balance::value<T1>(&v11);
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v12, 0x2::balance::zero<T1>(), v10);
                0x2::balance::join<T1>(&mut v4, v11);
            } else {
                assert!(0x2::balance::value<T1>(&v4) >= arg6, 4);
                let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, arg6, 79226673515401279992447579055 - 1);
                let v16 = v13;
                let v17 = 0x2::balance::split<T1>(&mut v4, arg6);
                0x2::balance::join<T1>(&mut v17, v14);
                v7 = 0x2::balance::value<T0>(&v16);
                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v17, v15);
                0x2::balance::join<T0>(&mut v5, v16);
            };
        };
        let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v19 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg4);
        let v20 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v18, v19), v19);
        let v21 = v20;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v18) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v18, v19), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v21 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v20, v19);
        };
        let v22 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v21);
        let v23 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v21, v19));
        let v24 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, v22, v23, arg16);
        let (v25, v26, v27, v28) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v24, v5, v4, arg7, arg8);
        let v29 = v28;
        let v30 = v27;
        let v31 = 0x2::balance::value<T0>(&v30);
        let v32 = 0x2::balance::value<T1>(&v29);
        assert!(v25 >= arg11, 5);
        assert!(v26 >= arg12, 6);
        assert!(v31 >= arg13, 3);
        assert!(v32 >= arg14, 4);
        let v33 = SpacingPositionRebalanced{
            tick_lower        : v22,
            tick_upper        : v23,
            reward_amount     : v1,
            reward_compounded : arg9,
            closed_a          : 0x2::balance::value<T0>(&v5),
            closed_b          : 0x2::balance::value<T1>(&v4),
            swap_a_to_b       : arg5,
            swap_input        : arg6,
            swap_output       : v7,
            deposited_a       : v25,
            deposited_b       : v26,
            residual_a        : v31,
            residual_b        : v32,
        };
        0x2::event::emit<SpacingPositionRebalanced>(v33);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v24, 0x2::tx_context::sender(arg16));
        let v34 = 0x2::tx_context::sender(arg16);
        transfer_nonzero<T0>(v30, v34, arg16);
        let v35 = 0x2::tx_context::sender(arg16);
        transfer_nonzero<T1>(v29, v35, arg16);
        transfer_nonzero<T0>(v6, arg15, arg16);
    }

    public entry fun rebalance_one_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u32, arg7: u32, arg8: u64, arg9: bool, arg10: u64, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 7);
        assert_active_one_tick<T0, T1>(arg2, arg6, arg7);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg10, 2);
        let (v2, v3) = close_and_collect<T0, T1>(arg0, arg1, arg2, arg3);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::into_balance<T0>(arg4);
        0x2::balance::join<T0>(&mut v6, v5);
        let v7 = 0x2::coin::into_balance<T1>(arg5);
        0x2::balance::join<T1>(&mut v7, v4);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg6, arg7, arg12);
        let (v9, v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v8, v6, v7, arg8, arg9);
        let v13 = v12;
        let v14 = v11;
        let v15 = BluefinPositionRebalanced{
            tick_lower    : arg6,
            tick_upper    : arg7,
            reward_amount : v1,
            closed_a      : 0x2::balance::value<T0>(&v5),
            closed_b      : 0x2::balance::value<T1>(&v4),
            deposited_a   : v9,
            deposited_b   : v10,
            residual_a    : 0x2::balance::value<T0>(&v14),
            residual_b    : 0x2::balance::value<T1>(&v13),
        };
        0x2::event::emit<BluefinPositionRebalanced>(v15);
        let v16 = 0x2::tx_context::sender(arg12);
        transfer_nonzero<T0>(v14, v16, arg12);
        let v17 = 0x2::tx_context::sender(arg12);
        transfer_nonzero<T1>(v13, v17, arg12);
        transfer_nonzero<T2>(v0, arg11, arg12);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v8, 0x2::tx_context::sender(arg12));
    }

    public fun reopen_balances<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert_active_one_tick<T0, T1>(arg2, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg9);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v0, arg3, arg4, arg7, arg8);
        let v5 = v4;
        let v6 = v3;
        let v7 = BluefinPositionOpened{
            tick_lower  : arg5,
            tick_upper  : arg6,
            deposited_a : v1,
            deposited_b : v2,
            residual_a  : 0x2::balance::value<T0>(&v6),
            residual_b  : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<BluefinPositionOpened>(v7);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::tx_context::sender(arg9));
        (v6, v5)
    }

    public fun reopen_current_spacing_balances<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u32, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg5 > 0, 0);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg5);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v0, v1), v1);
        let v3 = v2;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v0) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v0, v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v1);
        };
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, v1));
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, v4, v5, arg8);
        let (v7, v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v6, arg3, arg4, arg6, arg7);
        let v11 = v10;
        let v12 = v9;
        let v13 = BluefinPositionOpened{
            tick_lower  : v4,
            tick_upper  : v5,
            deposited_a : v7,
            deposited_b : v8,
            residual_a  : 0x2::balance::value<T0>(&v12),
            residual_b  : 0x2::balance::value<T1>(&v11),
        };
        0x2::event::emit<BluefinPositionOpened>(v13);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v6, 0x2::tx_context::sender(arg8));
        (v12, v11)
    }

    public fun reopen_current_tick_balances<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)));
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, v1, v2, arg7);
        let (v4, v5, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v3, arg3, arg4, arg5, arg6);
        let v8 = v7;
        let v9 = v6;
        let v10 = BluefinPositionOpened{
            tick_lower  : v1,
            tick_upper  : v2,
            deposited_a : v4,
            deposited_b : v5,
            residual_a  : 0x2::balance::value<T0>(&v9),
            residual_b  : 0x2::balance::value<T1>(&v8),
        };
        0x2::event::emit<BluefinPositionOpened>(v10);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v3, 0x2::tx_context::sender(arg7));
        (v9, v8)
    }

    public entry fun roundtrip_probe<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert_active_one_tick<T0, T1>(arg2, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg11);
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v0, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg7, arg8);
        let (v5, v6) = close_and_collect<T0, T1>(arg0, arg1, arg2, v0);
        let v7 = v6;
        let v8 = v5;
        0x2::balance::join<T0>(&mut v8, v3);
        0x2::balance::join<T1>(&mut v7, v4);
        assert!(0x2::balance::value<T0>(&v8) >= arg9, 3);
        assert!(0x2::balance::value<T1>(&v7) >= arg10, 4);
        let v9 = 0x2::tx_context::sender(arg11);
        transfer_nonzero<T0>(v8, v9, arg11);
        let v10 = 0x2::tx_context::sender(arg11);
        transfer_nonzero<T1>(v7, v10, arg11);
    }

    public fun settle_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        transfer_nonzero<T0>(arg0, arg1, arg2);
    }

    public fun top_up_position_balances<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v4 = v3;
        let v5 = v2;
        let v6 = PositionToppedUp{
            deposited_a : v0,
            deposited_b : v1,
            residual_a  : 0x2::balance::value<T0>(&v5),
            residual_b  : 0x2::balance::value<T1>(&v4),
        };
        0x2::event::emit<PositionToppedUp>(v6);
        (v5, v4)
    }

    fun transfer_nonzero<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

