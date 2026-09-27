module 0x93e913f7f17d2bcf693d64ecc0621f5793fb67747bd8d6f2df3a491234bbd35d::m {
    public fun gz<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 100);
        0x2::coin::from_balance<T0>(arg0, arg2)
    }

    // decompiled from Move bytecode v7
}

