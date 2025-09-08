module 0x87978366ddb9db366dd8f1a3deac21d23ad0da9e6d7d8f9430cf7128cf68a958::auto {
    public fun collect_fee<T0, T1>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::FeeCollector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = position_mut(arg0, arg1, arg5, arg8);
        let v2 = v1;
        let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg7, arg3, arg4, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::inner_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0));
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4);
        let v10 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::yield_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg4), arg6);
        if (v10 > 0) {
            0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T0>(arg2, v9, &mut v8, arg6, v10);
            0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T1>(arg2, v9, &mut v7, arg6, v10);
        };
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::events::emit_automated_fee_collected(&v2, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::owner<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), v9, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), 0x2::balance::value<T0>(&v8), 0x2::balance::value<T1>(&v7));
        (0x2::coin::from_balance<T0>(v8, arg8), 0x2::coin::from_balance<T1>(v7, arg8))
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::FeeCollector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = position_mut(arg0, arg1, arg5, arg8);
        let v2 = v1;
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg7, arg3, arg4, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::inner_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0));
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4);
        let v5 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::yield_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg4), arg6);
        if (v5 > 0) {
            0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T2>(arg2, v4, &mut v3, arg6, v5);
        };
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::events::emit_automated_reward_collected(&v2, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::owner<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), v4, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), 0x1::type_name::get<T2>(), 0x2::balance::value<T2>(&v3));
        0x2::coin::from_balance<T2>(v3, arg8)
    }

    public fun close_position<T0, T1>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x87978366ddb9db366dd8f1a3deac21d23ad0da9e6d7d8f9430cf7128cf68a958::lp_bluefin::mint_proxy_cap(arg0);
        let (v1, v2, v3) = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::unwrap_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, arg4, &v0);
        assert!(v1 == 0x2::tx_context::sender(arg6), 0);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::close(v3);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg5, arg2, arg3, v2);
    }

    public fun compound<T0, T1>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::FeeCollector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: 0x2::object::ID, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = position_mut(arg0, arg1, arg9, arg11);
        let v2 = v1;
        let v3 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::vault_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0);
        0x2::coin::join<T0>(&mut arg5, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::withdraw_all<T0>(v3, arg11));
        0x2::coin::join<T1>(&mut arg6, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::withdraw_all<T1>(v3, arg11));
        let (v4, v5) = 0x87978366ddb9db366dd8f1a3deac21d23ad0da9e6d7d8f9430cf7128cf68a958::lp_bluefin::compound<T0, T1>(arg0, arg2, arg3, arg4, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::inner_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), arg5, arg6, arg7, arg8, arg10, arg11);
        let v6 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::vault_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::deposit_coin<T0>(v6, v4);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::deposit_coin<T1>(v6, v5);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::events::emit_automated(&v2, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::owner<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::constants::auto_compound_source());
    }

    public fun deposit_coin_to_vault<T0>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = position_mut(arg0, arg1, arg2, arg4);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::deposit_coin<T0>(0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::vault_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), arg3);
    }

    public fun open_position(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x87978366ddb9db366dd8f1a3deac21d23ad0da9e6d7d8f9430cf7128cf68a958::lp_bluefin::mint_proxy_cap(arg0);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::insert_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::new<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg2, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::new(arg3), 0x2::tx_context::sender(arg3), &v0), &v0);
    }

    fun position_mut(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : (&mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::AutoPosition<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap) {
        let v0 = 0x87978366ddb9db366dd8f1a3deac21d23ad0da9e6d7d8f9430cf7128cf68a958::lp_bluefin::mint_proxy_cap(arg0);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::assert_keeper(arg0, 0x2::tx_context::sender(arg3));
        (0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::position_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, arg2, &v0), v0)
    }

    public fun rebalance<T0, T1>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::FeeCollector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: 0x2::object::ID, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x87978366ddb9db366dd8f1a3deac21d23ad0da9e6d7d8f9430cf7128cf68a958::lp_bluefin::mint_proxy_cap(arg0);
        let (v1, v2, v3) = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::unwrap_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, arg11, &v0);
        let v4 = v3;
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::assert_keeper(arg0, 0x2::tx_context::sender(arg13));
        0x2::coin::join<T0>(&mut arg7, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::withdraw_all<T0>(&mut v4, arg13));
        0x2::coin::join<T1>(&mut arg8, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::withdraw_all<T1>(&mut v4, arg13));
        let (v5, v6, v7) = 0x87978366ddb9db366dd8f1a3deac21d23ad0da9e6d7d8f9430cf7128cf68a958::lp_bluefin::rebalance<T0, T1>(arg0, arg2, arg3, arg4, v2, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::deposit_coin<T0>(&mut v4, v5);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::deposit_coin<T1>(&mut v4, v6);
        let v8 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::new<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v7, v4, v1, &v0);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::events::emit_automated(&v0, v1, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v8), 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::constants::auto_rebalance_source());
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::insert_position<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, v8, &v0);
    }

    public fun remove_all_liquidity<T0, T1>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::LPRegistry<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1) = position_mut(arg0, arg1, arg4, arg6);
        let v2 = v1;
        let v3 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::inner_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0);
        let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg3, v3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v3), arg5);
        let v8 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::vault_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::deposit<T0>(v8, v6);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::vault::deposit<T1>(v8, v7);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::events::emit_automated(&v2, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::owner<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::auto_position::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::constants::auto_exit_source());
    }

    // decompiled from Move bytecode v6
}

