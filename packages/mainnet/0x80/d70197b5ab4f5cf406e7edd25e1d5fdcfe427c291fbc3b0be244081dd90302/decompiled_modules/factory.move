module 0x80d70197b5ab4f5cf406e7edd25e1d5fdcfe427c291fbc3b0be244081dd90302::factory {
    public entry fun create_distributor<T0>(arg0: address, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0, 1);
        assert!(arg1 > 0, 2);
        0x80d70197b5ab4f5cf406e7edd25e1d5fdcfe427c291fbc3b0be244081dd90302::distributor::create_and_share<T0>(0x2::tx_context::sender(arg3), arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

