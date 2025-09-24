module 0x81d6c164530a03f8c41c6dafbf36141df175378c80f7e1de79153d04f7285afd::arb {
    public fun bluemove_a2b<T0, T1>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::balance::value<T0>(&arg1), 0x2::coin::from_balance<T0>(arg1, arg2), 0, arg0, arg2))
    }

    public fun bluemove_b2a<T0, T1>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T0>(0x2::balance::value<T1>(&arg1), 0x2::coin::from_balance<T1>(arg1, arg2), 0, arg0, arg2))
    }

    // decompiled from Move bytecode v6
}

