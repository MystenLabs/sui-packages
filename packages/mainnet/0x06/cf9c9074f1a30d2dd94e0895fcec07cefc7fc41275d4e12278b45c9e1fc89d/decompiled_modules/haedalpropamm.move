module 0xfc8d838dd2c9b3bd58cd0afa753e8201a9156b22eb0a031abbb443ed1b013c8c::haedalpropamm {
    public fun swap_a2b_pro<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg3: &0x2::clock::Clock, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T0>(arg0, arg5);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<T0>(v0, arg6);
        let v3 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_base_pro<T0, T1>(arg1, arg2, arg3, arg4, &mut v2, v1, 0, arg6);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v3));
        let v4 = 0x2::coin::into_balance<T0>(v2);
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T0>(arg0, v4);
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T0, T1>(arg0, b"HAEDALPROPAMM", 0x2::object::id<0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>>(arg1), v1, 0x2::coin::value<T1>(&v3), 0);
    }

    public fun swap_a2b_pyth_core<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T0>(arg0, arg6);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<T0>(v0, arg7);
        let v3 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_base_pyth_core<T0, T1>(arg1, arg2, arg3, arg4, arg5, &mut v2, v1, 0, arg7);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v3));
        let v4 = 0x2::coin::into_balance<T0>(v2);
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T0>(arg0, v4);
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T0, T1>(arg0, b"HAEDALPROPAMM", 0x2::object::id<0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>>(arg1), v1, 0x2::coin::value<T1>(&v3), 0);
    }

    public fun swap_b2a_pro<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg3: &0x2::clock::Clock, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T1>(arg0, arg5);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<T1>(v0, arg6);
        let v3 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_quote_pro<T0, T1>(arg1, arg2, arg3, arg4, &mut v2, v1, 0, arg6);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
        let v4 = 0x2::coin::into_balance<T1>(v2);
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T1>(arg0, v4);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T1, T0>(arg0, b"HAEDALPROPAMM", 0x2::object::id<0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>>(arg1), v1, 0x2::coin::value<T0>(&v3), 0);
    }

    public fun swap_b2a_pyth_core<T0, T1>(arg0: &mut 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::SwapContext, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg2: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::take_balance<T1>(arg0, arg6);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x2::coin::from_balance<T1>(v0, arg7);
        let v3 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader::swap_exact_in_quote_pyth_core<T0, T1>(arg1, arg2, arg3, arg4, arg5, &mut v2, v1, 0, arg7);
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
        let v4 = 0x2::coin::into_balance<T1>(v2);
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::merge_balance<T1>(arg0, v4);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
        0x908d14a365b07c0576ff3d6b662df3673667da4951eaf72e9f67cba843963e84::router::emit_swap_event<T1, T0>(arg0, b"HAEDALPROPAMM", 0x2::object::id<0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>>(arg1), v1, 0x2::coin::value<T0>(&v3), 0);
    }

    // decompiled from Move bytecode v7
}

