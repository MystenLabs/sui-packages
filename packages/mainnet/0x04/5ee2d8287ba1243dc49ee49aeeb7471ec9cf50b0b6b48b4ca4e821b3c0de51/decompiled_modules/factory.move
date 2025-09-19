module 0x45ee2d8287ba1243dc49ee49aeeb7471ec9cf50b0b6b48b4ca4e821b3c0de51::factory {
    public entry fun create_distributor<T0>(arg0: address, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0, 1);
        assert!(arg1 > 0, 2);
        0x45ee2d8287ba1243dc49ee49aeeb7471ec9cf50b0b6b48b4ca4e821b3c0de51::distributor::create_and_share<T0>(0x2::tx_context::sender(arg3), arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

