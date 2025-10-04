module 0xeab603035de5d1f26ee93154fc5b85584e72c42cf5253c90bdc5d0f01e5b0742::web3cloud_policy {
    entry fun seal_approve(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::address::to_bytes(0x2::tx_context::sender(arg1)), 1);
    }

    entry fun seal_approve_identity(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) > 0, 2);
        assert!(0x2::address::from_bytes(arg0) == 0x2::tx_context::sender(arg1), 1);
    }

    entry fun seal_approve_shared(arg0: vector<u8>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::address::to_bytes(0x2::tx_context::sender(arg2)), 1);
    }

    // decompiled from Move bytecode v6
}

