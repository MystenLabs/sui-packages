module 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::utils {
    public fun address_from_hex_string(arg0: &0x1::string::String) : address {
        let v0 = arg0;
        if (0x1::string::length(arg0) == 66) {
            let v1 = 0x1::string::substring(arg0, 2, 66);
            v0 = &v1;
        };
        let v2 = 0x2::bcs::new(0x2::hex::decode(*0x1::string::as_bytes(v0)));
        0x2::bcs::peel_address(&mut v2)
    }

    public fun address_from_str(arg0: &0x1::string::String) : address {
        let v0 = format_sui_address(arg0);
        0x2::address::from_ascii_bytes(0x1::string::as_bytes(&v0))
    }

    public fun address_to_hex_string(arg0: &address) : 0x1::string::String {
        to_hex_string(0x1::string::utf8(0x2::hex::encode(0x2::bcs::to_bytes<address>(arg0))))
    }

    public fun format_sui_address(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = *arg0;
        if (0x1::string::substring(&v0, 0, 2) == 0x1::string::utf8(b"0x")) {
            v0 = 0x1::string::substring(arg0, 2, 0x1::string::length(arg0));
        };
        v0
    }

    public fun get_type_string<T0>() : 0x1::string::String {
        to_hex_string(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun id_from_hex_string(arg0: &0x1::string::String) : 0x2::object::ID {
        let v0 = format_sui_address(arg0);
        0x2::object::id_from_bytes(0x2::hex::decode(*0x1::string::as_bytes(&v0)))
    }

    public fun id_to_hex_string(arg0: &0x2::object::ID) : 0x1::string::String {
        to_hex_string(0x1::string::utf8(0x2::hex::encode(0x2::object::id_to_bytes(arg0))))
    }

    public fun to_hex_string(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

