module 0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::urlencode {
    public fun decode(arg0: 0x1::string::String) : vector<u8> {
        let v0 = b"";
        let v1 = 0x1::string::into_bytes(arg0);
        let v2 = 0x1::vector::length<u8>(&v1);
        0x1::vector::reverse<u8>(&mut v1);
        while (v2 > 0) {
            let v3 = 0x1::vector::pop_back<u8>(&mut v1);
            let v4 = &v3;
            if (*v4 == 37) {
                v2 = v2 - 3;
                let v5 = 0x1::vector::pop_back<u8>(&mut v1);
                let v6 = 0x1::vector::pop_back<u8>(&mut v1);
                let v7 = if (v5 >= 65) {
                    v5 - 55
                } else {
                    v5 - 48
                };
                let v8 = if (v6 >= 65) {
                    v6 - 55
                } else {
                    v6 - 48
                };
                0x1::vector::push_back<u8>(&mut v0, v7 * 16 + v8);
                continue
            };
            if (*v4 == 43) {
                v2 = v2 - 1;
                0x1::vector::push_back<u8>(&mut v0, 32);
                continue
            };
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v0, v3);
        };
        v0
    }

    public fun encode(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"";
        0x1::vector::reverse<u8>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = 0x1::vector::pop_back<u8>(&mut arg0);
            if (v2 == 32) {
                0x1::vector::append<u8>(&mut v0, b"%20");
            } else {
                let v3 = if (v2 < 48 || v2 > 57) {
                    if (v2 < 65 || v2 > 90) {
                        v2 < 97 || v2 > 122
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    0x1::vector::push_back<u8>(&mut v0, 37);
                    let v4 = if (v2 / 16 < 10) {
                        48
                    } else {
                        55
                    };
                    0x1::vector::push_back<u8>(&mut v0, v2 / 16 + v4);
                    let v5 = if (v2 % 16 < 10) {
                        48
                    } else {
                        55
                    };
                    0x1::vector::push_back<u8>(&mut v0, v2 % 16 + v5);
                } else {
                    0x1::vector::push_back<u8>(&mut v0, v2);
                };
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u8>(arg0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

