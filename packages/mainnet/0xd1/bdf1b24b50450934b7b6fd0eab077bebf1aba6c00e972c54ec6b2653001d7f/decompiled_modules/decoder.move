module 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder {
    public fun decode(arg0: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) > 0, 1);
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        if (v0 == 128) {
            0x1::vector::empty<u8>()
        } else if (v0 < 128) {
            0x1::vector::singleton<u8>(v0)
        } else if (v0 < 184) {
            0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(arg0, 1, ((v0 - 128) as u64))
        } else {
            let v2 = v0 - 183;
            let v3 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(arg0, 1, (v2 as u64));
            0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(arg0, ((v2 + 1) as u64), 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::from_bytes_u64(&v3))
        }
    }

    public fun decode_address(arg0: &vector<u8>) : address {
        let v0 = 0x2::bcs::new(*arg0);
        0x2::bcs::peel_address(&mut v0)
    }

    public fun decode_bool(arg0: &vector<u8>) : bool {
        *0x1::vector::borrow<u8>(arg0, 0) == 1
    }

    public fun decode_length(arg0: &vector<u8>, arg1: u8) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0) {
            0
        } else if (v0 < 56) {
            ((*0x1::vector::borrow<u8>(arg0, 0) - arg1) as u64)
        } else {
            let v2 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(arg0, 1, ((*0x1::vector::borrow<u8>(arg0, 0) - arg1) as u64));
            0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::from_bytes_u64(&v2)
        }
    }

    public fun decode_list(arg0: &vector<u8>) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        if (0x1::vector::length<u8>(arg0) > 0) {
            let v1 = *0x1::vector::borrow<u8>(arg0, 0);
            let v2 = if (v1 <= 247) {
                ((v1 - 192) as u64)
            } else {
                let v3 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(arg0, 1, ((v1 - 247) as u64));
                0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::from_bytes_u64(&v3)
            };
            let v4 = 0x1::vector::length<u8>(arg0) - v2;
            let v5 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(arg0, v4, 0x1::vector::length<u8>(arg0) - v4);
            let v6 = 0;
            while (v6 < 0x1::vector::length<u8>(&v5)) {
                let v7 = *0x1::vector::borrow<u8>(&v5, v6);
                if (v7 == 128) {
                    0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::vector::empty<u8>());
                    v6 = v6 + 1;
                    continue
                };
                if (v7 < 128) {
                    0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::vector::singleton<u8>(v7));
                    v6 = v6 + 1;
                    continue
                };
                if (v7 > 128 && v7 < 184) {
                    let v8 = ((v7 - 128) as u64);
                    0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(&v5, ((v6 + 1) as u64), v8));
                    v6 = v6 + v8 + 1;
                    continue
                };
                if (v7 == 192) {
                    0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::vector::empty<u8>());
                    v6 = v6 + 1;
                    continue
                };
                if (v7 > 192 && v7 < 247) {
                    let v9 = ((v7 - 192) as u64);
                    0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(&v5, (v6 as u64), v9 + 1));
                    v6 = v6 + v9 + 1;
                    continue
                };
                if (v7 > 183 && v7 < 192) {
                    let v10 = ((v7 - 183) as u64);
                    let v11 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(&v5, ((v6 + 1) as u64), v10);
                    let v12 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::from_bytes_u64(&v11);
                    0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(&v5, ((v6 + v10 + 1) as u64), v12));
                    v6 = v6 + v10 + v12 + 1;
                    continue
                };
                assert!(v7 > 247, 1);
                let v13 = ((v7 - 247) as u64);
                let v14 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(&v5, ((v6 + 1) as u64), v13);
                let v15 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::from_bytes_u64(&v14);
                if (v7 == 248 && v15 == 0) {
                    0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::vector::empty<u8>());
                } else {
                    0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::slice_vector(&v5, (v6 as u64), v15 + v13 + 1));
                };
                v6 = v6 + v13 + v15 + 1;
            };
        };
        v0
    }

    public fun decode_string(arg0: &vector<u8>) : 0x1::string::String {
        0x1::string::utf8(*arg0)
    }

    public fun decode_strings(arg0: &vector<u8>) : vector<0x1::string::String> {
        let v0 = decode_list(arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&v0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, decode_string(0x1::vector::borrow<vector<u8>>(&v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun decode_u128(arg0: &vector<u8>) : u128 {
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::from_bytes_u128(arg0)
    }

    public fun decode_u64(arg0: &vector<u8>) : u64 {
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::utils::from_bytes_u64(arg0)
    }

    public fun decode_u8(arg0: &vector<u8>) : u8 {
        *0x1::vector::borrow<u8>(arg0, 0)
    }

    // decompiled from Move bytecode v6
}

