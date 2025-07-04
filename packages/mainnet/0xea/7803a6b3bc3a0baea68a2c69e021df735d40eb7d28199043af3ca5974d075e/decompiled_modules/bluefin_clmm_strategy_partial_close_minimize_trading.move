module 0xea7803a6b3bc3a0baea68a2c69e021df735d40eb7d28199043af3ca5974d075e::bluefin_clmm_strategy_partial_close_minimize_trading {
    public(friend) fun execute_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg6) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg7) == 0, 5);
        let v0 = 0;
        assert!(v0 == 0x1::vector::length<u8>(&arg11), 6);
        let v1 = 0x2::math::min(arg10, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0));
        let (_, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg4, arg5, arg9, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min_u128(arg8, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg11, &mut v0)), arg15);
        0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v4, arg16));
        0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v5, arg16));
        let v6 = 0x2::coin::value<T0>(&arg6);
        if (v1 > v6) {
            let (v7, v8) = 0x19859e5539776e956f31b4e0a6fc611eca9f380846cfc1f66a1c0d84adaa52f8::bluefin_clmm_utils::swap_exact_safe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, false, v1 - v6, arg14, arg15, arg16);
            arg7 = v8;
            arg6 = v7;
        };
        assert!(0x2::coin::value<T1>(&arg7) >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0), 1);
        (arg6, arg7)
    }

    public(friend) fun execute_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg6) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg7) == 0, 5);
        let v0 = 0;
        assert!(v0 == 0x1::vector::length<u8>(&arg11), 6);
        let v1 = 0x2::math::min(arg10, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0));
        let (_, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T1, T0>(arg4, arg5, arg9, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min_u128(arg8, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg11, &mut v0)), arg15);
        0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v5, arg16));
        0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v4, arg16));
        let v6 = 0x2::coin::value<T0>(&arg6);
        if (v1 > v6) {
            let (v7, v8) = 0x19859e5539776e956f31b4e0a6fc611eca9f380846cfc1f66a1c0d84adaa52f8::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, false, v1 - v6, arg14, arg15, arg16);
            arg7 = v8;
            arg6 = v7;
        };
        assert!(0x2::coin::value<T1>(&arg7) >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0), 1);
        (arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

