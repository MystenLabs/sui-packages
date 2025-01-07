module 0x18a016d523904c3289b72ffdff20c6937b1149822a385045345b254688f76d78::utils {
    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

