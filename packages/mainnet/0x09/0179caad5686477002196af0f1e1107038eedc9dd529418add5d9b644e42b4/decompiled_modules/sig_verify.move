module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::sig_verify {
    public fun derive_address_from_public_key(arg0: vector<u8>) : address {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13835058231375822849);
        let v0 = 0x1::vector::singleton<u8>(0);
        0x1::vector::append<u8>(&mut v0, arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    fun extract_bytes(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg2 - arg1) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: address) : bool {
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 >= 1, 13835621254343950341);
        let v1 = *0x1::vector::borrow<u8>(&arg1, 0);
        let v2 = 0;
        assert!(&v1 == &v2, 13835339805136912387);
        let v3 = 64;
        let v4 = 1 + v3 + 32;
        assert!(v0 == v4, 13835621297293623301);
        let v5 = extract_bytes(&arg1, 1, 1 + v3);
        let v6 = extract_bytes(&arg1, 1 + v3, v4);
        let v7 = x"030000";
        0x1::vector::append<u8>(&mut v7, arg0);
        let v8 = 0x2::hash::blake2b256(&v7);
        if (derive_address_from_public_key(v6) != arg2) {
            return false
        };
        let v9 = 0;
        assert!(&v1 == &v9, 13835339951165800451);
        0x2::ed25519::ed25519_verify(&v5, &v6, &v8)
    }

    // decompiled from Move bytecode v6
}

