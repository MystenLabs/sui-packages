module 0x1fca92b59e4203af53919f35a66ee371ba358c58e39d7a3010d9e243ecf65cd2::auto {
    public fun close_position(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        let (v0, v1, _) = close_position_int(arg0, arg1, arg2);
        assert!(v1 == 0x2::tx_context::sender(arg3), 0);
        v0
    }

    fun close_position_int(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: 0x2::object::ID) : (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, address, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::ProxyCap) {
        let v0 = 0x1fca92b59e4203af53919f35a66ee371ba358c58e39d7a3010d9e243ecf65cd2::lp_bluefin::mint_proxy_cap(arg0);
        let (v1, v2, v3, _) = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::unwrap<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::remove_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, arg2, &v0), &v0);
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u64>(v3);
        (v2, v1, v0)
    }

    public fun collect_fee<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = position_mut(arg0, arg1, arg5, arg8);
        let v2 = v1;
        let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg7, arg3, arg4, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::inner_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0));
        let v7 = v6;
        let v8 = v5;
        if (arg6) {
            let v9 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4);
            let v10 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0);
            let v11 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg4), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_claim_source());
            0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T0>(arg2, v9, v10, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::owner<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_claim_source(), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::split_balance_by_pips<T0>(&mut v8, v11));
            0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T1>(arg2, v9, v10, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::owner<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_claim_source(), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::split_balance_by_pips<T1>(&mut v7, v11));
            0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_auto_fee_collected(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::owner<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), v9, v10, 0x2::balance::value<T0>(&v8), 0x2::balance::value<T1>(&v7), &v2);
        };
        (0x2::coin::from_balance<T0>(v8, arg8), 0x2::coin::from_balance<T1>(v7, arg8))
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = position_mut(arg0, arg1, arg5, arg8);
        let v2 = v1;
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg7, arg3, arg4, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::inner_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0));
        if (arg6) {
            let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4);
            let v5 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0);
            0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T2>(arg2, v4, v5, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::owner<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_claim_source(), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::split_balance_by_pips<T2>(&mut v3, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg4), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_claim_source())));
            0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_auto_reward_collected(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::owner<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), v4, v5, 0x1::type_name::with_original_ids<T2>(), 0x2::balance::value<T2>(&v3), &v2);
        };
        0x2::coin::from_balance<T2>(v3, arg8)
    }

    public fun compound<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: 0x2::object::ID, arg10: vector<0x1::string::String>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = position_mut(arg0, arg1, arg9, arg12);
        let v2 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::owner<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0);
        let (v3, v4) = 0x1fca92b59e4203af53919f35a66ee371ba358c58e39d7a3010d9e243ecf65cd2::lp_bluefin::compound_int<T0, T1>(arg0, arg2, arg3, arg4, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::inner_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), arg5, arg6, arg7, arg8, arg10, v2, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_compound_source(), arg11, arg12);
        let v5 = v1;
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::transfer_or_destroy<T0>(v3, v2);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::transfer_or_destroy<T1>(v4, v2);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_automated(v2, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_compound_source(), &v5);
    }

    public fun exit<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_keeper(arg0, 0x2::tx_context::sender(arg9));
        let (v0, v1, v2) = close_position_int(arg0, arg1, arg5);
        let v3 = v0;
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v3);
        let (_, _, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg8, arg3, arg4, &mut v3);
        let (_, _, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg4, &mut v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v3), arg8);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg4), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_exit_source());
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T0>(arg2, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4), v4, v1, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_exit_source(), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::split_balance_by_pips<T0>(&mut v14, v15));
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T1>(arg2, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4), v4, v1, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_exit_source(), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::split_balance_by_pips<T1>(&mut v13, v15));
        assert!(0x2::balance::value<T0>(&v14) >= arg6 && 0x2::balance::value<T1>(&v13) >= arg7, 1);
        0x2::balance::join<T0>(&mut v14, v7);
        0x2::balance::join<T1>(&mut v13, v8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg8, arg3, arg4, v3);
        let v16 = v2;
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::transfer_or_destroy<T0>(0x2::coin::from_balance<T0>(v14, arg9), v1);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::transfer_or_destroy<T1>(0x2::coin::from_balance<T1>(v13, arg9), v1);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_automated(v1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4), v4, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_exit_source(), &v16);
    }

    public fun open_position(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1fca92b59e4203af53919f35a66ee371ba358c58e39d7a3010d9e243ecf65cd2::lp_bluefin::mint_proxy_cap(arg0);
        let v1 = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::new<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg2, 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(), 0x2::tx_context::sender(arg4), arg3, &v0);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::insert_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, v1, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v1), &v0);
    }

    fun position_mut(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : (&mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::AutoPosition<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::ProxyCap) {
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_keeper(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1fca92b59e4203af53919f35a66ee371ba358c58e39d7a3010d9e243ecf65cd2::lp_bluefin::mint_proxy_cap(arg0);
        (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::position_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, arg2, &v0), v0)
    }

    public fun rebalance<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::Collector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::RebalanceReceipt, arg6: u32, arg7: u32, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: 0x2::object::ID, arg13: vector<0x1::string::String>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::assert_keeper(arg0, 0x2::tx_context::sender(arg15));
        let v0 = 0x1fca92b59e4203af53919f35a66ee371ba358c58e39d7a3010d9e243ecf65cd2::lp_bluefin::mint_proxy_cap(arg0);
        let (v1, v2, v3, v4) = 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::unwrap<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::remove_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, arg12, &v0), &v0);
        let (v5, v6, v7) = 0x1fca92b59e4203af53919f35a66ee371ba358c58e39d7a3010d9e243ecf65cd2::lp_bluefin::rebalance_int<T0, T1>(arg0, arg2, arg3, arg4, v2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, v1, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_rebalance_source(), arg14, arg15);
        let v8 = v7;
        let v9 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v8);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::insert_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::new<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v8, v3, v1, v4, &v0), v9, &v0);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::transfer_or_destroy<T0>(v5, v1);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::utils::transfer_or_destroy<T1>(v6, v1);
        0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::events::emit_automated(v1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4), v9, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::constants::auto_rebalance_source(), &v0);
    }

    public fun start_rebalance<T0, T1>(arg0: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::Registry, arg1: &mut 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::RebalanceReceipt, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = position_mut(arg0, arg1, arg4, arg6);
        let v2 = v1;
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::inner<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0));
        let (v5, v6, v7, v8) = if (v4 > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg3, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::inner_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), v4, arg5)
        } else {
            (0, 0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        (0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::state::new_rebalance_receipt(0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), v5, v6, v3, 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::math::get_auto_rebalance_min_liquidity(v5, v6, v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3), 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::auto_position::slippage_pips<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0)), &v2), 0x2::coin::from_balance<T0>(v7, arg6), 0x2::coin::from_balance<T1>(v8, arg6))
    }

    // decompiled from Move bytecode v6
}

