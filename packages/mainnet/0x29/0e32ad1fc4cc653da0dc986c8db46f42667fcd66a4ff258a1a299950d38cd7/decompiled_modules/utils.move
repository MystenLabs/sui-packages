module 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::utils {
    public(friend) fun decimal_to_fixedpoint64(arg0: 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::Decimal) : 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::fixed_point64::FixedPoint64 {
        let v0 = 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::to_scaled_val(arg0) * 18446744073709551616 / 1000000000000000000;
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::fixed_point64::from_raw_value((v0 as u128))
    }

    public(friend) fun get_type_reflection<T0>() : 0x1::string::String {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v1 = 0x1::string::utf8(b"::");
        let v2 = 0x1::string::substring(&v0, 0x1::string::index_of(&v0, &v1) + 2, 0x1::string::length(&v0));
        0x1::string::substring(&v2, 0x1::string::index_of(&v2, &v1) + 2, 0x1::string::length(&v2))
    }

    public(friend) fun oracle_decimal_to_decimal(arg0: 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracle_decimal::OracleDecimal) : 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::Decimal {
        if (0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracle_decimal::is_expo_negative(&arg0)) {
            0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::div(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from_u128(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracle_decimal::base(&arg0)), 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from(0x1::u64::pow(10, (0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracle_decimal::expo(&arg0) as u8))))
        } else {
            0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::mul(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from_u128(0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracle_decimal::base(&arg0)), 0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::decimal::from(0x1::u64::pow(10, (0x290e32ad1fc4cc653da0dc986c8db46f42667fcd66a4ff258a1a299950d38cd7::oracle_decimal::expo(&arg0) as u8))))
        }
    }

    // decompiled from Move bytecode v6
}

