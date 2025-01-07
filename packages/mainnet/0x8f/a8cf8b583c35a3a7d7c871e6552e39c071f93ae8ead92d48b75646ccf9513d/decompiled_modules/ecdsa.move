module 0x8fa8cf8b583c35a3a7d7c871e6552e39c071f93ae8ead92d48b75646ccf9513d::ecdsa {
    public fun assert_mint_signature_valid(arg0: address, arg1: &0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(verify_mint_data(arg0, arg1, arg2, arg3), 0);
    }

    fun verify_mint_data(arg0: address, arg1: &0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(arg1));
        0x2::ed25519::ed25519_verify(&arg2, &arg3, &v0)
    }

    // decompiled from Move bytecode v6
}

