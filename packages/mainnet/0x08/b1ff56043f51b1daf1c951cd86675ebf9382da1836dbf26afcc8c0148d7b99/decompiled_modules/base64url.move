module 0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::base64url {
    public fun decode(arg0: 0x1::string::String) : vector<u8> {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
        let v1 = b"";
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::string::into_bytes(arg0);
        0x1::vector::reverse<u8>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&v4)) {
            let v6 = 0x1::vector::pop_back<u8>(&mut v4);
            if (v6 == 61) {
            } else {
                let (v7, v8) = 0x1::vector::index_of<u8>(&v0, &v6);
                assert!(v7, 0);
                let v9 = v2 << 6 | (v8 as u32);
                v2 = v9;
                let v10 = v3 + 6;
                v3 = v10;
                if (v10 >= 8) {
                    let v11 = v10 - 8;
                    v3 = v11;
                    0x1::vector::push_back<u8>(&mut v1, ((v9 >> v11 & 255) as u8));
                };
            };
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u8>(v4);
        v1
    }

    public fun encode(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
        let v1 = b"";
        let v2 = 0x1::vector::length<u8>(&arg0);
        0x1::vector::reverse<u8>(&mut arg0);
        while (v2 > 0) {
            let v3 = 1;
            let v4 = v3;
            let v5 = 0x1::vector::pop_back<u8>(&mut arg0);
            let v6 = if (v2 > 1) {
                v4 = v3 + 1;
                0x1::vector::pop_back<u8>(&mut arg0)
            } else {
                0
            };
            let v7 = if (v2 > 2) {
                v4 = v4 + 1;
                0x1::vector::pop_back<u8>(&mut arg0)
            } else {
                0
            };
            let v8 = if (v4 < 2) {
                64
            } else {
                (v6 & 15) << 2 | v7 >> 6
            };
            let v9 = if (v4 < 3) {
                64
            } else {
                v7 & 63
            };
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v5 >> 2) as u64)));
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, (((v5 & 3) << 4 | v6 >> 4) as u64)));
            if (v8 != 64) {
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, (v8 as u64)));
            };
            if (v9 != 64) {
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, (v9 as u64)));
            };
            v2 = v2 - v4;
        };
        0x1::string::utf8(v1)
    }

    // decompiled from Move bytecode v6
}

