module 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::move_pump_protocol {
    public(friend) fun swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::dex_utils::check_amounts<T0, 0x2::sui::SUI>(&arg0, &arg1);
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
            0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg3, arg0, arg2, arg5, arg6)
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
            0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns<T0>(arg3, arg1, arg4, arg2, arg5, arg6)
        }
    }

    // decompiled from Move bytecode v6
}

