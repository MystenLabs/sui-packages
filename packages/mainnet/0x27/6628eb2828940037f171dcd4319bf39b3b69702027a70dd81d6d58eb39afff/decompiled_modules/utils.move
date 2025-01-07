module 0x6978f040cc983b85316a51b4aa70f168d7f7badfb98958a1b0d5f0b979710aec::utils {
    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

