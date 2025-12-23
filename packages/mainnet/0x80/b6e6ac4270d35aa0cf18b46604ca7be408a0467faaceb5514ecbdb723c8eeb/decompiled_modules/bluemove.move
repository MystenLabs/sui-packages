module 0x80b6e6ac4270d35aa0cf18b46604ca7be408a0467faaceb5514ecbdb723c8eeb::bluemove {
    public fun swap<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_a2b<T0, T1>(arg0, arg1, arg3, arg4);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg3, arg4);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::take_balance<T0>(arg0, arg2), arg3);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(v1, v0, 0, arg1, arg3);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::emit_swap_event<T0, T1>(arg0, b"BLUEMOVE", 0x2::object::id<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info>(arg1), v1, 0x2::coin::value<T1>(&v2), 0);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::take_balance<T1>(arg0, arg2), arg3);
        let v1 = 0x2::coin::value<T1>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T0>(v1, v0, 0, arg1, arg3);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::emit_swap_event<T1, T0>(arg0, b"BLUEMOVE", 0x2::object::id<0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info>(arg1), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    // decompiled from Move bytecode v6
}

