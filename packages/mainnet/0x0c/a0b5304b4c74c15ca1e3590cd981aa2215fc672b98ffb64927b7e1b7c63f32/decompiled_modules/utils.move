module 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::utils {
    public(friend) fun decimal_to_fixedpoint64(arg0: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::FixedPoint64 {
        let v0 = 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::to_scaled_val(arg0) * 18446744073709551616 / 1000000000000000000;
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::fixed_point64::from_raw_value((v0 as u128))
    }

    public(friend) fun get_type_reflection<T0>() : 0x1::string::String {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v1 = 0x1::string::utf8(b"::");
        let v2 = 0x1::string::substring(&v0, 0x1::string::index_of(&v0, &v1) + 2, 0x1::string::length(&v0));
        0x1::string::substring(&v2, 0x1::string::index_of(&v2, &v1) + 2, 0x1::string::length(&v2))
    }

    public(friend) fun oracle_decimal_to_decimal(arg0: 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracle_decimal::OracleDecimal) : 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::Decimal {
        if (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracle_decimal::is_expo_negative(&arg0)) {
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::div(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from_u128(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracle_decimal::base(&arg0)), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(0x1::u64::pow(10, (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracle_decimal::expo(&arg0) as u8))))
        } else {
            0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::mul(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from_u128(0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracle_decimal::base(&arg0)), 0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::decimal::from(0x1::u64::pow(10, (0xca0b5304b4c74c15ca1e3590cd981aa2215fc672b98ffb64927b7e1b7c63f32::oracle_decimal::expo(&arg0) as u8))))
        }
    }

    // decompiled from Move bytecode v6
}

