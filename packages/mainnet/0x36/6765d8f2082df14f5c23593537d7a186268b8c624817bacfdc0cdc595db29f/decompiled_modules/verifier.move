module 0x366765d8f2082df14f5c23593537d7a186268b8c624817bacfdc0cdc595db29f::verifier {
    public fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg0, 64);
        if (*v0 == 27) {
            *v0 = 0;
        } else if (*v0 == 28) {
            *v0 = 1;
        } else if (*v0 > 35) {
            *v0 = (*v0 - 1) % 2;
        };
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 0)
    }

    public fun ecrecover_to_eth_address(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg0, 64);
        if (*v0 == 27) {
            *v0 = 0;
        } else if (*v0 == 28) {
            *v0 = 1;
        } else if (*v0 > 35) {
            *v0 = (*v0 - 1) % 2;
        };
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 0);
        let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 1;
        while (v4 < 65) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x2::hash::keccak256(&v3);
        let v6 = 0x1::vector::empty<u8>();
        let v7 = 12;
        while (v7 < 32) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v5, v7));
            v7 = v7 + 1;
        };
        v6
    }

    // decompiled from Move bytecode v6
}

