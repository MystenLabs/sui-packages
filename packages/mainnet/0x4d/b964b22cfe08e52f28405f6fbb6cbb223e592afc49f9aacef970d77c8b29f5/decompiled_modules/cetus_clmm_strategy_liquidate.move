module 0xdcb271ff2e80185557d651707aeaaa21f899cb8de9be9c2fb4efef9c9500f6d9::cetus_clmm_strategy_liquidate {
    public(friend) fun execute<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::balance::Balance<T0>, arg9: &mut 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg3) == 0, 5);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg5) >= arg4, 6);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, arg5, arg4, arg10);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v0, arg11));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v1, arg11));
        let v2 = 0x2::coin::value<T1>(&arg3);
        if (v2 > 0) {
            let (v3, v4) = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::swap_exact<T0, T1>(arg0, arg1, arg2, arg3, false, true, v2, arg10, arg11);
            arg3 = v4;
            arg2 = v3;
        };
        assert!(0x2::coin::value<T0>(&arg2) - arg6 >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::decode_u64(&mut arg7), 1);
        (arg2, arg3)
    }

    public(friend) fun execute_reverse<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::balance::Balance<T0>, arg9: &mut 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg3) == 0, 5);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg5) >= arg4, 6);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T0>(arg0, arg1, arg5, arg4, arg10);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v1, arg11));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v0, arg11));
        let v2 = 0x2::coin::value<T1>(&arg3);
        if (v2 > 0) {
            let (v3, v4) = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::swap_exact_reverse<T0, T1>(arg0, arg1, arg2, arg3, false, true, v2, arg10, arg11);
            arg3 = v4;
            arg2 = v3;
        };
        assert!(0x2::coin::value<T0>(&arg2) - arg6 >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::decode_u64(&mut arg7), 1);
        (arg2, arg3)
    }

    public(friend) fun execute_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg6) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg7) == 0, 5);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg9) >= arg8, 6);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg4, arg5, arg9, arg8, arg15);
        0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v0, arg16));
        0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v1, arg16));
        let v2 = 0x2::coin::value<T1>(&arg7);
        if (v2 > 0) {
            let (v3, v4) = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::swap_exact_safe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, true, v2, arg14, arg15, arg16);
            arg7 = v4;
            arg6 = v3;
        };
        assert!(0x2::coin::value<T0>(&arg6) - arg10 >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::decode_u64(&mut arg11), 1);
        (arg6, arg7)
    }

    public(friend) fun execute_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg6) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg7) == 0, 5);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg9) >= arg8, 6);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T0>(arg4, arg5, arg9, arg8, arg15);
        0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v1, arg16));
        0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v0, arg16));
        let v2 = 0x2::coin::value<T1>(&arg7);
        if (v2 > 0) {
            let (v3, v4) = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::swap_exact_safe_reverse<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, true, v2, arg14, arg15, arg16);
            arg7 = v4;
            arg6 = v3;
        };
        assert!(0x2::coin::value<T0>(&arg6) - arg10 >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::decode_u64(&mut arg11), 1);
        (arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

