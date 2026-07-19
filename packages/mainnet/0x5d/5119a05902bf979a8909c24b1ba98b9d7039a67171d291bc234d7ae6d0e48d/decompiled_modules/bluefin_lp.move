module 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::bluefin_lp {
    struct PositionOpened has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct Recentered has copy, drop {
        pool_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        reward_type: 0x1::type_name::TypeName,
        reward_amount: u64,
        returned_a: u64,
        returned_b: u64,
        fee_a: u64,
        fee_b: u64,
        swap_a_to_b: bool,
        swap_amount: u64,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
    }

    struct FeesCollected has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        fee_a: u64,
        fee_b: u64,
    }

    struct RewardHarvested has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Swapped has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        input: u64,
        output: u64,
    }

    struct PositionClosed has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        reward_amount: u64,
        fee_a: u64,
        fee_b: u64,
        out_a: u64,
        out_b: u64,
    }

    public fun close<T0, T1, T2>(arg0: &mut 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::CapitalVault, arg1: &0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::KeeperCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg9) <= arg8, 110);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        let v1 = 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::take_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg1, v0, arg4);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg9, arg2, arg3, &mut v1);
        let v3 = 0x2::balance::value<T2>(&v2);
        assert!(v3 >= arg5, 105);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::realize_income<T2>(arg0, v2, arg10);
        let (v4, v5, v6, v7) = close_with_fees<T0, T1>(arg9, arg2, arg3, v1);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::realize_income<T0>(arg0, v9, arg10);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::realize_income<T1>(arg0, v8, arg10);
        let v12 = 0x2::balance::value<T0>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg6, 101);
        assert!(v13 >= arg7, 102);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::deposit_balance<T0>(arg0, v11);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::deposit_balance<T1>(arg0, v10);
        let v14 = PositionClosed{
            pool_id       : v0,
            position_id   : arg4,
            reward_type   : 0x1::type_name::with_defining_ids<T2>(),
            reward_amount : v3,
            fee_a         : 0x2::balance::value<T0>(&v9),
            fee_b         : 0x2::balance::value<T1>(&v8),
            out_a         : v12,
            out_b         : v13,
        };
        0x2::event::emit<PositionClosed>(v14);
    }

    fun close_with_fees<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
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

    public fun collect_fees<T0, T1>(arg0: &mut 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::CapitalVault, arg1: &0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::KeeperCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg5, arg2, arg3, 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::borrow_position_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg1, v0, arg4));
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::realize_income<T0>(arg0, v3, arg6);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::realize_income<T1>(arg0, v4, arg6);
        let v5 = FeesCollected{
            pool_id     : v0,
            position_id : arg4,
            fee_a       : v1,
            fee_b       : v2,
        };
        0x2::event::emit<FeesCollected>(v5);
    }

    fun deploy_liquidity<T0, T1>(arg0: &mut 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::CapitalVault, arg1: &0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::KeeperCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: u32, arg6: u32, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64, u64, u64, u64) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg3, arg5, arg6, arg16);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg15, arg2, arg3, &mut v0, arg7, arg8, arg9, arg10);
        let v5 = v4;
        let v6 = v3;
        assert!(v1 >= arg11, 103);
        assert!(v2 >= arg12, 104);
        let v7 = 0x2::balance::value<T0>(&v6);
        let v8 = 0x2::balance::value<T1>(&v5);
        assert!(v7 <= arg13, 106);
        assert!(v8 <= arg14, 107);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::deposit_balance<T0>(arg0, v6);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::deposit_balance<T1>(arg0, v5);
        (0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::store_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg1, arg4, v0), v1, v2, v7, v8)
    }

    public fun harvest_reward<T0, T1, T2>(arg0: &mut 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::CapitalVault, arg1: &0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::KeeperCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg6, arg2, arg3, 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::borrow_position_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg1, v0, arg4));
        let v2 = 0x2::balance::value<T2>(&v1);
        assert!(v2 >= arg5, 105);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::realize_income<T2>(arg0, v1, arg7);
        let v3 = RewardHarvested{
            pool_id     : v0,
            position_id : arg4,
            reward_type : 0x1::type_name::with_defining_ids<T2>(),
            amount      : v2,
        };
        0x2::event::emit<RewardHarvested>(v3);
    }

    public fun open<T0, T1>(arg0: &mut 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::CapitalVault, arg1: &0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::KeeperCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg15) <= arg14, 110);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::assert_pool_approved(arg0, v0);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v2), 112);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v3, v1) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v3, v2), 112);
        let v4 = 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::withdraw_balance<T0>(arg0, arg1, arg6);
        let v5 = 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::withdraw_balance<T1>(arg0, arg1, arg7);
        let (v6, v7, v8, v9, v10) = deploy_liquidity<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4, arg5, v4, v5, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg16);
        let v11 = PositionOpened{
            pool_id     : v0,
            position_id : v6,
            tick_lower  : arg4,
            tick_upper  : arg5,
            deposited_a : v7,
            deposited_b : v8,
            residual_a  : v9,
            residual_b  : v10,
        };
        0x2::event::emit<PositionOpened>(v11);
    }

    public fun rebalance_swap<T0, T1>(arg0: &mut 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::CapitalVault, arg1: &0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::KeeperCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: u64, arg10: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg10) <= arg9, 110);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::assert_pool_approved(arg0, v0);
        if (arg4) {
            let v1 = swap_a_to_b_balance<T0, T1>(arg10, arg2, arg3, 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::withdraw_balance<T0>(arg0, arg1, arg5));
            let v2 = 0x2::balance::value<T1>(&v1);
            0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::oracle::assert_swap_floor(arg0, v0, arg7, arg8, true, arg5, v2, arg6, arg10);
            0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::deposit_balance<T1>(arg0, v1);
            let v3 = Swapped{
                pool_id : v0,
                a2b     : arg4,
                input   : arg5,
                output  : v2,
            };
            0x2::event::emit<Swapped>(v3);
        } else {
            let v4 = swap_b_to_a_balance<T0, T1>(arg10, arg2, arg3, 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::withdraw_balance<T1>(arg0, arg1, arg5));
            let v5 = 0x2::balance::value<T0>(&v4);
            0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::oracle::assert_swap_floor(arg0, v0, arg7, arg8, false, arg5, v5, arg6, arg10);
            0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::deposit_balance<T0>(arg0, v4);
            let v6 = Swapped{
                pool_id : v0,
                a2b     : arg4,
                input   : arg5,
                output  : v5,
            };
            0x2::event::emit<Swapped>(v6);
        };
    }

    public fun recenter<T0, T1, T2>(arg0: &mut 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::CapitalVault, arg1: &0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::KeeperCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: u32, arg6: u32, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg20: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg22) <= arg21, 110);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::assert_pool_approved(arg0, v0);
        let v1 = 0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::take_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, arg1, v0, arg4);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg22, arg2, arg3, &mut v1);
        let v3 = 0x2::balance::value<T2>(&v2);
        assert!(v3 >= arg12, 105);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::realize_income<T2>(arg0, v2, arg23);
        let (v4, v5, v6, v7) = close_with_fees<T0, T1>(arg22, arg2, arg3, v1);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::realize_income<T0>(arg0, v9, arg23);
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::balance_manager::realize_income<T1>(arg0, v8, arg23);
        let v12 = 0x2::balance::value<T0>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg13, 101);
        assert!(v13 >= arg14, 102);
        if (arg8 > 0) {
            if (arg7) {
                assert!(0x2::balance::value<T0>(&v11) >= arg8, 111);
                let v14 = swap_a_to_b_balance<T0, T1>(arg22, arg2, arg3, 0x2::balance::split<T0>(&mut v11, arg8));
                0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::oracle::assert_swap_floor(arg0, v0, arg19, arg20, true, arg8, 0x2::balance::value<T1>(&v14), arg9, arg22);
                0x2::balance::join<T1>(&mut v10, v14);
            } else {
                assert!(0x2::balance::value<T1>(&v10) >= arg8, 111);
                let v15 = swap_b_to_a_balance<T0, T1>(arg22, arg2, arg3, 0x2::balance::split<T1>(&mut v10, arg8));
                0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::oracle::assert_swap_floor(arg0, v0, arg19, arg20, false, arg8, 0x2::balance::value<T0>(&v15), arg9, arg22);
                0x2::balance::join<T0>(&mut v11, v15);
            };
        };
        0x5d5119a05902bf979a8909c24b1ba98b9d7039a67171d291bc234d7ae6d0e48d::oracle::assert_pool_near_oracle(arg0, v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), arg19, arg20, arg22);
        let v16 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v17 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v16, v17), 112);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v18, v16) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v18, v17), 112);
        let (v19, v20, v21, v22, v23) = deploy_liquidity<T0, T1>(arg0, arg1, arg2, arg3, v0, arg5, arg6, v11, v10, arg10, arg11, arg15, arg16, arg17, arg18, arg22, arg23);
        let v24 = Recentered{
            pool_id         : v0,
            old_position_id : arg4,
            new_position_id : v19,
            tick_lower      : arg5,
            tick_upper      : arg6,
            reward_type     : 0x1::type_name::with_defining_ids<T2>(),
            reward_amount   : v3,
            returned_a      : v12,
            returned_b      : v13,
            fee_a           : 0x2::balance::value<T0>(&v9),
            fee_b           : 0x2::balance::value<T1>(&v8),
            swap_a_to_b     : arg7,
            swap_amount     : arg8,
            deposited_a     : v20,
            deposited_b     : v21,
            residual_a      : v22,
            residual_b      : v23,
        };
        0x2::event::emit<Recentered>(v24);
    }

    fun swap_a_to_b_balance<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
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

    fun swap_b_to_a_balance<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
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

    // decompiled from Move bytecode v7
}

