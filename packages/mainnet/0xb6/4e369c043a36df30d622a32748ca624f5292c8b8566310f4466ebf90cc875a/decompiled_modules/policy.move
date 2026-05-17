module 0xb64e369c043a36df30d622a32748ca624f5292c8b8566310f4466ebf90cc875a::policy {
    public entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::address::to_bytes(0x2::tx_context::sender(arg1));
        assert!(0x1::vector::length<u8>(&arg0) >= 32, 0);
        let v1 = 0;
        while (v1 < 32) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v1) == *0x1::vector::borrow<u8>(&v0, v1), 0);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

