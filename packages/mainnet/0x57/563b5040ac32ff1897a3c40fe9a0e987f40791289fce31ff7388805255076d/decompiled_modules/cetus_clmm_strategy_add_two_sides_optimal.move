module 0x57563b5040ac32ff1897a3c40fe9a0e987f40791289fce31ff7388805255076d::cetus_clmm_strategy_add_two_sides_optimal {
    public(friend) fun execute<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::balance::Balance<T0>, arg9: &mut 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0;
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg7, &mut v0);
        let v1 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_bool(&arg7, &mut v0);
        let v2 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg7, &mut v0);
        assert!(v0 == 0x1::vector::length<u8>(&arg7), 6);
        let v3 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min(1000, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg7, &mut v0));
        if (v2 > 0) {
            let v4 = if (v1) {
                0x2::coin::value<T0>(&arg2)
            } else {
                0x2::coin::value<T1>(&arg3)
            };
            assert!(v2 <= v4, 3);
            let (v5, v6) = 0x8e165e19449d61c45514ee07958a81ef257005f4edaf2b6020f5864b4da4fa54::cetus_clmm_utils::swap_exact<T0, T1>(arg0, arg1, arg2, arg3, v1, true, v2, arg10, arg11);
            arg3 = v6;
            arg2 = v5;
        };
        let v7 = 0x2::coin::value<T0>(&arg2);
        let v8 = 0x2::coin::value<T1>(&arg3);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg5);
        let v11 = 0x8e165e19449d61c45514ee07958a81ef257005f4edaf2b6020f5864b4da4fa54::cetus_clmm_utils::get_liquidity_for_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v9), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v10), v7, v8);
        assert!(v11 > 0, 4);
        0x8e165e19449d61c45514ee07958a81ef257005f4edaf2b6020f5864b4da4fa54::cetus_clmm_utils::add_liquidity<T0, T1>(arg0, arg1, arg5, &mut arg2, &mut arg3, v11, arg10, arg11);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg5) - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg5) > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg7, &mut v0), 2);
        assert!(v7 * v3 >= 0x2::coin::value<T0>(&arg2) * 10000 && v8 * v3 >= 0x2::coin::value<T1>(&arg3) * 10000, 5);
        (arg2, arg3)
    }

    public(friend) fun execute_reverse<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::balance::Balance<T0>, arg9: &mut 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0;
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg7, &mut v0);
        let v1 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_bool(&arg7, &mut v0);
        let v2 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg7, &mut v0);
        assert!(v0 == 0x1::vector::length<u8>(&arg7), 6);
        let v3 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min(1000, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg7, &mut v0));
        if (v2 > 0) {
            let v4 = if (v1) {
                0x2::coin::value<T0>(&arg2)
            } else {
                0x2::coin::value<T1>(&arg3)
            };
            assert!(v2 <= v4, 3);
            let (v5, v6) = 0x8e165e19449d61c45514ee07958a81ef257005f4edaf2b6020f5864b4da4fa54::cetus_clmm_utils::swap_exact_reverse<T0, T1>(arg0, arg1, arg2, arg3, v1, true, v2, arg10, arg11);
            arg3 = v6;
            arg2 = v5;
        };
        let v7 = 0x2::coin::value<T0>(&arg2);
        let v8 = 0x2::coin::value<T1>(&arg3);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg5);
        let v11 = 0x8e165e19449d61c45514ee07958a81ef257005f4edaf2b6020f5864b4da4fa54::cetus_clmm_utils::get_liquidity_for_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v9), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v10), v8, v7);
        assert!(v11 > 0, 4);
        0x8e165e19449d61c45514ee07958a81ef257005f4edaf2b6020f5864b4da4fa54::cetus_clmm_utils::add_liquidity_reverse<T0, T1>(arg0, arg1, arg5, &mut arg2, &mut arg3, v11, arg10, arg11);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg5) - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg5) > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg7, &mut v0), 2);
        assert!(v7 * v3 >= 0x2::coin::value<T0>(&arg2) * 10000 && v8 * v3 >= 0x2::coin::value<T1>(&arg3) * 10000, 5);
        (arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

