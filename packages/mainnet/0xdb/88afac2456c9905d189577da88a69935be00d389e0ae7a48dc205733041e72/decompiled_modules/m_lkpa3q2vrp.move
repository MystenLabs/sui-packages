module 0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_lkpa3q2vrp {
    struct T_vqfvxllmd2 has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
    }

    struct T_4uhklxj7e6 has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct T_2slmclq3go<phantom T0> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct T_dggl2dkk4w<phantom T0> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        route_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
    }

    struct T_6tezlhecvo has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        must_pin_registry_id: bool,
    }

    struct T_e7wdfpwkn3 has copy, drop {
        registry_id: 0x2::object::ID,
        route_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct T_7apn7fwxel has copy, drop {
        registry_id: 0x2::object::ID,
        route_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        source_witness_id: 0x2::object::ID,
        replacement_position_id: 0x2::object::ID,
        deadline_ms: u64,
        swap_a_to_b: bool,
        requested_swap_amount: u64,
        sqrt_price_limit: u128,
        repayment_amount: u64,
        swap_output: u64,
        start_tick: u32,
        terminal_tick: u32,
        terminal_tick_lower: u32,
        terminal_tick_upper: u32,
        replacement_liquidity: u128,
        reward_a: u64,
        fee_a: u64,
        fee_b: u64,
        source_principal_a: u64,
        source_principal_b: u64,
        post_repay_principal_a: u64,
        post_repay_principal_b: u64,
        target_tick_lower: u32,
        target_tick_upper: u32,
        fixed_amount: u64,
        fix_amount_a: bool,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct T_bim37xgyqv has copy, drop {
        registry_id: 0x2::object::ID,
        route_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        legacy_position_id: 0x2::object::ID,
        replacement_position_id: 0x2::object::ID,
        replacement_witness_id: 0x2::object::ID,
        deadline_ms: u64,
        swap_a_to_b: bool,
        requested_swap_input: u64,
        actual_swap_input: u64,
        sqrt_price_limit: u128,
        swap_output: u64,
        start_tick: u32,
        terminal_tick: u32,
        terminal_tick_lower: u32,
        terminal_tick_upper: u32,
        reward_a: u64,
        fee_a: u64,
        fee_b: u64,
        source_principal_a: u64,
        source_principal_b: u64,
        post_swap_principal_a: u64,
        post_swap_principal_b: u64,
        target_tick_lower: u32,
        target_tick_upper: u32,
        replacement_liquidity: u128,
        fixed_amount: u64,
        fix_amount_a: bool,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    fun f_3ttr7hbqan<T0>(arg0: &T_vqfvxllmd2, arg1: &T_2slmclq3go<T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u32, arg5: u32, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) : T_dggl2dkk4w<T0> {
        T_dggl2dkk4w<T0>{
            id           : 0x2::object::new(arg7),
            registry_id  : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id : 0x2::object::id<T_2slmclq3go<T0>>(arg1),
            pool_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg2),
            position_id  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3),
            tick_lower   : arg4,
            tick_upper   : arg5,
            liquidity    : arg6,
        }
    }

    public fun f_5patblb2tv<T0>(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID, arg2: &T_4uhklxj7e6, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext, arg5: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        f_ohgzgmpstk(arg0, arg1);
        f_b5rccek2lh(arg0, arg2);
        let v0 = T_2slmclq3go<T0>{
            id          : 0x2::object::new(arg4),
            registry_id : 0x2::object::id<T_vqfvxllmd2>(arg0),
            pool_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg3),
        };
        let v1 = T_e7wdfpwkn3{
            registry_id  : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id : 0x2::object::id<T_2slmclq3go<T0>>(&v0),
            pool_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg3),
        };
        0x2::event::emit<T_e7wdfpwkn3>(v1);
        0x2::transfer::public_transfer<T_2slmclq3go<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun f_662qezy5ix<T0>(arg0: &T_vqfvxllmd2, arg1: &T_2slmclq3go<T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &T_dggl2dkk4w<T0>) {
        assert!(arg4.registry_id == 0x2::object::id<T_vqfvxllmd2>(arg0), 28);
        assert!(arg4.route_cap_id == 0x2::object::id<T_2slmclq3go<T0>>(arg1), 10);
        assert!(arg4.pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 11);
        assert!(arg4.position_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3), 12);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg3) == arg4.liquidity, 14);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4.tick_lower), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4.tick_upper)), 13);
    }

    public entry fun f_7tngnkumon<T0>(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID, arg2: &T_2slmclq3go<T0>, arg3: &0x2::clock::Clock, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: bool, arg8: u64, arg9: u128, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u32, arg23: u32, arg24: u32, arg25: u32, arg26: u64, arg27: bool, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: u64, arg33: u64, arg34: u64, arg35: &mut 0x2::tx_context::TxContext, arg36: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        f_ohgzgmpstk(arg0, arg1);
        f_mya47rtyhx<T0>(arg0, arg2, arg5);
        f_iinh44wzaj(arg3, arg34);
        assert!(arg8 > 0, 15);
        assert!(arg9 > 4295048017 && arg9 < 79226673515401279992447579055, 16);
        f_t7oxcoz37o(arg10, arg11, 16);
        f_t7oxcoz37o(arg12, arg13, 2);
        f_t7oxcoz37o(arg14, arg15, 18);
        f_t7oxcoz37o(arg16, arg17, 19);
        f_t7oxcoz37o(arg18, arg19, 20);
        f_t7oxcoz37o(arg20, arg21, 21);
        f_t7oxcoz37o(arg28, arg29, 5);
        f_t7oxcoz37o(arg30, arg31, 6);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg22);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg23);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg24);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg25);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v2, v3), 24);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg6);
        assert!(v4 > 0, 14);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, 0x2::sui::SUI, T0>(arg3, arg4, arg5, &mut arg6);
        let v6 = 0x2::balance::value<T0>(&v5);
        f_qhlrowy5tp(v6, arg12, arg13, 2);
        let (_, _, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg4, arg5, &mut arg6, v4, arg3);
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg6);
        let (v15, v16) = if (v13 > 0 || v14 > 0) {
            let (_, _, v19, v20) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg3, arg4, arg5, &mut arg6);
            (v19, v20)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v21 = v16;
        let v22 = v15;
        let v23 = 0x2::balance::value<T0>(&v22);
        let v24 = 0x2::balance::value<0x2::sui::SUI>(&v21);
        f_qhlrowy5tp(v23, arg14, arg15, 18);
        f_qhlrowy5tp(v24, arg16, arg17, 19);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, 0x2::sui::SUI>(arg3, arg4, arg5, arg6);
        let v25 = 0x2::balance::value<T0>(&v12);
        let v26 = 0x2::balance::value<0x2::sui::SUI>(&v11);
        f_qhlrowy5tp(v25, arg18, arg19, 20);
        f_qhlrowy5tp(v26, arg20, arg21, 21);
        let v27 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg5);
        let (v28, v29) = if (arg7) {
            assert!(v25 >= arg8, 20);
            let (v30, v31, v32) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, arg5, true, true, arg8, arg9);
            let v33 = v32;
            let v34 = v31;
            let v35 = v30;
            assert!(0x2::balance::value<T0>(&v35) == 0, 17);
            0x2::balance::destroy_zero<T0>(v35);
            let v36 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v33);
            assert!(v36 == arg8, 15);
            let v37 = 0x2::balance::value<0x2::sui::SUI>(&v34);
            f_qhlrowy5tp(v37, arg10, arg11, 16);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, 0x2::balance::split<T0>(&mut v12, arg8), 0x2::balance::zero<0x2::sui::SUI>(), v33);
            0x2::balance::join<0x2::sui::SUI>(&mut v11, v34);
            (v36, v37)
        } else {
            assert!(v26 >= arg8, 21);
            let (v38, v39, v40) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, arg5, false, true, arg8, arg9);
            let v41 = v40;
            let v42 = v39;
            let v43 = v38;
            assert!(0x2::balance::value<0x2::sui::SUI>(&v42) == 0, 17);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v42);
            let v44 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v41);
            assert!(v44 == arg8, 15);
            let v45 = 0x2::balance::value<T0>(&v43);
            f_qhlrowy5tp(v45, arg10, arg11, 16);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v11, arg8), v41);
            0x2::balance::join<T0>(&mut v12, v43);
            (v44, v45)
        };
        let v46 = 0x2::balance::value<T0>(&v12);
        let v47 = 0x2::balance::value<0x2::sui::SUI>(&v11);
        if (arg7) {
            assert!(v46 + v28 == v25, 27);
            assert!(v47 == v26 + v29, 27);
        } else {
            assert!(v47 + v28 == v26, 27);
            assert!(v46 == v25 + v29, 27);
        };
        let v48 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg5);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v48, v0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v48, v1), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v48, v2) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v48, v3), 24);
        if (arg7) {
            assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v27, v48), 25);
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v48, v27), 25);
        };
        let v49 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg4, arg5, arg24, arg25, arg35);
        let (v50, v51, v52, v53) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg3, arg4, arg5, &mut v49, v12, v11, arg26, arg27);
        let v54 = v53;
        let v55 = v52;
        let v56 = 0x2::balance::value<T0>(&v55);
        let v57 = 0x2::balance::value<0x2::sui::SUI>(&v54);
        f_qhlrowy5tp(v50, arg28, arg29, 5);
        f_qhlrowy5tp(v51, arg30, arg31, 6);
        assert!(v56 <= arg32, 22);
        assert!(v57 <= arg33, 23);
        assert!(v50 + v56 == v46, 27);
        assert!(v51 + v57 == v47, 27);
        let v58 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v49);
        assert!(v58 > 0, 14);
        let v59 = f_3ttr7hbqan<T0>(arg0, arg2, arg5, &v49, arg24, arg25, v58, arg35);
        let v60 = T_bim37xgyqv{
            registry_id             : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id            : 0x2::object::id<T_2slmclq3go<T0>>(arg2),
            pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg5),
            legacy_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg6),
            replacement_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v49),
            replacement_witness_id  : 0x2::object::id<T_dggl2dkk4w<T0>>(&v59),
            deadline_ms             : arg34,
            swap_a_to_b             : arg7,
            requested_swap_input    : arg8,
            actual_swap_input       : v28,
            sqrt_price_limit        : arg9,
            swap_output             : v29,
            start_tick              : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v27),
            terminal_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v48),
            terminal_tick_lower     : arg22,
            terminal_tick_upper     : arg23,
            reward_a                : v6,
            fee_a                   : v23,
            fee_b                   : v24,
            source_principal_a      : v25,
            source_principal_b      : v26,
            post_swap_principal_a   : v46,
            post_swap_principal_b   : v47,
            target_tick_lower       : arg24,
            target_tick_upper       : arg25,
            replacement_liquidity   : v58,
            fixed_amount            : arg26,
            fix_amount_a            : arg27,
            deposited_a             : v50,
            deposited_b             : v51,
            residual_a              : v56,
            residual_b              : v57,
        };
        0x2::event::emit<T_bim37xgyqv>(v60);
        f_j5xsfhml4e<T0>(v5, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg35);
        f_j5xsfhml4e<T0>(v22, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg35);
        f_j5xsfhml4e<0x2::sui::SUI>(v21, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg35);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v49, 0x2::tx_context::sender(arg35));
        0x2::transfer::public_transfer<T_dggl2dkk4w<T0>>(v59, 0x2::tx_context::sender(arg35));
        let v61 = 0x2::tx_context::sender(arg35);
        f_j5xsfhml4e<T0>(v55, v61, arg35);
        let v62 = 0x2::tx_context::sender(arg35);
        f_j5xsfhml4e<0x2::sui::SUI>(v54, v62, arg35);
    }

    public entry fun f_aa2shpyuxv<T0>(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID, arg2: &T_2slmclq3go<T0>, arg3: T_dggl2dkk4w<T0>, arg4: &0x2::clock::Clock, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: 0x2::coin::Coin<T0>, arg9: bool, arg10: u64, arg11: u128, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u32, arg27: u32, arg28: u32, arg29: u32, arg30: u64, arg31: bool, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: u64, arg38: u64, arg39: &mut 0x2::tx_context::TxContext, arg40: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        f_ohgzgmpstk(arg0, arg1);
        f_mya47rtyhx<T0>(arg0, arg2, arg6);
        f_662qezy5ix<T0>(arg0, arg2, arg6, &arg7, &arg3);
        f_iinh44wzaj(arg4, arg38);
        f_t7oxcoz37o(arg12, arg13, 15);
        f_t7oxcoz37o(arg14, arg15, 16);
        f_t7oxcoz37o(arg16, arg17, 2);
        f_t7oxcoz37o(arg18, arg19, 18);
        f_t7oxcoz37o(arg20, arg21, 19);
        f_t7oxcoz37o(arg22, arg23, 20);
        f_t7oxcoz37o(arg24, arg25, 21);
        f_t7oxcoz37o(arg32, arg33, 5);
        f_t7oxcoz37o(arg34, arg35, 6);
        assert!(arg9, 25);
        assert!(arg11 == 4295048017 + 1, 16);
        assert!(0x2::coin::value<T0>(&arg8) == arg10, 29);
        let v0 = arg3.liquidity;
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_lower);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_upper);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg26);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg27);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg28);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg29);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 13);
        assert!(v0 > 0, 14);
        assert!(arg10 > 0, 15);
        assert!(arg11 > 4295048017 && arg11 < 79226673515401279992447579055, 16);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v5, v6), 24);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, 0x2::sui::SUI, T0>(arg4, arg5, arg6, &mut arg7);
        let v9 = 0x2::balance::value<T0>(&v8);
        f_qhlrowy5tp(v9, arg16, arg17, 2);
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg5, arg6, &mut arg7, v0, arg4);
        let v14 = v13;
        let v15 = v12;
        let (v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg7);
        let (v18, v19) = if (v16 > 0 || v17 > 0) {
            let (_, _, v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut arg7);
            (v22, v23)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v24 = v19;
        let v25 = v18;
        let v26 = 0x2::balance::value<T0>(&v25);
        let v27 = 0x2::balance::value<0x2::sui::SUI>(&v24);
        f_qhlrowy5tp(v26, arg18, arg19, 18);
        f_qhlrowy5tp(v27, arg20, arg21, 19);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7);
        let v28 = 0x2::balance::value<T0>(&v15);
        let v29 = 0x2::balance::value<0x2::sui::SUI>(&v14);
        f_qhlrowy5tp(v28, arg22, arg23, 20);
        f_qhlrowy5tp(v29, arg24, arg25, 21);
        let (v30, v31, v32) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, arg6, true, true, arg10, arg11);
        let v33 = v32;
        let v34 = v31;
        let v35 = v30;
        assert!(0x2::balance::value<T0>(&v35) == 0, 17);
        0x2::balance::destroy_zero<T0>(v35);
        let v36 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v33);
        f_qhlrowy5tp(v36, arg12, arg13, 15);
        assert!(v36 == arg10, 29);
        let v37 = 0x2::balance::value<0x2::sui::SUI>(&v34);
        f_qhlrowy5tp(v37, arg14, arg15, 16);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg5, arg6, 0x2::coin::into_balance<T0>(arg8), 0x2::balance::zero<0x2::sui::SUI>(), v33);
        assert!(v28 >= v36, 20);
        0x2::balance::join<0x2::sui::SUI>(&mut v14, v34);
        let v38 = 0x2::balance::value<T0>(&v15);
        let v39 = 0x2::balance::value<0x2::sui::SUI>(&v14);
        if (arg9) {
            assert!(v38 + v36 == v28, 27);
            assert!(v39 == v29 + v37, 27);
        } else {
            assert!(v39 + v36 == v29, 27);
            assert!(v38 == v28 + v37, 27);
        };
        let v40 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v5) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v6), 24);
        if (arg9) {
            assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v7, v40), 25);
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v7), 25);
        };
        assert!(f_pzpcan6eoz(v7, v40, v1, v2), 26);
        let v41 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg5, arg6, arg28, arg29, arg39);
        let (v42, v43, v44, v45) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut v41, v15, v14, arg30, arg31);
        let v46 = v45;
        let v47 = v44;
        let v48 = 0x2::balance::value<T0>(&v47);
        let v49 = 0x2::balance::value<0x2::sui::SUI>(&v46);
        f_qhlrowy5tp(v42, arg32, arg33, 5);
        f_qhlrowy5tp(v43, arg34, arg35, 6);
        assert!(v48 <= arg36, 22);
        assert!(v49 <= arg37, 23);
        assert!(v42 + v48 == v38, 27);
        assert!(v43 + v49 == v39, 27);
        let v50 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v41);
        assert!(v50 > 0, 14);
        let v51 = f_3ttr7hbqan<T0>(arg0, arg2, arg6, &v41, arg28, arg29, v50, arg39);
        let v52 = T_7apn7fwxel{
            registry_id             : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id            : 0x2::object::id<T_2slmclq3go<T0>>(arg2),
            pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg6),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            source_witness_id       : 0x2::object::id<T_dggl2dkk4w<T0>>(&arg3),
            replacement_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v41),
            deadline_ms             : arg38,
            swap_a_to_b             : arg9,
            requested_swap_amount   : arg10,
            sqrt_price_limit        : arg11,
            repayment_amount        : v36,
            swap_output             : v37,
            start_tick              : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v7),
            terminal_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v40),
            terminal_tick_lower     : arg26,
            terminal_tick_upper     : arg27,
            replacement_liquidity   : v50,
            reward_a                : v9,
            fee_a                   : v26,
            fee_b                   : v27,
            source_principal_a      : v28,
            source_principal_b      : v29,
            post_repay_principal_a  : v38,
            post_repay_principal_b  : v39,
            target_tick_lower       : arg28,
            target_tick_upper       : arg29,
            fixed_amount            : arg30,
            fix_amount_a            : arg31,
            deposited_a             : v42,
            deposited_b             : v43,
            residual_a              : v48,
            residual_b              : v49,
        };
        0x2::event::emit<T_7apn7fwxel>(v52);
        f_tmq3lrd2aq<T0>(arg3);
        f_j5xsfhml4e<T0>(v8, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<T0>(v25, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v24, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v41, 0x2::tx_context::sender(arg39));
        0x2::transfer::public_transfer<T_dggl2dkk4w<T0>>(v51, 0x2::tx_context::sender(arg39));
        let v53 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<T0>(0x2::balance::split<T0>(&mut v15, v36), v53, arg39);
        let v54 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<T0>(v47, v54, arg39);
        let v55 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v46, v55, arg39);
    }

    fun f_b5rccek2lh(arg0: &T_vqfvxllmd2, arg1: &T_4uhklxj7e6) {
        assert!(arg1.registry_id == 0x2::object::id<T_vqfvxllmd2>(arg0), 28);
        assert!(0x2::object::id<T_4uhklxj7e6>(arg1) == arg0.admin_cap_id, 10);
    }

    public entry fun f_elssxkxyc7<T0>(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID, arg2: &T_2slmclq3go<T0>, arg3: T_dggl2dkk4w<T0>, arg4: &0x2::clock::Clock, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: bool, arg10: u64, arg11: u128, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u32, arg27: u32, arg28: u32, arg29: u32, arg30: u64, arg31: bool, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: u64, arg38: u64, arg39: &mut 0x2::tx_context::TxContext, arg40: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        f_ohgzgmpstk(arg0, arg1);
        f_mya47rtyhx<T0>(arg0, arg2, arg6);
        f_662qezy5ix<T0>(arg0, arg2, arg6, &arg7, &arg3);
        f_iinh44wzaj(arg4, arg38);
        f_t7oxcoz37o(arg12, arg13, 15);
        f_t7oxcoz37o(arg14, arg15, 16);
        f_t7oxcoz37o(arg16, arg17, 2);
        f_t7oxcoz37o(arg18, arg19, 18);
        f_t7oxcoz37o(arg20, arg21, 19);
        f_t7oxcoz37o(arg22, arg23, 20);
        f_t7oxcoz37o(arg24, arg25, 21);
        f_t7oxcoz37o(arg32, arg33, 5);
        f_t7oxcoz37o(arg34, arg35, 6);
        assert!(!arg9, 25);
        assert!(arg11 == 79226673515401279992447579055 - 1, 16);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) == arg10, 29);
        let v0 = arg3.liquidity;
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_lower);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_upper);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg26);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg27);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg28);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg29);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 13);
        assert!(v0 > 0, 14);
        assert!(arg10 > 0, 15);
        let v7 = if (arg9) {
            4295048017 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        assert!(arg11 == v7, 16);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v5, v6), 24);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, 0x2::sui::SUI, T0>(arg4, arg5, arg6, &mut arg7);
        let v10 = 0x2::balance::value<T0>(&v9);
        f_qhlrowy5tp(v10, arg16, arg17, 2);
        let (v11, v12) = 0x24933581e8d9afd09de1ff6e3630ca6e36250bece669e27f03771f89574f04f4::m_6tbw6halsn::f_hmfbe4jssh<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg10, arg39);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v14);
        f_qhlrowy5tp(v15, arg12, arg13, 15);
        assert!(v15 == arg10, 29);
        let v16 = 0x2::balance::value<T0>(&v13);
        f_qhlrowy5tp(v16, arg14, arg15, 16);
        let v17 = 0x24933581e8d9afd09de1ff6e3630ca6e36250bece669e27f03771f89574f04f4::m_6tbw6halsn::f_fwsuio7vyp<T0, 0x2::sui::SUI>(arg5, arg6, v14, 0x2::coin::into_balance<0x2::sui::SUI>(arg8), arg39);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v17) == 0, 17);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v17);
        let (_, _, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg5, arg6, &mut arg7, v0, arg4);
        let v22 = v21;
        let v23 = v20;
        let (v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg7);
        let (v26, v27) = if (v24 > 0 || v25 > 0) {
            let (_, _, v30, v31) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut arg7);
            (v30, v31)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v32 = v27;
        let v33 = v26;
        let v34 = 0x2::balance::value<T0>(&v33);
        let v35 = 0x2::balance::value<0x2::sui::SUI>(&v32);
        f_qhlrowy5tp(v34, arg18, arg19, 18);
        f_qhlrowy5tp(v35, arg20, arg21, 19);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7);
        let v36 = 0x2::balance::value<T0>(&v23);
        let v37 = 0x2::balance::value<0x2::sui::SUI>(&v22);
        f_qhlrowy5tp(v36, arg22, arg23, 20);
        f_qhlrowy5tp(v37, arg24, arg25, 21);
        assert!(v37 >= v15, 21);
        0x2::balance::join<T0>(&mut v23, v13);
        let v38 = 0x2::balance::value<T0>(&v23);
        let v39 = 0x2::balance::value<0x2::sui::SUI>(&v22);
        if (arg9) {
            assert!(v38 + v15 == v36, 27);
            assert!(v39 == v37 + v16, 27);
        } else {
            assert!(v39 + v15 == v37, 27);
            assert!(v38 == v36 + v16, 27);
        };
        let v40 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v5) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v6), 24);
        if (arg9) {
            assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v8, v40), 25);
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v8), 25);
        };
        assert!(f_pzpcan6eoz(v8, v40, v1, v2), 26);
        let v41 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg5, arg6, arg28, arg29, arg39);
        let (v42, v43, v44, v45) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut v41, v23, v22, arg30, arg31);
        let v46 = v45;
        let v47 = v44;
        let v48 = 0x2::balance::value<T0>(&v47);
        let v49 = 0x2::balance::value<0x2::sui::SUI>(&v46);
        f_qhlrowy5tp(v42, arg32, arg33, 5);
        f_qhlrowy5tp(v43, arg34, arg35, 6);
        assert!(v48 <= arg36, 22);
        assert!(v49 <= arg37, 23);
        assert!(v42 + v48 == v38, 27);
        assert!(v43 + v49 == v39, 27);
        let v50 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v41);
        assert!(v50 > 0, 14);
        let v51 = f_3ttr7hbqan<T0>(arg0, arg2, arg6, &v41, arg28, arg29, v50, arg39);
        let v52 = T_7apn7fwxel{
            registry_id             : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id            : 0x2::object::id<T_2slmclq3go<T0>>(arg2),
            pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg6),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            source_witness_id       : 0x2::object::id<T_dggl2dkk4w<T0>>(&arg3),
            replacement_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v41),
            deadline_ms             : arg38,
            swap_a_to_b             : arg9,
            requested_swap_amount   : arg10,
            sqrt_price_limit        : arg11,
            repayment_amount        : v15,
            swap_output             : v16,
            start_tick              : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v8),
            terminal_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v40),
            terminal_tick_lower     : arg26,
            terminal_tick_upper     : arg27,
            replacement_liquidity   : v50,
            reward_a                : v10,
            fee_a                   : v34,
            fee_b                   : v35,
            source_principal_a      : v36,
            source_principal_b      : v37,
            post_repay_principal_a  : v38,
            post_repay_principal_b  : v39,
            target_tick_lower       : arg28,
            target_tick_upper       : arg29,
            fixed_amount            : arg30,
            fix_amount_a            : arg31,
            deposited_a             : v42,
            deposited_b             : v43,
            residual_a              : v48,
            residual_b              : v49,
        };
        0x2::event::emit<T_7apn7fwxel>(v52);
        f_tmq3lrd2aq<T0>(arg3);
        f_j5xsfhml4e<T0>(v9, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<T0>(v33, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v32, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v41, 0x2::tx_context::sender(arg39));
        0x2::transfer::public_transfer<T_dggl2dkk4w<T0>>(v51, 0x2::tx_context::sender(arg39));
        let v53 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v22, v15), v53, arg39);
        let v54 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<T0>(v47, v54, arg39);
        let v55 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v46, v55, arg39);
    }

    fun f_iinh44wzaj(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 <= arg1, 8);
        assert!(arg1 - v0 <= 30000, 9);
    }

    public entry fun f_iwp2h3nhvw<T0>(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID, arg2: &T_2slmclq3go<T0>, arg3: T_dggl2dkk4w<T0>, arg4: &0x2::clock::Clock, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: bool, arg9: u64, arg10: u128, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u32, arg26: u32, arg27: u32, arg28: u32, arg29: u64, arg30: bool, arg31: u64, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: u64, arg38: &mut 0x2::tx_context::TxContext, arg39: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        f_ohgzgmpstk(arg0, arg1);
        f_mya47rtyhx<T0>(arg0, arg2, arg6);
        f_662qezy5ix<T0>(arg0, arg2, arg6, &arg7, &arg3);
        f_iinh44wzaj(arg4, arg37);
        f_t7oxcoz37o(arg11, arg12, 15);
        f_t7oxcoz37o(arg13, arg14, 16);
        f_t7oxcoz37o(arg15, arg16, 2);
        f_t7oxcoz37o(arg17, arg18, 18);
        f_t7oxcoz37o(arg19, arg20, 19);
        f_t7oxcoz37o(arg21, arg22, 20);
        f_t7oxcoz37o(arg23, arg24, 21);
        f_t7oxcoz37o(arg31, arg32, 5);
        f_t7oxcoz37o(arg33, arg34, 6);
        let v0 = arg3.liquidity;
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_lower);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_upper);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg25);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg26);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg27);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg28);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 13);
        assert!(v0 > 0, 14);
        assert!(arg9 > 0, 15);
        assert!(arg10 > 4295048017 && arg10 < 79226673515401279992447579055, 16);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v5, v6), 24);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, 0x2::sui::SUI, T0>(arg4, arg5, arg6, &mut arg7);
        let v9 = 0x2::balance::value<T0>(&v8);
        f_qhlrowy5tp(v9, arg15, arg16, 2);
        let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg8, true, arg9, arg10);
        let v13 = v12;
        let v14 = v11;
        let v15 = v10;
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v13);
        f_qhlrowy5tp(v16, arg11, arg12, 15);
        assert!(v16 <= arg9, 15);
        let (v17, v18, v19) = if (arg8) {
            assert!(0x2::balance::value<T0>(&v15) == 0, 17);
            0x2::balance::destroy_zero<T0>(v15);
            (0x2::balance::value<0x2::sui::SUI>(&v14), 0x2::balance::zero<T0>(), v14)
        } else {
            assert!(0x2::balance::value<0x2::sui::SUI>(&v14) == 0, 17);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
            (0x2::balance::value<T0>(&v15), v15, 0x2::balance::zero<0x2::sui::SUI>())
        };
        f_qhlrowy5tp(v17, arg13, arg14, 16);
        let (_, _, v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg5, arg6, &mut arg7, v0, arg4);
        let v24 = v23;
        let v25 = v22;
        let (v26, v27) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg7);
        let (v28, v29) = if (v26 > 0 || v27 > 0) {
            let (_, _, v32, v33) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut arg7);
            (v32, v33)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v34 = v29;
        let v35 = v28;
        let v36 = 0x2::balance::value<T0>(&v35);
        let v37 = 0x2::balance::value<0x2::sui::SUI>(&v34);
        f_qhlrowy5tp(v36, arg17, arg18, 18);
        f_qhlrowy5tp(v37, arg19, arg20, 19);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7);
        let v38 = 0x2::balance::value<T0>(&v25);
        let v39 = 0x2::balance::value<0x2::sui::SUI>(&v24);
        f_qhlrowy5tp(v38, arg21, arg22, 20);
        f_qhlrowy5tp(v39, arg23, arg24, 21);
        if (arg8) {
            assert!(v38 >= v16, 20);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg5, arg6, 0x2::balance::split<T0>(&mut v25, v16), 0x2::balance::zero<0x2::sui::SUI>(), v13);
            0x2::balance::join<0x2::sui::SUI>(&mut v24, v19);
            0x2::balance::destroy_zero<T0>(v18);
        } else {
            assert!(v39 >= v16, 21);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v24, v16), v13);
            0x2::balance::join<T0>(&mut v25, v18);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v19);
        };
        let v40 = 0x2::balance::value<T0>(&v25);
        let v41 = 0x2::balance::value<0x2::sui::SUI>(&v24);
        if (arg8) {
            assert!(v40 + v16 == v38, 27);
            assert!(v41 == v39 + v17, 27);
        } else {
            assert!(v41 + v16 == v39, 27);
            assert!(v40 == v38 + v17, 27);
        };
        let v42 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v42, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v42, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v42, v5) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v42, v6), 24);
        if (arg8) {
            assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v7, v42), 25);
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v42, v7), 25);
        };
        assert!(f_pzpcan6eoz(v7, v42, v1, v2), 26);
        let v43 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg5, arg6, arg27, arg28, arg38);
        let (v44, v45, v46, v47) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut v43, v25, v24, arg29, arg30);
        let v48 = v47;
        let v49 = v46;
        let v50 = 0x2::balance::value<T0>(&v49);
        let v51 = 0x2::balance::value<0x2::sui::SUI>(&v48);
        f_qhlrowy5tp(v44, arg31, arg32, 5);
        f_qhlrowy5tp(v45, arg33, arg34, 6);
        assert!(v50 <= arg35, 22);
        assert!(v51 <= arg36, 23);
        assert!(v44 + v50 == v40, 27);
        assert!(v45 + v51 == v41, 27);
        let v52 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v43);
        assert!(v52 > 0, 14);
        let v53 = f_3ttr7hbqan<T0>(arg0, arg2, arg6, &v43, arg27, arg28, v52, arg38);
        let v54 = T_7apn7fwxel{
            registry_id             : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id            : 0x2::object::id<T_2slmclq3go<T0>>(arg2),
            pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg6),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            source_witness_id       : 0x2::object::id<T_dggl2dkk4w<T0>>(&arg3),
            replacement_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v43),
            deadline_ms             : arg37,
            swap_a_to_b             : arg8,
            requested_swap_amount   : arg9,
            sqrt_price_limit        : arg10,
            repayment_amount        : v16,
            swap_output             : v17,
            start_tick              : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v7),
            terminal_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v42),
            terminal_tick_lower     : arg25,
            terminal_tick_upper     : arg26,
            replacement_liquidity   : v52,
            reward_a                : v9,
            fee_a                   : v36,
            fee_b                   : v37,
            source_principal_a      : v38,
            source_principal_b      : v39,
            post_repay_principal_a  : v40,
            post_repay_principal_b  : v41,
            target_tick_lower       : arg27,
            target_tick_upper       : arg28,
            fixed_amount            : arg29,
            fix_amount_a            : arg30,
            deposited_a             : v44,
            deposited_b             : v45,
            residual_a              : v50,
            residual_b              : v51,
        };
        0x2::event::emit<T_7apn7fwxel>(v54);
        f_tmq3lrd2aq<T0>(arg3);
        f_j5xsfhml4e<T0>(v8, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg38);
        f_j5xsfhml4e<T0>(v35, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg38);
        f_j5xsfhml4e<0x2::sui::SUI>(v34, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg38);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v43, 0x2::tx_context::sender(arg38));
        0x2::transfer::public_transfer<T_dggl2dkk4w<T0>>(v53, 0x2::tx_context::sender(arg38));
        let v55 = 0x2::tx_context::sender(arg38);
        f_j5xsfhml4e<T0>(v49, v55, arg38);
        let v56 = 0x2::tx_context::sender(arg38);
        f_j5xsfhml4e<0x2::sui::SUI>(v48, v56, arg38);
    }

    fun f_j5xsfhml4e<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public entry fun f_kw3eda3362<T0>(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID, arg2: &T_2slmclq3go<T0>, arg3: T_dggl2dkk4w<T0>, arg4: &0x2::clock::Clock, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: bool, arg10: u64, arg11: u128, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u32, arg27: u32, arg28: u32, arg29: u32, arg30: u64, arg31: bool, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: u64, arg38: u64, arg39: &mut 0x2::tx_context::TxContext, arg40: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        f_ohgzgmpstk(arg0, arg1);
        f_mya47rtyhx<T0>(arg0, arg2, arg6);
        f_662qezy5ix<T0>(arg0, arg2, arg6, &arg7, &arg3);
        f_iinh44wzaj(arg4, arg38);
        f_t7oxcoz37o(arg12, arg13, 15);
        f_t7oxcoz37o(arg14, arg15, 16);
        f_t7oxcoz37o(arg16, arg17, 2);
        f_t7oxcoz37o(arg18, arg19, 18);
        f_t7oxcoz37o(arg20, arg21, 19);
        f_t7oxcoz37o(arg22, arg23, 20);
        f_t7oxcoz37o(arg24, arg25, 21);
        f_t7oxcoz37o(arg32, arg33, 5);
        f_t7oxcoz37o(arg34, arg35, 6);
        assert!(!arg9, 25);
        assert!(arg11 == 79226673515401279992447579055 - 1, 16);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) == arg10, 29);
        let v0 = arg3.liquidity;
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_lower);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_upper);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg26);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg27);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg28);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg29);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 13);
        assert!(v0 > 0, 14);
        assert!(arg10 > 0, 15);
        assert!(arg11 > 4295048017 && arg11 < 79226673515401279992447579055, 16);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v5, v6), 24);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, 0x2::sui::SUI, T0>(arg4, arg5, arg6, &mut arg7);
        let v9 = 0x2::balance::value<T0>(&v8);
        f_qhlrowy5tp(v9, arg16, arg17, 2);
        let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, arg6, false, true, arg10, arg11);
        let v13 = v12;
        let v14 = v11;
        let v15 = v10;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v14) == 0, 17);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v13);
        f_qhlrowy5tp(v16, arg12, arg13, 15);
        assert!(v16 == arg10, 29);
        let v17 = 0x2::balance::value<T0>(&v15);
        f_qhlrowy5tp(v17, arg14, arg15, 16);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(arg8), v13);
        let (_, _, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg5, arg6, &mut arg7, v0, arg4);
        let v22 = v21;
        let v23 = v20;
        let (v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg7);
        let (v26, v27) = if (v24 > 0 || v25 > 0) {
            let (_, _, v30, v31) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut arg7);
            (v30, v31)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v32 = v27;
        let v33 = v26;
        let v34 = 0x2::balance::value<T0>(&v33);
        let v35 = 0x2::balance::value<0x2::sui::SUI>(&v32);
        f_qhlrowy5tp(v34, arg18, arg19, 18);
        f_qhlrowy5tp(v35, arg20, arg21, 19);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7);
        let v36 = 0x2::balance::value<T0>(&v23);
        let v37 = 0x2::balance::value<0x2::sui::SUI>(&v22);
        f_qhlrowy5tp(v36, arg22, arg23, 20);
        f_qhlrowy5tp(v37, arg24, arg25, 21);
        assert!(v37 >= v16, 21);
        0x2::balance::join<T0>(&mut v23, v15);
        let v38 = 0x2::balance::value<T0>(&v23);
        let v39 = 0x2::balance::value<0x2::sui::SUI>(&v22);
        if (arg9) {
            assert!(v38 + v16 == v36, 27);
            assert!(v39 == v37 + v17, 27);
        } else {
            assert!(v39 + v16 == v37, 27);
            assert!(v38 == v36 + v17, 27);
        };
        let v40 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v5) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v6), 24);
        if (arg9) {
            assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v7, v40), 25);
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v7), 25);
        };
        assert!(f_pzpcan6eoz(v7, v40, v1, v2), 26);
        let v41 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg5, arg6, arg28, arg29, arg39);
        let (v42, v43, v44, v45) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut v41, v23, v22, arg30, arg31);
        let v46 = v45;
        let v47 = v44;
        let v48 = 0x2::balance::value<T0>(&v47);
        let v49 = 0x2::balance::value<0x2::sui::SUI>(&v46);
        f_qhlrowy5tp(v42, arg32, arg33, 5);
        f_qhlrowy5tp(v43, arg34, arg35, 6);
        assert!(v48 <= arg36, 22);
        assert!(v49 <= arg37, 23);
        assert!(v42 + v48 == v38, 27);
        assert!(v43 + v49 == v39, 27);
        let v50 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v41);
        assert!(v50 > 0, 14);
        let v51 = f_3ttr7hbqan<T0>(arg0, arg2, arg6, &v41, arg28, arg29, v50, arg39);
        let v52 = T_7apn7fwxel{
            registry_id             : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id            : 0x2::object::id<T_2slmclq3go<T0>>(arg2),
            pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg6),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            source_witness_id       : 0x2::object::id<T_dggl2dkk4w<T0>>(&arg3),
            replacement_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v41),
            deadline_ms             : arg38,
            swap_a_to_b             : arg9,
            requested_swap_amount   : arg10,
            sqrt_price_limit        : arg11,
            repayment_amount        : v16,
            swap_output             : v17,
            start_tick              : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v7),
            terminal_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v40),
            terminal_tick_lower     : arg26,
            terminal_tick_upper     : arg27,
            replacement_liquidity   : v50,
            reward_a                : v9,
            fee_a                   : v34,
            fee_b                   : v35,
            source_principal_a      : v36,
            source_principal_b      : v37,
            post_repay_principal_a  : v38,
            post_repay_principal_b  : v39,
            target_tick_lower       : arg28,
            target_tick_upper       : arg29,
            fixed_amount            : arg30,
            fix_amount_a            : arg31,
            deposited_a             : v42,
            deposited_b             : v43,
            residual_a              : v48,
            residual_b              : v49,
        };
        0x2::event::emit<T_7apn7fwxel>(v52);
        f_tmq3lrd2aq<T0>(arg3);
        f_j5xsfhml4e<T0>(v8, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<T0>(v33, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v32, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v41, 0x2::tx_context::sender(arg39));
        0x2::transfer::public_transfer<T_dggl2dkk4w<T0>>(v51, 0x2::tx_context::sender(arg39));
        let v53 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v22, v16), v53, arg39);
        let v54 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<T0>(v47, v54, arg39);
        let v55 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v46, v55, arg39);
    }

    public entry fun f_mghe2ihuth<T0>(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID, arg2: &T_2slmclq3go<T0>, arg3: T_dggl2dkk4w<T0>, arg4: &0x2::clock::Clock, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: bool, arg9: u64, arg10: u128, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u32, arg26: u32, arg27: u32, arg28: u32, arg29: u64, arg30: bool, arg31: u64, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: u64, arg38: &mut 0x2::tx_context::TxContext, arg39: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        f_ohgzgmpstk(arg0, arg1);
        f_mya47rtyhx<T0>(arg0, arg2, arg6);
        f_662qezy5ix<T0>(arg0, arg2, arg6, &arg7, &arg3);
        f_iinh44wzaj(arg4, arg37);
        f_t7oxcoz37o(arg11, arg12, 15);
        f_t7oxcoz37o(arg13, arg14, 16);
        f_t7oxcoz37o(arg15, arg16, 2);
        f_t7oxcoz37o(arg17, arg18, 18);
        f_t7oxcoz37o(arg19, arg20, 19);
        f_t7oxcoz37o(arg21, arg22, 20);
        f_t7oxcoz37o(arg23, arg24, 21);
        f_t7oxcoz37o(arg31, arg32, 5);
        f_t7oxcoz37o(arg33, arg34, 6);
        let v0 = arg3.liquidity;
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_lower);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_upper);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg25);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg26);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg27);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg28);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 13);
        assert!(v0 > 0, 14);
        assert!(arg9 > 0, 15);
        assert!(arg10 > 4295048017 && arg10 < 79226673515401279992447579055, 16);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v5, v6), 24);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, 0x2::sui::SUI, T0>(arg4, arg5, arg6, &mut arg7);
        let v9 = 0x2::balance::value<T0>(&v8);
        f_qhlrowy5tp(v9, arg15, arg16, 2);
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg5, arg6, &mut arg7, v0, arg4);
        let v14 = v13;
        let v15 = v12;
        let (v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg7);
        let (v18, v19) = if (v16 > 0 || v17 > 0) {
            let (_, _, v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut arg7);
            (v22, v23)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v24 = v19;
        let v25 = v18;
        let v26 = 0x2::balance::value<T0>(&v25);
        let v27 = 0x2::balance::value<0x2::sui::SUI>(&v24);
        f_qhlrowy5tp(v26, arg17, arg18, 18);
        f_qhlrowy5tp(v27, arg19, arg20, 19);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7);
        let v28 = 0x2::balance::value<T0>(&v15);
        let v29 = 0x2::balance::value<0x2::sui::SUI>(&v14);
        f_qhlrowy5tp(v28, arg21, arg22, 20);
        f_qhlrowy5tp(v29, arg23, arg24, 21);
        let (v30, v31, v32) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg8, true, arg9, arg10);
        let v33 = v32;
        let v34 = v31;
        let v35 = v30;
        let v36 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v33);
        f_qhlrowy5tp(v36, arg11, arg12, 15);
        assert!(v36 <= arg9, 15);
        let (v37, v38, v39) = if (arg8) {
            assert!(0x2::balance::value<T0>(&v35) == 0, 17);
            0x2::balance::destroy_zero<T0>(v35);
            (0x2::balance::value<0x2::sui::SUI>(&v34), 0x2::balance::zero<T0>(), v34)
        } else {
            assert!(0x2::balance::value<0x2::sui::SUI>(&v34) == 0, 17);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v34);
            (0x2::balance::value<T0>(&v35), v35, 0x2::balance::zero<0x2::sui::SUI>())
        };
        f_qhlrowy5tp(v37, arg13, arg14, 16);
        if (arg8) {
            assert!(v28 >= v36, 20);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg5, arg6, 0x2::balance::split<T0>(&mut v15, v36), 0x2::balance::zero<0x2::sui::SUI>(), v33);
            0x2::balance::join<0x2::sui::SUI>(&mut v14, v39);
            0x2::balance::destroy_zero<T0>(v38);
        } else {
            assert!(v29 >= v36, 21);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v14, v36), v33);
            0x2::balance::join<T0>(&mut v15, v38);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v39);
        };
        let v40 = 0x2::balance::value<T0>(&v15);
        let v41 = 0x2::balance::value<0x2::sui::SUI>(&v14);
        if (arg8) {
            assert!(v40 + v36 == v28, 27);
            assert!(v41 == v29 + v37, 27);
        } else {
            assert!(v41 + v36 == v29, 27);
            assert!(v40 == v28 + v37, 27);
        };
        let v42 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v42, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v42, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v42, v5) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v42, v6), 24);
        if (arg8) {
            assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v7, v42), 25);
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v42, v7), 25);
        };
        assert!(f_pzpcan6eoz(v7, v42, v1, v2), 26);
        let v43 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg5, arg6, arg27, arg28, arg38);
        let (v44, v45, v46, v47) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut v43, v15, v14, arg29, arg30);
        let v48 = v47;
        let v49 = v46;
        let v50 = 0x2::balance::value<T0>(&v49);
        let v51 = 0x2::balance::value<0x2::sui::SUI>(&v48);
        f_qhlrowy5tp(v44, arg31, arg32, 5);
        f_qhlrowy5tp(v45, arg33, arg34, 6);
        assert!(v50 <= arg35, 22);
        assert!(v51 <= arg36, 23);
        assert!(v44 + v50 == v40, 27);
        assert!(v45 + v51 == v41, 27);
        let v52 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v43);
        assert!(v52 > 0, 14);
        let v53 = f_3ttr7hbqan<T0>(arg0, arg2, arg6, &v43, arg27, arg28, v52, arg38);
        let v54 = T_7apn7fwxel{
            registry_id             : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id            : 0x2::object::id<T_2slmclq3go<T0>>(arg2),
            pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg6),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            source_witness_id       : 0x2::object::id<T_dggl2dkk4w<T0>>(&arg3),
            replacement_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v43),
            deadline_ms             : arg37,
            swap_a_to_b             : arg8,
            requested_swap_amount   : arg9,
            sqrt_price_limit        : arg10,
            repayment_amount        : v36,
            swap_output             : v37,
            start_tick              : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v7),
            terminal_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v42),
            terminal_tick_lower     : arg25,
            terminal_tick_upper     : arg26,
            replacement_liquidity   : v52,
            reward_a                : v9,
            fee_a                   : v26,
            fee_b                   : v27,
            source_principal_a      : v28,
            source_principal_b      : v29,
            post_repay_principal_a  : v40,
            post_repay_principal_b  : v41,
            target_tick_lower       : arg27,
            target_tick_upper       : arg28,
            fixed_amount            : arg29,
            fix_amount_a            : arg30,
            deposited_a             : v44,
            deposited_b             : v45,
            residual_a              : v50,
            residual_b              : v51,
        };
        0x2::event::emit<T_7apn7fwxel>(v54);
        f_tmq3lrd2aq<T0>(arg3);
        f_j5xsfhml4e<T0>(v8, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg38);
        f_j5xsfhml4e<T0>(v25, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg38);
        f_j5xsfhml4e<0x2::sui::SUI>(v24, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg38);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v43, 0x2::tx_context::sender(arg38));
        0x2::transfer::public_transfer<T_dggl2dkk4w<T0>>(v53, 0x2::tx_context::sender(arg38));
        let v55 = 0x2::tx_context::sender(arg38);
        f_j5xsfhml4e<T0>(v49, v55, arg38);
        let v56 = 0x2::tx_context::sender(arg38);
        f_j5xsfhml4e<0x2::sui::SUI>(v48, v56, arg38);
    }

    fun f_mya47rtyhx<T0>(arg0: &T_vqfvxllmd2, arg1: &T_2slmclq3go<T0>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>) {
        assert!(arg1.registry_id == 0x2::object::id<T_vqfvxllmd2>(arg0), 28);
        assert!(arg1.pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 11);
    }

    fun f_ohgzgmpstk(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID) {
        assert!(0x2::object::id<T_vqfvxllmd2>(arg0) == arg1, 28);
    }

    public entry fun f_p6gdw6525b(arg0: &mut 0x2::tx_context::TxContext, arg1: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = T_4uhklxj7e6{
            id          : 0x2::object::new(arg0),
            registry_id : v1,
        };
        let v3 = 0x2::object::id<T_4uhklxj7e6>(&v2);
        let v4 = T_6tezlhecvo{
            registry_id          : v1,
            admin_cap_id         : v3,
            must_pin_registry_id : true,
        };
        0x2::event::emit<T_6tezlhecvo>(v4);
        0x2::transfer::public_transfer<T_4uhklxj7e6>(v2, 0x2::tx_context::sender(arg0));
        let v5 = T_vqfvxllmd2{
            id           : v0,
            admin_cap_id : v3,
        };
        0x2::transfer::share_object<T_vqfvxllmd2>(v5);
    }

    fun f_pzpcan6eoz(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        let v0 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg1)) {
            arg0
        } else {
            arg1
        };
        let v1 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0, arg1)) {
            arg0
        } else {
            arg1
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, arg3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v1, arg2)
    }

    fun f_qhlrowy5tp(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0 >= arg1 && arg0 <= arg2, arg3);
    }

    fun f_t7oxcoz37o(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 <= arg1, arg2);
    }

    fun f_tmq3lrd2aq<T0>(arg0: T_dggl2dkk4w<T0>) {
        let T_dggl2dkk4w {
            id           : v0,
            registry_id  : _,
            route_cap_id : _,
            pool_id      : _,
            position_id  : _,
            tick_lower   : _,
            tick_upper   : _,
            liquidity    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun f_ugyiyhzvog<T0>(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID, arg2: &T_2slmclq3go<T0>, arg3: T_dggl2dkk4w<T0>, arg4: &0x2::clock::Clock, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: 0x2::coin::Coin<T0>, arg9: bool, arg10: u64, arg11: u128, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u32, arg27: u32, arg28: u32, arg29: u32, arg30: u64, arg31: bool, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: u64, arg38: u64, arg39: &mut 0x2::tx_context::TxContext, arg40: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        f_ohgzgmpstk(arg0, arg1);
        f_mya47rtyhx<T0>(arg0, arg2, arg6);
        f_662qezy5ix<T0>(arg0, arg2, arg6, &arg7, &arg3);
        f_iinh44wzaj(arg4, arg38);
        f_t7oxcoz37o(arg12, arg13, 15);
        f_t7oxcoz37o(arg14, arg15, 16);
        f_t7oxcoz37o(arg16, arg17, 2);
        f_t7oxcoz37o(arg18, arg19, 18);
        f_t7oxcoz37o(arg20, arg21, 19);
        f_t7oxcoz37o(arg22, arg23, 20);
        f_t7oxcoz37o(arg24, arg25, 21);
        f_t7oxcoz37o(arg32, arg33, 5);
        f_t7oxcoz37o(arg34, arg35, 6);
        assert!(arg9, 25);
        assert!(arg11 == 4295048017 + 1, 16);
        assert!(0x2::coin::value<T0>(&arg8) == arg10, 29);
        let v0 = arg3.liquidity;
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_lower);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_upper);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg26);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg27);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg28);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg29);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 13);
        assert!(v0 > 0, 14);
        assert!(arg10 > 0, 15);
        assert!(arg11 > 4295048017 && arg11 < 79226673515401279992447579055, 16);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v5, v6), 24);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, 0x2::sui::SUI, T0>(arg4, arg5, arg6, &mut arg7);
        let v9 = 0x2::balance::value<T0>(&v8);
        f_qhlrowy5tp(v9, arg16, arg17, 2);
        let (v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, arg6, true, true, arg10, arg11);
        let v13 = v12;
        let v14 = v11;
        let v15 = v10;
        assert!(0x2::balance::value<T0>(&v15) == 0, 17);
        0x2::balance::destroy_zero<T0>(v15);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v13);
        f_qhlrowy5tp(v16, arg12, arg13, 15);
        assert!(v16 == arg10, 29);
        let v17 = 0x2::balance::value<0x2::sui::SUI>(&v14);
        f_qhlrowy5tp(v17, arg14, arg15, 16);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg5, arg6, 0x2::coin::into_balance<T0>(arg8), 0x2::balance::zero<0x2::sui::SUI>(), v13);
        let (_, _, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg5, arg6, &mut arg7, v0, arg4);
        let v22 = v21;
        let v23 = v20;
        let (v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg7);
        let (v26, v27) = if (v24 > 0 || v25 > 0) {
            let (_, _, v30, v31) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut arg7);
            (v30, v31)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v32 = v27;
        let v33 = v26;
        let v34 = 0x2::balance::value<T0>(&v33);
        let v35 = 0x2::balance::value<0x2::sui::SUI>(&v32);
        f_qhlrowy5tp(v34, arg18, arg19, 18);
        f_qhlrowy5tp(v35, arg20, arg21, 19);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7);
        let v36 = 0x2::balance::value<T0>(&v23);
        let v37 = 0x2::balance::value<0x2::sui::SUI>(&v22);
        f_qhlrowy5tp(v36, arg22, arg23, 20);
        f_qhlrowy5tp(v37, arg24, arg25, 21);
        assert!(v36 >= v16, 20);
        0x2::balance::join<0x2::sui::SUI>(&mut v22, v14);
        let v38 = 0x2::balance::value<T0>(&v23);
        let v39 = 0x2::balance::value<0x2::sui::SUI>(&v22);
        if (arg9) {
            assert!(v38 + v16 == v36, 27);
            assert!(v39 == v37 + v17, 27);
        } else {
            assert!(v39 + v16 == v37, 27);
            assert!(v38 == v36 + v17, 27);
        };
        let v40 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v5) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v6), 24);
        if (arg9) {
            assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v7, v40), 25);
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v7), 25);
        };
        assert!(f_pzpcan6eoz(v7, v40, v1, v2), 26);
        let v41 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg5, arg6, arg28, arg29, arg39);
        let (v42, v43, v44, v45) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut v41, v23, v22, arg30, arg31);
        let v46 = v45;
        let v47 = v44;
        let v48 = 0x2::balance::value<T0>(&v47);
        let v49 = 0x2::balance::value<0x2::sui::SUI>(&v46);
        f_qhlrowy5tp(v42, arg32, arg33, 5);
        f_qhlrowy5tp(v43, arg34, arg35, 6);
        assert!(v48 <= arg36, 22);
        assert!(v49 <= arg37, 23);
        assert!(v42 + v48 == v38, 27);
        assert!(v43 + v49 == v39, 27);
        let v50 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v41);
        assert!(v50 > 0, 14);
        let v51 = f_3ttr7hbqan<T0>(arg0, arg2, arg6, &v41, arg28, arg29, v50, arg39);
        let v52 = T_7apn7fwxel{
            registry_id             : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id            : 0x2::object::id<T_2slmclq3go<T0>>(arg2),
            pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg6),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            source_witness_id       : 0x2::object::id<T_dggl2dkk4w<T0>>(&arg3),
            replacement_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v41),
            deadline_ms             : arg38,
            swap_a_to_b             : arg9,
            requested_swap_amount   : arg10,
            sqrt_price_limit        : arg11,
            repayment_amount        : v16,
            swap_output             : v17,
            start_tick              : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v7),
            terminal_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v40),
            terminal_tick_lower     : arg26,
            terminal_tick_upper     : arg27,
            replacement_liquidity   : v50,
            reward_a                : v9,
            fee_a                   : v34,
            fee_b                   : v35,
            source_principal_a      : v36,
            source_principal_b      : v37,
            post_repay_principal_a  : v38,
            post_repay_principal_b  : v39,
            target_tick_lower       : arg28,
            target_tick_upper       : arg29,
            fixed_amount            : arg30,
            fix_amount_a            : arg31,
            deposited_a             : v42,
            deposited_b             : v43,
            residual_a              : v48,
            residual_b              : v49,
        };
        0x2::event::emit<T_7apn7fwxel>(v52);
        f_tmq3lrd2aq<T0>(arg3);
        f_j5xsfhml4e<T0>(v8, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<T0>(v33, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v32, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v41, 0x2::tx_context::sender(arg39));
        0x2::transfer::public_transfer<T_dggl2dkk4w<T0>>(v51, 0x2::tx_context::sender(arg39));
        let v53 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<T0>(0x2::balance::split<T0>(&mut v23, v16), v53, arg39);
        let v54 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<T0>(v47, v54, arg39);
        let v55 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v46, v55, arg39);
    }

    public entry fun f_v5chsdo2yc<T0>(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID, arg2: &T_2slmclq3go<T0>, arg3: T_dggl2dkk4w<T0>, arg4: &0x2::clock::Clock, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: bool, arg9: u64, arg10: u128, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u32, arg26: u32, arg27: u32, arg28: u32, arg29: u64, arg30: bool, arg31: u64, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: u64, arg38: &mut 0x2::tx_context::TxContext, arg39: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        f_ohgzgmpstk(arg0, arg1);
        f_mya47rtyhx<T0>(arg0, arg2, arg6);
        f_662qezy5ix<T0>(arg0, arg2, arg6, &arg7, &arg3);
        f_iinh44wzaj(arg4, arg37);
        f_t7oxcoz37o(arg11, arg12, 15);
        f_t7oxcoz37o(arg13, arg14, 16);
        f_t7oxcoz37o(arg15, arg16, 2);
        f_t7oxcoz37o(arg17, arg18, 18);
        f_t7oxcoz37o(arg19, arg20, 19);
        f_t7oxcoz37o(arg21, arg22, 20);
        f_t7oxcoz37o(arg23, arg24, 21);
        f_t7oxcoz37o(arg31, arg32, 5);
        f_t7oxcoz37o(arg33, arg34, 6);
        let v0 = arg3.liquidity;
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_lower);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_upper);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg25);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg26);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg27);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg28);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 13);
        assert!(v0 > 0, 14);
        assert!(arg9 > 0, 15);
        let v7 = if (arg8) {
            4295048017 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        assert!(arg10 == v7, 16);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v5, v6), 24);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, 0x2::sui::SUI, T0>(arg4, arg5, arg6, &mut arg7);
        let v10 = 0x2::balance::value<T0>(&v9);
        f_qhlrowy5tp(v10, arg15, arg16, 2);
        let (v11, v12, v13) = if (arg8) {
            let (v14, v15) = 0x24933581e8d9afd09de1ff6e3630ca6e36250bece669e27f03771f89574f04f4::m_6tbw6halsn::f_4nvf24fpdz<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg9, arg38);
            (v14, 0x2::balance::zero<T0>(), v15)
        } else {
            let (v16, v17) = 0x24933581e8d9afd09de1ff6e3630ca6e36250bece669e27f03771f89574f04f4::m_6tbw6halsn::f_hmfbe4jssh<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg9, arg38);
            (v16, v17, 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v18 = v13;
        let v19 = v12;
        let v20 = v11;
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v20);
        f_qhlrowy5tp(v21, arg11, arg12, 15);
        assert!(v21 <= arg9, 15);
        let v22 = if (arg8) {
            0x2::balance::value<0x2::sui::SUI>(&v18)
        } else {
            0x2::balance::value<T0>(&v19)
        };
        f_qhlrowy5tp(v22, arg13, arg14, 16);
        let (_, _, v25, v26) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg5, arg6, &mut arg7, v0, arg4);
        let v27 = v26;
        let v28 = v25;
        let (v29, v30) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg7);
        let (v31, v32) = if (v29 > 0 || v30 > 0) {
            let (_, _, v35, v36) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut arg7);
            (v35, v36)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v37 = v32;
        let v38 = v31;
        let v39 = 0x2::balance::value<T0>(&v38);
        let v40 = 0x2::balance::value<0x2::sui::SUI>(&v37);
        f_qhlrowy5tp(v39, arg17, arg18, 18);
        f_qhlrowy5tp(v40, arg19, arg20, 19);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7);
        let v41 = 0x2::balance::value<T0>(&v28);
        let v42 = 0x2::balance::value<0x2::sui::SUI>(&v27);
        f_qhlrowy5tp(v41, arg21, arg22, 20);
        f_qhlrowy5tp(v42, arg23, arg24, 21);
        if (arg8) {
            assert!(v41 >= v21, 20);
            let v43 = 0x24933581e8d9afd09de1ff6e3630ca6e36250bece669e27f03771f89574f04f4::m_6tbw6halsn::f_zdjbz3hg6z<T0, 0x2::sui::SUI>(arg5, arg6, v20, 0x2::balance::split<T0>(&mut v28, v21), arg38);
            assert!(0x2::balance::value<T0>(&v43) == 0, 15);
            0x2::balance::destroy_zero<T0>(v43);
            0x2::balance::join<0x2::sui::SUI>(&mut v27, v18);
            0x2::balance::destroy_zero<T0>(v19);
        } else {
            assert!(v42 >= v21, 21);
            let v44 = 0x24933581e8d9afd09de1ff6e3630ca6e36250bece669e27f03771f89574f04f4::m_6tbw6halsn::f_fwsuio7vyp<T0, 0x2::sui::SUI>(arg5, arg6, v20, 0x2::balance::split<0x2::sui::SUI>(&mut v27, v21), arg38);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v44) == 0, 15);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v44);
            0x2::balance::join<T0>(&mut v28, v19);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v18);
        };
        let v45 = 0x2::balance::value<T0>(&v28);
        let v46 = 0x2::balance::value<0x2::sui::SUI>(&v27);
        if (arg8) {
            assert!(v45 + v21 == v41, 27);
            assert!(v46 == v42 + v22, 27);
        } else {
            assert!(v46 + v21 == v42, 27);
            assert!(v45 == v41 + v22, 27);
        };
        let v47 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v47, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v47, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v47, v5) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v47, v6), 24);
        if (arg8) {
            assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v8, v47), 25);
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v47, v8), 25);
        };
        assert!(f_pzpcan6eoz(v8, v47, v1, v2), 26);
        let v48 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg5, arg6, arg27, arg28, arg38);
        let (v49, v50, v51, v52) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut v48, v28, v27, arg29, arg30);
        let v53 = v52;
        let v54 = v51;
        let v55 = 0x2::balance::value<T0>(&v54);
        let v56 = 0x2::balance::value<0x2::sui::SUI>(&v53);
        f_qhlrowy5tp(v49, arg31, arg32, 5);
        f_qhlrowy5tp(v50, arg33, arg34, 6);
        assert!(v55 <= arg35, 22);
        assert!(v56 <= arg36, 23);
        assert!(v49 + v55 == v45, 27);
        assert!(v50 + v56 == v46, 27);
        let v57 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v48);
        assert!(v57 > 0, 14);
        let v58 = f_3ttr7hbqan<T0>(arg0, arg2, arg6, &v48, arg27, arg28, v57, arg38);
        let v59 = T_7apn7fwxel{
            registry_id             : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id            : 0x2::object::id<T_2slmclq3go<T0>>(arg2),
            pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg6),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            source_witness_id       : 0x2::object::id<T_dggl2dkk4w<T0>>(&arg3),
            replacement_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v48),
            deadline_ms             : arg37,
            swap_a_to_b             : arg8,
            requested_swap_amount   : arg9,
            sqrt_price_limit        : arg10,
            repayment_amount        : v21,
            swap_output             : v22,
            start_tick              : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v8),
            terminal_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v47),
            terminal_tick_lower     : arg25,
            terminal_tick_upper     : arg26,
            replacement_liquidity   : v57,
            reward_a                : v10,
            fee_a                   : v39,
            fee_b                   : v40,
            source_principal_a      : v41,
            source_principal_b      : v42,
            post_repay_principal_a  : v45,
            post_repay_principal_b  : v46,
            target_tick_lower       : arg27,
            target_tick_upper       : arg28,
            fixed_amount            : arg29,
            fix_amount_a            : arg30,
            deposited_a             : v49,
            deposited_b             : v50,
            residual_a              : v55,
            residual_b              : v56,
        };
        0x2::event::emit<T_7apn7fwxel>(v59);
        f_tmq3lrd2aq<T0>(arg3);
        f_j5xsfhml4e<T0>(v9, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg38);
        f_j5xsfhml4e<T0>(v38, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg38);
        f_j5xsfhml4e<0x2::sui::SUI>(v37, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg38);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v48, 0x2::tx_context::sender(arg38));
        0x2::transfer::public_transfer<T_dggl2dkk4w<T0>>(v58, 0x2::tx_context::sender(arg38));
        let v60 = 0x2::tx_context::sender(arg38);
        f_j5xsfhml4e<T0>(v54, v60, arg38);
        let v61 = 0x2::tx_context::sender(arg38);
        f_j5xsfhml4e<0x2::sui::SUI>(v53, v61, arg38);
    }

    public entry fun f_vd3d2b4j2y<T0>(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID, arg2: &T_2slmclq3go<T0>, arg3: T_dggl2dkk4w<T0>, arg4: &0x2::clock::Clock, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: 0x2::coin::Coin<T0>, arg9: bool, arg10: u64, arg11: u128, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u32, arg27: u32, arg28: u32, arg29: u32, arg30: u64, arg31: bool, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: u64, arg38: u64, arg39: &mut 0x2::tx_context::TxContext, arg40: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        f_ohgzgmpstk(arg0, arg1);
        f_mya47rtyhx<T0>(arg0, arg2, arg6);
        f_662qezy5ix<T0>(arg0, arg2, arg6, &arg7, &arg3);
        f_iinh44wzaj(arg4, arg38);
        f_t7oxcoz37o(arg12, arg13, 15);
        f_t7oxcoz37o(arg14, arg15, 16);
        f_t7oxcoz37o(arg16, arg17, 2);
        f_t7oxcoz37o(arg18, arg19, 18);
        f_t7oxcoz37o(arg20, arg21, 19);
        f_t7oxcoz37o(arg22, arg23, 20);
        f_t7oxcoz37o(arg24, arg25, 21);
        f_t7oxcoz37o(arg32, arg33, 5);
        f_t7oxcoz37o(arg34, arg35, 6);
        assert!(arg9, 25);
        assert!(arg11 == 4295048017 + 1, 16);
        assert!(0x2::coin::value<T0>(&arg8) == arg10, 29);
        let v0 = arg3.liquidity;
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_lower);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_upper);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg26);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg27);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg28);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg29);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 13);
        assert!(v0 > 0, 14);
        assert!(arg10 > 0, 15);
        let v7 = if (arg9) {
            4295048017 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        assert!(arg11 == v7, 16);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v5, v6), 24);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, 0x2::sui::SUI, T0>(arg4, arg5, arg6, &mut arg7);
        let v10 = 0x2::balance::value<T0>(&v9);
        f_qhlrowy5tp(v10, arg16, arg17, 2);
        let (v11, v12) = 0x24933581e8d9afd09de1ff6e3630ca6e36250bece669e27f03771f89574f04f4::m_6tbw6halsn::f_4nvf24fpdz<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg10, arg39);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v14);
        f_qhlrowy5tp(v15, arg12, arg13, 15);
        assert!(v15 == arg10, 29);
        let v16 = 0x2::balance::value<0x2::sui::SUI>(&v13);
        f_qhlrowy5tp(v16, arg14, arg15, 16);
        let v17 = 0x24933581e8d9afd09de1ff6e3630ca6e36250bece669e27f03771f89574f04f4::m_6tbw6halsn::f_zdjbz3hg6z<T0, 0x2::sui::SUI>(arg5, arg6, v14, 0x2::coin::into_balance<T0>(arg8), arg39);
        assert!(0x2::balance::value<T0>(&v17) == 0, 17);
        0x2::balance::destroy_zero<T0>(v17);
        let (_, _, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg5, arg6, &mut arg7, v0, arg4);
        let v22 = v21;
        let v23 = v20;
        let (v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg7);
        let (v26, v27) = if (v24 > 0 || v25 > 0) {
            let (_, _, v30, v31) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut arg7);
            (v30, v31)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v32 = v27;
        let v33 = v26;
        let v34 = 0x2::balance::value<T0>(&v33);
        let v35 = 0x2::balance::value<0x2::sui::SUI>(&v32);
        f_qhlrowy5tp(v34, arg18, arg19, 18);
        f_qhlrowy5tp(v35, arg20, arg21, 19);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7);
        let v36 = 0x2::balance::value<T0>(&v23);
        let v37 = 0x2::balance::value<0x2::sui::SUI>(&v22);
        f_qhlrowy5tp(v36, arg22, arg23, 20);
        f_qhlrowy5tp(v37, arg24, arg25, 21);
        assert!(v36 >= v15, 20);
        0x2::balance::join<0x2::sui::SUI>(&mut v22, v13);
        let v38 = 0x2::balance::value<T0>(&v23);
        let v39 = 0x2::balance::value<0x2::sui::SUI>(&v22);
        if (arg9) {
            assert!(v38 + v15 == v36, 27);
            assert!(v39 == v37 + v16, 27);
        } else {
            assert!(v39 + v15 == v37, 27);
            assert!(v38 == v36 + v16, 27);
        };
        let v40 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v5) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v6), 24);
        if (arg9) {
            assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v8, v40), 25);
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v8), 25);
        };
        assert!(f_pzpcan6eoz(v8, v40, v1, v2), 26);
        let v41 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg5, arg6, arg28, arg29, arg39);
        let (v42, v43, v44, v45) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut v41, v23, v22, arg30, arg31);
        let v46 = v45;
        let v47 = v44;
        let v48 = 0x2::balance::value<T0>(&v47);
        let v49 = 0x2::balance::value<0x2::sui::SUI>(&v46);
        f_qhlrowy5tp(v42, arg32, arg33, 5);
        f_qhlrowy5tp(v43, arg34, arg35, 6);
        assert!(v48 <= arg36, 22);
        assert!(v49 <= arg37, 23);
        assert!(v42 + v48 == v38, 27);
        assert!(v43 + v49 == v39, 27);
        let v50 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v41);
        assert!(v50 > 0, 14);
        let v51 = f_3ttr7hbqan<T0>(arg0, arg2, arg6, &v41, arg28, arg29, v50, arg39);
        let v52 = T_7apn7fwxel{
            registry_id             : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id            : 0x2::object::id<T_2slmclq3go<T0>>(arg2),
            pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg6),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            source_witness_id       : 0x2::object::id<T_dggl2dkk4w<T0>>(&arg3),
            replacement_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v41),
            deadline_ms             : arg38,
            swap_a_to_b             : arg9,
            requested_swap_amount   : arg10,
            sqrt_price_limit        : arg11,
            repayment_amount        : v15,
            swap_output             : v16,
            start_tick              : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v8),
            terminal_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v40),
            terminal_tick_lower     : arg26,
            terminal_tick_upper     : arg27,
            replacement_liquidity   : v50,
            reward_a                : v10,
            fee_a                   : v34,
            fee_b                   : v35,
            source_principal_a      : v36,
            source_principal_b      : v37,
            post_repay_principal_a  : v38,
            post_repay_principal_b  : v39,
            target_tick_lower       : arg28,
            target_tick_upper       : arg29,
            fixed_amount            : arg30,
            fix_amount_a            : arg31,
            deposited_a             : v42,
            deposited_b             : v43,
            residual_a              : v48,
            residual_b              : v49,
        };
        0x2::event::emit<T_7apn7fwxel>(v52);
        f_tmq3lrd2aq<T0>(arg3);
        f_j5xsfhml4e<T0>(v9, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<T0>(v33, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v32, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v41, 0x2::tx_context::sender(arg39));
        0x2::transfer::public_transfer<T_dggl2dkk4w<T0>>(v51, 0x2::tx_context::sender(arg39));
        let v53 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<T0>(0x2::balance::split<T0>(&mut v23, v15), v53, arg39);
        let v54 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<T0>(v47, v54, arg39);
        let v55 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v46, v55, arg39);
    }

    public entry fun f_vp4anphxye<T0>(arg0: &T_vqfvxllmd2, arg1: 0x2::object::ID, arg2: &T_2slmclq3go<T0>, arg3: T_dggl2dkk4w<T0>, arg4: &0x2::clock::Clock, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: bool, arg10: u64, arg11: u128, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u32, arg27: u32, arg28: u32, arg29: u32, arg30: u64, arg31: bool, arg32: u64, arg33: u64, arg34: u64, arg35: u64, arg36: u64, arg37: u64, arg38: u64, arg39: &mut 0x2::tx_context::TxContext, arg40: &0xdb88afac2456c9905d189577da88a69935be00d389e0ae7a48dc205733041e72::m_qkaetr75zk::T_evvsobbppw) {
        f_ohgzgmpstk(arg0, arg1);
        f_mya47rtyhx<T0>(arg0, arg2, arg6);
        f_662qezy5ix<T0>(arg0, arg2, arg6, &arg7, &arg3);
        f_iinh44wzaj(arg4, arg38);
        f_t7oxcoz37o(arg12, arg13, 15);
        f_t7oxcoz37o(arg14, arg15, 16);
        f_t7oxcoz37o(arg16, arg17, 2);
        f_t7oxcoz37o(arg18, arg19, 18);
        f_t7oxcoz37o(arg20, arg21, 19);
        f_t7oxcoz37o(arg22, arg23, 20);
        f_t7oxcoz37o(arg24, arg25, 21);
        f_t7oxcoz37o(arg32, arg33, 5);
        f_t7oxcoz37o(arg34, arg35, 6);
        assert!(!arg9, 25);
        assert!(arg11 == 79226673515401279992447579055 - 1, 16);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) == arg10, 29);
        let v0 = arg3.liquidity;
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_lower);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3.tick_upper);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg26);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg27);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg28);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg29);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 13);
        assert!(v0 > 0, 14);
        assert!(arg10 > 0, 15);
        assert!(arg11 > 4295048017 && arg11 < 79226673515401279992447579055, 16);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v5, v6), 24);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, 0x2::sui::SUI, T0>(arg4, arg5, arg6, &mut arg7);
        let v9 = 0x2::balance::value<T0>(&v8);
        f_qhlrowy5tp(v9, arg16, arg17, 2);
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, 0x2::sui::SUI>(arg5, arg6, &mut arg7, v0, arg4);
        let v14 = v13;
        let v15 = v12;
        let (v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(&arg7);
        let (v18, v19) = if (v16 > 0 || v17 > 0) {
            let (_, _, v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut arg7);
            (v22, v23)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v24 = v19;
        let v25 = v18;
        let v26 = 0x2::balance::value<T0>(&v25);
        let v27 = 0x2::balance::value<0x2::sui::SUI>(&v24);
        f_qhlrowy5tp(v26, arg18, arg19, 18);
        f_qhlrowy5tp(v27, arg20, arg21, 19);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7);
        let v28 = 0x2::balance::value<T0>(&v15);
        let v29 = 0x2::balance::value<0x2::sui::SUI>(&v14);
        f_qhlrowy5tp(v28, arg22, arg23, 20);
        f_qhlrowy5tp(v29, arg24, arg25, 21);
        let (v30, v31, v32) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg4, arg5, arg6, false, true, arg10, arg11);
        let v33 = v32;
        let v34 = v31;
        let v35 = v30;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v34) == 0, 17);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v34);
        let v36 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v33);
        f_qhlrowy5tp(v36, arg12, arg13, 15);
        assert!(v36 == arg10, 29);
        let v37 = 0x2::balance::value<T0>(&v35);
        f_qhlrowy5tp(v37, arg14, arg15, 16);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg5, arg6, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(arg8), v33);
        assert!(v29 >= v36, 21);
        0x2::balance::join<T0>(&mut v15, v35);
        let v38 = 0x2::balance::value<T0>(&v15);
        let v39 = 0x2::balance::value<0x2::sui::SUI>(&v14);
        if (arg9) {
            assert!(v38 + v36 == v28, 27);
            assert!(v39 == v29 + v37, 27);
        } else {
            assert!(v39 + v36 == v29, 27);
            assert!(v38 == v28 + v37, 27);
        };
        let v40 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0x2::sui::SUI>(arg6);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v4), 24);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v5) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v40, v6), 24);
        if (arg9) {
            assert!(!0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v7, v40), 25);
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v40, v7), 25);
        };
        assert!(f_pzpcan6eoz(v7, v40, v1, v2), 26);
        let v41 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg5, arg6, arg28, arg29, arg39);
        let (v42, v43, v44, v45) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg4, arg5, arg6, &mut v41, v15, v14, arg30, arg31);
        let v46 = v45;
        let v47 = v44;
        let v48 = 0x2::balance::value<T0>(&v47);
        let v49 = 0x2::balance::value<0x2::sui::SUI>(&v46);
        f_qhlrowy5tp(v42, arg32, arg33, 5);
        f_qhlrowy5tp(v43, arg34, arg35, 6);
        assert!(v48 <= arg36, 22);
        assert!(v49 <= arg37, 23);
        assert!(v42 + v48 == v38, 27);
        assert!(v43 + v49 == v39, 27);
        let v50 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v41);
        assert!(v50 > 0, 14);
        let v51 = f_3ttr7hbqan<T0>(arg0, arg2, arg6, &v41, arg28, arg29, v50, arg39);
        let v52 = T_7apn7fwxel{
            registry_id             : 0x2::object::id<T_vqfvxllmd2>(arg0),
            route_cap_id            : 0x2::object::id<T_2slmclq3go<T0>>(arg2),
            pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg6),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            source_witness_id       : 0x2::object::id<T_dggl2dkk4w<T0>>(&arg3),
            replacement_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v41),
            deadline_ms             : arg38,
            swap_a_to_b             : arg9,
            requested_swap_amount   : arg10,
            sqrt_price_limit        : arg11,
            repayment_amount        : v36,
            swap_output             : v37,
            start_tick              : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v7),
            terminal_tick           : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v40),
            terminal_tick_lower     : arg26,
            terminal_tick_upper     : arg27,
            replacement_liquidity   : v50,
            reward_a                : v9,
            fee_a                   : v26,
            fee_b                   : v27,
            source_principal_a      : v28,
            source_principal_b      : v29,
            post_repay_principal_a  : v38,
            post_repay_principal_b  : v39,
            target_tick_lower       : arg28,
            target_tick_upper       : arg29,
            fixed_amount            : arg30,
            fix_amount_a            : arg31,
            deposited_a             : v42,
            deposited_b             : v43,
            residual_a              : v48,
            residual_b              : v49,
        };
        0x2::event::emit<T_7apn7fwxel>(v52);
        f_tmq3lrd2aq<T0>(arg3);
        f_j5xsfhml4e<T0>(v8, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<T0>(v25, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v24, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, arg39);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v41, 0x2::tx_context::sender(arg39));
        0x2::transfer::public_transfer<T_dggl2dkk4w<T0>>(v51, 0x2::tx_context::sender(arg39));
        let v53 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v14, v36), v53, arg39);
        let v54 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<T0>(v47, v54, arg39);
        let v55 = 0x2::tx_context::sender(arg39);
        f_j5xsfhml4e<0x2::sui::SUI>(v46, v55, arg39);
    }

    // decompiled from Move bytecode v7
}

