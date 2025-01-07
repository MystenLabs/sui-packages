module 0xe03181356888bf5cf862757a349b4d3b7e6756f83c5406c9758b0efcbc1db071::app {
    public fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

