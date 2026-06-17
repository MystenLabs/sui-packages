module 0x7f3578ebe174b0343cd96391b2a1c75d5db4ad82c793650b3950bdb5634192e5::access_policy {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x2::address::from_bytes(arg0), 0);
    }

    // decompiled from Move bytecode v7
}

