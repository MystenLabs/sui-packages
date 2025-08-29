module 0x297caa74bf795f3e50e2209c4daa9adf2681dcb7026bfac5d4ae6f5461a52bd2::utils {
    public fun parse_signature(arg0: vector<u8>) : (address, vector<u8>, vector<u8>) {
        assert!(*0x1::vector::borrow<u8>(&arg0, 0) == 0, 13906834281717563393);
        let v0 = x"00";
        let v1 = b"";
        let v2 = 0x1::vector::length<u8>(&arg0);
        let v3 = 1;
        while (v3 < v2) {
            if (v3 <= v2 - 32 - 1) {
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0, v3));
            } else {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v3));
            };
            v3 = v3 + 1;
        };
        0x1::vector::remove<u8>(&mut v0, 0);
        (0x2::address::from_bytes(0x2::hash::blake2b256(&v0)), v0, v1)
    }

    public fun verify_internal(arg0: vector<u8>, arg1: &0x1::string::String) : (bool, address) {
        if (0x1::string::length(arg1) < 97) {
            return (false, @0x0)
        };
        let (v0, v1, v2) = parse_signature(0x2::hex::decode(*0x1::string::as_bytes(arg1)));
        let v3 = v2;
        let v4 = v1;
        (0x2::ed25519::ed25519_verify(&v3, &v4, &arg0), v0)
    }

    // decompiled from Move bytecode v6
}

