module 0x6d1689fcfca2036107f40414c98af236acae1629ae6b99cddc379e1d376560dc::validator {
    fun parse_signature(arg0: vector<u8>) : (address, vector<u8>, vector<u8>) {
        assert!(*0x1::vector::borrow<u8>(&arg0, 0) == 0, 1);
        let v0 = 1;
        let v1 = x"00";
        let v2 = b"";
        let v3 = 0x1::vector::length<u8>(&arg0);
        while (v0 < v3) {
            if (v0 <= v3 - 32 - 1) {
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg0, v0));
            } else {
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0, v0));
            };
            v0 = v0 + 1;
        };
        0x1::vector::remove<u8>(&mut v1, 0);
        (0x2::address::from_bytes(0x2::hash::blake2b256(&v1)), v1, v2)
    }

    public fun verify(arg0: &0x6d1689fcfca2036107f40414c98af236acae1629ae6b99cddc379e1d376560dc::config::GlobalConfig, arg1: vector<u8>, arg2: vector<0x1::string::String>) : bool {
        if (0x6d1689fcfca2036107f40414c98af236acae1629ae6b99cddc379e1d376560dc::config::skip_verify(arg0)) {
            true
        } else {
            let v1 = 0;
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                if (verify_internal(arg0, arg1, 0x1::vector::borrow<0x1::string::String>(&arg2, v2))) {
                    v1 = v1 + 1;
                };
                v2 = v2 + 1;
            };
            if (v1 >= 0x6d1689fcfca2036107f40414c98af236acae1629ae6b99cddc379e1d376560dc::config::get_confirmed_limit(arg0)) {
                return true
            };
            false
        }
    }

    fun verify_internal(arg0: &0x6d1689fcfca2036107f40414c98af236acae1629ae6b99cddc379e1d376560dc::config::GlobalConfig, arg1: vector<u8>, arg2: &0x1::string::String) : bool {
        let (v0, v1, v2) = parse_signature(0x2::hex::decode(*0x1::string::bytes(arg2)));
        let v3 = v2;
        let v4 = v1;
        if (!0x6d1689fcfca2036107f40414c98af236acae1629ae6b99cddc379e1d376560dc::config::has_validator_role(arg0, v0)) {
            return false
        };
        0x2::ed25519::ed25519_verify(&v3, &v4, &arg1)
    }

    // decompiled from Move bytecode v6
}

