module 0x652c97317f1e6e84b0e83f2e353ada085beb3123a0a25c6d96cc3686ab569527::utils {
    public fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

