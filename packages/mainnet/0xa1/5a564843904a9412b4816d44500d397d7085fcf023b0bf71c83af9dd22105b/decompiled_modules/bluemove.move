module 0xa15a564843904a9412b4816d44500d397d7085fcf023b0bf71c83af9dd22105b::bluemove {
    public fun swap_exact_in<T0, T1>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::balance::value<T0>(&arg1), 0x2::coin::from_balance<T0>(arg1, arg2), 1, arg0, arg2))
    }

    // decompiled from Move bytecode v7
}

