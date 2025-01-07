module 0x5b7964cf132015d66a79cfa248789204389e7fa7af0b8c4cb75a6b03c5877ea1::base64 {
    public fun decode(arg0: &vector<u8>) : vector<u8> {
        if (0x1::vector::is_empty<u8>(arg0) || 0x1::vector::length<u8>(arg0) % 4 != 0) {
            return 0x1::vector::empty<u8>()
        };
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = pos_of_char(*0x1::vector::borrow<u8>(arg0, v2 + 1));
            0x1::vector::push_back<u8>(&mut v1, (pos_of_char(*0x1::vector::borrow<u8>(arg0, v2)) << 2) + ((v3 & 48) >> 4));
            if (v2 + 2 < v0 && *0x1::vector::borrow<u8>(arg0, v2 + 2) != 61 && *0x1::vector::borrow<u8>(arg0, v2 + 2) != 46) {
                0x1::vector::push_back<u8>(&mut v1, ((v3 & 15) << 4) + ((pos_of_char(*0x1::vector::borrow<u8>(arg0, v2 + 2)) & 60) >> 2));
                if (v2 + 3 < v0 && *0x1::vector::borrow<u8>(arg0, v2 + 3) != 61 && *0x1::vector::borrow<u8>(arg0, v2 + 3) != 46) {
                    0x1::vector::push_back<u8>(&mut v1, ((pos_of_char(*0x1::vector::borrow<u8>(arg0, v2 + 2)) & 3) << 6) + pos_of_char(*0x1::vector::borrow<u8>(arg0, v2 + 3)));
                };
            };
            v2 = v2 + 4;
        };
        v1
    }

    public fun encode(arg0: &vector<u8>) : vector<u8> {
        if (0x1::vector::is_empty<u8>(arg0)) {
            return 0x1::vector::empty<u8>()
        };
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 61;
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v4, (((*0x1::vector::borrow<u8>(arg0, v3) & 252) >> 2) as u64)));
            if (v3 + 3 >= v0) {
                if (v0 % 3 == 1) {
                    let v5 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v5, (((*0x1::vector::borrow<u8>(arg0, v3) & 3) << 4) as u64)));
                    0x1::vector::push_back<u8>(&mut v2, v1);
                    0x1::vector::push_back<u8>(&mut v2, v1);
                } else if (v0 % 3 == 2) {
                    let v6 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v6, ((((*0x1::vector::borrow<u8>(arg0, v3) & 3) << 4) + ((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 240) >> 4)) as u64)));
                    let v7 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v7, (((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 15) << 2) as u64)));
                    0x1::vector::push_back<u8>(&mut v2, v1);
                } else {
                    let v8 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v8, ((((*0x1::vector::borrow<u8>(arg0, v3) & 3) << 4) + ((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 240) >> 4)) as u64)));
                    let v9 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v9, ((((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 15) << 2) + ((*0x1::vector::borrow<u8>(arg0, v3 + 2) & 192) >> 6)) as u64)));
                    let v10 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                    0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v10, ((*0x1::vector::borrow<u8>(arg0, v3 + 2) & 63) as u64)));
                };
            } else {
                let v11 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v11, ((((*0x1::vector::borrow<u8>(arg0, v3) & 3) << 4) + ((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 240) >> 4)) as u64)));
                let v12 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v12, ((((*0x1::vector::borrow<u8>(arg0, v3 + 1) & 15) << 2) + ((*0x1::vector::borrow<u8>(arg0, v3 + 2) & 192) >> 6)) as u64)));
                let v13 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v13, ((*0x1::vector::borrow<u8>(arg0, v3 + 2) & 63) as u64)));
            };
            v3 = v3 + 3;
        };
        v2
    }

    fun pos_of_char(arg0: u8) : u8 {
        if (arg0 >= 65 && arg0 <= 90) {
            return arg0 - 65
        };
        if (arg0 >= 97 && arg0 <= 122) {
            return arg0 - 97 + 25 + 1
        };
        if (arg0 >= 48 && arg0 <= 57) {
            return arg0 - 48 + 25 + 25 + 2
        };
        if (arg0 == 43 || arg0 == 45) {
            return 62
        };
        assert!(arg0 == 47 || arg0 == 95, 1001);
        63
    }

    // decompiled from Move bytecode v6
}

