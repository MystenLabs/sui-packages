module 0xf1402aa91c5707bc46b0c47326bd71e31032e57977da41118ed69ca9c80d7440::ecdsa {
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

