module 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::ticket_reveal {
    public fun check_zk_login_issuer(arg0: address, arg1: u256, arg2: &0x1::string::String) : bool {
        0x2::zklogin_verified_issuer::check_zklogin_issuer(arg0, arg1, arg2)
    }

    public fun parse_ed25519_signature(arg0: &vector<u8>) : (vector<u8>, vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 97, 6);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == 0, 6);
        let v0 = 1;
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        while (v0 < 65) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, v0));
            v0 = v0 + 1;
        };
        while (v0 < 97) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v0));
            v0 = v0 + 1;
        };
        (v1, v2)
    }

    public fun pk_to_sui_address(arg0: vector<u8>) : address {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun verify_personal_message_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: address) : bool {
        let (v0, v1) = parse_ed25519_signature(arg0);
        let v2 = v1;
        let v3 = v0;
        assert!(pk_to_sui_address(v2) == arg2, 6);
        let v4 = x"030000";
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<vector<u8>>(arg1));
        let v5 = 0x2::hash::blake2b256(&v4);
        0x2::ed25519::ed25519_verify(&v3, &v2, &v5)
    }

    public fun verify_personal_message_signature_for_zk_login_inner(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let (v0, v1) = parse_ed25519_signature(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = x"030000";
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<vector<u8>>(arg1));
        let v5 = 0x2::hash::blake2b256(&v4);
        0x2::ed25519::ed25519_verify(&v3, &v2, &v5)
    }

    // decompiled from Move bytecode v6
}

