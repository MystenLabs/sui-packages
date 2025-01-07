module 0x5b856cf444390bd43c275e51e8a43e2f6b8a7c23697278357e593f44bbf962fe::ecdsa {
    public fun ed25519_verify(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(arg0, arg1, arg2)
    }

    public fun assert_mint_signature_valid(arg0: address, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(verify_mint_data(arg0, arg1, arg2, arg3, arg4), 0);
    }

    public fun assert_open_box_signature_valid(arg0: &0x2::object::ID, arg1: &0x2::object::ID, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: vector<u8>, arg5: vector<u8>) {
        assert!(verify_open_box_data(arg0, arg1, arg2, arg3, arg4, arg5), 1);
    }

    public fun verify_mint_data(arg0: address, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::push_back<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x2::ed25519::ed25519_verify(&arg3, &arg4, &v0)
    }

    public fun verify_open_box_data(arg0: &0x2::object::ID, arg1: &0x2::object::ID, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: vector<u8>, arg5: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(arg3));
        0x2::ed25519::ed25519_verify(&arg4, &arg5, &v0)
    }

    // decompiled from Move bytecode v6
}

