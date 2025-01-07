module 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils {
    public fun address_from_hex_string(arg0: &0x1::string::String) : address {
        let v0 = arg0;
        if (0x1::string::length(arg0) == 66) {
            let v1 = 0x1::string::substring(arg0, 2, 66);
            v0 = &v1;
        };
        let v2 = 0x2::bcs::new(0x2::hex::decode(*0x1::string::bytes(v0)));
        0x2::bcs::peel_address(&mut v2)
    }

    public fun address_to_hex_string(arg0: &address) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::bcs::to_bytes<address>(arg0))));
        v0
    }

    // decompiled from Move bytecode v6
}

