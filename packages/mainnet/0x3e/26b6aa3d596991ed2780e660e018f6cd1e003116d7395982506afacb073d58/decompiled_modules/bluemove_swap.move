module 0x3e26b6aa3d596991ed2780e660e018f6cd1e003116d7395982506afacb073d58::bluemove_swap {
    public fun swap_exact_input_<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T1>) {
        if (arg0 == 0) {
            arg0 = 0x2::coin::value<T0>(&arg1);
        };
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg0, arg1, 0, arg2, arg4);
        (0x2::coin::value<T1>(&v0), v0)
    }

    public fun swap_stable_exact_input_<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T1>) {
        if (arg0 == 0) {
            arg0 = 0x2::coin::value<T0>(&arg1);
        };
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T0, T1>(arg1, arg0, 0, arg2, arg3, arg4);
        (0x2::coin::value<T1>(&v0), v0)
    }

    // decompiled from Move bytecode v6
}

