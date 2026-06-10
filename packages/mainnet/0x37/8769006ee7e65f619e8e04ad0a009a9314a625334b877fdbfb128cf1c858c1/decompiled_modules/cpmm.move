module 0x378769006ee7e65f619e8e04ad0a009a9314a625334b877fdbfb128cf1c858c1::cpmm {
    public fun swap<T0, T1, T2>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1, T2>(arg0, arg1, arg3, arg4);
        } else {
            swap_b2a<T0, T1, T2>(arg0, arg1, arg3, arg4);
        };
    }

    fun swap_a2b<T0, T1, T2>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::take_balance<T0>(arg0, arg2);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_x_for_coin_y<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(v0, arg3), 0, arg3)));
    }

    fun swap_b2a<T0, T1, T2>(arg0: &mut 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::SwapContext, arg1: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::take_balance<T1>(arg0, arg2);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        0x27f0a2dd036967aed0ffc395ce040b3f2a84b6e56b466500af3670aaf99c3ec4::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_y_for_coin_x<T0, T1, T2>(arg1, 0x2::coin::from_balance<T1>(v0, arg3), 0, arg3)));
    }

    // decompiled from Move bytecode v7
}

