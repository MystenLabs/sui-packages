module 0x976b63cd557ab69b7d63054a01a1f7b07408035b7afe8a362ccdad3787b31d78::factory {
    public entry fun create_distributor<T0>(arg0: address, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0, 1);
        assert!(arg1 > 0, 2);
        0x976b63cd557ab69b7d63054a01a1f7b07408035b7afe8a362ccdad3787b31d78::distributor::create_and_share<T0>(0x2::tx_context::sender(arg3), arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

