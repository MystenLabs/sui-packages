module 0xcfd561fa6a1cff38bbef4ab4cd43fcab7dcd47b708a4a40ce7d76e6f39609664::mmt_strategy_partial_close_liquidate {
    public(friend) fun execute_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::global_config::GlobalConfig, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg6) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg7) == 0, 5);
        let v0 = 0;
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg5, arg9, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min_u128(arg8, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg11, &mut v0)), 0x2::balance::value<T0>(arg12), 0x2::balance::value<T1>(arg13), arg16, arg15, arg17);
        0x2::coin::join<T0>(&mut arg6, v1);
        0x2::coin::join<T1>(&mut arg7, v2);
        let v3 = 0x2::coin::value<T1>(&arg7);
        if (v3 > 0) {
            let (v4, v5) = 0x741703e69a6ecc16b94b7d5d876df9f0891ba2ea8159e041106228b80756b9f4::mmt_utils::swap_exact_safe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, true, v3, arg14, arg15, arg16, arg17);
            arg7 = v5;
            arg6 = v4;
        };
        assert!(0x2::coin::value<T0>(&arg6) - 0x2::math::min(arg10, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0)) >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0), 1);
        (arg6, arg7)
    }

    public(friend) fun execute_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::global_config::GlobalConfig, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::balance::Balance<T0>, arg13: &mut 0x2::balance::Balance<T1>, arg14: u64, arg15: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg6) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg7) == 0, 5);
        let v0 = 0;
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T1, T0>(arg5, arg9, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min_u128(arg8, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg11, &mut v0)), 0x2::balance::value<T1>(arg13), 0x2::balance::value<T0>(arg12), arg16, arg15, arg17);
        0x2::coin::join<T0>(&mut arg6, v2);
        0x2::coin::join<T1>(&mut arg7, v1);
        let v3 = 0x2::coin::value<T1>(&arg7);
        if (v3 > 0) {
            let (v4, v5) = 0x741703e69a6ecc16b94b7d5d876df9f0891ba2ea8159e041106228b80756b9f4::mmt_utils::swap_exact_safe_reverse<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false, true, v3, arg14, arg15, arg16, arg17);
            arg7 = v5;
            arg6 = v4;
        };
        assert!(0x2::coin::value<T0>(&arg6) - 0x2::math::min(arg10, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0)) >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg11, &mut v0), 1);
        (arg6, arg7)
    }

    // decompiled from Move bytecode v6
}

