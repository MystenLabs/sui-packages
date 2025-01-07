module 0x53d0489394719f30d0db5716935cbde374f573c07b9d2031db9f15835f874f30::base64 {
    public fun decode(arg0: &0x1::string::String) : vector<u8> {
        let v0 = get_char_map();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::string::as_bytes(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v2)) {
            let v4 = if (v3 + 2 < 0x1::vector::length<u8>(v2)) {
                let v5 = 0x1::vector::borrow<u8>(v2, v3 + 2);
                if (0x2::vec_map::contains<u8, u32>(&v0, v5)) {
                    *0x2::vec_map::get<u8, u32>(&v0, v5)
                } else {
                    64
                }
            } else {
                64
            };
            let v6 = if (v3 + 3 < 0x1::vector::length<u8>(v2)) {
                let v7 = 0x1::vector::borrow<u8>(v2, v3 + 3);
                if (0x2::vec_map::contains<u8, u32>(&v0, v7)) {
                    *0x2::vec_map::get<u8, u32>(&v0, v7)
                } else {
                    64
                }
            } else {
                64
            };
            let v8 = *0x2::vec_map::get<u8, u32>(&v0, 0x1::vector::borrow<u8>(v2, v3)) << 18 | *0x2::vec_map::get<u8, u32>(&v0, 0x1::vector::borrow<u8>(v2, v3 + 1)) << 12 | v4 << 6 | v6;
            0x1::vector::push_back<u8>(&mut v1, ((v8 >> 16 & 255) as u8));
            if (v4 != 64) {
                0x1::vector::push_back<u8>(&mut v1, ((v8 >> 8 & 255) as u8));
            };
            if (v6 != 64) {
                0x1::vector::push_back<u8>(&mut v1, ((v8 & 255) as u8));
            };
            v3 = v3 + 4;
        };
        v1
    }

    public fun encode(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = if (v1 + 1 < 0x1::vector::length<u8>(arg0)) {
                *0x1::vector::borrow<u8>(arg0, v1 + 1)
            } else {
                0
            };
            let v3 = if (v1 + 2 < 0x1::vector::length<u8>(arg0)) {
                *0x1::vector::borrow<u8>(arg0, v1 + 2)
            } else {
                0
            };
            let v4 = (*0x1::vector::borrow<u8>(arg0, v1) as u32) << 16 | (v2 as u32) << 8 | (v3 as u32);
            let v5 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v5, ((v4 >> 18 & 63) as u64)));
            let v6 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v6, ((v4 >> 12 & 63) as u64)));
            if (v1 + 1 < 0x1::vector::length<u8>(arg0)) {
                let v7 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v7, ((v4 >> 6 & 63) as u64)));
            } else {
                let v8 = b"=";
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v8, 0));
            };
            if (v1 + 2 < 0x1::vector::length<u8>(arg0)) {
                let v9 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v9, ((v4 & 63) as u64)));
            } else {
                let v10 = b"=";
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v10, 0));
            };
            v1 = v1 + 3;
        };
        0x1::string::utf8(v0)
    }

    fun get_char_map() : 0x2::vec_map::VecMap<u8, u32> {
        let v0 = 0x2::vec_map::empty<u8, u32>();
        let v1 = 0;
        let v2 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        while (v1 < 0x1::vector::length<u8>(&v2)) {
            let v3 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x2::vec_map::insert<u8, u32>(&mut v0, *0x1::vector::borrow<u8>(&v3, v1), (v1 as u32));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

