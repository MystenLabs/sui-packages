module 0x1b7d39e3fb60ffacb94a7a1710537f444aa145364f4665fe263d83e7afcb1883::utils {
    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

