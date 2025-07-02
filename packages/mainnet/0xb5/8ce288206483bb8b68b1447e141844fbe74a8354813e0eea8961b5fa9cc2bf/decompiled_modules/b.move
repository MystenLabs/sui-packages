module 0xb58ce288206483bb8b68b1447e141844fbe74a8354813e0eea8961b5fa9cc2bf::b {
    public fun distribute<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

