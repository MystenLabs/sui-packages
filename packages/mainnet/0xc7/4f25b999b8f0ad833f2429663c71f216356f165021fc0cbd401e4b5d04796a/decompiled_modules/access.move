module 0xc74f25b999b8f0ad833f2429663c71f216356f165021fc0cbd401e4b5d04796a::access {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::address::from_bytes(arg0) == 0x2::tx_context::sender(arg1), 0);
    }

    // decompiled from Move bytecode v6
}

