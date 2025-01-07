module 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::movepump {
    public fun move_pump_swap<T0>(arg0: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::KongBot<0x2::sui::SUI>, arg1: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::Banana<0x2::sui::SUI>, arg2: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_bananas<0x2::sui::SUI>(arg0, arg1, arg3, arg7);
        0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy<T0>(arg2, v1, arg4, arg5, arg6, arg7);
    }

    public fun move_pump_swap_sell<T0>(arg0: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::KongBot<0x2::sui::SUI>, arg1: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::Banana<0x2::sui::SUI>, arg2: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg2, arg3, arg4, arg5, arg6);
        let (_, v3) = 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_bananas<0x2::sui::SUI>(arg0, arg1, v0, arg6);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<0x2::sui::SUI>(v3, arg6);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T0>(v1, arg6);
    }

    // decompiled from Move bytecode v6
}

