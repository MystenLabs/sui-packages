module 0x5a259db4b1d17fafc09185c9a71bac36f25f9ee462e72894c8610e5a58b79f8f::movepump_router {
    public fun swap<T0>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: &0x2::clock::Clock, arg4: u64, arg5: bool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            swap_a_to_b<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        } else {
            swap_b_to_a<T0>(arg0, arg1, arg3, arg4, arg6, arg7);
        };
    }

    public fun swap_a_to_b<T0>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<0x2::sui::SUI>(arg0, arg5);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        let (v2, v3) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns<T0>(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg6), arg2, arg4, arg3, arg6);
        let v4 = v3;
        let v5 = v2;
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v4));
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        if (arg5 == 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::max_amount_in()) {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::utils::transfer_balance<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(v5), 0x2::tx_context::sender(arg6), arg6);
        } else {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
        };
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<0x2::sui::SUI, T0>(arg0, b"movepump", 0x2::object::id<0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration>(arg1), v1 - v6, 0x2::coin::value<T0>(&v4), v6);
    }

    public fun swap_b_to_a<T0>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg5), arg3, arg2, arg5);
        let v4 = v3;
        let v5 = v2;
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
        let v6 = 0x2::coin::value<T0>(&v4);
        if (arg4 == 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::max_amount_in()) {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::utils::transfer_balance<T0>(0x2::coin::into_balance<T0>(v4), 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v4));
        };
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T0, 0x2::sui::SUI>(arg0, b"movepump", 0x2::object::id<0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration>(arg1), v1 - v6, 0x2::coin::value<0x2::sui::SUI>(&v5), v6);
    }

    // decompiled from Move bytecode v6
}

