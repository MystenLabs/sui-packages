module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::utils {
    public(friend) fun decode_metadata(arg0: vector<u8>) : (u32, vector<u8>) {
        if (0x1::vector::length<u8>(&arg0) < 4) {
            (0, b"")
        } else {
            let v2 = 0;
            let v3 = 0;
            while (v2 < 4) {
                let v4 = ((v3 << 8) as u32);
                v3 = v4 + (0x1::vector::remove<u8>(&mut arg0, 0) as u32);
                v2 = v2 + 1;
            };
            (v3, arg0)
        }
    }

    entry fun is_lowercase(arg0: u8) : bool {
        arg0 >= 97 && arg0 < 97 + 26
    }

    entry fun is_number(arg0: u8) : bool {
        arg0 >= 48 && arg0 < 48 + 10
    }

    entry fun is_uppercase(arg0: u8) : bool {
        arg0 >= 65 && arg0 < 65 + 26
    }

    public(friend) fun module_from_symbol(arg0: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::as_bytes(arg0);
        let v1 = b"";
        let v2 = 0;
        while (is_number(*0x1::vector::borrow<u8>(v0, v2))) {
            v2 = v2 + 1;
        };
        while (v2 < 0x1::vector::length<u8>(v0)) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            if (is_lowercase(v3) || is_number(v3)) {
                0x1::vector::push_back<u8>(&mut v1, v3);
            } else if (is_uppercase(v3)) {
                0x1::vector::push_back<u8>(&mut v1, v3 - 65 + 97);
            } else if (v3 == 95 || v3 == 32) {
                0x1::vector::push_back<u8>(&mut v1, 95);
            };
            v2 = v2 + 1;
        };
        0x1::ascii::string(v1)
    }

    // decompiled from Move bytecode v6
}

