module 0xc050349cdc1355a5410b08d06db1fc58df8eca2d9ae4143f20bc164bf5018b3c::cpmm {
    public fun swap<T0, T1, T2>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg2: bool, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1, T2>(arg0, arg1, arg3, arg4, arg5);
        } else {
            swap_b2a<T0, T1, T2>(arg0, arg1, arg3, arg4, arg5);
        };
    }

    fun swap_a2b<T0, T1, T2>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<T0>(arg0, arg2);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_x_for_coin_y<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(v0, arg4), 0, arg4)));
        if (arg3) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<T0>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<T0>(arg0), arg4);
        };
    }

    fun swap_b2a<T0, T1, T2>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<T1>(arg0, arg2);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_y_for_coin_x<T0, T1, T2>(arg1, 0x2::coin::from_balance<T1>(v0, arg4), 0, arg4)));
        if (arg3) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<T1>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<T1>(arg0), arg4);
        };
    }

    // decompiled from Move bytecode v7
}

