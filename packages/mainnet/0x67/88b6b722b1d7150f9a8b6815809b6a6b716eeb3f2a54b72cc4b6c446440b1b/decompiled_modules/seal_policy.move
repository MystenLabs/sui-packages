module 0x6788b6b722b1d7150f9a8b6815809b6a6b716eeb3f2a54b72cc4b6c446440b1b::seal_policy {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::address::to_bytes(0x2::tx_context::sender(arg1));
        assert!(0x1::vector::length<u8>(&arg0) == 0x1::vector::length<u8>(&v0), 1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v1) == *0x1::vector::borrow<u8>(&v0, v1), 1);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

