module 0x92890696604dacfa9c59d45d9709185217c7b00f42807044f934e3f0b8a073f3::utils {
    public(friend) fun get_type_reflection<T0>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v1 = 0x1::string::utf8(b"::");
        let v2 = 0x1::string::substring(&v0, 0x1::string::index_of(&v0, &v1) + 2, 0x1::string::length(&v0));
        0x1::string::substring(&v2, 0x1::string::index_of(&v2, &v1) + 2, 0x1::string::length(&v2))
    }

    // decompiled from Move bytecode v6
}

