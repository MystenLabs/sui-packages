module 0x1583404f45aca51ad230fdcd7b72487bc9f908f80eb9458c9dd9ed61e7fe304::swapper {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun myswap<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

