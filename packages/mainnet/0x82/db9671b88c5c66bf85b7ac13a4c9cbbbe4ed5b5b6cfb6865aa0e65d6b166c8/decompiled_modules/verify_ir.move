module 0x82db9671b88c5c66bf85b7ac13a4c9cbbbe4ed5b5b6cfb6865aa0e65d6b166c8::verify_ir {
    public(friend) fun verify_and_extract_payload(arg0: vector<u8>, arg1: vector<u8>, arg2: u8) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) >= 51, 0);
        assert!((*0x1::vector::borrow<u8>(&arg0, 8) as u16) << 8 | (*0x1::vector::borrow<u8>(&arg0, 9) as u16) == 42069, 1);
        let v0 = x"0000000000000000000000000000000000000000000000000000000000004155";
        let v1 = 0;
        while (v1 < 32) {
            assert!(*0x1::vector::borrow<u8>(&arg0, 10 + v1) == *0x1::vector::borrow<u8>(&v0, v1), 2);
            v1 = v1 + 1;
        };
        let v2 = 0x2::hash::keccak256(&arg0);
        0x1::vector::push_back<u8>(&mut arg1, arg2);
        let v3 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg1, &v2, 0);
        let v4 = 0x2::ecdsa_k1::decompress_pubkey(&v3);
        0x1::vector::remove<u8>(&mut v4, 0);
        let v5 = 0x2::hash::keccak256(&v4);
        let v6 = x"0000000000000000000000007aec8515478a3e7dd1534d47abe8853577fa67ae";
        let v7 = 12;
        while (v7 < 32) {
            assert!(*0x1::vector::borrow<u8>(&v5, v7) == *0x1::vector::borrow<u8>(&v6, v7), 3);
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<u8>();
        let v9 = 51;
        while (v9 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<u8>(&mut v8, *0x1::vector::borrow<u8>(&arg0, v9));
            v9 = v9 + 1;
        };
        v8
    }

    // decompiled from Move bytecode v6
}

