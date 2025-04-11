module 0xea15ee7c28ff237eeb8fa1fe64b507ab97c352a46bba54b67fa751dde42696e5::hex {
    public fun decode(arg0: 0x1::string::String) : vector<u8> {
        0x2::hex::decode(0x1::string::into_bytes(arg0))
    }

    public fun encode(arg0: vector<u8>) : 0x1::string::String {
        0x1::string::utf8(0x2::hex::encode(arg0))
    }

    // decompiled from Move bytecode v6
}

