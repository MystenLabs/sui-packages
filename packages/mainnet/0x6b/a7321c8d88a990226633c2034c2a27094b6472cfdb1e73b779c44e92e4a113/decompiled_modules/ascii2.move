module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::ascii2 {
    public fun empty() : 0x1::ascii::String {
        0x1::ascii::string(0x1::vector::empty<u8>())
    }

    public fun addr_into_string(arg0: address) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::bcs::to_bytes<address>(&arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            0x1::vector::push_back<u8>(&mut v0, u8_to_ascii(*0x1::vector::borrow<u8>(&v1, v2) / 16));
            0x1::vector::push_back<u8>(&mut v0, u8_to_ascii(*0x1::vector::borrow<u8>(&v1, v2) % 16));
            v2 = v2 + 1;
        };
        0x1::ascii::string(v0)
    }

    public fun append(arg0: &mut 0x1::ascii::String, arg1: 0x1::ascii::String) {
        let v0 = 0;
        while (v0 < 0x1::ascii::length(&arg1)) {
            0x1::ascii::push_char(arg0, into_char(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun ascii_bytes_into_id(arg0: vector<u8>) : 0x2::object::ID {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<u8>(&mut v0, ascii_to_u8(*0x1::vector::borrow<u8>(&arg0, v1 + 1)) + ascii_to_u8(*0x1::vector::borrow<u8>(&arg0, v1)) * 16);
            v1 = v1 + 2;
        };
        0x2::object::id_from_bytes(v0)
    }

    public fun ascii_into_id(arg0: 0x1::ascii::String) : 0x2::object::ID {
        ascii_bytes_into_id(0x1::ascii::into_bytes(arg0))
    }

    public fun ascii_to_u8(arg0: u8) : u8 {
        assert!(0x1::ascii::is_valid_char(arg0), 65536);
        if (arg0 < 58) {
            arg0 - 48
        } else {
            arg0 - 87
        }
    }

    public fun bytes_to_strings(arg0: vector<vector<u8>>) : vector<0x1::ascii::String> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, 0x1::ascii::string(*0x1::vector::borrow<vector<u8>>(&arg0, v0)));
            v0 = v0 + 1;
        };
        v1
    }

    public fun index_of(arg0: &0x1::ascii::String, arg1: &0x1::ascii::String) : u64 {
        if (0x1::ascii::length(arg1) > 0x1::ascii::length(arg0)) {
            return 0x1::ascii::length(arg0)
        };
        let v0 = 0x1::ascii::length(arg1) - 1;
        let v1 = 0;
        while (v1 + v0 < 0x1::ascii::length(arg0)) {
            while (into_char(arg0, v1 + v0) == into_char(arg1, v0)) {
                if (v0 == 0) {
                    return v1
                };
                v0 = v0 - 1;
            };
            v1 = v1 + 1;
        };
        v1 + v0
    }

    public fun into_char(arg0: &0x1::ascii::String, arg1: u64) : 0x1::ascii::Char {
        let v0 = 0x1::ascii::into_bytes(*arg0);
        0x1::ascii::char(*0x1::vector::borrow<u8>(&v0, arg1))
    }

    public fun sub_string(arg0: &0x1::ascii::String, arg1: u64, arg2: u64) : 0x1::ascii::String {
        assert!(arg2 <= 0x1::ascii::length(arg0) && arg1 <= arg2, 0);
        let v0 = 0x1::ascii::into_bytes(*arg0);
        0x1::ascii::string(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::slice<u8>(&v0, arg1, arg2))
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

    public fun u8_to_ascii(arg0: u8) : u8 {
        if (arg0 < 10) {
            arg0 + 48
        } else {
            arg0 + 87
        }
    }

    public fun vec_bytes_to_vec_strings(arg0: vector<vector<vector<u8>>>) : vector<vector<0x1::ascii::String>> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<vector<0x1::ascii::String>>();
        while (v0 < 0x1::vector::length<vector<vector<u8>>>(&arg0)) {
            0x1::vector::push_back<vector<0x1::ascii::String>>(&mut v1, bytes_to_strings(*0x1::vector::borrow<vector<vector<u8>>>(&arg0, v0)));
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

