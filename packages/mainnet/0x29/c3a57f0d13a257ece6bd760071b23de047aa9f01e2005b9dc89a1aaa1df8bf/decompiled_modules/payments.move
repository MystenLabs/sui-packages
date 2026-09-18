module 0x29c3a57f0d13a257ece6bd760071b23de047aa9f01e2005b9dc89a1aaa1df8bf::payments {
    public fun pay_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

