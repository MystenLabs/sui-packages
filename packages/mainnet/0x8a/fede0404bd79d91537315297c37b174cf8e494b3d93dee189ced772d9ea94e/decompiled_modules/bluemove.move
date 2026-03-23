module 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::bluemove {
    public fun swap_a2b<T0, T1>(arg0: &mut 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::SwapContext, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::take_balance<T0>(arg0);
        0x8afede0404bd79d91537315297c37b174cf8e494b3d93dee189ced772d9ea94e::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(0x2::balance::value<T0>(&v0), 0x2::coin::from_balance<T0>(v0, arg2), 0, arg1, arg2)));
    }

    // decompiled from Move bytecode v6
}

