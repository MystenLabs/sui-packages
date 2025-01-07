module 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian {
    struct Guardian has copy, drop, store {
        pubkey: 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::bytes20::Bytes20,
    }

    public fun new(arg0: vector<u8>) : Guardian {
        let v0 = 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::bytes20::new(arg0);
        assert!(0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::bytes20::is_nonzero(&v0), 0);
        Guardian{pubkey: v0}
    }

    public fun as_bytes(arg0: &Guardian) : vector<u8> {
        0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::bytes20::data(&arg0.pubkey)
    }

    public(friend) fun destroy(arg0: Guardian) {
        let Guardian {  } = arg0;
    }

    fun ecrecover(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg1, &arg0, 0);
        let v1 = 0x2::ecdsa_k1::decompress_pubkey(&v0);
        0x1::vector::remove<u8>(&mut v1, 0);
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::bytes20::length()) {
            0x1::vector::push_back<u8>(&mut v3, 0x1::vector::pop_back<u8>(&mut v2));
            v4 = v4 + 1;
        };
        0x1::vector::reverse<u8>(&mut v3);
        v3
    }

    public fun pubkey(arg0: &Guardian) : 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::bytes20::Bytes20 {
        arg0.pubkey
    }

    public fun verify(arg0: &Guardian, arg1: vector<u8>, arg2: vector<u8>) : bool {
        as_bytes(arg0) == ecrecover(arg2, arg1)
    }

    // decompiled from Move bytecode v6
}

