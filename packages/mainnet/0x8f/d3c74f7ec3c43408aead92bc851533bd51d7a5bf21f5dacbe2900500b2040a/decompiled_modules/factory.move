module 0x8fd3c74f7ec3c43408aead92bc851533bd51d7a5bf21f5dacbe2900500b2040a::factory {
    public entry fun create_distributor<T0>(arg0: address, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != @0x0, 1);
        assert!(arg1 > 0, 2);
        0x8fd3c74f7ec3c43408aead92bc851533bd51d7a5bf21f5dacbe2900500b2040a::distributor::create_and_share<T0>(0x2::tx_context::sender(arg3), arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

