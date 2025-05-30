module 0x6665ad06bb0c47a00e3ce6da9c796f8061b9f8178095e421ce36e3f73345f24a::cetus_clmm_strategy_partial_close_liquidate {
    public(friend) fun execute<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::balance::Balance<T0>, arg9: &mut 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg3) == 0, 5);
        let v0 = 0;
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, arg5, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min_u128(arg4, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg7, &mut v0)), arg10);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v1, arg11));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v2, arg11));
        let v3 = 0x2::coin::value<T1>(&arg3);
        if (v3 > 0) {
            let (v4, v5) = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::swap_exact<T0, T1>(arg0, arg1, arg2, arg3, false, true, v3, arg10, arg11);
            arg3 = v5;
            arg2 = v4;
        };
        assert!(0x2::coin::value<T0>(&arg2) - 0x2::math::min(arg6, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg7, &mut v0)) >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg7, &mut v0), 1);
        (arg2, arg3)
    }

    public(friend) fun execute_reverse<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::balance::Balance<T0>, arg9: &mut 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg3) == 0, 5);
        let v0 = 0;
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T0>(arg0, arg1, arg5, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min_u128(arg4, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg7, &mut v0)), arg10);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v2, arg11));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v1, arg11));
        let v3 = 0x2::coin::value<T1>(&arg3);
        if (v3 > 0) {
            let (v4, v5) = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::swap_exact_reverse<T0, T1>(arg0, arg1, arg2, arg3, false, true, v3, arg10, arg11);
            arg3 = v5;
            arg2 = v4;
        };
        assert!(0x2::coin::value<T0>(&arg2) - 0x2::math::min(arg6, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg7, &mut v0)) >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg7, &mut v0), 1);
        (arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

