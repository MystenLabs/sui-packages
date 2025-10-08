module 0xcda743fad5bb31d3813d5e4b4a69cfd8afd771f0c370e67822de0971bf970feb::helpers {
    public fun get_coin_type_string_with_0x<T0>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        v0
    }

    // decompiled from Move bytecode v6
}

