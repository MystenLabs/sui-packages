module 0x1097af71793b72d62a5daeea9d9bb6df21a17c93ed25397894cc523424f6b82c::me7ad3cc18e6a3fdef2f5f480 {
    public fun f00a1eacb8be2fa6d4abcbcbf<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_base_pyth_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun f58cdb1809f16621bde392340<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_quote_pyth_core_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun f6bbff8422c4d026dd3ec887b<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_quote_pyth_core<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun ff75d3201bc0af37da79b8357<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_base_pyth_core_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v7
}

