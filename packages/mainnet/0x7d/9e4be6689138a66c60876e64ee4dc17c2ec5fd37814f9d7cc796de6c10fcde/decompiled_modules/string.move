module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::string {
    public fun contains_whitespace(arg0: 0x1::string::String) : bool {
        let v0 = 0;
        let v1 = 0x1::ascii::into_bytes(0x1::string::to_ascii(arg0));
        while (v0 < 0x1::vector::length<u8>(&v1)) {
            if (*0x1::vector::borrow_mut<u8>(&mut v1, v0) == 32) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun to_lower_case(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0;
        let v1 = 0x1::ascii::into_bytes(0x1::string::to_ascii(arg0));
        while (v0 < 0x1::vector::length<u8>(&v1)) {
            let v2 = 0x1::vector::borrow_mut<u8>(&mut v1, v0);
            if (*v2 >= 65 && *v2 <= 90) {
                *v2 = *v2 + 32;
            };
            v0 = v0 + 1;
        };
        0x1::string::from_ascii(0x1::ascii::string(v1))
    }

    // decompiled from Move bytecode v6
}

