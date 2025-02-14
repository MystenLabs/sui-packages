module 0x1f1f7de4b72a2ba6b1bf07b8a3361b14d8ee94a22102d4562f5f3dbf2fa194c4::utils {
    public fun send_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

