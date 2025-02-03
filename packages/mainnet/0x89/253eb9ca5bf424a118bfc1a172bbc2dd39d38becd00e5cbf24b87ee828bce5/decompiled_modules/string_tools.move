module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::string_tools {
    public fun address_to_hexstring(arg0: &address) : 0x1::string::String {
        let v0 = 0x1::bcs::to_bytes<address>(arg0);
        let v1 = b"0123456789abcdef";
        let v2 = &v1;
        let v3 = b"0x";
        let v4 = &mut v3;
        let v5 = 0;
        let v6 = true;
        while (v5 < 0x1::vector::length<u8>(&v0)) {
            let v7 = *0x1::vector::borrow<u8>(&v0, v5);
            v5 = v5 + 1;
            if (v7 != 0) {
                v6 = false;
            };
            if (v6) {
                continue
            };
            0x1::vector::push_back<u8>(v4, *0x1::vector::borrow<u8>(v2, ((v7 / 16) as u64)));
            0x1::vector::push_back<u8>(v4, *0x1::vector::borrow<u8>(v2, ((v7 % 16) as u64)));
        };
        0x1::string::utf8(*v4)
    }

    public fun bytes_to_hexstring(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = &mut v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg0)) {
            0x1::string::append(v1, u64_to_hexstring((*0x1::vector::borrow<u8>(arg0, v2) as u64)));
            v2 = v2 + 1;
        };
        *v1
    }

    public fun get_position_key(arg0: address, arg1: u32, arg2: bool, arg3: u32, arg4: bool) : 0x1::string::String {
        let v0 = address_to_hexstring(&arg0);
        let v1 = if (arg2) {
            0x1::string::utf8(b"-")
        } else {
            0x1::string::utf8(b"+")
        };
        let v2 = if (arg4) {
            0x1::string::utf8(b"-")
        } else {
            0x1::string::utf8(b"+")
        };
        0x1::string::append(&mut v0, v1);
        0x1::string::append(&mut v0, u64_to_string((arg1 as u64)));
        0x1::string::append(&mut v0, v2);
        0x1::string::append(&mut v0, u64_to_string((arg3 as u64)));
        v0
    }

    public fun u64_to_hexstring(arg0: u64) : 0x1::string::String {
        let v0 = b"0123456789abcdef";
        let v1 = &v0;
        let v2 = b"";
        let v3 = &mut v2;
        0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(v1, arg0 / 16));
        0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(v1, arg0 % 16));
        0x1::string::utf8(*v3)
    }

    public fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x2::math::pow(10, 19);
        let v1 = 20;
        let v2 = 0x1::string::utf8(b"");
        let v3 = &mut v2;
        while (v1 > 0) {
            let v4 = arg0 / v0;
            if (v4 != 0) {
                arg0 = arg0 - v4 * v0;
            };
            if (!0x1::string::is_empty(v3) || v4 != 0) {
                let v5 = 0x1::vector::empty<u8>();
                0x1::vector::push_back<u8>(&mut v5, ((v4 + 48) as u8));
                0x1::string::append_utf8(v3, v5);
            };
            v0 = v0 / 10;
            v1 = v1 - 1;
        };
        *v3
    }

    // decompiled from Move bytecode v6
}

