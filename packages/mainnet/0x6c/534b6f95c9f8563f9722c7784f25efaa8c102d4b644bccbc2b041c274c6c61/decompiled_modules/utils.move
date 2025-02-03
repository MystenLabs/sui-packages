module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils {
    public fun decimal_to_hex_char(arg0: u8) : 0x1::string::String {
        let v0 = vector[b"0", b"1", b"2", b"3", b"4", b"5", b"6", b"7", b"8", b"9", b"a", b"b", b"c", b"d", b"e", b"f"];
        0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, (arg0 as u64)))
    }

    public fun get_type<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun i64_to_u64(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u64 {
        if (!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg0)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg0)
        }
    }

    public fun is_bear_position(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_bull_position(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_negative(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : bool {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0)
    }

    public fun is_valid_position(arg0: u8) : bool {
        arg0 == 0 || arg0 == 1
    }

    public fun power(arg0: u64, arg1: u64) : u64 {
        let v0 = 1;
        let v1 = 1;
        while (v1 <= arg1) {
            v0 = v0 * arg0;
            v1 = v1 + 1;
        };
        v0
    }

    public fun split_string(arg0: 0x1::string::String, arg1: u8) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::string::to_ascii(0x1::string::utf8(0x1::vector::empty<u8>()));
        let v2 = 0x1::ascii::into_bytes(0x1::string::to_ascii(arg0));
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            let v4 = *0x1::vector::borrow<u8>(&v2, v3);
            if (v4 == arg1) {
                0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::from_ascii(v1));
                v1 = 0x1::string::to_ascii(0x1::string::utf8(0x1::vector::empty<u8>()));
            } else {
                0x1::ascii::push_char(&mut v1, 0x1::ascii::char(v4));
            };
            v3 = v3 + 1;
        };
        if (0x1::ascii::length(&v1) != 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::from_ascii(v1));
        };
        v0
    }

    public fun string_to_u64(arg0: 0x1::string::String) : u64 {
        let v0 = 0;
        let v1 = 0x1::string::bytes(&arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            let v3 = (*0x1::vector::borrow<u8>(v1, v2) as u8);
            assert!(v3 >= 48 && v3 <= 57, 1);
            let v4 = v0 * 10;
            v0 = v4 + ((v3 - 48) as u64);
            v2 = v2 + 1;
        };
        v0
    }

    public fun vector_to_hex_char(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0;
        let v1 = 0x1::string::utf8(b"0x");
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = 0x1::vector::borrow<u8>(&arg0, v0);
            0x1::string::append(&mut v1, decimal_to_hex_char(*v2 / 16));
            0x1::string::append(&mut v1, decimal_to_hex_char(*v2 % 16));
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

