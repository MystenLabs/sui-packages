module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info {
    public fun get_package_id<T0>() : address {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    public fun get_type_name_string<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    public fun parse_type_name(arg0: 0x1::type_name::TypeName) : (address, 0x1::ascii::String, 0x1::ascii::String, 0x1::ascii::String) {
        let v0 = 0x1::type_name::into_string(arg0);
        let v1 = 0x1::ascii::string(b"::");
        let v2 = 0x1::ascii::index_of(&v0, &v1);
        let v3 = 0x1::ascii::substring(&v0, 0, v2);
        let v4 = 0x1::ascii::substring(&v0, v2 + 2, 0x1::ascii::length(&v0));
        let v5 = 0x1::ascii::index_of(&v4, &v1);
        let v6 = 0x1::ascii::substring(&v4, v5 + 2, 0x1::ascii::length(&v4));
        let v7 = 0x1::ascii::string(b"<");
        (0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v3)), 0x1::ascii::substring(&v4, 0, v5), 0x1::ascii::substring(&v6, 0, 0x1::ascii::index_of(&v6, &v7)), v6)
    }

    // decompiled from Move bytecode v6
}

