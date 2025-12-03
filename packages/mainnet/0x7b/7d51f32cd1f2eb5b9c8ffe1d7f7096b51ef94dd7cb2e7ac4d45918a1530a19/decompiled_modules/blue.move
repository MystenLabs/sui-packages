module 0x7b7d51f32cd1f2eb5b9c8ffe1d7f7096b51ef94dd7cb2e7ac4d45918a1530a19::blue {
    public fun swap<T0, T1>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x7b7d51f32cd1f2eb5b9c8ffe1d7f7096b51ef94dd7cb2e7ac4d45918a1530a19::help::merge_all<T0>(arg1, arg3);
        let v1 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg2, 0x2::coin::split<T0>(&mut v0, arg2, arg3), 0, arg0, arg3);
        0x7b7d51f32cd1f2eb5b9c8ffe1d7f7096b51ef94dd7cb2e7ac4d45918a1530a19::help::transfer<T0>(v0, 0x2::tx_context::sender(arg3));
        (v1, 0x2::coin::value<T1>(&v1))
    }

    public fun swap1<T0, T1>(arg0: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let (v0, v1) = swap<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

