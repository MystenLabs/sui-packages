module 0xcbe9ca8cee83ee454cbc114b8f9825b49ed945f89e6ef4f26a07417a10525f42::utils {
    public entry fun ecrecover_to_eth_address(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
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

    public fun u64_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
        v0
    }

    // decompiled from Move bytecode v6
}

