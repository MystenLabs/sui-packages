module 0xf1c38b4d5ca2ec523086679d9fd1a3dbaacd08159f2ef04cfbf5810990db1b81::signature {
    fun add_intent_bytes_and_hash(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg0));
        0x2::hash::blake2b256(&v0)
    }

    fun append_u64_bytes(arg0: &mut vector<u8>, arg1: u64) {
        0x1::vector::append<u8>(arg0, 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
    }

    public fun build_claim_message(arg0: &vector<u64>, arg1: u64, arg2: address) : vector<u8> {
        let v0 = b"{\"ids\":[";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            if (v1 > 0) {
                0x1::vector::append<u8>(&mut v0, b",");
            };
            0x1::vector::append<u8>(&mut v0, b"\"");
            let v2 = &mut v0;
            append_u64_bytes(v2, *0x1::vector::borrow<u64>(arg0, v1));
            0x1::vector::append<u8>(&mut v0, b"\"");
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, b"],\"amount\":\"");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
        0x1::vector::append<u8>(&mut v0, b"\",\"receiver\":\"0x");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::address::to_string(arg2)));
        0x1::vector::append<u8>(&mut v0, b"\"}");
        v0
    }

    public fun verify_claim_signature(arg0: &vector<u64>, arg1: u64, arg2: address, arg3: vector<u8>) : address {
        verify_personal_message_signature(build_claim_message(arg0, arg1, arg2), arg3)
    }

    public fun verify_personal_message_signature(arg0: vector<u8>, arg1: vector<u8>) : address {
        verify_signature_and_recover_signer(add_intent_bytes_and_hash(arg0), arg1)
    }

    fun verify_signature_and_recover_signer(arg0: vector<u8>, arg1: vector<u8>) : address {
        assert!(0x1::vector::length<u8>(&arg1) > 64, 2003);
        let v0 = *0x1::vector::borrow<u8>(&arg1, 64);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 64) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg1, v3));
            v3 = v3 + 1;
        };
        v3 = 64 + 1;
        while (v3 < 0x1::vector::length<u8>(&arg1)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg1, v3));
            v3 = v3 + 1;
        };
        let v4 = if (v0 == 1) {
            assert!(0x2::ed25519::ed25519_verify(&v1, &v2, &arg0), 2002);
            0
        } else {
            assert!(v0 == 0, 2001);
            assert!(0x2::ecdsa_k1::secp256k1_verify(&v1, &v2, &arg0, 1), 2002);
            1
        };
        0x1::vector::insert<u8>(&mut v2, v4, 0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v2))
    }

    // decompiled from Move bytecode v6
}

