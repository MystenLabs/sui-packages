module 0x82c3d9a3b621de2890054ddb9c0b0d240583ce3cd8c8bed0f5529f15869f1d3a::move_pump_protocol {
    public(friend) fun sui_from_coin<T0>(arg0: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun sui_to_coin<T0>(arg0: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns<T0>(arg0, arg2, arg1, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

