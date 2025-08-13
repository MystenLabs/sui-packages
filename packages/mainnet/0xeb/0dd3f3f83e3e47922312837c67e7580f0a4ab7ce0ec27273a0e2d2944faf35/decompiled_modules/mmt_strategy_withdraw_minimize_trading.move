module 0x279c8a09b6262d445ea2e86aa62fffd6a211dd269c74830eb27683a26b654431::mmt_strategy_withdraw_minimize_trading {
    public(friend) fun execute_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::balance::Balance<T0>, arg12: &mut 0x2::balance::Balance<T1>, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg5) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg6) == 0, 5);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg8) >= arg7, 6);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg4, arg8, arg7, 0x2::balance::value<T0>(arg11), 0x2::balance::value<T1>(arg12), arg15, arg14, arg16);
        0x2::coin::join<T0>(&mut arg5, v0);
        0x2::coin::join<T1>(&mut arg6, v1);
        let v2 = 0x2::coin::value<T0>(&arg5);
        if (arg9 > v2) {
            let (v3, v4) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, false, arg9 - v2, arg13, arg14, arg15, arg16);
            arg6 = v4;
            arg5 = v3;
        };
        assert!(0x2::coin::value<T1>(&arg6) >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::decode_u64(&mut arg10), 1);
        assert!(0x2::coin::value<T0>(&arg5) >= arg9, 7);
        (arg5, arg6)
    }

    public(friend) fun execute_safe_reverse<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::balance::Balance<T0>, arg12: &mut 0x2::balance::Balance<T1>, arg13: u64, arg14: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg5) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg6) == 0, 5);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg8) >= arg7, 6);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T1, T0>(arg4, arg8, arg7, 0x2::balance::value<T1>(arg12), 0x2::balance::value<T0>(arg11), arg15, arg14, arg16);
        0x2::coin::join<T0>(&mut arg5, v1);
        0x2::coin::join<T1>(&mut arg6, v0);
        let v2 = 0x2::coin::value<T0>(&arg5);
        if (arg9 > v2) {
            let (v3, v4) = 0xf66b6e6e045b5453186744a20bb7a8d2f526e95adfb60080f78423809b3ac4f8::mmt_utils::swap_exact_safe_reverse<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, false, arg9 - v2, arg13, arg14, arg15, arg16);
            arg6 = v4;
            arg5 = v3;
        };
        assert!(0x2::coin::value<T1>(&arg6) >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::decode_u64(&mut arg10), 1);
        assert!(0x2::coin::value<T0>(&arg5) >= arg9, 7);
        (arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

