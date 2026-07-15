module 0x6beaf3c3c00b157853c9205bb44198abfeecb7b774d975c63895b40e2ee0a661::cpmm {
    public fun swap<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<T0>(arg0, arg3);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_balance_for_balance<T0, T1>(arg1, arg2, v0, 0x2::balance::zero<T1>());
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T1>(arg0, v2);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, v1);
        if (arg4) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<T0>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<T0>(arg0), arg5);
        };
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<T1>(arg0, arg3);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_balance_for_balance<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v0);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, v1);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T1>(arg0, v2);
        if (arg4) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<T1>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<T1>(arg0), arg5);
        };
    }

    // decompiled from Move bytecode v7
}

