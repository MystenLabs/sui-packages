module 0xee7ce5884b5abb56d4b92f42fb986e02c88a1fac41d5c1fd740618aa3d61b739::shop {
    public fun blue_move_swap<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            let (v0, v1) = get_fee<T0>(&arg3);
            let (v2, v3) = get_coin_fee<T0>(arg3, v1, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
            0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input<T0, T1>(v0, v2, arg1, arg2, arg5);
        } else {
            let v4 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg0, arg3, arg1, arg2, arg5);
            let (_, v6) = get_fee<T1>(&v4);
            let (v7, v8) = get_coin_fee<T1>(v4, v6, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, 0x2::tx_context::sender(arg5));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, @0x4b57068af6be5bb31ddbb70da8819856ea590f741a62cbe97ef4f80d47336875);
        };
    }

    fun get_coin_fee<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        (arg0, 0x2::coin::split<T0>(&mut arg0, arg1, arg2))
    }

    fun get_fee<T0>(arg0: &0x2::coin::Coin<T0>) : (u64, u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = v0 * 990 / 1000;
        (v1, v0 - v1)
    }

    // decompiled from Move bytecode v6
}

