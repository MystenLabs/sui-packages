module 0x1cfcbaeb7d8e53ca9db19b9e1fc928f16d5e35817c86b03307a4ed50e29c7517::stable_farming_strategy_add_base_coin_only {
    public(friend) fun execute_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u128, arg11: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg12: u64, arg13: vector<u8>, arg14: &mut 0x2::balance::Balance<T0>, arg15: &mut 0x2::balance::Balance<T1>, arg16: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(&arg9) == 0, 1);
        let v0 = 0;
        let v1 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg13, &mut v0);
        assert!(v0 == 0x1::vector::length<u8>(&arg13), 6);
        let v2 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min(10000, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg13, &mut v0));
        if (v1 > 0) {
            assert!(v1 <= 0x2::coin::value<T0>(&arg8), 3);
            let (v3, v4) = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::swap_exact_safe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg8, arg9, true, true, v1, arg17, arg18, arg19);
            arg9 = v4;
            arg8 = v3;
        };
        let v5 = 0x2::coin::value<T0>(&arg8);
        let v6 = 0x2::coin::value<T1>(&arg9);
        let v7 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg11);
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v7);
        let v10 = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::get_liquidity_for_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v8), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v9), v5, v6);
        assert!(v10 > 0, 4);
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v7);
        let (v12, v13) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::add_liquidity<T0, T1>(arg5, arg4, arg16, arg7, arg6, arg11, arg8, arg9, v5, v6, v10, arg18, arg19);
        let v14 = v13;
        let v15 = v12;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg11)) - v11 > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg13, &mut v0), 2);
        assert!(v5 * v2 >= 0x2::balance::value<T0>(&v15) * 10000 && v6 * v2 >= 0x2::balance::value<T1>(&v14) * 10000, 5);
        (0x2::coin::from_balance<T0>(v15, arg19), 0x2::coin::from_balance<T1>(v14, arg19))
    }

    public(friend) fun execute_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u128, arg11: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg12: u64, arg13: vector<u8>, arg14: &mut 0x2::balance::Balance<T0>, arg15: &mut 0x2::balance::Balance<T1>, arg16: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(&arg9) == 0, 1);
        let v0 = 0;
        let v1 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg13, &mut v0);
        assert!(v0 == 0x1::vector::length<u8>(&arg13), 6);
        let v2 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min(10000, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg13, &mut v0));
        if (v1 > 0) {
            assert!(v1 <= 0x2::coin::value<T0>(&arg8), 3);
            let (v3, v4) = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::swap_exact_safe_reverse<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg8, arg9, true, true, v1, arg17, arg18, arg19);
            arg9 = v4;
            arg8 = v3;
        };
        let v5 = 0x2::coin::value<T0>(&arg8);
        let v6 = 0x2::coin::value<T1>(&arg9);
        let v7 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg11);
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v7);
        let v10 = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::get_liquidity_for_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v8), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v9), v6, v5);
        assert!(v10 > 0, 4);
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v7);
        let (v12, v13) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::add_liquidity<T1, T0>(arg5, arg4, arg16, arg7, arg6, arg11, arg9, arg8, v6, v5, v10, arg18, arg19);
        let v14 = v13;
        let v15 = v12;
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(arg11)) - v11 > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg13, &mut v0), 2);
        assert!(v5 * v2 >= 0x2::balance::value<T0>(&v14) * 10000 && v6 * v2 >= 0x2::balance::value<T1>(&v15) * 10000, 5);
        (0x2::coin::from_balance<T0>(v14, arg19), 0x2::coin::from_balance<T1>(v15, arg19))
    }

    // decompiled from Move bytecode v6
}

