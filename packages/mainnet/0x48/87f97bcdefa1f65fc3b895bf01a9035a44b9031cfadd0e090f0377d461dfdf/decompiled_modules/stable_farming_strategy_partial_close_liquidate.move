module 0x4887f97bcdefa1f65fc3b895bf01a9035a44b9031cfadd0e090f0377d461dfdf::stable_farming_strategy_partial_close_liquidate {
    public(friend) fun execute_safe<T0, T1>(arg0: &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: address, arg2: u8, arg3: u8, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u128, arg11: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT, arg12: u64, arg13: vector<u8>, arg14: &mut 0x2::balance::Balance<T0>, arg15: &mut 0x2::balance::Balance<T1>, arg16: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg8) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg9) == 0, 5);
        let v0 = 0;
        let (v1, v2) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::remove_liquidity<T0, T1>(arg5, arg4, arg16, arg7, arg6, arg11, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::mole_math::min_u128(arg10, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u128(&arg13, &mut v0)), 0, 0, arg18);
        0x2::coin::join<T0>(&mut arg8, 0x2::coin::from_balance<T0>(v1, arg19));
        0x2::coin::join<T1>(&mut arg9, 0x2::coin::from_balance<T1>(v2, arg19));
        let v3 = 0x2::coin::value<T1>(&arg9);
        if (v3 > 0) {
            let (v4, v5) = 0xb40b95dfee63de4d308b5b3118d1f127950d15184cad3ee762bba7594f26dd40::cetus_clmm_utils::swap_exact_safe<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg8, arg9, false, true, v3, arg17, arg18, arg19);
            arg9 = v5;
            arg8 = v4;
        };
        assert!(0x2::coin::value<T0>(&arg8) - 0x2::math::min(arg12, 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg13, &mut v0)) >= 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coder::parse_u64(&arg13, &mut v0), 1);
        (arg8, arg9)
    }

    // decompiled from Move bytecode v6
}

