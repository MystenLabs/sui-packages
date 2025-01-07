module 0xffb658200f93630bacf98a33f4ca26605a6aaabbfb8336d9e28c5eb746d5c364::utils {
    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

