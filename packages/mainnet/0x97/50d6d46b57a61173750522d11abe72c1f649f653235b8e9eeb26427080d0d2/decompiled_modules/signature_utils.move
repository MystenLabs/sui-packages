module 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::signature_utils {
    fun ecrecover_to_eth_address(arg0: &mut vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::borrow_mut<u8>(arg0, 64);
        if (*v0 == 27) {
            *v0 = 0;
        } else if (*v0 == 28) {
            *v0 = 1;
        } else if (*v0 > 35) {
            *v0 = (*v0 - 1) % 2;
        };
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(arg0, &arg1, 0);
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

    public(friend) fun make_digest(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::constants::get_msg_prefix();
        0x1::vector::append<u8>(&mut v0, *arg0);
        v0
    }

    public(friend) fun verify_sig(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &mut vector<u8>) : bool {
        *arg0 == ecrecover_to_eth_address(arg2, *arg1)
    }

    // decompiled from Move bytecode v6
}

