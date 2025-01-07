module 0x6e3f76eea8bcbe0f59c7f26df47f4f8bd718b7f67ba1d972fe3ea3f6c14c12dc::utils {
    public(friend) fun data_to_RGB(arg0: vector<u8>, arg1: u64) : 0x1::string::String {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::length<u8>(&arg0);
        if (*0x1::vector::borrow<u8>(&arg0, 0) & 1 == 1) {
            0x1::vector::reverse<u8>(&mut arg0);
        };
        while (v3 > 0) {
            if (v3 > 0) {
                v0 = v0 + (0x1::vector::pop_back<u8>(&mut arg0) as u64);
                v3 = v3 - 1;
            };
            if (v3 > 0) {
                v1 = v1 + (0x1::vector::pop_back<u8>(&mut arg0) as u64);
                v3 = v3 - 1;
            };
            if (v3 > 0) {
                v2 = v2 + (0x1::vector::pop_back<u8>(&mut arg0) as u64);
                v3 = v3 - 1;
            };
        };
        let v4 = intToHexStringVectorU8(0x2::math::diff(v0, arg1) % 256);
        let v5 = intToHexStringVectorU8(0x2::math::diff(v1, arg1) % 256);
        let v6 = intToHexStringVectorU8(0x2::math::diff(v2, arg1) % 256);
        let v7 = 0x1::vector::empty<u8>();
        if (0x1::vector::length<u8>(&v4) == 1) {
            0x1::vector::append<u8>(&mut v7, b"0");
        };
        0x1::vector::append<u8>(&mut v7, v4);
        if (0x1::vector::length<u8>(&v5) == 1) {
            0x1::vector::append<u8>(&mut v7, b"0");
        };
        0x1::vector::append<u8>(&mut v7, v5);
        if (0x1::vector::length<u8>(&v6) == 1) {
            0x1::vector::append<u8>(&mut v7, b"0");
        };
        0x1::vector::append<u8>(&mut v7, v6);
        0x1::string::utf8(v7)
    }

    public fun intToHexString(arg0: u64) : 0x1::string::String {
        0x1::string::utf8(intToHexStringVectorU8(arg0))
    }

    public fun intToHexStringVectorU8(arg0: u64) : vector<u8> {
        let v0 = b"0123456789ABCDEF";
        let v1 = b"";
        if (arg0 > 0) {
            while (arg0 > 0) {
                let v2 = arg0 % 16;
                arg0 = arg0 / 16;
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            };
            0x1::vector::reverse<u8>(&mut v1);
        } else {
            0x1::vector::append<u8>(&mut v1, b"0");
        };
        v1
    }

    public fun num_to_alpha(arg0: u64) : vector<u8> {
        let v0 = b"0123456789";
        let v1 = 0;
        while (arg0 > 0) {
            arg0 = arg0 >> 1;
            v1 = v1 + 1;
        };
        let v2 = b"";
        if (v1 < 10) {
            0x1::vector::push_back<u8>(&mut v2, 48);
            0x1::vector::push_back<u8>(&mut v2, 46);
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, v1));
        } else {
            0x1::vector::push_back<u8>(&mut v2, 49);
            0x1::vector::push_back<u8>(&mut v2, 46);
            0x1::vector::push_back<u8>(&mut v2, 48);
        };
        v2
    }

    // decompiled from Move bytecode v6
}

