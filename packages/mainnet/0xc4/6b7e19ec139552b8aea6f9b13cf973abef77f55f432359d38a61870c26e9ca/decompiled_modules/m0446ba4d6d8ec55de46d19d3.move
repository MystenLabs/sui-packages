module 0xc46b7e19ec139552b8aea6f9b13cf973abef77f55f432359d38a61870c26e9ca::m0446ba4d6d8ec55de46d19d3 {
    public fun f5a6a3c65d6534668f5fca386<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_quote_pyth_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun f761f6b8cd1f8207b117c60dd<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_base_pyth_core_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun f7f559f6d4498b9ec5bee71d1<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_base_pyth_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun fb95b6e40ebd195d8292a6948<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_quote_pyth_core_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v7
}

