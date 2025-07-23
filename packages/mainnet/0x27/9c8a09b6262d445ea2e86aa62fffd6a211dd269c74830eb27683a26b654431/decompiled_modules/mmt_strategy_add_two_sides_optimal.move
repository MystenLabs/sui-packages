module 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_add_two_sides_optimal {
    public(friend) fun execute_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::balance::Balance<T0>, arg12: &mut 0x2::balance::Balance<T1>, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0;
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg10, &mut v0);
        let v1 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_bool(&arg10, &mut v0);
        let v2 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg10, &mut v0);
        assert!(v0 == 0x1::vector::length<u8>(&arg10), 6);
        let v3 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min(10000, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg10, &mut v0));
        if (v2 > 0) {
            let v4 = if (v1) {
                0x2::coin::value<T0>(&arg5)
            } else {
                0x2::coin::value<T1>(&arg6)
            };
            assert!(v2 <= v4, 3);
            let (v5, v6) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v1, true, v2, arg13, arg14, arg15, arg16);
            arg6 = v6;
            arg5 = v5;
        };
        let v7 = 0x2::coin::value<T0>(&arg5);
        let v8 = 0x2::coin::value<T1>(&arg6);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amounts(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg4), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(arg8)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(arg8)), v7, v8) > 0, 4);
        let (v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg4, arg8, arg5, arg6, 0x2::balance::value<T0>(arg11), 0x2::balance::value<T1>(arg12), arg15, arg14, arg16);
        let v11 = v10;
        let v12 = v9;
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg8) - 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg8) > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg10, &mut v0), 2);
        assert!(v7 * v3 >= 0x2::coin::value<T0>(&v12) * 10000 && v8 * v3 >= 0x2::coin::value<T1>(&v11) * 10000, 5);
        (v12, v11)
    }

    public(friend) fun execute_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::balance::Balance<T0>, arg12: &mut 0x2::balance::Balance<T1>, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0;
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg10, &mut v0);
        let v1 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_bool(&arg10, &mut v0);
        let v2 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg10, &mut v0);
        assert!(v0 == 0x1::vector::length<u8>(&arg10), 6);
        let v3 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min(10000, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg10, &mut v0));
        if (v2 > 0) {
            let v4 = if (v1) {
                0x2::coin::value<T0>(&arg5)
            } else {
                0x2::coin::value<T1>(&arg6)
            };
            assert!(v2 <= v4, 3);
            let (v5, v6) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v1, true, v2, arg13, arg14, arg15, arg16);
            arg6 = v6;
            arg5 = v5;
        };
        let v7 = 0x2::coin::value<T0>(&arg5);
        let v8 = 0x2::coin::value<T1>(&arg6);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amounts(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T1, T0>(arg4), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(arg8)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(arg8)), v8, v7) > 0, 4);
        let (v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T1, T0>(arg4, arg8, arg6, arg5, 0x2::balance::value<T1>(arg12), 0x2::balance::value<T0>(arg11), arg15, arg14, arg16);
        let v11 = v10;
        let v12 = v9;
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg8) - 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg8) > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg10, &mut v0), 2);
        assert!(v7 * v3 >= 0x2::coin::value<T0>(&v11) * 10000 && v8 * v3 >= 0x2::coin::value<T1>(&v12) * 10000, 5);
        (v11, v12)
    }

    // decompiled from Move bytecode v6
}

