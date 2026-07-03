module 0xe8600d718517550594fccb04cb5e0918ddd95ddfc8f0027e21966d5323c91abb::bluemove {
    public fun swap_exact_in<T0, T1>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::balance::value<T0>(&arg1), 0x2::coin::from_balance<T0>(arg1, arg3), arg2, arg0, arg3))
    }

    // decompiled from Move bytecode v7
}

