module 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::ascii_utils {
    public fun append(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0;
        while (v0 < 0x1::ascii::length(&arg1)) {
            0x1::ascii::push_char(&mut arg0, into_char(&arg1, v0));
            v0 = v0 + 1;
        };
        arg0
    }

    public fun addr_into_string(arg0: address) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::bcs::to_bytes<address>(&arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            0x1::vector::push_back<u8>(&mut v0, u8_to_ascii(*0x1::vector::borrow<u8>(&v1, v2) / 16));
            0x1::vector::push_back<u8>(&mut v0, u8_to_ascii(*0x1::vector::borrow<u8>(&v1, v2) % 16));
            v2 = v2 + 1;
        };
        0x1::ascii::string(v0)
    }

    public fun ascii_to_u8(arg0: u8) : u8 {
        assert!(0x1::ascii::is_valid_char(arg0), 2);
        if (arg0 < 58) {
            arg0 - 48
        } else {
            arg0 - 87
        }
    }

    public fun bytes_to_hex_string(arg0: vector<u8>) : 0x1::ascii::String {
        let v0 = b"0x";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            let v3 = b"0123456789abcdef";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v3, ((v2 >> 4 & 15) as u64)));
            let v4 = b"0123456789abcdef";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v4, ((v2 & 15) as u64)));
            v1 = v1 + 1;
        };
        0x1::ascii::string(v0)
    }

    public fun contains(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String) : bool {
        if (0x1::ascii::length(&arg1) > 0x1::ascii::length(&arg0)) {
            return false
        };
        let v0 = 0x1::ascii::length(&arg1) - 1;
        let v1 = 0;
        while (v1 + v0 < 0x1::ascii::length(&arg0)) {
            while (into_char(&arg0, v1 + v0) == into_char(&arg1, v0)) {
                if (v0 == 0) {
                    return true
                };
                v0 = v0 - 1;
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun into_char(arg0: &0x1::ascii::String, arg1: u64) : 0x1::ascii::Char {
        let v0 = 0x1::ascii::into_bytes(*arg0);
        0x1::ascii::char(*0x1::vector::borrow<u8>(&v0, arg1))
    }

    public fun slice(arg0: 0x1::ascii::String, arg1: u64, arg2: u64) : 0x1::ascii::String {
        assert!(arg2 <= 0x1::ascii::length(&arg0) && arg1 <= arg2, 0);
        let v0 = 0x1::ascii::into_bytes(arg0);
        let v1 = b"";
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, arg1));
            arg1 = arg1 + 1;
        };
        0x1::ascii::string(v1)
    }

    public fun to_lower_case(arg0: 0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0;
        let v1 = 0x1::ascii::into_bytes(arg0);
        while (v0 < 0x1::vector::length<u8>(&v1)) {
            let v2 = 0x1::vector::borrow_mut<u8>(&mut v1, v0);
            if (*v2 >= 65 && *v2 <= 90) {
                *v2 = *v2 + 32;
            };
            v0 = v0 + 1;
        };
        0x1::ascii::string(v1)
    }

    public fun to_upper_case(arg0: 0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0;
        let v1 = 0x1::ascii::into_bytes(arg0);
        while (v0 < 0x1::vector::length<u8>(&v1)) {
            let v2 = 0x1::vector::borrow_mut<u8>(&mut v1, v0);
            if (*v2 >= 97 && *v2 <= 122) {
                *v2 = *v2 - 32;
            };
            v0 = v0 + 1;
        };
        0x1::ascii::string(v1)
    }

    public fun u128_to_hex_string(arg0: u128) : 0x1::ascii::String {
        if (arg0 == 0) {
            return 0x1::ascii::string(b"0x00")
        };
        let v0 = 0;
        while (arg0 != 0) {
            v0 = v0 + 1;
            arg0 = arg0 >> 8;
        };
        u128_to_hex_string_fixed_length(arg0, v0)
    }

    public fun u128_to_hex_string_fixed_length(arg0: u128, arg1: u128) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg1 * 2) {
            let v2 = b"0123456789abcdef";
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v2, ((arg0 & 15) as u64)));
            arg0 = arg0 >> 4;
            v1 = v1 + 1;
        };
        assert!(arg0 == 0, 1);
        0x1::vector::append<u8>(&mut v0, b"x0");
        0x1::vector::reverse<u8>(&mut v0);
        0x1::ascii::string(v0)
    }

    public fun u128_to_string(arg0: u128) : 0x1::ascii::String {
        if (arg0 == 0) {
            return 0x1::ascii::string(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::ascii::string(v0)
    }

    public fun u8_to_ascii(arg0: u8) : u8 {
        if (arg0 < 10) {
            arg0 + 48
        } else {
            arg0 + 87
        }
    }

    // decompiled from Move bytecode v6
}

