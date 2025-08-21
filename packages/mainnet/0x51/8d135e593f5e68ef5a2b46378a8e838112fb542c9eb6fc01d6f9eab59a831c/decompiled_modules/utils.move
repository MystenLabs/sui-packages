module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::utils {
    public(friend) fun build_customization_signed_data(arg0: &0x2::object::UID, arg1: u64, arg2: u64, arg3: &0x1::option::Option<0x1::string::String>) : vector<u8> {
        let v0 = 0x2::object::uid_to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::option::Option<0x1::string::String>>(arg3));
        v0
    }

    public(friend) fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public(friend) fun verify_ed25519_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

