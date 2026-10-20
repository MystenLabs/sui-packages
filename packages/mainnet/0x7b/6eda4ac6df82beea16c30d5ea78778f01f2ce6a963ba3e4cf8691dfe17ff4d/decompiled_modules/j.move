module 0x7b6eda4ac6df82beea16c30d5ea78778f01f2ce6a963ba3e4cf8691dfe17ff4d::j {
    public fun ab<T0, T1>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg3);
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_balance_for_balance<T0, T1>(arg0, arg2, arg1, 0x2::balance::zero<T1>());
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    public fun ba<T0, T1>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg3);
        let (v0, v1) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_balance_for_balance<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), arg1);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        ab<0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3)
    }

    public fun xs<T0>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        ba<0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

