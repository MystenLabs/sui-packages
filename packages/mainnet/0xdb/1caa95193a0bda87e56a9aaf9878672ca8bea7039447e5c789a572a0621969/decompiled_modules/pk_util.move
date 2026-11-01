module 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::pk_util {
    public fun assert_valid_key(arg0: &vector<u8>) {
        assert!(is_valid_key(arg0), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::errors::invalid_public_key());
    }

    public fun flag_ed25519() : u8 {
        0
    }

    public fun flag_passkey() : u8 {
        6
    }

    public fun flag_secp256k1() : u8 {
        1
    }

    public fun flag_secp256r1() : u8 {
        2
    }

    public fun is_p256_flag(arg0: u8) : bool {
        arg0 == 2 || arg0 == 6
    }

    public fun is_valid_key(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0) {
            return false
        };
        let v1 = *0x1::vector::borrow<u8>(arg0, 0);
        v1 == 0 && v0 == 33 || v1 == 1 && v0 == 34 || v1 == 2 && v0 == 34 || v1 == 6 && v0 == 34
    }

    // decompiled from Move bytecode v7
}

