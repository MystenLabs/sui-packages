module 0x92718eccba74093d2124ffaba3ed38aef418bf565a23d97bc9ca1d272bdf1238::shop {
    public fun blue_move_swap<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            let (v0, v1) = get_fee<T0>(&arg3);
            let (v2, v3) = get_coin_fee<T0>(arg3, v1, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input<T0, T1>(v0, v2, arg1, arg2, arg5);
        } else {
            let v4 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg0, arg3, arg1, arg2, arg5);
            let (_, v6) = get_fee<T1>(&v4);
            let (v7, v8) = get_coin_fee<T1>(v4, v6, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, 0x2::tx_context::sender(arg5));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
        };
    }

    fun get_coin_fee<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        (arg0, 0x2::coin::split<T0>(&mut arg0, arg1, arg2))
    }

    fun get_fee<T0>(arg0: &0x2::coin::Coin<T0>) : (u64, u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = v0 * 990 / 1000;
        (v1, v0 - v1)
    }

    public fun move_pump_swap<T0>(arg0: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = get_fee<0x2::sui::SUI>(&arg1);
        let (v2, v3) = get_coin_fee<0x2::sui::SUI>(arg1, v1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
        0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy<T0>(arg0, v2, arg2, arg3, arg4, arg5);
    }

    public fun move_pump_swap_sell<T0>(arg0: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        let (_, v5) = get_fee<0x2::sui::SUI>(&v3);
        let (v6, v7) = get_coin_fee<0x2::sui::SUI>(v3, v5, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
        if (0x2::coin::value<T0>(&v2) == 0) {
            0x2::coin::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg4));
        };
    }

    // decompiled from Move bytecode v6
}

