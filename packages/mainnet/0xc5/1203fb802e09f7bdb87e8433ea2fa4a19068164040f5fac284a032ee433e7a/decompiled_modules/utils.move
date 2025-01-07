module 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::utils {
    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

