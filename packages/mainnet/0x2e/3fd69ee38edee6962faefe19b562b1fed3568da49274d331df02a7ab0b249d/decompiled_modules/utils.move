module 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::utils {
    public fun approximate_compounded_interest(arg0: 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal, arg1: u64) : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal {
        let v0 = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::div(arg0, 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::from(31536000000));
        if (arg1 == 0) {
            return 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::one()
        };
        if (arg1 == 1) {
            return 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::add(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::one(), v0)
        };
        if (arg1 == 2) {
            let v1 = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::add(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::one(), v0);
            return 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::mul(v1, v1)
        };
        if (arg1 == 3) {
            let v2 = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::add(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::one(), v0);
            return 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::mul(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::mul(v2, v2), v2)
        };
        if (arg1 == 4) {
            let v3 = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::add(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::one(), v0);
            let v4 = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::mul(v3, v3);
            return 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::mul(v4, v4)
        };
        let v5 = (arg1 as u256);
        let v6 = v5 - 1;
        let v7 = 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::mul(v0, v0);
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::add(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::add(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::add(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::one(), 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::mul_u256(v0, v5)), 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::div_u256(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::mul(v7, 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::from_u128(((v5 * v6) as u128))), 2)), 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::div_u256(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::mul(0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::mul(v7, v0), 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::from_u128(((v5 * v6 * (v5 - 2)) as u128))), 6))
    }

    public fun decimal_to_hex_char(arg0: u8) : 0x1::string::String {
        let v0 = vector[b"0", b"1", b"2", b"3", b"4", b"5", b"6", b"7", b"8", b"9", b"a", b"b", b"c", b"d", b"e", b"f"];
        0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v0, (arg0 as u64)))
    }

    public fun default_rate_factor_bps() : u64 {
        10000
    }

    public fun get_type<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun max_of_u64() : u64 {
        18446744073709551615
    }

    public fun max_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
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

    public fun power(arg0: u64, arg1: u64) : u64 {
        let v0 = 1;
        let v1 = 1;
        while (v1 <= arg1) {
            v0 = v0 * arg0;
            v1 = v1 + 1;
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

    public fun vector_to_hex_char_without_prefix(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0;
        let v1 = 0x1::string::utf8(b"");
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

