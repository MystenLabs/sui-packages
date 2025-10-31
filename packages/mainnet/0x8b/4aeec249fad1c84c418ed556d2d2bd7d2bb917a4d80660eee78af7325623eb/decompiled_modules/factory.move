module 0x8b4aeec249fad1c84c418ed556d2d2bd7d2bb917a4d80660eee78af7325623eb::factory {
    public entry fun create_distributor<T0>(arg0: address, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0, 1);
        assert!(arg1 > 0, 2);
        0x8b4aeec249fad1c84c418ed556d2d2bd7d2bb917a4d80660eee78af7325623eb::distributor::create_and_share<T0>(0x2::tx_context::sender(arg3), arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

