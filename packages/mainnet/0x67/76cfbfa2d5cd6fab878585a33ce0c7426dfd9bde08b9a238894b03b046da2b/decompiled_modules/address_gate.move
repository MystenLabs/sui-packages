module 0x6776cfbfa2d5cd6fab878585a33ce0c7426dfd9bde08b9a238894b03b046da2b::address_gate {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        assert!(0x2::tx_context::sender(arg1) == 0x2::address::from_bytes(arg0), 0);
    }

    // decompiled from Move bytecode v7
}

