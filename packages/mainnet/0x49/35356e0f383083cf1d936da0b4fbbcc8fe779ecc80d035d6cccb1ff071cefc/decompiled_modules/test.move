module 0x4935356e0f383083cf1d936da0b4fbbcc8fe779ecc80d035d6cccb1ff071cefc::test {
    public fun blue_move_swap<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input<T0, T1>(arg0, arg3, arg1, arg2, arg4);
    }

    // decompiled from Move bytecode v6
}

