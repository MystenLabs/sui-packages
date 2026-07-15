module 0x6b1c18f037b27194f068c7bc266366aa5d6f895125073d2dea7d81d05c64f94e::bonding_curve {
    public fun swap<T0>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::ThresholdConfig, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &0x2::clock::Clock, arg5: bool, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            swap_a2b<T0>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        } else {
            swap_b2a<T0>(arg0, arg1, arg4, arg6, arg7, arg8);
        };
    }

    fun swap_a2b<T0>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::ThresholdConfig, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &0x2::clock::Clock, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<0x2::sui::SUI>(arg0, arg5);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        let (_, v3) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::estimate_amount_out<T0>(arg1, v1, 0);
        let (v4, v5) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns_v2<T0>(arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg7), arg3, v3, arg4, arg7);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v5));
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v4));
        if (arg6) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<0x2::sui::SUI>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<0x2::sui::SUI>(arg0), arg7);
        };
    }

    fun swap_b2a<T0>(arg0: &mut 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::SwapContext, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_balance<T0>(arg0, arg3);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v1, v2) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg1, 0x2::coin::from_balance<T0>(v0, arg5), 0, arg2, arg5);
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
        0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        if (arg4) {
            0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::transfer_remaining_balance<T0>(arg0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::router::take_all_balance<T0>(arg0), arg5);
        };
    }

    // decompiled from Move bytecode v7
}

