module 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::utils {
    public(friend) fun get_type_reflection<T0>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v1 = 0x1::string::utf8(b"::");
        let v2 = 0x1::string::substring(&v0, 0x1::string::index_of(&v0, &v1) + 2, 0x1::string::length(&v0));
        0x1::string::substring(&v2, 0x1::string::index_of(&v2, &v1) + 2, 0x1::string::length(&v2))
    }

    // decompiled from Move bytecode v6
}

