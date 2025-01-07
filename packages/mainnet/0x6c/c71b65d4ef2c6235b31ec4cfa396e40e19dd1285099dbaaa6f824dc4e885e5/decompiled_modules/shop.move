module 0x6cc71b65d4ef2c6235b31ec4cfa396e40e19dd1285099dbaaa6f824dc4e885e5::shop {
    public fun blue_move_swap<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input<T0, T1>(arg0, arg3, arg1, arg2, arg4);
    }

    // decompiled from Move bytecode v6
}

