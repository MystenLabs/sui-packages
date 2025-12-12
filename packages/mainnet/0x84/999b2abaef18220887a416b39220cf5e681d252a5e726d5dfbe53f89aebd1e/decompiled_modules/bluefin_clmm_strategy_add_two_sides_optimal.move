module 0x49edcb8c45b9a1f5de8d3a7bce497828a52ed05f643acae2488e02a7696dd3f6::bluefin_clmm_strategy_add_two_sides_optimal {
    public(friend) fun execute_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0;
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0);
        let v1 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_bool(&arg11, &mut v0);
        let v2 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0);
        assert!(v0 == 0x1::vector::length<u8>(&arg11), 6);
        let v3 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min(10000, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0));
        if (v2 > 0) {
            let v4 = if (v1) {
                0x2::coin::value<T0>(&arg6)
            } else {
                0x2::coin::value<T1>(&arg7)
            };
            assert!(v2 <= v4, 3);
            let (v5, v6) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v1, true, v2, arg14, arg15, arg16);
            arg7 = v6;
            arg6 = v5;
        };
        let v7 = 0x2::coin::value<T0>(&arg6);
        let v8 = 0x2::coin::value<T1>(&arg7);
        let v9 = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::get_liquidity_for_amounts(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg9)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg9)), v7, v8);
        assert!(v9 > 0, 4);
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg15, arg4, arg5, arg9, 0x2::coin::into_balance<T0>(arg6), 0x2::coin::into_balance<T1>(arg7), v9);
        let v14 = v13;
        let v15 = v12;
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg9) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg9) > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg11, &mut v0), 2);
        assert!(v7 * v3 >= 0x2::balance::value<T0>(&v15) * 10000 && v8 * v3 >= 0x2::balance::value<T1>(&v14) * 10000, 5);
        (0x2::coin::from_balance<T0>(v15, arg16), 0x2::coin::from_balance<T1>(v14, arg16))
    }

    public(friend) fun execute_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0;
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0);
        let v1 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_bool(&arg11, &mut v0);
        let v2 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0);
        assert!(v0 == 0x1::vector::length<u8>(&arg11), 6);
        let v3 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min(10000, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0));
        if (v2 > 0) {
            let v4 = if (v1) {
                0x2::coin::value<T0>(&arg6)
            } else {
                0x2::coin::value<T1>(&arg7)
            };
            assert!(v2 <= v4, 3);
            let (v5, v6) = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::swap_exact_safe_reverse<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v1, true, v2, arg14, arg15, arg16);
            arg7 = v6;
            arg6 = v5;
        };
        let v7 = 0x2::coin::value<T0>(&arg6);
        let v8 = 0x2::coin::value<T1>(&arg7);
        let v9 = 0x87a5e0ad2f534245971542090137a368879938c10beabb175d8eb602c5582477::bluefin_clmm_utils::get_liquidity_for_amounts(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg9)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg9)), v8, v7);
        assert!(v9 > 0, 4);
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T1, T0>(arg15, arg4, arg5, arg9, 0x2::coin::into_balance<T1>(arg7), 0x2::coin::into_balance<T0>(arg6), v9);
        let v14 = v13;
        let v15 = v12;
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg9) - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg9) > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg11, &mut v0), 2);
        assert!(v7 * v3 >= 0x2::balance::value<T0>(&v14) * 10000 && v8 * v3 >= 0x2::balance::value<T1>(&v15) * 10000, 5);
        (0x2::coin::from_balance<T0>(v14, arg16), 0x2::coin::from_balance<T1>(v15, arg16))
    }

    // decompiled from Move bytecode v6
}

