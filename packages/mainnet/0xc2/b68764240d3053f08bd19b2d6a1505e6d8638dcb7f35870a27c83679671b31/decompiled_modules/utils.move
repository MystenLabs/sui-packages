module 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::utils {
    public fun split_and_transfer<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (((0x2::coin::value<T0>(arg0) as u128) * arg1 / 1000000000000000000) as u64);
        if (v0 > 0) {
            0x2::pay::split_and_transfer<T0>(arg0, v0, arg2, arg3);
        };
    }

    public fun transfer_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

