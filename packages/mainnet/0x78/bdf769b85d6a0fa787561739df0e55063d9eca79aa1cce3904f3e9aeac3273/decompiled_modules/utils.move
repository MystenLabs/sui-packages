module 0x78bdf769b85d6a0fa787561739df0e55063d9eca79aa1cce3904f3e9aeac3273::utils {
    public(friend) fun derive_address_from_ed25519(arg0: vector<u8>) : address {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 102);
        let v0 = 0x1::vector::singleton<u8>(0);
        0x1::vector::append<u8>(&mut v0, arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun extract_signature_and_pubilc_key(arg0: vector<u8>) : (vector<u8>, vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0) == 97, 101);
        assert!(*0x1::vector::borrow<u8>(&arg0, 0) == 0, 102);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 1;
        while (v1 <= 64) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<u8>();
        let v3 = v1;
        while (v3 < 97) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg0, v3));
            v3 = v3 + 1;
        };
        (v0, v2)
    }

    public fun hash_message(arg0: vector<u8>) : vector<u8> {
        let v0 = x"030000";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&arg0));
        0x2::hash::blake2b256(&v0)
    }

    public(friend) fun type_to_string<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>()))
    }

    // decompiled from Move bytecode v6
}

