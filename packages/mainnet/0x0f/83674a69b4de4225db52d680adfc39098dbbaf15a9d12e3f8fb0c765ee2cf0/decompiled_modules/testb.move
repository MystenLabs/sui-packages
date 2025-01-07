module 0xf83674a69b4de4225db52d680adfc39098dbbaf15a9d12e3f8fb0c765ee2cf0::testb {
    public fun swap_exact_input<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::coin::value<T0>(&arg0), arg0, 0, arg1, arg2)
    }

    public fun swap_exact_output<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_output_<T1, T0>(0x2::coin::value<T1>(&arg0), 0, arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

