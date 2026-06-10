module 0xaf452a52bdbe6fa827f838187bf5c1d3eb4d4ffc88a13edf5098b0b6ab527961::cpmm {
    public fun swap<T0, T1>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::take_balance<T0>(arg0, arg3);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_balance_for_balance<T0, T1>(arg1, arg2, v0, 0x2::balance::zero<T1>());
        0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<T1>(arg0, v2);
        if (arg3 == 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::max_amount_in()) {
            0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::transfer_remaining_balance<T0>(arg0, v1, arg4);
        } else {
            0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<T0>(arg0, v1);
        };
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::take_balance<T1>(arg0, arg3);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_balance_for_balance<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), v0);
        0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<T0>(arg0, v1);
        if (arg3 == 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::max_amount_in()) {
            0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::transfer_remaining_balance<T1>(arg0, v2, arg4);
        } else {
            0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<T1>(arg0, v2);
        };
    }

    // decompiled from Move bytecode v7
}

