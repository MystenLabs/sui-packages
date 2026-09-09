module 0x8df091488699ed7350989e3b149ada06c0474bebc32f21c157ace955c3f6fdcf::reader {
    public fun current<T0, T1>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools) : (u128, u128, u64, u64) {
        let (v0, _, _, _) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_admin_data(arg0);
        let (v4, v5, v6) = if (0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap_library::compare<T0, T1>()) {
            let (v7, _) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_pool<T0, T1>(arg0);
            let (v9, v10) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_reserves_size<T0, T1>(v7);
            ((v9 as u128), (v10 as u128), 10000)
        } else {
            let (v11, _) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_pool<T1, T0>(arg0);
            let (v13, v14) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_reserves_size<T1, T0>(v11);
            ((v14 as u128), (v13 as u128), 10000)
        };
        (v4, v5, v0, v6)
    }

    // decompiled from Move bytecode v7
}

