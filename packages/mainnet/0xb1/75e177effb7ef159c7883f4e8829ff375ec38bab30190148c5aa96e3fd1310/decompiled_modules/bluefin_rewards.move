module 0xf9fb721962251aa3587d9b570543efcd04b43c6e95e7afd5a1bdc202354f1eb7::bluefin_rewards {
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

    fun assert_active_one_tick<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32, arg2: u32) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg2);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)), v1), 0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v2, v0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v2, v1), 1);
    }

    public entry fun harvest_one_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg4, 2);
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position<T0, T1>(arg0, arg1, arg2, arg3);
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

    public entry fun rebalance_one_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u32, arg7: u32, arg8: u64, arg9: bool, arg10: u64, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        assert_active_one_tick<T0, T1>(arg2, arg6, arg7);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg10, 2);
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position<T0, T1>(arg0, arg1, arg2, arg3);
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

    fun transfer_nonzero<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

