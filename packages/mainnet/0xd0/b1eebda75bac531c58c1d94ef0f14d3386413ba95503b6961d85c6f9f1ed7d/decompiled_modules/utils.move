module 0xd0b1eebda75bac531c58c1d94ef0f14d3386413ba95503b6961d85c6f9f1ed7d::utils {
    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

