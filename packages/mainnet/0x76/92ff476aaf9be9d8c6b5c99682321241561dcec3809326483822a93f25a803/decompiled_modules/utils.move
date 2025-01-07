module 0x7692ff476aaf9be9d8c6b5c99682321241561dcec3809326483822a93f25a803::utils {
    public fun transfer_and_destroy_coin_opt<T0>(arg0: 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0), 0x2::tx_context::sender(arg1));
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

