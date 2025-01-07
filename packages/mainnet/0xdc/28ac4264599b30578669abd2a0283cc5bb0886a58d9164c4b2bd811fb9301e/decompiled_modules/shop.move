module 0xdc28ac4264599b30578669abd2a0283cc5bb0886a58d9164c4b2bd811fb9301e::shop {
    public fun blue_move_swap<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4, 0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = v0 - v0 * 990 / 1000;
        let v2 = if (v1 > 200000000) {
            200000000
        } else {
            v1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v2, arg6), arg5);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input<T0, T1>(arg0, arg3, arg1, arg2, arg6);
    }

    // decompiled from Move bytecode v6
}

