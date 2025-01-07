module 0xb3dc986293acf9f6b752fc37bbd66847217648d9777825fe02c45cf69e7ba16b::shop {
    public fun blue_move_swap<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: 0x2::coin::Coin<T0>, arg4: bool, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4, 0);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = v0 * 990 / 1000;
        let v2 = v0 - v1;
        let v3 = if (v2 > 200000000) {
            200000000
        } else {
            v2
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg6), arg5);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input<T0, T1>(v1, arg3, arg1, arg2, arg6);
    }

    // decompiled from Move bytecode v6
}

