module 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::string_util {
    public fun has_valid_spaces(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(&arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        let v2 = if (v1 == 0) {
            true
        } else if (*0x1::vector::borrow<u8>(v0, 0) == 32) {
            true
        } else {
            *0x1::vector::borrow<u8>(v0, v1 - 1) == 32
        };
        if (v2) {
            return false
        };
        let v3 = 0;
        while (v3 < v1 - 1) {
            if (*0x1::vector::borrow<u8>(v0, v3) == 32 && *0x1::vector::borrow<u8>(v0, v3 + 1) == 32) {
                return false
            };
            v3 = v3 + 1;
        };
        true
    }

    public fun is_alphanumeric(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(&arg0);
        let v1 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            if (!0x1::vector::contains<u8>(&v1, &v3) && v3 != 32) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun remove_space(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::as_bytes(&arg0);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            if (*0x1::vector::borrow<u8>(v0, v2) != 32) {
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(v0, v2));
            };
            v2 = v2 + 1;
        };
        0x1::string::utf8(v1)
    }

    // decompiled from Move bytecode v7
}

