module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::helpers {
    public fun utf8(arg0: vector<u8>) : 0x1::string::String {
        0x1::string::utf8(arg0)
    }

    public fun calculate_quality_adjusted_multiplier(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 >= 1 && arg2 <= 100, 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_quality_out_of_range());
        if (arg0 > arg1) {
            return arg0 - (arg0 - arg1) * (arg2 - 1) / 99
        };
        arg0 + (arg1 - arg0) * (arg2 - 1) / 99
    }

    public fun get_coin_type_string<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun get_coin_type_string_with_0x<T0>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        v0
    }

    public fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun sanitize(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0x1::string::as_bytes(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            let v3 = *0x1::vector::borrow<u8>(v1, v2);
            let v4 = if (v3 >= 48 && v3 <= 57) {
                true
            } else if (v3 >= 65 && v3 <= 90) {
                true
            } else {
                v3 >= 97 && v3 <= 122
            };
            if (v4) {
                let v5 = 0x1::vector::empty<u8>();
                0x1::vector::push_back<u8>(&mut v5, v3);
                0x1::string::append(&mut v0, 0x1::string::utf8(v5));
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun slugify(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0x1::string::as_bytes(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            let v3 = *0x1::vector::borrow<u8>(v1, v2);
            if (v3 >= 48 && v3 <= 57) {
                let v4 = 0x1::vector::empty<u8>();
                0x1::vector::push_back<u8>(&mut v4, v3);
                0x1::string::append(&mut v0, 0x1::string::utf8(v4));
            } else if (v3 >= 65 && v3 <= 90) {
                let v5 = 0x1::vector::empty<u8>();
                0x1::vector::push_back<u8>(&mut v5, v3 + 32);
                0x1::string::append(&mut v0, 0x1::string::utf8(v5));
            } else if (v3 >= 97 && v3 <= 122) {
                let v6 = 0x1::vector::empty<u8>();
                0x1::vector::push_back<u8>(&mut v6, v3);
                0x1::string::append(&mut v0, 0x1::string::utf8(v6));
            } else if (0x1::vector::length<u8>(0x1::string::as_bytes(&v0)) == 0 || *0x1::vector::borrow<u8>(0x1::string::as_bytes(&v0), 0x1::vector::length<u8>(0x1::string::as_bytes(&v0)) - 1) != 45) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun string_to_u64(arg0: &0x1::string::String) : u64 {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0) {
            return 0
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u8>(v0, v3);
            if (v4 < 48 || v4 > 57) {
                abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_invalid_numeric_string()
            };
            let v5 = ((v4 - 48) as u64);
            if (v2 > (18446744073709551615 - v5) / 10) {
                abort 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors::error_code_numeric_overflow()
            };
            let v6 = v2 * 10;
            v2 = v6 + v5;
            v3 = v3 + 1;
        };
        v2
    }

    public fun u128_to_string(arg0: u128) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

