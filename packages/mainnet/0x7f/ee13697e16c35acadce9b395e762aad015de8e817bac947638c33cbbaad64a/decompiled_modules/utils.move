module 0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::utils {
    public fun address_to_hex_string(arg0: &address) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x1::bcs::to_bytes<address>(arg0))));
        v0
    }

    public fun full_32_be_bytes(arg0: &u256) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u256>(arg0);
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun get_message_event_bytes(arg0: u256, arg1: vector<u8>, arg2: u256, arg3: vector<u8>, arg4: u256, arg5: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, full_32_be_bytes(&arg2));
        0x1::vector::append<u8>(&mut v0, full_32_be_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, full_32_be_bytes(&arg4));
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::debug::print<vector<u8>>(&v0);
        v0
    }

    public fun get_package_address(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID) : 0x1::string::String {
        let v0 = 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(0x2::package::published_package(arg0)));
        let v1 = address_to_hex_string(&v0);
        0x1::string::append_utf8(&mut v1, b"::");
        0x1::string::append(&mut v1, 0x1::string::from_ascii(*0x2::package::published_module(arg0)));
        0x1::string::append_utf8(&mut v1, b"::");
        0x1::string::append(&mut v1, id_to_hex_string(&arg1));
        v1
    }

    public fun id_to_hex_string(arg0: &0x2::object::ID) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::object::id_to_bytes(arg0))));
        v0
    }

    public fun trimmed_be_bytes(arg0: &u256) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u256>(arg0);
        0x1::vector::reverse<u8>(&mut v0);
        truncate_zeros(&v0)
    }

    public fun truncate_zeros(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0;
        let v1 = false;
        let v2 = 0x1::vector::empty<u8>();
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v3 = (*0x1::vector::borrow<u8>(arg0, v0) as u8);
            if (v3 > 0 || v1) {
                v1 = true;
                0x1::vector::push_back<u8>(&mut v2, v3);
            };
            v0 = v0 + 1;
        };
        if (0x1::vector::length<u8>(&v2) == 0) {
            x"00"
        } else {
            v2
        }
    }

    // decompiled from Move bytecode v6
}

