module 0xf5c7dae97437e7e4fc65bcfd71f9a25f759a0325e8cf0928d8373193c10eb18c::legacy_v2_execution {
    public fun maybe_anime_x_to_y<T0, T1>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg2), 0x2::coin::zero<T1>(arg3), arg3);
        0x2::coin::destroy_zero<T0>(v0);
        0x1::option::some<0x2::coin::Coin<T1>>(v1)
    }

    public fun maybe_anime_y_to_x<T0, T1>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<0x2::coin::Coin<T1>>, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg2)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg2);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg0, arg1, 0x2::coin::zero<T0>(arg3), 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg2), arg3);
        0x2::coin::destroy_zero<T1>(v1);
        0x1::option::some<0x2::coin::Coin<T0>>(v0)
    }

    // decompiled from Move bytecode v7
}

