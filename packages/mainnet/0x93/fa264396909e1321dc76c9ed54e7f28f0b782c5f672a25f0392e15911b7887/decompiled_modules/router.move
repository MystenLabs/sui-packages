module 0x93fa264396909e1321dc76c9ed54e7f28f0b782c5f672a25f0392e15911b7887::router {
    public entry fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

