module 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils {
    public fun address_to_string(arg0: &address) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<address>(arg0);
        let v1 = b"";
        let v2 = 0;
        0x1::vector::append<u8>(&mut v1, b"0x");
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            let v3 = *0x1::vector::borrow<u8>(&v0, v2);
            let v4 = b"0123456789abcdef";
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v4, (v3 as u64) / 16));
            let v5 = b"0123456789abcdef";
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v5, (v3 as u64) % 16));
            v2 = v2 + 1;
        };
        v1
    }

    public fun string_get_parent(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(*arg0);
        let v1 = 0x1::vector::length<u8>(arg0);
        let v2 = 0x1::string::utf8(b".");
        let v3 = 0x1::string::index_of(&v0, &v2);
        let v4 = v3;
        if (v3 < v1) {
            v4 = v3 + 1;
        };
        0x1::string::sub_string(&v0, v4, v1)
    }

    public fun string_start_with(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = true;
        let v1 = 0x1::vector::length<u8>(arg1);
        loop {
            v1 = v1 - 1;
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                v0 = false;
                break
            };
            if (v1 <= 0) {
                break
            };
        };
        v0
    }

    public fun string_to_u64(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (0x1::vector::length<u8>(arg0) > v1) {
            let v2 = v0 * 10;
            v0 = v2 + ((*0x1::vector::borrow<u8>(arg0, v1) - 48) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun u64_to_hex_string(arg0: u64) : vector<u8> {
        let v0 = b"";
        loop {
            let v1 = b"0123456789abcdef";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, ((arg0 % 16) as u64)));
            arg0 = arg0 >> 4;
            if (arg0 <= 0) {
                break
            };
        };
        0x1::vector::append<u8>(&mut v0, b"x0");
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun u64_to_string(arg0: u64) : vector<u8> {
        let v0 = b"";
        loop {
            let v1 = b"0123456789abcdef";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, ((arg0 % 10) as u64)));
            arg0 = arg0 / 10;
            if (arg0 <= 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun unicode_strlen(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            if (v2 < 128) {
                v1 = v1 + 1;
            } else if (v2 < 224) {
                v1 = v1 + 2;
            } else if (v2 < 240) {
                v1 = v1 + 3;
            } else if (v2 < 248) {
                v1 = v1 + 4;
            } else if (v2 < 252) {
                v1 = v1 + 5;
            } else {
                v1 = v1 + 6;
            };
            v0 = v0 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

