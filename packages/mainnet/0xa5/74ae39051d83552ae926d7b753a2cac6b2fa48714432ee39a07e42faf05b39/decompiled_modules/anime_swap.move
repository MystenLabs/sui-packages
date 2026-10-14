module 0xa574ae39051d83552ae926d7b753a2cac6b2fa48714432ee39a07e42faf05b39::anime_swap {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(arg1, arg3), 0x2::coin::zero<T1>(arg3), arg3);
        let v2 = v0;
        assert!(0x2::coin::value<T0>(&v2) == 0, 1);
        0x2::coin::destroy_zero<T0>(v2);
        0x2::coin::into_balance<T1>(v1)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg0, arg2, 0x2::coin::zero<T0>(arg3), 0x2::coin::from_balance<T1>(arg1, arg3), arg3);
        let v2 = v1;
        assert!(0x2::coin::value<T1>(&v2) == 0, 1);
        0x2::coin::destroy_zero<T1>(v2);
        0x2::coin::into_balance<T0>(v0)
    }

    // decompiled from Move bytecode v7
}

