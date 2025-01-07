module 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::type_helper {
    public fun get_type_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

