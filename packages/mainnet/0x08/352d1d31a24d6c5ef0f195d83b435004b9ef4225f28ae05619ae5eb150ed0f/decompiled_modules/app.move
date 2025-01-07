module 0x8352d1d31a24d6c5ef0f195d83b435004b9ef4225f28ae05619ae5eb150ed0f::app {
    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

