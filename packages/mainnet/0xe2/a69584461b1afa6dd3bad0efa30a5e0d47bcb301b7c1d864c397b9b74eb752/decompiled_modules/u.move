module 0xe2a69584461b1afa6dd3bad0efa30a5e0d47bcb301b7c1d864c397b9b74eb752::u {
    public fun ck<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun rt<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public fun st<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address) {
        ck<T0>(&arg0, arg1);
        rt<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

