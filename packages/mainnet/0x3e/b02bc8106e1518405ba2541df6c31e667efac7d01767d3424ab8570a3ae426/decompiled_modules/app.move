module 0x3eb02bc8106e1518405ba2541df6c31e667efac7d01767d3424ab8570a3ae426::app {
    public fun transfer_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

