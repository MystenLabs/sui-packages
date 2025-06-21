module 0x58280a47c88b3b6d8c8c23546a8602a9569e31d4c139b6370847a6a807883614::cetus_clmm_strategy_add_two_sides_optimal {
    public(friend) fun execute_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
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
            let (v5, v6) = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::swap_exact_safe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v1, true, v2, arg14, arg15, arg16);
            arg7 = v6;
            arg6 = v5;
        };
        let v7 = 0x2::coin::value<T0>(&arg6);
        let v8 = 0x2::coin::value<T1>(&arg7);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg9);
        let v11 = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::get_liquidity_for_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v9), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v10), v7, v8);
        assert!(v11 > 0, 4);
        0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::add_liquidity<T0, T1>(arg4, arg5, arg9, &mut arg6, &mut arg7, v11, arg15, arg16);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg9) - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg9) > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg11, &mut v0), 2);
        assert!(v7 * v3 >= 0x2::coin::value<T0>(&arg6) * 10000 && v8 * v3 >= 0x2::coin::value<T1>(&arg7) * 10000, 5);
        (arg6, arg7)
    }

    public(friend) fun execute_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
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
            let (v5, v6) = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::swap_exact_safe_reverse<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v1, true, v2, arg14, arg15, arg16);
            arg7 = v6;
            arg6 = v5;
        };
        let v7 = 0x2::coin::value<T0>(&arg6);
        let v8 = 0x2::coin::value<T1>(&arg7);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg9);
        let v11 = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::get_liquidity_for_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg5), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v9), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v10), v8, v7);
        assert!(v11 > 0, 4);
        0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::add_liquidity_reverse<T0, T1>(arg4, arg5, arg9, &mut arg6, &mut arg7, v11, arg15, arg16);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg9) - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg9) > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg11, &mut v0), 2);
        assert!(v7 * v3 >= 0x2::coin::value<T0>(&arg6) * 10000 && v8 * v3 >= 0x2::coin::value<T1>(&arg7) * 10000, 5);
        (arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

