module 0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::base64 {
    public fun decode(arg0: 0x1::string::String) : vector<u8> {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
        let v1 = b"";
        let v2 = 0x1::string::into_bytes(arg0);
        let v3 = 0x1::vector::length<u8>(&v2);
        0x1::vector::reverse<u8>(&mut v2);
        assert!(0x1::vector::length<u8>(&v2) % 4 == 0, 1);
        while (v3 > 0) {
            let v4 = 0x1::vector::pop_back<u8>(&mut v2);
            let (v5, v6) = 0x1::vector::index_of<u8>(&v0, &v4);
            let v7 = 0x1::vector::pop_back<u8>(&mut v2);
            let (v8, v9) = 0x1::vector::index_of<u8>(&v0, &v7);
            let v10 = 0x1::vector::pop_back<u8>(&mut v2);
            let (v11, v12) = 0x1::vector::index_of<u8>(&v0, &v10);
            let v13 = 0x1::vector::pop_back<u8>(&mut v2);
            let (v14, v15) = 0x1::vector::index_of<u8>(&v0, &v13);
            let v16 = if (v5) {
                if (v8) {
                    if (v11) {
                        v14
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v16, 0);
            0x1::vector::push_back<u8>(&mut v1, ((v6 << 2 | v9 >> 4) as u8));
            if (v12 != 64) {
                0x1::vector::push_back<u8>(&mut v1, (((v9 & 15) << 4 | v12 >> 2) as u8));
            };
            if (v15 != 64) {
                0x1::vector::push_back<u8>(&mut v1, (((v12 & 3) << 6 | v15) as u8));
            };
            v3 = v3 - 4;
        };
        v1
    }

    public fun encode(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
        let v1 = b"";
        let v2 = 0x1::vector::length<u8>(&arg0);
        0x1::vector::reverse<u8>(&mut arg0);
        while (v2 > 0) {
            let v3 = v2 - 1;
            v2 = v3;
            let v4 = 0x1::vector::pop_back<u8>(&mut arg0);
            let v5 = if (0x1::vector::length<u8>(&arg0) > 0) {
                v2 = v3 - 1;
                0x1::vector::pop_back<u8>(&mut arg0)
            } else {
                0
            };
            let v6 = if (0x1::vector::length<u8>(&arg0) > 0) {
                v2 = v2 - 1;
                0x1::vector::pop_back<u8>(&mut arg0)
            } else {
                0
            };
            let v7 = if (v5 == 0) {
                64
            } else {
                (v5 & 15) << 2 | v6 >> 6
            };
            let v8 = if (v6 == 0) {
                64
            } else {
                v6 & 63
            };
            let v9 = 0x1::vector::empty<u8>();
            let v10 = &mut v9;
            0x1::vector::push_back<u8>(v10, *0x1::vector::borrow<u8>(&v0, ((v4 >> 2) as u64)));
            0x1::vector::push_back<u8>(v10, *0x1::vector::borrow<u8>(&v0, (((v4 & 3) << 4 | v5 >> 4) as u64)));
            0x1::vector::push_back<u8>(v10, *0x1::vector::borrow<u8>(&v0, (v7 as u64)));
            0x1::vector::push_back<u8>(v10, *0x1::vector::borrow<u8>(&v0, (v8 as u64)));
            0x1::vector::append<u8>(&mut v1, v9);
        };
        0x1::string::utf8(v1)
    }

    // decompiled from Move bytecode v6
}

