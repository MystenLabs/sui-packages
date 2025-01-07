module 0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::urlencode {
    public fun decode(arg0: 0x1::string::String) : vector<u8> {
        let v0 = b"";
        let v1 = 0x1::string::into_bytes(arg0);
        0x1::vector::reverse<u8>(&mut v1);
        while (0x1::vector::length<u8>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<u8>(&mut v1);
            if (v2 == 43) {
                0x1::vector::push_back<u8>(&mut v0, 32);
                continue
            };
            if (v2 == 37) {
                let v3 = 0x1::vector::pop_back<u8>(&mut v1);
                let v4 = 0x1::vector::pop_back<u8>(&mut v1);
                let v5 = if (v3 >= 65) {
                    v3 - 55
                } else {
                    v3 - 48
                };
                let v6 = if (v4 >= 65) {
                    v4 - 55
                } else {
                    v4 - 48
                };
                0x1::vector::push_back<u8>(&mut v0, v5 * 16 + v6);
                continue
            };
            0x1::vector::push_back<u8>(&mut v0, v2);
        };
        v0
    }

    public fun encode(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"";
        0x1::vector::reverse<u8>(&mut arg0);
        while (!0x1::vector::is_empty<u8>(&arg0)) {
            let v1 = 0x1::vector::pop_back<u8>(&mut arg0);
            if (v1 == 32) {
                0x1::vector::append<u8>(&mut v0, b"%20");
                continue
            };
            if ((v1 < 48 || v1 > 57) && (v1 < 65 || v1 > 90) && (v1 < 97 || v1 > 122)) {
                0x1::vector::push_back<u8>(&mut v0, 37);
                let v2 = if (v1 / 16 < 10) {
                    48
                } else {
                    55
                };
                0x1::vector::push_back<u8>(&mut v0, v1 / 16 + v2);
                let v3 = if (v1 % 16 < 10) {
                    48
                } else {
                    55
                };
                0x1::vector::push_back<u8>(&mut v0, v1 % 16 + v3);
                continue
            };
            0x1::vector::push_back<u8>(&mut v0, v1);
        };
        0x1::vector::destroy_empty<u8>(arg0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

