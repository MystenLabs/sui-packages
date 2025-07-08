module 0x9e18dcb9de2db3be2d216ba6c15a6b6dcd905e4ea1a8bdfb1b4a5fbf643b6ac9::earnos {
    public fun earnos_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    public fun earnos_transfer_generic<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

