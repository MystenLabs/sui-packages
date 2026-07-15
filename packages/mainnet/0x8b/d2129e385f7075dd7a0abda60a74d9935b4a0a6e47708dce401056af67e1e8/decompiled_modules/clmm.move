module 0x8bd2129e385f7075dd7a0abda60a74d9935b4a0a6e47708dce401056af67e1e8::clmm {
    public fun swap<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg2: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg3: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg2: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg3: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<T0>(arg0, arg4);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::trade::swap_returns<T0, T1>(arg1, arg2, arg3, 0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::zero<T1>(arg6), true, true, 4295048016, arg6);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        if (arg5) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<T0>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<T0>(arg0), arg6);
        };
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg2: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg3: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<T1>(arg0, arg4);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v1, v2) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::trade::swap_returns<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<T0>(arg6), 0x2::coin::from_balance<T1>(v0, arg6), false, true, 79226673515401279992447579055, arg6);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        if (arg5) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<T1>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<T1>(arg0), arg6);
        };
    }

    // decompiled from Move bytecode v7
}

