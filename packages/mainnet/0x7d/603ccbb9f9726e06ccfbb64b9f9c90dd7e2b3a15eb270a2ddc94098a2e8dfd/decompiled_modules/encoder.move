module 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder {
    public fun encode(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0) {
            0x1::vector::singleton<u8>(128)
        } else if (v0 == 1 && *0x1::vector::borrow<u8>(arg0, 0) < 128) {
            *arg0
        } else if (v0 <= 55) {
            let v2 = encode_length(v0, 128);
            0x1::vector::append<u8>(&mut v2, *arg0);
            v2
        } else {
            let v3 = encode_length(v0, 183);
            0x1::vector::append<u8>(&mut v3, *arg0);
            v3
        }
    }

    public fun encode_address(arg0: &address) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<address>(arg0);
        encode(&v0)
    }

    public fun encode_bool(arg0: bool) : vector<u8> {
        if (arg0 == true) {
            return x"01"
        };
        x"00"
    }

    public fun encode_length(arg0: u64, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 < 56) {
            0x1::vector::push_back<u8>(&mut v0, arg1 + (arg0 as u8));
        } else {
            let v1 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::to_bytes_u64_sign(arg0, false);
            0x1::vector::push_back<u8>(&mut v0, arg1 + (0x1::vector::length<u8>(&v1) as u8));
            0x1::vector::append<u8>(&mut v0, v1);
        };
        v0
    }

    public fun encode_list(arg0: &vector<vector<u8>>, arg1: bool) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = *arg0;
        if (0x1::vector::length<vector<u8>>(&v2) > 0) {
            0x1::vector::reverse<vector<u8>>(&mut v2);
            while (!0x1::vector::is_empty<vector<u8>>(&v2)) {
                if (arg1 == true) {
                    let v3 = 0x1::vector::pop_back<vector<u8>>(&mut v2);
                    0x1::vector::append<u8>(&mut v0, encode(&v3));
                    continue
                };
                0x1::vector::append<u8>(&mut v0, 0x1::vector::pop_back<vector<u8>>(&mut v2));
            };
            if (0x1::vector::length<u8>(&v0) <= 55) {
                v1 = encode_length(0x1::vector::length<u8>(&v0), 192);
                0x1::vector::append<u8>(&mut v1, v0);
            } else {
                let v4 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::to_bytes_u64_sign(0x1::vector::length<u8>(&v0), false);
                0x1::vector::push_back<u8>(&mut v1, ((247 + 0x1::vector::length<u8>(&v4)) as u8));
                0x1::vector::append<u8>(&mut v1, v4);
                0x1::vector::append<u8>(&mut v1, v0);
            };
        } else {
            0x1::vector::push_back<u8>(&mut v1, 192);
        };
        v1
    }

    public fun encode_string(arg0: &0x1::string::String) : vector<u8> {
        encode(0x1::string::bytes(arg0))
    }

    public fun encode_strings(arg0: &vector<0x1::string::String>) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(arg0)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(arg0, v1);
            0x1::vector::push_back<vector<u8>>(&mut v0, encode_string(&v2));
            v1 = v1 + 1;
        };
        encode_list(&v0, false)
    }

    public fun encode_u128(arg0: u128) : vector<u8> {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::to_bytes_u128_sign(arg0, true);
        encode(&v0)
    }

    public fun encode_u32(arg0: u32) : vector<u8> {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::to_bytes_u32_sign(arg0, true);
        encode(&v0)
    }

    public fun encode_u64(arg0: u64) : vector<u8> {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::to_bytes_u64_sign(arg0, true);
        encode(&v0)
    }

    public fun encode_u8(arg0: u8) : vector<u8> {
        let v0 = 0x1::vector::singleton<u8>(arg0);
        encode(&v0)
    }

    // decompiled from Move bytecode v6
}

