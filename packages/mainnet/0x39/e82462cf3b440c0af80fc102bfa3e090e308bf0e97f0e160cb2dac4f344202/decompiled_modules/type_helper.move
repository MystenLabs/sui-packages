module 0x39e82462cf3b440c0af80fc102bfa3e090e308bf0e97f0e160cb2dac4f344202::type_helper {
    public fun get_type_name<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

