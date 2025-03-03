module 0x1e5d3cd48eecedffbc0ee5aafeb07251bbc3d20148984b3147a8d15c04e11e40::betting {
    public entry fun place_bet<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, 10, arg1), @0xf2fc809d2e96923e148a5439729d8f7176bf799a996d3e6fe021f37a5d478c6f);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

