module 0xca84cb2d31245587ee527fe5b6ee6825be54b55e517d3565d78af7ae566a0c8f::cetus_clmm_strategy_withdraw_minimize_trading {
    public(friend) fun execute<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::balance::Balance<T0>, arg9: &mut 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg3) == 0, 5);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg5) >= arg4, 6);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, arg5, arg4, arg10);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v0, arg11));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v1, arg11));
        let v2 = 0x2::coin::value<T0>(&arg2);
        if (arg6 > v2) {
            let (v3, v4) = 0x392e916a31062fc503bd7144ad2e0c003d9b016b28ca1a3d23c1e3aa6ba3d361::cetus_clmm_utils::swap_exact<T0, T1>(arg0, arg1, arg2, arg3, false, false, arg6 - v2, arg10, arg11);
            arg3 = v4;
            arg2 = v3;
        };
        assert!(0x2::coin::value<T1>(&arg3) >= 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::coder::decode_u64(&mut arg7), 1);
        assert!(0x2::coin::value<T0>(&arg2) >= arg6, 7);
        (arg2, arg3)
    }

    public(friend) fun execute_reverse<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::balance::Balance<T0>, arg9: &mut 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg2) == 0, 4);
        assert!(0x2::coin::value<T1>(&arg3) == 0, 5);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg5) >= arg4, 6);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T0>(arg0, arg1, arg5, arg4, arg10);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v1, arg11));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v0, arg11));
        let v2 = 0x2::coin::value<T0>(&arg2);
        if (arg6 > v2) {
            let (v3, v4) = 0x392e916a31062fc503bd7144ad2e0c003d9b016b28ca1a3d23c1e3aa6ba3d361::cetus_clmm_utils::swap_exact_reverse<T0, T1>(arg0, arg1, arg2, arg3, false, false, arg6 - v2, arg10, arg11);
            arg3 = v4;
            arg2 = v3;
        };
        assert!(0x2::coin::value<T1>(&arg3) >= 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::coder::decode_u64(&mut arg7), 1);
        assert!(0x2::coin::value<T0>(&arg2) >= arg6, 7);
        (arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

