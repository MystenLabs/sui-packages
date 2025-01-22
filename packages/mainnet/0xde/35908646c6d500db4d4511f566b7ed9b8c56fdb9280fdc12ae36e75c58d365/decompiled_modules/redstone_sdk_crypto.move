module 0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_crypto {
    fun check_s(arg0: &vector<u8>) {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, 32 + v1));
            v1 = v1 + 1;
        };
        assert!(0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::redstone_sdk_conv::from_bytes_to_u256(&v0) <= 57896044618658097711785492504343953926418782139537452191302581570759080747168, 3);
    }

    fun last_n_bytes(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(arg1 <= v0, 2);
        let v1 = b"";
        let v2 = 0;
        while (v2 < arg1) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, v0 - arg1 + v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun recover_address(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg1) == 65, 0);
        let v0 = *arg1;
        let v1 = *0x1::vector::borrow<u8>(&v0, 64);
        let v2 = if (v1 >= 27) {
            v1 - 27
        } else {
            v1
        };
        assert!(v2 < 2, 1);
        check_s(&v0);
        *0x1::vector::borrow_mut<u8>(&mut v0, 64) = v2;
        let v3 = 0x2::ecdsa_k1::secp256k1_ecrecover(&v0, arg0, 0);
        let v4 = 0x2::ecdsa_k1::decompress_pubkey(&v3);
        let v5 = last_n_bytes(&v4, 0x1::vector::length<u8>(&v4) - 1);
        let v6 = 0x2::hash::keccak256(&v5);
        last_n_bytes(&v6, 20)
    }

    // decompiled from Move bytecode v6
}

