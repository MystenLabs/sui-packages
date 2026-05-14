module 0xd7a25592d4c99570a767195cd666cf9c54686d64a512907830bc9b1d91783d65::assertion {
    struct WebAuthnAssertion has drop {
        public_key: vector<u8>,
        authenticator_data: vector<u8>,
        client_data_json: vector<u8>,
        signature: vector<u8>,
    }

    public(friend) fun authenticator_data(arg0: &WebAuthnAssertion) : &vector<u8> {
        &arg0.authenticator_data
    }

    public(friend) fun base64url_encode_32(arg0: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) == 32, 4);
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 10) {
            let v3 = (*0x1::vector::borrow<u8>(arg0, v2 * 3) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, v2 * 3 + 1) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, v2 * 3 + 2) as u64);
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 >> 18 & 63) as u64)));
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 >> 12 & 63) as u64)));
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 >> 6 & 63) as u64)));
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 & 63) as u64)));
            v2 = v2 + 1;
        };
        let v4 = (*0x1::vector::borrow<u8>(arg0, 30) as u64);
        let v5 = (*0x1::vector::borrow<u8>(arg0, 31) as u64);
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v4 >> 2 & 63) as u64)));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((((v4 & 3) << 4 | v5 >> 4) & 63) as u64)));
        0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, (((v5 & 15) << 2 & 63) as u64)));
        v1
    }

    public(friend) fun client_data_json(arg0: &WebAuthnAssertion) : &vector<u8> {
        &arg0.client_data_json
    }

    public(friend) fun contains_subvec(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        if (v1 == 0) {
            return true
        };
        if (v0 < v1) {
            return false
        };
        let v2 = 0;
        while (v2 <= v0 - v1) {
            let v3 = 0;
            let v4 = true;
            while (v3 < v1) {
                if (*0x1::vector::borrow<u8>(arg0, v2 + v3) != *0x1::vector::borrow<u8>(arg1, v3)) {
                    v4 = false;
                    break
                };
                v3 = v3 + 1;
            };
            if (v4) {
                return true
            };
            v2 = v2 + 1;
        };
        false
    }

    public fun new(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : WebAuthnAssertion {
        WebAuthnAssertion{
            public_key         : arg0,
            authenticator_data : arg1,
            client_data_json   : arg2,
            signature          : arg3,
        }
    }

    public(friend) fun public_key(arg0: &WebAuthnAssertion) : &vector<u8> {
        &arg0.public_key
    }

    public(friend) fun signature(arg0: &WebAuthnAssertion) : &vector<u8> {
        &arg0.signature
    }

    public(friend) fun verify_client_data_json(arg0: &vector<u8>, arg1: &vector<u8>) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"\"challenge\":\"");
        0x1::vector::append<u8>(&mut v0, base64url_encode_32(arg1));
        0x1::vector::push_back<u8>(&mut v0, 34);
        assert!(contains_subvec(arg0, &v0), 3);
        let v1 = b"\"type\":\"webauthn.get\"";
        assert!(contains_subvec(arg0, &v1), 5);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, b"\"origin\":\"");
        0x1::vector::append<u8>(&mut v2, b"https://app.mpckit.xyz");
        0x1::vector::push_back<u8>(&mut v2, 34);
        assert!(contains_subvec(arg0, &v2), 6);
    }

    public(friend) fun verify_signature(arg0: &WebAuthnAssertion, arg1: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 32, 4);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0.authenticator_data);
        0x1::vector::append<u8>(&mut v0, 0x1::hash::sha2_256(arg0.client_data_json));
        assert!(0x2::ecdsa_r1::secp256r1_verify(&arg0.signature, &arg0.public_key, &v0, 1), 2);
        verify_client_data_json(&arg0.client_data_json, arg1);
    }

    // decompiled from Move bytecode v6
}

