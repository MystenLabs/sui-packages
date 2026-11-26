module 0xad68f9ed18db8c69c48343d33a7e7e528ddb1d05fcd03786e50cdc44597470fe::sweep {
    public fun coin_to_bank<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x55ba0de97ef574b0bad7641366f31c44162642a3a28f4051bb0b8978b9f025bc);
    }

    public fun to_bank<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), @0x55ba0de97ef574b0bad7641366f31c44162642a3a28f4051bb0b8978b9f025bc);
        };
    }

    // decompiled from Move bytecode v7
}

