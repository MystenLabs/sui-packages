module 0x6499785bb7d6f2e5f6abd195ed014d4a3969626b6fcb06ecfb2c92242f96c42::movepump {
    public fun move_pump_swap<T0>(arg0: &mut 0x6499785bb7d6f2e5f6abd195ed014d4a3969626b6fcb06ecfb2c92242f96c42::bot::KongBot<0x2::sui::SUI>, arg1: &mut 0x6499785bb7d6f2e5f6abd195ed014d4a3969626b6fcb06ecfb2c92242f96c42::bot::Banana<0x2::sui::SUI>, arg2: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x6499785bb7d6f2e5f6abd195ed014d4a3969626b6fcb06ecfb2c92242f96c42::bot::transfer_bananas<0x2::sui::SUI>(arg0, arg1, arg3, arg7);
        0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy<T0>(arg2, v1, arg4, arg5, arg6, arg7);
    }

    public fun move_pump_swap_sell<T0>(arg0: &mut 0x6499785bb7d6f2e5f6abd195ed014d4a3969626b6fcb06ecfb2c92242f96c42::bot::KongBot<0x2::sui::SUI>, arg1: &mut 0x6499785bb7d6f2e5f6abd195ed014d4a3969626b6fcb06ecfb2c92242f96c42::bot::Banana<0x2::sui::SUI>, arg2: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        let (_, v4) = 0x6499785bb7d6f2e5f6abd195ed014d4a3969626b6fcb06ecfb2c92242f96c42::bot::transfer_bananas<0x2::sui::SUI>(arg0, arg1, v0, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, 0x2::tx_context::sender(arg6));
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg6));
        };
    }

    // decompiled from Move bytecode v6
}

