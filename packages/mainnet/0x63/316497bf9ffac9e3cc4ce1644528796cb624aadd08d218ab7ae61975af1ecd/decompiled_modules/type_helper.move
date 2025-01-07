module 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::type_helper {
    public fun get_type_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

