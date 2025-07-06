module 0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::hmac256ctr {
    public(friend) fun decrypt(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>) : 0x1::option::Option<vector<u8>> {
        let v0 = mac(arg3, arg2, arg0);
        if (&v0 != arg1) {
            return 0x1::option::none<vector<u8>>()
        };
        let v1 = 0;
        let v2 = 0;
        let v3 = b"";
        let v4 = b"";
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(arg0)) {
            if (v2 == 0) {
                let v6 = (v1 as u64);
                let v7 = 0x1::vector::empty<vector<u8>>();
                let v8 = &mut v7;
                0x1::vector::push_back<vector<u8>>(v8, b"HMAC-CTR-ENC");
                0x1::vector::push_back<vector<u8>>(v8, 0x1::bcs::to_bytes<u64>(&v6));
                let v9 = 0x1::vector::flatten<u8>(v7);
                v3 = 0x2::hmac::hmac_sha3_256(arg3, &v9);
                v1 = v1 + 1;
            };
            let v10 = *0x1::vector::borrow<u8>(arg0, v5) ^ *0x1::vector::borrow<u8>(&v3, v2);
            let v11 = v2 + 1;
            v2 = v11 % 32;
            0x1::vector::push_back<u8>(&mut v4, v10);
            v5 = v5 + 1;
        };
        0x1::option::some<vector<u8>>(v4)
    }

    fun mac(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : vector<u8> {
        let v0 = b"HMAC-CTR-MAC";
        let v1 = 0x1::vector::length<u8>(arg1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x2::hmac::hmac_sha3_256(arg0, &v0)
    }

    // decompiled from Move bytecode v6
}

