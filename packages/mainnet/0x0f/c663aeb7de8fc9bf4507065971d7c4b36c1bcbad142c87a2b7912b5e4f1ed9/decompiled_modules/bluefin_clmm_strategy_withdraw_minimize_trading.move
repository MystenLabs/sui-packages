module 0xa536ee4488c7b4ce968d94925928b88df3d3fa0e01a134a285c1e00c830fd985::bluefin_clmm_strategy_withdraw_minimize_trading {
    public(friend) fun execute_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg6) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg7) == 0, 5);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg9) >= arg8, 6);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg4, arg5, arg9, arg8, arg15);
        0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v2, arg16));
        0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v3, arg16));
        let v4 = 0x2::coin::value<T0>(&arg6);
        if (arg10 > v4) {
            let (v5, v6) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, false, arg10 - v4, arg14, arg15, arg16);
            arg7 = v6;
            arg6 = v5;
        };
        assert!(0x2::coin::value<T1>(&arg7) >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::decode_u64(&mut arg11), 1);
        assert!(0x2::coin::value<T0>(&arg6) >= arg10, 7);
        (arg6, arg7)
    }

    public(friend) fun execute_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg6) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg7) == 0, 5);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg9) >= arg8, 6);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T1, T0>(arg4, arg5, arg9, arg8, arg15);
        0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v3, arg16));
        0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v2, arg16));
        let v4 = 0x2::coin::value<T0>(&arg6);
        if (arg10 > v4) {
            let (v5, v6) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, false, arg10 - v4, arg14, arg15, arg16);
            arg7 = v6;
            arg6 = v5;
        };
        assert!(0x2::coin::value<T1>(&arg7) >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::decode_u64(&mut arg11), 1);
        assert!(0x2::coin::value<T0>(&arg6) >= arg10, 7);
        (arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

