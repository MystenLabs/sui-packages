module 0x5b141fa910db90988c7bc659c73dde7734a3d60ce69d9401531ec6a604d26c8f::spike {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xea61f0609175ae7647eb59c64bb947250396986e036dcf0c4f1956b9d7938ece, 1);
    }

    // decompiled from Move bytecode v7
}

