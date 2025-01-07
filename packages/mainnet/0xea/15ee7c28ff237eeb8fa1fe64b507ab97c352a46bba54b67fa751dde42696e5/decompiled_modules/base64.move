module 0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::base64 {
    public fun decode(arg0: 0x1::string::String) : vector<u8> {
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
        v1
    }

    public fun encode(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
        let v1 = b"";
        0x1::vector::reverse<u8>(&mut arg0);
        while (0x1::vector::length<u8>(&arg0) > 0) {
            let v2 = 0x1::vector::pop_back<u8>(&mut arg0);
            let v3 = if (0x1::vector::length<u8>(&arg0) > 0) {
                0x1::vector::pop_back<u8>(&mut arg0)
            } else {
                0
            };
            let v4 = if (0x1::vector::length<u8>(&arg0) > 0) {
                0x1::vector::pop_back<u8>(&mut arg0)
            } else {
                0
            };
            let v5 = if (v3 == 0) {
                64
            } else {
                (v3 & 15) << 2 | v4 >> 6
            };
            let v6 = if (v4 == 0) {
                64
            } else {
                v4 & 63
            };
            let v7 = 0x1::vector::empty<u8>();
            let v8 = &mut v7;
            0x1::vector::push_back<u8>(v8, *0x1::vector::borrow<u8>(&v0, ((v2 >> 2) as u64)));
            0x1::vector::push_back<u8>(v8, *0x1::vector::borrow<u8>(&v0, (((v2 & 3) << 4 | v3 >> 4) as u64)));
            0x1::vector::push_back<u8>(v8, *0x1::vector::borrow<u8>(&v0, (v5 as u64)));
            0x1::vector::push_back<u8>(v8, *0x1::vector::borrow<u8>(&v0, (v6 as u64)));
            0x1::vector::append<u8>(&mut v1, v7);
        };
        0x1::string::utf8(v1)
    }

    // decompiled from Move bytecode v6
}

