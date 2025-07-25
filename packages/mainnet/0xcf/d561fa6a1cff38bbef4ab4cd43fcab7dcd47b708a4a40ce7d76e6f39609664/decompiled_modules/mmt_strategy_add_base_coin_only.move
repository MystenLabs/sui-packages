module 0xcfd561fa6a1cff38bbef4ab4cd43fcab7dcd47b708a4a40ce7d76e6f39609664::mmt_strategy_add_base_coin_only {
    public(friend) fun execute_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::global_config::GlobalConfig, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(&arg7) == 0, 1);
        let v0 = 0;
        let v1 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0);
        assert!(v0 == 0x1::vector::length<u8>(&arg11), 6);
        let v2 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min(10000, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0));
        if (v1 > 0) {
            assert!(v1 <= 0x2::coin::value<T0>(&arg6), 3);
            let (v3, v4) = 0x741703e69a6ecc16b94b7d5d876df9f0891ba2ea8159e041106228b80756b9f4::mmt_utils::swap_exact_safe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, true, true, v1, arg14, arg15, arg16, arg17);
            arg7 = v4;
            arg6 = v3;
        };
        let v5 = 0x2::coin::value<T0>(&arg6);
        let v6 = 0x2::coin::value<T1>(&arg7);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amounts(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg5), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(arg9)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(arg9)), v5, v6) > 0, 4);
        let (v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg5, arg9, arg6, arg7, 0x2::balance::value<T0>(arg12), 0x2::balance::value<T1>(arg13), arg16, arg15, arg17);
        let v9 = v8;
        let v10 = v7;
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg9) - 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg9) > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg11, &mut v0), 2);
        assert!(v5 * v2 >= 0x2::coin::value<T0>(&v10) * 10000 && v6 * v2 >= 0x2::coin::value<T1>(&v9) * 10000, 5);
        (v10, v9)
    }

    public(friend) fun execute_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::global_config::GlobalConfig, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(&arg7) == 0, 1);
        let v0 = 0;
        let v1 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0);
        assert!(v0 == 0x1::vector::length<u8>(&arg11), 6);
        let v2 = 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min(10000, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0));
        if (v1 > 0) {
            assert!(v1 <= 0x2::coin::value<T0>(&arg6), 3);
            let (v3, v4) = 0x741703e69a6ecc16b94b7d5d876df9f0891ba2ea8159e041106228b80756b9f4::mmt_utils::swap_exact_safe_reverse<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, true, true, v1, arg14, arg15, arg16, arg17);
            arg7 = v4;
            arg6 = v3;
        };
        let v5 = 0x2::coin::value<T0>(&arg6);
        let v6 = 0x2::coin::value<T1>(&arg7);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amounts(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T1, T0>(arg5), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(arg9)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(arg9)), v6, v5) > 0, 4);
        let (v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T1, T0>(arg5, arg9, arg7, arg6, 0x2::balance::value<T1>(arg13), 0x2::balance::value<T0>(arg12), arg16, arg15, arg17);
        let v9 = v8;
        let v10 = v7;
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg9) - 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg9) > 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg11, &mut v0), 2);
        assert!(v5 * v2 >= 0x2::coin::value<T0>(&v9) * 10000 && v6 * v2 >= 0x2::coin::value<T1>(&v10) * 10000, 5);
        (v9, v10)
    }

    // decompiled from Move bytecode v6
}

