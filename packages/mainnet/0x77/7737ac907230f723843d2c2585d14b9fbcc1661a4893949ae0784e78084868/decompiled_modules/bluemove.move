module 0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::bluemove {
    public fun a2b<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::coin::value<T0>(&arg0), arg0, 0, arg1, arg2)
    }

    public fun b2a<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T0>(0x2::coin::value<T1>(&arg0), arg0, 0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

