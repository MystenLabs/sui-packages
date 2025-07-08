module 0xb::crypto {
    public(friend) fun ecdsa_pub_key_to_eth_address(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x2::ecdsa_k1::decompress_pubkey(arg0);
        let v1 = b"";
        let v2 = 1;
        while (v2 < 65) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        let v3 = 0x2::hash::keccak256(&v1);
        let v4 = b"";
        let v5 = 12;
        while (v5 < 32) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v3, v5));
            v5 = v5 + 1;
        };
        v4
    }

    // decompiled from Move bytecode v6
}

