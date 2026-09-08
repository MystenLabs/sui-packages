module 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::legacy_v2_adapters {
    public fun anime<T0, T1>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools) : 0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::Hop {
        let (v0, _, _, _) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_admin_data(arg0);
        if (0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap_library::compare<T0, T1>()) {
            let (v5, _) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_pool<T0, T1>(arg0);
            let (v7, v8) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_reserves_size<T0, T1>(v5);
            0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::v2_hop((v7 as u128), (v8 as u128), v0, 10000)
        } else {
            let (v9, _) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_pool<T1, T0>(arg0);
            let (v11, v12) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_reserves_size<T1, T0>(v9);
            0xf2302893d6228112911ec19f3f2877921ac209fd0d1de625815bbf26b2e4757e::optimizer::v2_hop((v12 as u128), (v11 as u128), v0, 10000)
        }
    }

    // decompiled from Move bytecode v7
}

