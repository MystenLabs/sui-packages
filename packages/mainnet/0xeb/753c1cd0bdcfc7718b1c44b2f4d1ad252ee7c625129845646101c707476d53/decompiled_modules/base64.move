module 0xeb753c1cd0bdcfc7718b1c44b2f4d1ad252ee7c625129845646101c707476d53::base64 {
    public fun decode(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
        let v1 = b"";
        let v2 = 0x1::string::into_bytes(arg0);
        0x1::vector::reverse<u8>(&mut v2);
        assert!(0x1::vector::length<u8>(&v2) % 4 == 0, 9223372221538369535);
        while (0x1::vector::length<u8>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<u8>(&mut v2);
            let (_, v5) = 0x1::vector::index_of<u8>(&v0, &v3);
            let v6 = 0x1::vector::pop_back<u8>(&mut v2);
            let (_, v8) = 0x1::vector::index_of<u8>(&v0, &v6);
            let v9 = 0x1::vector::pop_back<u8>(&mut v2);
            let (_, v11) = 0x1::vector::index_of<u8>(&v0, &v9);
            let v12 = 0x1::vector::pop_back<u8>(&mut v2);
            let (_, v14) = 0x1::vector::index_of<u8>(&v0, &v12);
            0x1::vector::push_back<u8>(&mut v1, ((v5 << 2 | v8 >> 4) as u8));
            if (v11 != 64) {
                0x1::vector::push_back<u8>(&mut v1, (((v8 & 15) << 4 | v11 >> 2) as u8));
            };
            if (v14 != 64) {
                0x1::vector::push_back<u8>(&mut v1, (((v11 & 3) << 6 | v14) as u8));
            };
        };
        0x1::string::utf8(v1)
    }

    public fun encode(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
        let v1 = b"";
        let v2 = 0x1::string::into_bytes(arg0);
        0x1::vector::reverse<u8>(&mut v2);
        while (0x1::vector::length<u8>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<u8>(&mut v2);
            let v4 = if (0x1::vector::length<u8>(&v2) > 0) {
                0x1::vector::pop_back<u8>(&mut v2)
            } else {
                0
            };
            let v5 = if (0x1::vector::length<u8>(&v2) > 0) {
                0x1::vector::pop_back<u8>(&mut v2)
            } else {
                0
            };
            let v6 = if (v4 == 0) {
                64
            } else {
                (v4 & 15) << 2 | v5 >> 6
            };
            let v7 = if (v5 == 0) {
                64
            } else {
                v5 & 63
            };
            let v8 = 0x1::vector::empty<u8>();
            let v9 = &mut v8;
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(&v0, ((v3 >> 2) as u64)));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(&v0, (((v3 & 3) << 4 | v4 >> 4) as u64)));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(&v0, (v6 as u64)));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(&v0, (v7 as u64)));
            0x1::vector::append<u8>(&mut v1, v8);
        };
        0x1::string::utf8(v1)
    }

    // decompiled from Move bytecode v6
}

