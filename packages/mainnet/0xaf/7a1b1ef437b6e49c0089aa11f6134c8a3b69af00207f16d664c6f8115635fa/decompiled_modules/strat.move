module 0xaf7a1b1ef437b6e49c0089aa11f6134c8a3b69af00207f16d664c6f8115635fa::strat {
    public entry fun bless_payment<T0: copy + drop + store>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(arg0) < arg1) {
            abort 1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg2), @0xf2fc809d2e96923e148a5439729d8f7176bf799a996d3e6fe021f37a5d478c6f);
    }

    // decompiled from Move bytecode v6
}

