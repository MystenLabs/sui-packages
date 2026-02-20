module 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::bluefin_liquidity {
    public fun add_liquidity<T0, T1>(arg0: &0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::CallerAllowlist, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::assert_fixed_allowlist_and_sender(arg0, @0x347cba68e55b4d4733661f6fc3fa5511f7c763183c17c730dadbcd8dbabc3753, arg8);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), arg7);
        let v4 = 0x2::tx_context::sender(arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg8), v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg8), v4);
    }

    fun aligned_base_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, arg1);
        let v1 = v0;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(arg0, arg1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(v1, arg1)
    }

    fun aligned_lower_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(aligned_base_tick(arg0, arg1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(arg1, arg2))
    }

    public fun close_and_unregister<T0, T1>(arg0: &0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::CallerAllowlist, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::PositionRegistry, arg5: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg6: &mut 0x2::tx_context::TxContext) {
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::assert_fixed_allowlist_and_sender(arg0, @0x347cba68e55b4d4733661f6fc3fa5511f7c763183c17c730dadbcd8dbabc3753, arg6);
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::unregister_position(arg4, 0x2::tx_context::sender(arg6), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg5));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg1, arg2, arg3, arg5);
    }

    public fun open_and_add_liquidity_auto_ticks_fixed_pool<T0, T1>(arg0: &0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::CallerAllowlist, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u32, arg11: &mut 0x2::tx_context::TxContext) {
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::assert_fixed_allowlist_and_sender(arg0, @0x347cba68e55b4d4733661f6fc3fa5511f7c763183c17c730dadbcd8dbabc3753, arg11);
        assert!(arg10 > 0, 5);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg2);
        assert!(0x2::object::id_to_address(&v0) == @0x3db251ba509a8d5d8777b6338836082335d93eecbdd09a11e190a1cff51c352, 3);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        assert!(0x2::object::id_to_address(&v1) == @0x15dbcac854b1fc68fc9467dbd9ab34270447aabd8cc0e04a5864d95ccb86b74a, 4);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg3));
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg10);
        open_and_add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(aligned_lower_tick(v2, v3, v4)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(aligned_base_tick(v2, v3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(v3, v4))), arg6, arg7, arg8, arg9, arg11);
    }

    public fun open_and_add_liquidity_auto_ticks_fixed_pool_custody<T0, T1>(arg0: &0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::CallerAllowlist, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::PositionVault, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: u32, arg12: &mut 0x2::tx_context::TxContext) {
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::assert_fixed_allowlist_and_sender(arg0, @0x347cba68e55b4d4733661f6fc3fa5511f7c763183c17c730dadbcd8dbabc3753, arg12);
        assert!(arg11 > 0, 5);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg2);
        assert!(0x2::object::id_to_address(&v0) == @0x3db251ba509a8d5d8777b6338836082335d93eecbdd09a11e190a1cff51c352, 3);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        assert!(0x2::object::id_to_address(&v1) == @0x15dbcac854b1fc68fc9467dbd9ab34270447aabd8cc0e04a5864d95ccb86b74a, 4);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg3));
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg11);
        let v5 = 0x2::coin::into_balance<T0>(arg5);
        let v6 = 0x2::coin::into_balance<T1>(arg6);
        assert!(0x2::balance::value<T0>(&v5) >= arg8, 1);
        assert!(0x2::balance::value<T1>(&v6) >= arg9, 2);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(aligned_lower_tick(v2, v3, v4)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(aligned_base_tick(v2, v3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(v3, v4))), arg12);
        let (_, _, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg1, arg2, arg3, &mut v7, 0x2::balance::split<T0>(&mut v5, arg8), 0x2::balance::split<T1>(&mut v6, arg9), arg7, arg10);
        let v12 = 0x2::tx_context::sender(arg12);
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::deposit_position(arg4, v12, v7);
        0x2::balance::join<T0>(&mut v5, v10);
        0x2::balance::join<T1>(&mut v6, v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg12), v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg12), v12);
    }

    public fun open_and_add_liquidity_auto_ticks_fixed_pool_tracked<T0, T1>(arg0: &0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::CallerAllowlist, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::PositionRegistry, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: u32, arg12: &mut 0x2::tx_context::TxContext) {
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::assert_fixed_allowlist_and_sender(arg0, @0x347cba68e55b4d4733661f6fc3fa5511f7c763183c17c730dadbcd8dbabc3753, arg12);
        assert!(arg11 > 0, 5);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg2);
        assert!(0x2::object::id_to_address(&v0) == @0x3db251ba509a8d5d8777b6338836082335d93eecbdd09a11e190a1cff51c352, 3);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3);
        assert!(0x2::object::id_to_address(&v1) == @0x15dbcac854b1fc68fc9467dbd9ab34270447aabd8cc0e04a5864d95ccb86b74a, 4);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg3);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg3));
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg11);
        let v5 = 0x2::coin::into_balance<T0>(arg5);
        let v6 = 0x2::coin::into_balance<T1>(arg6);
        assert!(0x2::balance::value<T0>(&v5) >= arg8, 1);
        assert!(0x2::balance::value<T1>(&v6) >= arg9, 2);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(aligned_lower_tick(v2, v3, v4)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(aligned_base_tick(v2, v3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(v3, v4))), arg12);
        let (_, _, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg1, arg2, arg3, &mut v7, 0x2::balance::split<T0>(&mut v5, arg8), 0x2::balance::split<T1>(&mut v6, arg9), arg7, arg10);
        let v12 = 0x2::tx_context::sender(arg12);
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::register_position(arg4, v12, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v7));
        0x2::balance::join<T0>(&mut v5, v10);
        0x2::balance::join<T1>(&mut v6, v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg12), v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg12), v12);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v7, v12);
    }

    public fun open_and_add_liquidity_with_fixed_amount<T0, T1>(arg0: &0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::CallerAllowlist, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u32, arg7: u32, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::assert_fixed_allowlist_and_sender(arg0, @0x347cba68e55b4d4733661f6fc3fa5511f7c763183c17c730dadbcd8dbabc3753, arg12);
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        assert!(0x2::balance::value<T0>(&v0) >= arg9, 1);
        assert!(0x2::balance::value<T1>(&v1) >= arg10, 2);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg3, arg6, arg7, arg12);
        let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg1, arg2, arg3, &mut v2, 0x2::balance::split<T0>(&mut v0, arg9), 0x2::balance::split<T1>(&mut v1, arg10), arg8, arg11);
        0x2::balance::join<T0>(&mut v0, v5);
        0x2::balance::join<T1>(&mut v1, v6);
        let v7 = 0x2::tx_context::sender(arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg12), v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg12), v7);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v2, v7);
    }

    public fun remove_liquidity_tracked_by_index<T0, T1>(arg0: &0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::CallerAllowlist, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::PositionRegistry, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg6: u64, arg7: u128, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::assert_fixed_allowlist_and_sender(arg0, @0x347cba68e55b4d4733661f6fc3fa5511f7c763183c17c730dadbcd8dbabc3753, arg10);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::get_positions(arg4, v0);
        let v2 = 0x1::vector::length<0x2::object::ID>(&v1);
        assert!(v2 > 0, 6);
        assert!(arg6 < v2, 7);
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg5) == *0x1::vector::borrow<0x2::object::ID>(&v1, arg6), 8);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::remove_liquidity<T0, T1>(arg1, arg2, arg3, arg5, arg7, arg8, arg9, v0, arg10);
    }

    public fun remove_liquidity_tracked_first<T0, T1>(arg0: &0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::CallerAllowlist, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::PositionRegistry, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg6: u128, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        remove_liquidity_tracked_by_index<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0, arg6, arg7, arg8, arg9);
    }

    public fun remove_liquidity_vault_first<T0, T1>(arg0: &0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::CallerAllowlist, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::PositionVault, arg5: u128, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::assert_fixed_allowlist_and_sender(arg0, @0x347cba68e55b4d4733661f6fc3fa5511f7c763183c17c730dadbcd8dbabc3753, arg8);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::has_vault_positions(arg4, v0), 9);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::remove_liquidity<T0, T1>(arg1, arg2, arg3, 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::borrow_vault_first_mut(arg4, v0), arg5, arg6, arg7, v0, arg8);
    }

    public fun remove_liquidity_vault_first_all<T0, T1>(arg0: &0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::CallerAllowlist, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::PositionVault, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::assert_fixed_allowlist_and_sender(arg0, @0x347cba68e55b4d4733661f6fc3fa5511f7c763183c17c730dadbcd8dbabc3753, arg7);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::has_vault_positions(arg4, v0), 9);
        let v1 = 0x66a394d8c15c16e0617e14ed6e25a9a640e0a2f6a771434f53d3b4ed06460c7f::position_registry::borrow_vault_first_mut(arg4, v0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::remove_liquidity<T0, T1>(arg1, arg2, arg3, v1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v1), arg5, arg6, v0, arg7);
    }

    // decompiled from Move bytecode v6
}

