module 0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_5wzws5j6e3 {
    struct T_uqr3jcsgtn has copy, drop {
        tick_lower: u32,
        tick_upper: u32,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct T_zm6xeq7wj6 has copy, drop {
        reward_amount: u64,
        returned_a: u64,
        returned_b: u64,
    }

    struct T_3rriqnzp7j has copy, drop {
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct T_w7fv7c3nxw has copy, drop {
        reward_amount: u64,
    }

    struct T_vo3t3zbtjw has copy, drop {
        reward_amount: u64,
        fee_a: u64,
        fee_b: u64,
        sui_amount: u64,
    }

    struct T_pzfl3i7qrv has copy, drop {
        reward_a: u64,
        reward_b: u64,
        fee_a: u64,
        fee_b: u64,
        sui_amount: u64,
    }

    struct T_eg2tlee3sy has copy, drop {
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

    struct T_zwmgujrbza has copy, drop {
        initial_a: u64,
        initial_b: u64,
        final_a: u64,
        final_b: u64,
        first_swap_b: u64,
        second_swap_a: u64,
    }

    struct T_xkmrpg23vs has copy, drop {
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

    struct T_fogmqwt76g has copy, drop {
        reward_a: u64,
        reward_b: u64,
        fee_a: u64,
        fee_b: u64,
        profit_sui: u64,
        source_principal_a: u64,
        source_principal_b: u64,
        principal_b_to_a: u64,
        principal_a_to_sui: u64,
        principal_sui_out: u64,
        target_tick_lower: u32,
        target_tick_upper: u32,
        deposited_a: u64,
        deposited_sui: u64,
        residual_a: u64,
        residual_sui: u64,
    }

    struct T_jntxsf4hvv has copy, drop {
        input_sui: u64,
        swapped_sui: u64,
        deep_out: u64,
        deposited_deep: u64,
        deposited_sui: u64,
        residual_deep: u64,
        residual_sui: u64,
    }

    struct T_ydulj46aia has copy, drop {
        input_deep: u64,
        input_blue: u64,
        input_usdc: u64,
        blue_as_deep: u64,
        usdc_as_sui: u64,
        swap_deep_to_sui: bool,
        swap_input: u64,
        swap_output: u64,
        deposited_deep: u64,
        deposited_sui: u64,
        residual_deep: u64,
        residual_sui: u64,
    }

    struct T_m46zryi3pc has copy, drop {
        tick_lower: u32,
        tick_upper: u32,
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        profit_sui: u64,
        closed_deep: u64,
        closed_sui: u64,
        input_deep: u64,
        input_blue: u64,
        input_usdc: u64,
        input_sui: u64,
        blue_as_deep: u64,
        usdc_as_sui: u64,
        swap_deep_to_sui: bool,
        swap_input: u64,
        swap_output: u64,
        deposited_deep: u64,
        deposited_sui: u64,
        residual_deep: u64,
        residual_sui: u64,
    }

    struct T_g444rwocnc has copy, drop {
        reward_blue: u64,
        reward_stsui: u64,
        reward_sui: u64,
        fee_sui: u64,
        fee_usdc: u64,
        profit_sui: u64,
        source_principal_sui: u64,
        source_principal_usdc: u64,
        principal_usdc_to_sui: u64,
        principal_sui_to_deep: u64,
        principal_deep_out: u64,
        deposited_deep: u64,
        deposited_sui: u64,
        residual_deep: u64,
        residual_sui: u64,
    }

    struct T_kbnykld634 has copy, drop {
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

    public entry fun f_34zuvzg226<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T0>, arg6: u32, arg7: u32, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext, arg13: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        f_rbdgluiewm<T0, T1>(arg2, arg6, arg7);
        let v0 = 0x2::coin::value<T0>(&arg3) + 0x2::coin::value<T0>(&arg5);
        let v1 = 0x2::coin::value<T1>(&arg4);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg6, arg7, arg12);
        let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg8, arg9);
        let v7 = 0x2::coin::into_balance<T0>(arg5);
        let (v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, 0x2::balance::value<T0>(&v7), 4295048017 + 1);
        let v11 = v9;
        0x2::balance::join<T0>(&mut v7, v8);
        let v12 = 0x2::balance::value<T1>(&v11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v7, 0x2::balance::zero<T1>(), v10);
        let (v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, v12, 79226673515401279992447579055 - 1);
        let v16 = v13;
        0x2::balance::join<T1>(&mut v11, v14);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v11, v15);
        let (v17, v18) = f_bqybrjllo7<T0, T1>(arg0, arg1, arg2, v2);
        let v19 = v18;
        let v20 = v17;
        0x2::balance::join<T0>(&mut v20, v5);
        0x2::balance::join<T0>(&mut v20, v16);
        0x2::balance::join<T1>(&mut v19, v6);
        let v21 = 0x2::balance::value<T0>(&v20);
        let v22 = 0x2::balance::value<T1>(&v19);
        assert!(v21 >= arg10, 3);
        assert!(v22 >= arg11, 4);
        let v23 = T_zwmgujrbza{
            initial_a     : v0,
            initial_b     : v1,
            final_a       : v21,
            final_b       : v22,
            first_swap_b  : v12,
            second_swap_a : 0x2::balance::value<T0>(&v16),
        };
        0x2::event::emit<T_zwmgujrbza>(v23);
        if (v21 >= v0) {
            let v24 = 0x2::tx_context::sender(arg12);
            f_pa5xcnoftl<T0>(0x2::balance::split<T0>(&mut v20, v0), v24, arg12);
            f_edm3syx2md<T0>(v20, arg13);
        } else {
            let v25 = 0x2::tx_context::sender(arg12);
            f_pa5xcnoftl<T0>(v20, v25, arg12);
        };
        if (v22 >= v1) {
            let v26 = 0x2::tx_context::sender(arg12);
            f_pa5xcnoftl<T1>(0x2::balance::split<T1>(&mut v19, v1), v26, arg12);
            f_edm3syx2md<T1>(v19, arg13);
        } else {
            let v27 = 0x2::tx_context::sender(arg12);
            f_pa5xcnoftl<T1>(v19, v27, arg12);
        };
    }

    fun f_4pimt52xpy<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            0x2::balance::zero<T0>()
        } else {
            let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, v0, 79226673515401279992447579055 - 1);
            0x2::balance::join<T1>(&mut arg3, v3);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v4);
            v2
        }
    }

    public entry fun f_5zqfr5c6vm<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: u32, arg6: bool, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext, arg17: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        assert!(arg5 > 0, 0);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T1>(arg0, arg1, arg2, &mut arg3);
        let v2 = 0x2::balance::value<T0>(&v0);
        assert!(v2 >= arg10, 2);
        let (v3, v4, v5, v6) = f_oi7fe5qhpg<T0, T1>(arg0, arg1, arg2, arg3);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3;
        let v11 = 0x2::balance::value<T0>(&v8);
        let v12 = 0x2::balance::value<T1>(&v7);
        0x2::balance::join<T0>(&mut v0, v8);
        0x2::balance::join<T1>(&mut v1, v7);
        let v13 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, v1);
        0x2::balance::join<T0>(&mut v0, v13);
        let v14 = f_youdoh6zsv<T0, T2>(arg0, arg1, arg4, v0);
        let v15 = 0x2::balance::value<T2>(&v14);
        assert!(v15 >= arg11, 4);
        let v16 = T_vo3t3zbtjw{
            reward_amount : v2,
            fee_a         : v11,
            fee_b         : v12,
            sui_amount    : v15,
        };
        0x2::event::emit<T_vo3t3zbtjw>(v16);
        let v17 = T_pzfl3i7qrv{
            reward_a   : v2,
            reward_b   : 0x2::balance::value<T1>(&v1),
            fee_a      : v11,
            fee_b      : v12,
            sui_amount : v15,
        };
        0x2::event::emit<T_pzfl3i7qrv>(v17);
        0x2::balance::send_funds<T2>(v14, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v18 = 0;
        if (arg7 > 0) {
            if (arg6) {
                assert!(0x2::balance::value<T0>(&v10) >= arg7, 3);
                let v19 = f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v10, arg7));
                v18 = 0x2::balance::value<T1>(&v19);
                0x2::balance::join<T1>(&mut v9, v19);
            } else {
                assert!(0x2::balance::value<T1>(&v9) >= arg7, 4);
                let v20 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut v9, arg7));
                v18 = 0x2::balance::value<T0>(&v20);
                0x2::balance::join<T0>(&mut v10, v20);
            };
        };
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v22 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg5);
        let v23 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v21, v22), v22);
        let v24 = v23;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v21) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v21, v22), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v24 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v23, v22);
        };
        let v25 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v24);
        let v26 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v24, v22));
        let v27 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, v25, v26, arg16);
        let (v28, v29, v30, v31) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v27, v10, v9, arg8, arg9);
        let v32 = v31;
        let v33 = v30;
        let v34 = 0x2::balance::value<T0>(&v33);
        let v35 = 0x2::balance::value<T1>(&v32);
        assert!(v28 >= arg12, 5);
        assert!(v29 >= arg13, 6);
        assert!(v34 >= arg14, 3);
        assert!(v35 >= arg15, 4);
        let v36 = T_kbnykld634{
            tick_lower        : v25,
            tick_upper        : v26,
            reward_amount     : v2,
            reward_compounded : false,
            closed_a          : 0x2::balance::value<T0>(&v10),
            closed_b          : 0x2::balance::value<T1>(&v9),
            swap_a_to_b       : arg6,
            swap_input        : arg7,
            swap_output       : v18,
            deposited_a       : v28,
            deposited_b       : v29,
            residual_a        : v34,
            residual_b        : v35,
        };
        0x2::event::emit<T_kbnykld634>(v36);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v27, 0x2::tx_context::sender(arg16));
        let v37 = 0x2::tx_context::sender(arg16);
        f_pa5xcnoftl<T0>(v33, v37, arg16);
        let v38 = 0x2::tx_context::sender(arg16);
        f_pa5xcnoftl<T1>(v32, v38, arg16);
    }

    public entry fun f_6hzqxhddnb<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u32, arg5: bool, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext, arg15: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        assert!(arg4 > 0, 0);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        let (v2, v3, v4, v5) = f_oi7fe5qhpg<T0, T1>(arg0, arg1, arg2, arg3);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        0x2::balance::join<T0>(&mut v0, v7);
        let v10 = if (0x2::balance::value<T0>(&v0) > 0) {
            f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, v0)
        } else {
            0x2::balance::destroy_zero<T0>(v0);
            0x2::balance::zero<T1>()
        };
        let v11 = 0x2::balance::zero<T1>();
        0x2::balance::join<T1>(&mut v11, v6);
        0x2::balance::join<T1>(&mut v11, v10);
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg9, 4);
        let v13 = T_pzfl3i7qrv{
            reward_a   : v1,
            reward_b   : 0,
            fee_a      : 0x2::balance::value<T0>(&v7),
            fee_b      : 0x2::balance::value<T1>(&v6),
            sui_amount : v12,
        };
        0x2::event::emit<T_pzfl3i7qrv>(v13);
        if (v12 > 0) {
            0x2::balance::send_funds<T1>(v11, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        } else {
            0x2::balance::destroy_zero<T1>(v11);
        };
        let v14 = 0;
        if (arg6 > 0) {
            if (arg5) {
                assert!(0x2::balance::value<T0>(&v9) >= arg6, 3);
                let v15 = f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v9, arg6));
                v14 = 0x2::balance::value<T1>(&v15);
                0x2::balance::join<T1>(&mut v8, v15);
            } else {
                assert!(0x2::balance::value<T1>(&v8) >= arg6, 4);
                let v16 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut v8, arg6));
                v14 = 0x2::balance::value<T0>(&v16);
                0x2::balance::join<T0>(&mut v9, v16);
            };
        };
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v18 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg4);
        let v19 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v17, v18), v18);
        let v20 = v19;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v17) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v17, v18), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v20 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v19, v18);
        };
        let v21 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v20);
        let v22 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v20, v18));
        let v23 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, v21, v22, arg14);
        let (v24, v25, v26, v27) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v23, v9, v8, arg7, arg8);
        let v28 = v27;
        let v29 = v26;
        let v30 = 0x2::balance::value<T0>(&v29);
        let v31 = 0x2::balance::value<T1>(&v28);
        assert!(v24 >= arg10, 5);
        assert!(v25 >= arg11, 6);
        assert!(v30 >= arg12, 3);
        assert!(v31 >= arg13, 4);
        let v32 = T_kbnykld634{
            tick_lower        : v21,
            tick_upper        : v22,
            reward_amount     : v1,
            reward_compounded : false,
            closed_a          : 0x2::balance::value<T0>(&v9),
            closed_b          : 0x2::balance::value<T1>(&v8),
            swap_a_to_b       : arg5,
            swap_input        : arg6,
            swap_output       : v14,
            deposited_a       : v24,
            deposited_b       : v25,
            residual_a        : v30,
            residual_b        : v31,
        };
        0x2::event::emit<T_kbnykld634>(v32);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v23, 0x2::tx_context::sender(arg14));
        let v33 = 0x2::tx_context::sender(arg14);
        f_pa5xcnoftl<T0>(v29, v33, arg14);
        let v34 = 0x2::tx_context::sender(arg14);
        f_pa5xcnoftl<T1>(v28, v34, arg14);
    }

    public entry fun f_7o27pqixup<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T1>(arg0, arg1, arg2, arg3);
        0x2::balance::join<T0>(&mut v0, f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, v1));
        let v2 = 0x2::balance::value<T0>(&v0);
        assert!(v2 >= arg4, 3);
        let v3 = T_pzfl3i7qrv{
            reward_a   : 0x2::balance::value<T0>(&v0),
            reward_b   : 0x2::balance::value<T1>(&v1),
            fee_a      : 0,
            fee_b      : 0,
            sui_amount : v2,
        };
        0x2::event::emit<T_pzfl3i7qrv>(v3);
        0x2::balance::send_funds<T0>(v0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    fun f_bqybrjllo7<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2, v3) = f_oi7fe5qhpg<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::balance::send_funds<T0>(v2, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        0x2::balance::send_funds<T1>(v3, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        (v0, v1)
    }

    public entry fun f_cpnviszrfi<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg6: &mut 0x2::coin::Coin<T4>, arg7: u64, arg8: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T4>(arg0, arg1, arg2, arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T2, T3, T4>(arg0, arg1, arg4, arg5);
        let v2 = 0x2::balance::value<T4>(&v0) + 0x2::balance::value<T4>(&v1);
        assert!(v2 >= arg7, 2);
        0x2::balance::join<T4>(&mut v0, v1);
        let v3 = T_w7fv7c3nxw{reward_amount: v2};
        0x2::event::emit<T_w7fv7c3nxw>(v3);
        0x2::balance::send_funds<T4>(v0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public entry fun f_cx2qtoiwdv<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext, arg7: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        assert!(arg5 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 7);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg4, 2);
        let v2 = T_w7fv7c3nxw{reward_amount: v1};
        0x2::event::emit<T_w7fv7c3nxw>(v2);
        0x2::balance::send_funds<T2>(v0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public fun f_d344vye3t3<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u32, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext, arg9: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
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
        let v13 = T_uqr3jcsgtn{
            tick_lower  : v4,
            tick_upper  : v5,
            deposited_a : v7,
            deposited_b : v8,
            residual_a  : 0x2::balance::value<T0>(&v12),
            residual_b  : 0x2::balance::value<T1>(&v11),
        };
        0x2::event::emit<T_uqr3jcsgtn>(v13);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v6, 0x2::tx_context::sender(arg8));
        (v12, v11)
    }

    public entry fun f_ddw4fj36z6<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, arg3);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(arg3);
        let (v3, v4) = if (v1 > 0 || v2 > 0) {
            let (_, _, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, arg3);
            (v7, v8)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v9 = v4;
        let v10 = v3;
        0x2::balance::join<T0>(&mut v0, v10);
        0x2::balance::join<T1>(&mut v9, f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, v0));
        let v11 = 0x2::balance::value<T1>(&v9);
        assert!(v11 >= arg4, 4);
        let v12 = T_pzfl3i7qrv{
            reward_a   : 0x2::balance::value<T0>(&v0),
            reward_b   : 0,
            fee_a      : 0x2::balance::value<T0>(&v10),
            fee_b      : 0x2::balance::value<T1>(&v9),
            sui_amount : v11,
        };
        0x2::event::emit<T_pzfl3i7qrv>(v12);
        0x2::balance::send_funds<T1>(v9, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public fun f_edm3syx2md<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::balance::send_funds<T0>(arg0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun f_ft7uf3mmad<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext, arg8: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)));
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, v1, v2, arg7);
        let (v4, v5, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v3, arg3, arg4, arg5, arg6);
        let v8 = v7;
        let v9 = v6;
        let v10 = T_uqr3jcsgtn{
            tick_lower  : v1,
            tick_upper  : v2,
            deposited_a : v4,
            deposited_b : v5,
            residual_a  : 0x2::balance::value<T0>(&v9),
            residual_b  : 0x2::balance::value<T1>(&v8),
        };
        0x2::event::emit<T_uqr3jcsgtn>(v10);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v3, 0x2::tx_context::sender(arg7));
        (v9, v8)
    }

    public fun f_gh37cs4gzs<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        f_pa5xcnoftl<T0>(arg0, arg1, arg2);
    }

    public entry fun f_hhmgpp54yw<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T2>, arg7: 0x2::coin::Coin<T3>, arg8: u32, arg9: bool, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext, arg18: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        assert!(arg8 > 0, 0);
        let v0 = 0x2::coin::into_balance<T0>(arg5);
        0x2::balance::join<T0>(&mut v0, f_4pimt52xpy<T0, T2>(arg0, arg1, arg3, 0x2::coin::into_balance<T2>(arg6)));
        let v1 = f_4pimt52xpy<T1, T3>(arg0, arg1, arg4, 0x2::coin::into_balance<T3>(arg7));
        let v2 = 0;
        if (arg10 > 0) {
            if (arg9) {
                let v3 = f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg10));
                v2 = 0x2::balance::value<T1>(&v3);
                0x2::balance::join<T1>(&mut v1, v3);
            } else {
                let v4 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut v1, arg10));
                v2 = 0x2::balance::value<T0>(&v4);
                0x2::balance::join<T0>(&mut v0, v4);
            };
        };
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg8);
        let v7 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v5, v6), v6);
        let v8 = v7;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v5) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v5, v6), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v7, v6);
        };
        let v9 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v8);
        let v10 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v8, v6));
        let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, v9, v10, arg17);
        let (v12, v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v11, v0, v1, arg11, arg12);
        let v16 = v15;
        let v17 = v14;
        let v18 = 0x2::balance::value<T0>(&v17);
        let v19 = 0x2::balance::value<T1>(&v16);
        assert!(v12 >= arg13, 5);
        assert!(v13 >= arg14, 6);
        assert!(v18 >= arg15, 3);
        assert!(v19 >= arg16, 4);
        let v20 = T_kbnykld634{
            tick_lower        : v9,
            tick_upper        : v10,
            reward_amount     : 0,
            reward_compounded : false,
            closed_a          : 0x2::balance::value<T0>(&v0),
            closed_b          : 0x2::balance::value<T1>(&v1),
            swap_a_to_b       : arg9,
            swap_input        : arg10,
            swap_output       : v2,
            deposited_a       : v12,
            deposited_b       : v13,
            residual_a        : v18,
            residual_b        : v19,
        };
        0x2::event::emit<T_kbnykld634>(v20);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v11, 0x2::tx_context::sender(arg17));
        let v21 = 0x2::tx_context::sender(arg17);
        f_pa5xcnoftl<T0>(v17, v21, arg17);
        let v22 = 0x2::tx_context::sender(arg17);
        f_pa5xcnoftl<T1>(v16, v22, arg17);
    }

    public entry fun f_hrxdcyhgix<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext, arg12: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        f_rbdgluiewm<T0, T1>(arg2, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg11);
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v0, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg7, arg8);
        let (v5, v6) = f_bqybrjllo7<T0, T1>(arg0, arg1, arg2, v0);
        let v7 = v6;
        let v8 = v5;
        0x2::balance::join<T0>(&mut v8, v3);
        0x2::balance::join<T1>(&mut v7, v4);
        assert!(0x2::balance::value<T0>(&v8) >= arg9, 3);
        assert!(0x2::balance::value<T1>(&v7) >= arg10, 4);
        let v9 = 0x2::tx_context::sender(arg11);
        f_pa5xcnoftl<T0>(v8, v9, arg11);
        let v10 = 0x2::tx_context::sender(arg11);
        f_pa5xcnoftl<T1>(v7, v10, arg11);
    }

    public fun f_ht7dyocnuq<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext, arg10: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        f_rbdgluiewm<T0, T1>(arg2, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg9);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v0, arg3, arg4, arg7, arg8);
        let v5 = v4;
        let v6 = v3;
        let v7 = T_uqr3jcsgtn{
            tick_lower  : arg5,
            tick_upper  : arg6,
            deposited_a : v1,
            deposited_b : v2,
            residual_a  : 0x2::balance::value<T0>(&v6),
            residual_b  : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<T_uqr3jcsgtn>(v7);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::tx_context::sender(arg9));
        (v6, v5)
    }

    public entry fun f_hytltiad6g<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: u32, arg6: bool, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext, arg16: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        assert!(arg5 > 0, 0);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3);
        let v2 = 0x2::balance::value<T0>(&v0);
        let (v3, v4, v5, v6) = f_oi7fe5qhpg<T0, T1>(arg0, arg1, arg2, arg3);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3;
        0x2::balance::join<T0>(&mut v0, v8);
        0x2::balance::join<T0>(&mut v0, f_4pimt52xpy<T0, T2>(arg0, arg1, arg4, v1));
        let v11 = f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, v0);
        0x2::balance::join<T1>(&mut v7, v11);
        let v12 = 0x2::balance::value<T1>(&v7);
        assert!(v12 >= arg10, 4);
        let v13 = T_pzfl3i7qrv{
            reward_a   : v2,
            reward_b   : 0x2::balance::value<T2>(&v1),
            fee_a      : 0x2::balance::value<T0>(&v8),
            fee_b      : 0x2::balance::value<T1>(&v7),
            sui_amount : v12,
        };
        0x2::event::emit<T_pzfl3i7qrv>(v13);
        0x2::balance::send_funds<T1>(v7, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v14 = 0;
        if (arg7 > 0) {
            if (arg6) {
                assert!(0x2::balance::value<T0>(&v10) >= arg7, 3);
                let v15 = f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v10, arg7));
                v14 = 0x2::balance::value<T1>(&v15);
                0x2::balance::join<T1>(&mut v9, v15);
            } else {
                assert!(0x2::balance::value<T1>(&v9) >= arg7, 4);
                let v16 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut v9, arg7));
                v14 = 0x2::balance::value<T0>(&v16);
                0x2::balance::join<T0>(&mut v10, v16);
            };
        };
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v18 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg5);
        let v19 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v17, v18), v18);
        let v20 = v19;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v17) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v17, v18), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v20 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v19, v18);
        };
        let v21 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v20);
        let v22 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v20, v18));
        let v23 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, v21, v22, arg15);
        let (v24, v25, v26, v27) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v23, v10, v9, arg8, arg9);
        let v28 = v27;
        let v29 = v26;
        let v30 = 0x2::balance::value<T0>(&v29);
        let v31 = 0x2::balance::value<T1>(&v28);
        assert!(v24 >= arg11, 5);
        assert!(v25 >= arg12, 6);
        assert!(v30 >= arg13, 3);
        assert!(v31 >= arg14, 4);
        let v32 = T_kbnykld634{
            tick_lower        : v21,
            tick_upper        : v22,
            reward_amount     : v2,
            reward_compounded : false,
            closed_a          : 0x2::balance::value<T0>(&v10),
            closed_b          : 0x2::balance::value<T1>(&v9),
            swap_a_to_b       : arg6,
            swap_input        : arg7,
            swap_output       : v14,
            deposited_a       : v24,
            deposited_b       : v25,
            residual_a        : v30,
            residual_b        : v31,
        };
        0x2::event::emit<T_kbnykld634>(v32);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v23, 0x2::tx_context::sender(arg15));
        let v33 = 0x2::tx_context::sender(arg15);
        f_pa5xcnoftl<T0>(v29, v33, arg15);
        let v34 = 0x2::tx_context::sender(arg15);
        f_pa5xcnoftl<T1>(v28, v34, arg15);
    }

    public fun f_ilkf56nbr3<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: bool, arg8: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v4 = v3;
        let v5 = v2;
        let v6 = T_3rriqnzp7j{
            deposited_a : v0,
            deposited_b : v1,
            residual_a  : 0x2::balance::value<T0>(&v5),
            residual_b  : 0x2::balance::value<T1>(&v4),
        };
        0x2::event::emit<T_3rriqnzp7j>(v6);
        (v5, v4)
    }

    public entry fun f_jtg5xpjsas<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: u32, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext, arg15: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        assert!(arg5 > 0, 0);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T1>(arg0, arg1, arg2, &mut arg3);
        let (v2, v3, v4, v5) = f_oi7fe5qhpg<T0, T1>(arg0, arg1, arg2, arg3);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        0x2::balance::join<T1>(&mut v1, v6);
        let v10 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, v1);
        0x2::balance::join<T0>(&mut v0, v7);
        0x2::balance::join<T0>(&mut v0, v10);
        let v11 = f_youdoh6zsv<T0, T2>(arg0, arg1, arg4, v0);
        let v12 = 0x2::balance::value<T2>(&v11);
        assert!(v12 >= arg9, 4);
        0x2::balance::send_funds<T2>(v11, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v13 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, v8);
        0x2::balance::join<T0>(&mut v9, v13);
        assert!(0x2::balance::value<T0>(&v9) >= arg6, 3);
        let v14 = f_youdoh6zsv<T0, T2>(arg0, arg1, arg4, 0x2::balance::split<T0>(&mut v9, arg6));
        let v15 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T2>(arg4);
        let v16 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg5);
        let v17 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v15, v16), v16);
        let v18 = v17;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v15) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v15, v16), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v18 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v17, v16);
        };
        let v19 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v18);
        let v20 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v18, v16));
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T2>(arg1, arg4, v19, v20, arg14);
        let (v22, v23, v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T2>(arg0, arg1, arg4, &mut v21, v9, v14, arg7, arg8);
        let v26 = v25;
        let v27 = v24;
        let v28 = 0x2::balance::value<T0>(&v27);
        let v29 = 0x2::balance::value<T2>(&v26);
        assert!(v22 >= arg10, 5);
        assert!(v23 >= arg11, 6);
        assert!(v28 >= arg12, 3);
        assert!(v29 >= arg13, 4);
        let v30 = T_fogmqwt76g{
            reward_a           : 0x2::balance::value<T0>(&v0),
            reward_b           : 0x2::balance::value<T1>(&v1),
            fee_a              : 0x2::balance::value<T0>(&v7),
            fee_b              : 0x2::balance::value<T1>(&v6),
            profit_sui         : v12,
            source_principal_a : 0x2::balance::value<T0>(&v9),
            source_principal_b : 0x2::balance::value<T1>(&v8),
            principal_b_to_a   : 0x2::balance::value<T0>(&v13),
            principal_a_to_sui : arg6,
            principal_sui_out  : 0x2::balance::value<T2>(&v14),
            target_tick_lower  : v19,
            target_tick_upper  : v20,
            deposited_a        : v22,
            deposited_sui      : v23,
            residual_a         : v28,
            residual_sui       : v29,
        };
        0x2::event::emit<T_fogmqwt76g>(v30);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v21, 0x2::tx_context::sender(arg14));
        let v31 = 0x2::tx_context::sender(arg14);
        f_pa5xcnoftl<T0>(v27, v31, arg14);
        let v32 = 0x2::tx_context::sender(arg14);
        f_pa5xcnoftl<T2>(v26, v32, arg14);
    }

    public entry fun f_l6nn6nwmb6<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: u64, arg6: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T1>(arg0, arg1, arg2, arg3);
        let v2 = 0x2::balance::value<T0>(&v0);
        0x2::balance::join<T0>(&mut v0, f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, v1));
        let v3 = f_youdoh6zsv<T0, T2>(arg0, arg1, arg4, v0);
        let v4 = 0x2::balance::value<T2>(&v3);
        assert!(v4 >= arg5, 4);
        let v5 = T_w7fv7c3nxw{reward_amount: v2};
        0x2::event::emit<T_w7fv7c3nxw>(v5);
        let v6 = T_pzfl3i7qrv{
            reward_a   : v2,
            reward_b   : 0x2::balance::value<T1>(&v1),
            fee_a      : 0,
            fee_b      : 0,
            sui_amount : v4,
        };
        0x2::event::emit<T_pzfl3i7qrv>(v6);
        0x2::balance::send_funds<T2>(v3, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public entry fun f_ldtpyiwhrw<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u32, arg7: u32, arg8: u64, arg9: bool, arg10: u64, arg11: address, arg12: &mut 0x2::tx_context::TxContext, arg13: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        assert!(arg11 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 7);
        f_rbdgluiewm<T0, T1>(arg2, arg6, arg7);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg10, 2);
        let (v2, v3) = f_bqybrjllo7<T0, T1>(arg0, arg1, arg2, arg3);
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
        let v15 = T_xkmrpg23vs{
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
        0x2::event::emit<T_xkmrpg23vs>(v15);
        let v16 = 0x2::tx_context::sender(arg12);
        f_pa5xcnoftl<T0>(v14, v16, arg12);
        let v17 = 0x2::tx_context::sender(arg12);
        f_pa5xcnoftl<T1>(v13, v17, arg12);
        f_pa5xcnoftl<T2>(v0, arg11, arg12);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v8, 0x2::tx_context::sender(arg12));
    }

    public entry fun f_mlkcop6myh<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::coin::Coin<T2>, arg5: u64, arg6: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg5, 2);
        let v2 = T_w7fv7c3nxw{reward_amount: v1};
        0x2::event::emit<T_w7fv7c3nxw>(v2);
        0x2::balance::send_funds<T2>(v0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public entry fun f_nfbc3bvlsp<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext, arg13: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x2::coin::into_balance<T1>(arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 >= arg5, 4);
        let v2 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut v0, arg5));
        let v3 = 0x2::balance::value<T0>(&v2);
        let (v4, v5) = f_ilkf56nbr3<T0, T1>(arg0, arg1, arg2, arg3, v2, v0, arg6, arg7, arg13);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::balance::value<T0>(&v7);
        let v9 = 0x2::balance::value<T1>(&v6);
        let v10 = v3 - v8;
        let v11 = v1 - arg5 - v9;
        assert!(v10 >= arg8, 5);
        assert!(v11 >= arg9, 6);
        assert!(v8 >= arg10, 3);
        assert!(v9 >= arg11, 4);
        let v12 = T_jntxsf4hvv{
            input_sui      : v1,
            swapped_sui    : arg5,
            deep_out       : v3,
            deposited_deep : v10,
            deposited_sui  : v11,
            residual_deep  : v8,
            residual_sui   : v9,
        };
        0x2::event::emit<T_jntxsf4hvv>(v12);
        let v13 = 0x2::tx_context::sender(arg12);
        f_pa5xcnoftl<T0>(v7, v13, arg12);
        let v14 = 0x2::tx_context::sender(arg12);
        f_pa5xcnoftl<T1>(v6, v14, arg12);
    }

    public entry fun f_ogvisaujzr<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext, arg12: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 >= arg6, 2);
        let (v2, v3) = f_bqybrjllo7<T0, T1>(arg0, arg1, arg2, arg3);
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
        let v23 = T_eg2tlee3sy{
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
        0x2::event::emit<T_eg2tlee3sy>(v23);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v14, 0x2::tx_context::sender(arg11));
        let v24 = 0x2::tx_context::sender(arg11);
        f_pa5xcnoftl<T0>(v20, v24, arg11);
        let v25 = 0x2::tx_context::sender(arg11);
        f_pa5xcnoftl<T1>(v19, v25, arg11);
    }

    fun f_oi7fe5qhpg<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3), arg0);
        let (v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg3);
        let (v6, v7) = if (v4 > 0 || v5 > 0) {
            let (_, _, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, &mut arg3);
            (v10, v11)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg0, arg1, arg2, arg3);
        (v2, v3, v6, v7)
    }

    fun f_pa5xcnoftl<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public entry fun f_phkjybnf56<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u32, arg5: bool, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: address, arg16: &mut 0x2::tx_context::TxContext, arg17: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        assert!(arg15 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 7);
        assert!(!arg9, 7);
        assert!(arg4 > 0, 0);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 >= arg10, 2);
        let (v2, v3) = f_bqybrjllo7<T0, T1>(arg0, arg1, arg2, arg3);
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
        let v33 = T_kbnykld634{
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
        0x2::event::emit<T_kbnykld634>(v33);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v24, 0x2::tx_context::sender(arg16));
        let v34 = 0x2::tx_context::sender(arg16);
        f_pa5xcnoftl<T0>(v30, v34, arg16);
        let v35 = 0x2::tx_context::sender(arg16);
        f_pa5xcnoftl<T1>(v29, v35, arg16);
        f_pa5xcnoftl<T0>(v6, arg15, arg16);
    }

    public entry fun f_qb7qxsqdkc<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: u64, arg6: u64, arg7: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 >= arg5, 2);
        let v2 = f_youdoh6zsv<T0, T2>(arg0, arg1, arg4, v0);
        let v3 = 0x2::balance::value<T2>(&v2);
        assert!(v3 >= arg6, 4);
        let v4 = T_w7fv7c3nxw{reward_amount: v1};
        0x2::event::emit<T_w7fv7c3nxw>(v4);
        let v5 = T_vo3t3zbtjw{
            reward_amount : v1,
            fee_a         : 0,
            fee_b         : 0,
            sui_amount    : v3,
        };
        0x2::event::emit<T_vo3t3zbtjw>(v5);
        0x2::balance::send_funds<T2>(v2, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    fun f_rbdgluiewm<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32, arg2: u32) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)), v1), 0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v2, v0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v2, v1), 1);
    }

    public entry fun f_rj7oxzgldp<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext, arg9: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        assert!(arg7 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 7);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg4, 2);
        let (v2, v3) = f_bqybrjllo7<T0, T1>(arg0, arg1, arg2, arg3);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        assert!(v6 >= arg5, 3);
        assert!(v7 >= arg6, 4);
        let v8 = T_zm6xeq7wj6{
            reward_amount : v1,
            returned_a    : v6,
            returned_b    : v7,
        };
        0x2::event::emit<T_zm6xeq7wj6>(v8);
        let v9 = 0x2::tx_context::sender(arg8);
        f_pa5xcnoftl<T0>(v5, v9, arg8);
        let v10 = 0x2::tx_context::sender(arg8);
        f_pa5xcnoftl<T1>(v4, v10, arg8);
        f_pa5xcnoftl<T2>(v0, arg7, arg8);
    }

    public entry fun f_rjap4yhagc<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: 0x2::coin::Coin<T1>, arg10: u32, arg11: bool, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: &mut 0x2::tx_context::TxContext, arg21: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        assert!(arg10 > 0, 0);
        let v0 = 0x2::coin::value<T2>(&arg7);
        let v1 = 0x2::coin::value<T3>(&arg8);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, &mut arg3);
        let v3 = 0x2::balance::value<T0>(&v2);
        let (v4, v5, v6, v7) = f_oi7fe5qhpg<T0, T1>(arg0, arg1, arg2, arg3);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T0>(&v9);
        let v13 = 0x2::balance::value<T1>(&v8);
        0x2::balance::join<T0>(&mut v2, v9);
        let v14 = if (0x2::balance::value<T0>(&v2) > 0) {
            f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, v2)
        } else {
            0x2::balance::destroy_zero<T0>(v2);
            0x2::balance::zero<T1>()
        };
        0x2::balance::join<T1>(&mut v8, v14);
        let v15 = 0x2::balance::value<T1>(&v8);
        assert!(v15 >= arg15, 4);
        let v16 = T_pzfl3i7qrv{
            reward_a   : v3,
            reward_b   : 0,
            fee_a      : v12,
            fee_b      : v13,
            sui_amount : v15,
        };
        0x2::event::emit<T_pzfl3i7qrv>(v16);
        if (v15 > 0) {
            0x2::balance::send_funds<T1>(v8, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        } else {
            0x2::balance::destroy_zero<T1>(v8);
        };
        0x2::balance::join<T0>(&mut v11, 0x2::coin::into_balance<T0>(arg6));
        0x2::balance::join<T1>(&mut v10, 0x2::coin::into_balance<T1>(arg9));
        let v17 = if (v0 > 0) {
            f_4pimt52xpy<T0, T2>(arg0, arg1, arg4, 0x2::coin::into_balance<T2>(arg7))
        } else {
            0x2::coin::destroy_zero<T2>(arg7);
            0x2::balance::zero<T0>()
        };
        let v18 = v17;
        0x2::balance::join<T0>(&mut v11, v18);
        let v19 = if (v1 > 0) {
            f_4pimt52xpy<T1, T3>(arg0, arg1, arg5, 0x2::coin::into_balance<T3>(arg8))
        } else {
            0x2::coin::destroy_zero<T3>(arg8);
            0x2::balance::zero<T1>()
        };
        let v20 = v19;
        0x2::balance::join<T1>(&mut v10, v20);
        let v21 = 0;
        if (arg12 > 0) {
            if (arg11) {
                let v22 = f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v11, arg12));
                v21 = 0x2::balance::value<T1>(&v22);
                0x2::balance::join<T1>(&mut v10, v22);
            } else {
                let v23 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut v10, arg12));
                v21 = 0x2::balance::value<T0>(&v23);
                0x2::balance::join<T0>(&mut v11, v23);
            };
        };
        let v24 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2);
        let v25 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg10);
        let (v26, v27) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v25, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(2))) {
            (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v24, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v24, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1)))
        } else {
            let v28 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v24, v25), v25);
            let v29 = v28;
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(v24) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v24, v25), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
                v29 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v28, v25);
            };
            (v29, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v29, v25))
        };
        let v30 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v26);
        let v31 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v27);
        let v32 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, v30, v31, arg20);
        let (v33, v34, v35, v36) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v32, v11, v10, arg13, arg14);
        let v37 = v36;
        let v38 = v35;
        let v39 = 0x2::balance::value<T0>(&v38);
        let v40 = 0x2::balance::value<T1>(&v37);
        assert!(v33 >= arg16, 5);
        assert!(v34 >= arg17, 6);
        assert!(v39 >= arg18, 3);
        assert!(v40 >= arg19, 4);
        let v41 = T_m46zryi3pc{
            tick_lower       : v30,
            tick_upper       : v31,
            reward_deep      : v3,
            fee_deep         : v12,
            fee_sui          : v13,
            profit_sui       : v15,
            closed_deep      : 0x2::balance::value<T0>(&v11),
            closed_sui       : 0x2::balance::value<T1>(&v10),
            input_deep       : 0x2::coin::value<T0>(&arg6),
            input_blue       : v0,
            input_usdc       : v1,
            input_sui        : 0x2::coin::value<T1>(&arg9),
            blue_as_deep     : 0x2::balance::value<T0>(&v18),
            usdc_as_sui      : 0x2::balance::value<T1>(&v20),
            swap_deep_to_sui : arg11,
            swap_input       : arg12,
            swap_output      : v21,
            deposited_deep   : v33,
            deposited_sui    : v34,
            residual_deep    : v39,
            residual_sui     : v40,
        };
        0x2::event::emit<T_m46zryi3pc>(v41);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v32, 0x2::tx_context::sender(arg20));
        let v42 = 0x2::tx_context::sender(arg20);
        f_pa5xcnoftl<T0>(v38, v42, arg20);
        let v43 = 0x2::tx_context::sender(arg20);
        f_pa5xcnoftl<T1>(v37, v43, arg20);
    }

    public entry fun f_slnzlx6kud<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, arg3);
        let v1 = f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, v0);
        0x2::balance::join<T1>(&mut v1, 0x2::balance::zero<T1>());
        let v2 = 0x2::balance::value<T1>(&v1);
        assert!(v2 >= arg4, 4);
        let v3 = T_pzfl3i7qrv{
            reward_a   : 0x2::balance::value<T0>(&v0),
            reward_b   : 0,
            fee_a      : 0,
            fee_b      : 0,
            sui_amount : v2,
        };
        0x2::event::emit<T_pzfl3i7qrv>(v3);
        0x2::balance::send_funds<T1>(v1, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public entry fun f_szqqooqed6<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext, arg10: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        f_rbdgluiewm<T0, T1>(arg2, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg9);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v0, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg7, arg8);
        let v5 = v4;
        let v6 = v3;
        let v7 = T_uqr3jcsgtn{
            tick_lower  : arg5,
            tick_upper  : arg6,
            deposited_a : v1,
            deposited_b : v2,
            residual_a  : 0x2::balance::value<T0>(&v6),
            residual_b  : 0x2::balance::value<T1>(&v5),
        };
        0x2::event::emit<T_uqr3jcsgtn>(v7);
        let v8 = 0x2::tx_context::sender(arg9);
        f_pa5xcnoftl<T0>(v6, v8, arg9);
        let v9 = 0x2::tx_context::sender(arg9);
        f_pa5xcnoftl<T1>(v5, v9, arg9);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::tx_context::sender(arg9));
    }

    public entry fun f_tw5grmqcrg<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T0>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T4, T2>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T0>, arg8: u64, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext, arg17: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T3>(arg0, arg1, arg2, &mut arg3);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, &mut arg3);
        let (v3, v4, v5, v6) = f_oi7fe5qhpg<T0, T1>(arg0, arg1, arg2, arg3);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3;
        let v11 = 0x2::balance::value<T0>(&v10);
        let v12 = f_youdoh6zsv<T4, T0>(arg0, arg1, arg4, f_4pimt52xpy<T4, T2>(arg0, arg1, arg6, v0));
        let v13 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, v7);
        0x2::balance::join<T0>(&mut v2, v8);
        0x2::balance::join<T0>(&mut v2, v12);
        0x2::balance::join<T0>(&mut v2, f_youdoh6zsv<T3, T0>(arg0, arg1, arg7, v1));
        0x2::balance::join<T0>(&mut v2, v13);
        let v14 = 0x2::balance::value<T0>(&v2);
        assert!(v14 >= arg11, 4);
        0x2::balance::send_funds<T0>(v2, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v15 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, v9);
        let v16 = 0x2::balance::value<T0>(&v15);
        0x2::balance::join<T0>(&mut v10, v15);
        if (arg8 == 18446744073709551615) {
            let v17 = T_g444rwocnc{
                reward_blue           : 0x2::balance::value<T2>(&v0),
                reward_stsui          : 0x2::balance::value<T3>(&v1),
                reward_sui            : 0x2::balance::value<T0>(&v2),
                fee_sui               : 0x2::balance::value<T0>(&v8),
                fee_usdc              : 0x2::balance::value<T1>(&v7),
                profit_sui            : v14,
                source_principal_sui  : v11,
                source_principal_usdc : 0x2::balance::value<T1>(&v9),
                principal_usdc_to_sui : v16,
                principal_sui_to_deep : 0,
                principal_deep_out    : 0,
                deposited_deep        : 0,
                deposited_sui         : 0,
                residual_deep         : 0,
                residual_sui          : 0x2::balance::value<T0>(&v10),
            };
            0x2::event::emit<T_g444rwocnc>(v17);
            let v18 = 0x2::tx_context::sender(arg16);
            f_pa5xcnoftl<T0>(v10, v18, arg16);
            return
        };
        assert!(0x2::balance::value<T0>(&v10) >= arg8, 4);
        let v19 = f_4pimt52xpy<T4, T0>(arg0, arg1, arg4, 0x2::balance::split<T0>(&mut v10, arg8));
        let v20 = 0x2::balance::value<T4>(&v19);
        let (v21, v22) = f_ilkf56nbr3<T4, T0>(arg0, arg1, arg4, arg5, v19, v10, arg9, arg10, arg17);
        let v23 = v22;
        let v24 = v21;
        let v25 = 0x2::balance::value<T4>(&v24);
        let v26 = 0x2::balance::value<T0>(&v23);
        let v27 = v20 - v25;
        let v28 = v11 + v16 - arg8 - v26;
        assert!(v27 >= arg12, 5);
        assert!(v28 >= arg13, 6);
        assert!(v25 >= arg14, 3);
        assert!(v26 >= arg15, 4);
        let v29 = T_g444rwocnc{
            reward_blue           : 0x2::balance::value<T2>(&v0),
            reward_stsui          : 0x2::balance::value<T3>(&v1),
            reward_sui            : 0x2::balance::value<T0>(&v2),
            fee_sui               : 0x2::balance::value<T0>(&v8),
            fee_usdc              : 0x2::balance::value<T1>(&v7),
            profit_sui            : v14,
            source_principal_sui  : v11,
            source_principal_usdc : 0x2::balance::value<T1>(&v9),
            principal_usdc_to_sui : v16,
            principal_sui_to_deep : arg8,
            principal_deep_out    : v20,
            deposited_deep        : v27,
            deposited_sui         : v28,
            residual_deep         : v25,
            residual_sui          : v26,
        };
        0x2::event::emit<T_g444rwocnc>(v29);
        let v30 = 0x2::tx_context::sender(arg16);
        f_pa5xcnoftl<T4>(v24, v30, arg16);
        let v31 = 0x2::tx_context::sender(arg16);
        f_pa5xcnoftl<T0>(v23, v31, arg16);
    }

    public entry fun f_tyvsmvpae2<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext, arg12: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        assert!(arg10 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 7);
        f_rbdgluiewm<T0, T1>(arg2, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg11);
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, &mut v0, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg7, arg8);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut v0);
        let v6 = 0x2::balance::value<T2>(&v5);
        assert!(v6 >= arg9, 2);
        let (v7, v8) = f_bqybrjllo7<T0, T1>(arg0, arg1, arg2, v0);
        let v9 = v8;
        let v10 = v7;
        0x2::balance::join<T0>(&mut v10, v3);
        0x2::balance::join<T1>(&mut v9, v4);
        let v11 = T_zm6xeq7wj6{
            reward_amount : v6,
            returned_a    : 0x2::balance::value<T0>(&v10),
            returned_b    : 0x2::balance::value<T1>(&v9),
        };
        0x2::event::emit<T_zm6xeq7wj6>(v11);
        let v12 = 0x2::tx_context::sender(arg11);
        f_pa5xcnoftl<T0>(v10, v12, arg11);
        let v13 = 0x2::tx_context::sender(arg11);
        f_pa5xcnoftl<T1>(v9, v13, arg11);
        f_pa5xcnoftl<T2>(v5, arg10, arg11);
    }

    public entry fun f_ug4jrarj5n<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: bool, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext, arg19: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, arg3);
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(arg3);
        let (v3, v4) = if (v1 > 0 || v2 > 0) {
            let (_, _, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, arg3);
            (v7, v8)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v9 = v4;
        let v10 = v3;
        0x2::balance::join<T0>(&mut v0, v10);
        let v11 = if (0x2::balance::value<T0>(&v0) > 0) {
            f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, v0)
        } else {
            0x2::balance::destroy_zero<T0>(v0);
            0x2::balance::zero<T1>()
        };
        0x2::balance::join<T1>(&mut v9, v11);
        let v12 = 0x2::balance::value<T1>(&v9);
        assert!(v12 >= arg13, 4);
        let v13 = T_pzfl3i7qrv{
            reward_a   : 0x2::balance::value<T0>(&v0),
            reward_b   : 0,
            fee_a      : 0x2::balance::value<T0>(&v10),
            fee_b      : 0x2::balance::value<T1>(&v9),
            sui_amount : v12,
        };
        0x2::event::emit<T_pzfl3i7qrv>(v13);
        if (v12 > 0) {
            0x2::balance::send_funds<T1>(v9, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        } else {
            0x2::balance::destroy_zero<T1>(v9);
        };
        f_x6hq7bfzo5<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14, arg15, arg16, arg17, arg18, arg19);
    }

    public fun f_ux4tlpmfwa<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: u64, arg6: u64, arg7: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, &mut arg3);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 >= arg4, 2);
        let (v2, v3) = f_bqybrjllo7<T0, T1>(arg0, arg1, arg2, arg3);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        assert!(v6 >= arg5, 3);
        assert!(v7 >= arg6, 4);
        let v8 = T_zm6xeq7wj6{
            reward_amount : v1,
            returned_a    : v6,
            returned_b    : v7,
        };
        0x2::event::emit<T_zm6xeq7wj6>(v8);
        (v5, v4, v0)
    }

    public entry fun f_x6hq7bfzo5<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T3>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T2>, arg8: 0x2::coin::Coin<T3>, arg9: bool, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext, arg18: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x2::coin::value<T2>(&arg7);
        let v1 = 0x2::coin::value<T3>(&arg8);
        let v2 = 0x2::coin::into_balance<T0>(arg6);
        let v3 = if (v0 > 0) {
            f_4pimt52xpy<T0, T2>(arg0, arg1, arg4, 0x2::coin::into_balance<T2>(arg7))
        } else {
            0x2::coin::destroy_zero<T2>(arg7);
            0x2::balance::zero<T0>()
        };
        let v4 = v3;
        0x2::balance::join<T0>(&mut v2, v4);
        let v5 = if (v1 > 0) {
            f_4pimt52xpy<T1, T3>(arg0, arg1, arg5, 0x2::coin::into_balance<T3>(arg8))
        } else {
            0x2::coin::destroy_zero<T3>(arg8);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let v7 = 0;
        if (arg10 > 0) {
            if (arg9) {
                let v8 = f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v2, arg10));
                v7 = 0x2::balance::value<T1>(&v8);
                0x2::balance::join<T1>(&mut v6, v8);
            } else {
                let v9 = f_4pimt52xpy<T0, T1>(arg0, arg1, arg2, 0x2::balance::split<T1>(&mut v6, arg10));
                v7 = 0x2::balance::value<T0>(&v9);
                0x2::balance::join<T0>(&mut v2, v9);
            };
        };
        let (v10, v11) = f_ilkf56nbr3<T0, T1>(arg0, arg1, arg2, arg3, v2, v6, arg11, arg12, arg18);
        let v12 = v11;
        let v13 = v10;
        let v14 = 0x2::balance::value<T0>(&v13);
        let v15 = 0x2::balance::value<T1>(&v12);
        let v16 = 0x2::balance::value<T0>(&v2) - v14;
        let v17 = 0x2::balance::value<T1>(&v6) - v15;
        assert!(v16 >= arg13, 5);
        assert!(v17 >= arg14, 6);
        assert!(v14 >= arg15, 3);
        assert!(v15 >= arg16, 4);
        let v18 = T_ydulj46aia{
            input_deep       : 0x2::coin::value<T0>(&arg6),
            input_blue       : v0,
            input_usdc       : v1,
            blue_as_deep     : 0x2::balance::value<T0>(&v4),
            usdc_as_sui      : 0x2::balance::value<T1>(&v6),
            swap_deep_to_sui : arg9,
            swap_input       : arg10,
            swap_output      : v7,
            deposited_deep   : v16,
            deposited_sui    : v17,
            residual_deep    : v14,
            residual_sui     : v15,
        };
        0x2::event::emit<T_ydulj46aia>(v18);
        let v19 = 0x2::tx_context::sender(arg17);
        f_pa5xcnoftl<T0>(v13, v19, arg17);
        let v20 = 0x2::tx_context::sender(arg17);
        f_pa5xcnoftl<T1>(v12, v20, arg17);
    }

    fun f_youdoh6zsv<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
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

    public entry fun f_zv2cppgzjx<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg5: u64, arg6: &0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe::T_arzmsfzign) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg1, arg2, arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0x2::balance::join<T0>(&mut v0, f_4pimt52xpy<T0, T2>(arg0, arg1, arg4, v1));
        let v2 = f_youdoh6zsv<T0, T1>(arg0, arg1, arg2, v0);
        let v3 = 0x2::balance::value<T1>(&v2);
        assert!(v3 >= arg5, 4);
        let v4 = T_pzfl3i7qrv{
            reward_a   : 0x2::balance::value<T0>(&v0),
            reward_b   : 0x2::balance::value<T2>(&v1),
            fee_a      : 0,
            fee_b      : 0,
            sui_amount : v3,
        };
        0x2::event::emit<T_pzfl3i7qrv>(v4);
        0x2::balance::send_funds<T1>(v2, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    // decompiled from Move bytecode v7
}

