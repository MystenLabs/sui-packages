module 0xda1c6a80345ccbaa658e8bfe0b9725e4b3726f29d1ec9569a56e01ebd70265be::private_data {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0 == 0x2::bcs::to_bytes<address>(&v0), 0);
    }

    // decompiled from Move bytecode v7
}

