module 0xc1481cd1e88352a79f8b5d4a006ec6b916da0258a91de40c9876670ca5f28415::router {
    public entry fun claim<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

