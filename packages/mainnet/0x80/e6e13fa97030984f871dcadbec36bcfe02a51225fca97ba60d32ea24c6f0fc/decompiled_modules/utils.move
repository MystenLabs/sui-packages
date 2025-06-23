module 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::utils {
    public(friend) fun get_type_reflection<T0>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v1 = 0x1::string::utf8(b"::");
        let v2 = 0x1::string::substring(&v0, 0x1::string::index_of(&v0, &v1) + 2, 0x1::string::length(&v0));
        0x1::string::substring(&v2, 0x1::string::index_of(&v2, &v1) + 2, 0x1::string::length(&v2))
    }

    // decompiled from Move bytecode v6
}

