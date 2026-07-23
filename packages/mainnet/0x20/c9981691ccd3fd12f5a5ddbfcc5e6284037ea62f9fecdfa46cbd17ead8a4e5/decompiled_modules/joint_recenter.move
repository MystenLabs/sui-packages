module 0x472d27d6bba8725a15b72ed5e388d167dc5c2a597734abbdd50c869e4869ce3e::joint_recenter {
    struct OrdinaryBluefinClosed has copy, drop {
        source_position_id: 0x2::object::ID,
        source_liquidity: u128,
        principal_a: u64,
        principal_b: u64,
        fee_a: u64,
        fee_b: u64,
        reward_a: u64,
    }

    struct JointPrincipalJoined has copy, drop {
        ordinary_a: u64,
        ordinary_b: u64,
        kai_a: u64,
        kai_b: u64,
        combined_a: u64,
        combined_b: u64,
    }

    struct JointPrincipalPartitioned has copy, drop {
        ordinary_a: u64,
        ordinary_b: u64,
        kai_a: u64,
        kai_b: u64,
        combined_a: u64,
        combined_b: u64,
    }

    struct OrdinaryBluefinReopened has copy, drop {
        destination_position_id: 0x2::object::ID,
        observed_tick_bits: u32,
        tick_lower_bits: u32,
        tick_upper_bits: u32,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct JointProfitPaid has copy, drop {
        amount: u64,
        recipient: address,
    }

    fun assert_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 <= arg1, 0);
        assert!(arg1 - v0 <= 30000, 1);
    }

    public fun close_ordinary_bluefin<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert_deadline(arg0, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = &mut arg3;
        let (v3, v4) = collect_fees_if_any<T0, T1>(arg0, arg1, arg2, v2);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3);
        let (_, _, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, v7, arg0);
        let v12 = v11;
        let v13 = v10;
        let v14 = &mut arg3;
        let (v15, v16) = collect_fees_if_any<T0, T1>(arg0, arg1, arg2, v14);
        0x2::balance::join<T0>(&mut v6, v15);
        0x2::balance::join<T1>(&mut v5, v16);
        0x2::balance::join<T0>(&mut v6, v0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg0, arg1, arg2, arg3);
        let v17 = 0x2::balance::value<T0>(&v13);
        let v18 = 0x2::balance::value<T1>(&v12);
        assert!(v17 >= arg4, 2);
        assert!(v18 >= arg5, 3);
        let v19 = OrdinaryBluefinClosed{
            source_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg3),
            source_liquidity   : v7,
            principal_a        : v17,
            principal_b        : v18,
            fee_a              : 0x2::balance::value<T0>(&v6) - v1,
            fee_b              : 0x2::balance::value<T1>(&v5),
            reward_a           : v1,
        };
        0x2::event::emit<OrdinaryBluefinClosed>(v19);
        (v13, v12, v6, v5)
    }

    public fun close_ordinary_bluefin_to_sui<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2, v3) = close_ordinary_bluefin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v4 = v3;
        0x2::balance::join<T1>(&mut v4, swap_a_to_b<T0, T1>(arg0, arg1, arg2, v2));
        (v0, v1, v4)
    }

    fun collect_fees_if_any<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(arg3);
        if (v0 > 0 || v1 > 0) {
            let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, arg3);
            (v6, v7)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        }
    }

    public fun join_principal<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0, arg2);
        0x2::balance::join<T1>(&mut arg1, arg3);
        let v0 = JointPrincipalJoined{
            ordinary_a : 0x2::balance::value<T0>(&arg0),
            ordinary_b : 0x2::balance::value<T1>(&arg1),
            kai_a      : 0x2::balance::value<T0>(&arg2),
            kai_b      : 0x2::balance::value<T1>(&arg3),
            combined_a : 0x2::balance::value<T0>(&arg0),
            combined_b : 0x2::balance::value<T1>(&arg1),
        };
        0x2::event::emit<JointPrincipalJoined>(v0);
        (arg0, arg1)
    }

    public fun partition_principal<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        let v1 = 0x2::balance::value<T1>(&arg1);
        assert!(v0 >= arg2, 4);
        assert!(v1 >= arg3, 5);
        let v2 = 0x2::balance::value<T0>(&arg0);
        let v3 = 0x2::balance::value<T1>(&arg1);
        assert!(v2 >= arg4, 6);
        assert!(v3 >= arg5, 7);
        let v4 = JointPrincipalPartitioned{
            ordinary_a : arg2,
            ordinary_b : arg3,
            kai_a      : v2,
            kai_b      : v3,
            combined_a : v0,
            combined_b : v1,
        };
        0x2::event::emit<JointPrincipalPartitioned>(v4);
        (0x2::balance::split<T0>(&mut arg0, arg2), 0x2::balance::split<T1>(&mut arg1, arg3), arg0, arg1)
    }

    public fun reopen_ordinary_live_two_tick<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert_deadline(arg0, arg11);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v1);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, v1);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v2), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3), arg12);
        let (v5, v6, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v4, arg3, arg4, arg5, arg6);
        let v9 = v8;
        let v10 = v7;
        let v11 = 0x2::balance::value<T0>(&v10);
        let v12 = 0x2::balance::value<T1>(&v9);
        assert!(v5 >= arg7, 8);
        assert!(v6 >= arg8, 9);
        assert!(v11 <= arg9, 10);
        assert!(v12 <= arg10, 11);
        let v13 = OrdinaryBluefinReopened{
            destination_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v4),
            observed_tick_bits      : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0),
            tick_lower_bits         : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v2),
            tick_upper_bits         : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3),
            deposited_a             : v5,
            deposited_b             : v6,
            residual_a              : v11,
            residual_b              : v12,
        };
        0x2::event::emit<OrdinaryBluefinReopened>(v13);
        (v4, v10, v9)
    }

    public fun settle_profit_sui<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 >= arg1, 12);
        let v1 = JointProfitPaid{
            amount    : v0,
            recipient : @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498,
        };
        0x2::event::emit<JointProfitPaid>(v1);
        if (v0 > 0) {
            0x2::balance::send_funds<T0>(arg0, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    fun swap_a_to_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            0x2::balance::zero<T1>()
        } else {
            let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, v0, 4295048017 + 1);
            0x2::balance::join<T0>(&mut arg3, v2);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v4);
            v3
        }
    }

    // decompiled from Move bytecode v7
}

