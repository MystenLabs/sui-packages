module 0x194352a94e39a577e6b9d316efed218c8c30e5b11aedec95bd489e72906f3936::factory {
    public entry fun create_distributor<T0>(arg0: address, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0, 1);
        assert!(arg1 > 0, 2);
        0x194352a94e39a577e6b9d316efed218c8c30e5b11aedec95bd489e72906f3936::distributor::create_and_share<T0>(0x2::tx_context::sender(arg3), arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

