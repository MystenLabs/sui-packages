module 0x339c82d1e720986efee37b42e907f79cf73a4e347e83a8af4e5a240f71d4515a::prop_amm {
    public fun swap<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: &0x2::clock::Clock, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<T0>(arg0, arg5);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<T0>(v0, arg8);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_base_pyth_core<T0, T1>(arg1, arg2, arg6, arg3, arg4, &mut v2, v1, 0, arg8)));
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        if (arg7) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<T0>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<T0>(arg0), arg8);
        };
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: &0x2::clock::Clock, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<T1>(arg0, arg5);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<T1>(v0, arg8);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_quote_pyth_core<T0, T1>(arg1, arg2, arg6, arg3, arg4, &mut v2, v1, 0, arg8)));
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        if (arg7) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<T1>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<T1>(arg0), arg8);
        };
    }

    // decompiled from Move bytecode v7
}

