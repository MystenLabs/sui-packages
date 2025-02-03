module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::string2 {
    public fun empty() : 0x1::string::String {
        0x1::string::utf8(0x1::vector::empty<u8>())
    }

    public fun from_address(arg0: address) : 0x1::string::String {
        0x1::string::utf8(0x2::hex::encode(0x1::bcs::to_bytes<address>(&arg0)))
    }

    public fun from_id(arg0: 0x2::object::ID) : 0x1::string::String {
        0x1::string::utf8(0x2::hex::encode(0x2::object::id_to_bytes(&arg0)))
    }

    public fun into_address(arg0: 0x1::string::String) : address {
        assert!(0x1::string::length(&arg0) == 0x1::address::length() * 2, 0);
        0x2::address::from_bytes(0x2::hex::decode(*0x1::string::bytes(&arg0)))
    }

    public fun into_id(arg0: 0x1::string::String) : 0x2::object::ID {
        assert!(0x1::string::length(&arg0) == 0x1::address::length() * 2, 0);
        0x2::object::id_from_bytes(0x2::hex::decode(*0x1::string::bytes(&arg0)))
    }

    // decompiled from Move bytecode v6
}

