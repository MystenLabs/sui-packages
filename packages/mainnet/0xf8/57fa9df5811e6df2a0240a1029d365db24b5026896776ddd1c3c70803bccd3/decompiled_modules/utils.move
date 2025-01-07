module 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::utils {
    public fun bytes_to_hex(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"0123456789abcdef";
        let v1 = b"0x";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg0)) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 & 15) as u64)));
            v2 = v2 + 1;
        };
        0x1::string::utf8(v1)
    }

    public fun hex_to_base58(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
        let v1 = arg0;
        let v2 = b"";
        while (!0x1::vector::is_empty<u8>(&v1)) {
            let v3 = 0;
            v1 = b"";
            let v4 = 0;
            while (v4 < 0x1::vector::length<u8>(&v1)) {
                let v5 = (*0x1::vector::borrow<u8>(&v1, v4) as u64) + v3 * 256;
                let v6 = v5 / 58;
                v3 = v5 % 58;
                if (!0x1::vector::is_empty<u8>(&v1) || v6 > 0) {
                    0x1::vector::push_back<u8>(&mut v1, (v6 as u8));
                };
                v4 = v4 + 1;
            };
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (v3 as u64)));
        };
        let v7 = b"";
        let v8 = 0x1::vector::length<u8>(&v2);
        while (v8 > 0) {
            v8 = v8 - 1;
            0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v2, v8));
        };
        0x1::string::utf8(v7)
    }

    public fun hex_to_bytes(arg0: 0x1::string::String) : vector<u8> {
        let v0 = b"0123456789abcdef";
        let v1 = 0x1::string::bytes(&arg0);
        let v2 = b"";
        let v3 = 2;
        while (v3 < 0x1::vector::length<u8>(v1)) {
            let v4 = *0x1::vector::borrow<u8>(v1, v3);
            let v5 = *0x1::vector::borrow<u8>(v1, v3 + 1);
            let (_, v7) = 0x1::vector::index_of<u8>(&v0, &v4);
            let (_, v9) = 0x1::vector::index_of<u8>(&v0, &v5);
            assert!(v7 >= 0 && v9 >= 0, 0);
            0x1::vector::push_back<u8>(&mut v2, ((v7 << 4) as u8) | (v9 as u8));
            v3 = v3 + 2;
        };
        v2
    }

    // decompiled from Move bytecode v6
}

