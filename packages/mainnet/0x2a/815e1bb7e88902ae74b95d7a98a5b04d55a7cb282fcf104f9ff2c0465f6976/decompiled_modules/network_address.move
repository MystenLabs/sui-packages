module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address {
    struct NetworkAddress has copy, drop, store {
        net_id: 0x1::string::String,
        addr: 0x1::string::String,
    }

    public fun addr(arg0: &NetworkAddress) : 0x1::string::String {
        arg0.addr
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String) : NetworkAddress {
        NetworkAddress{
            net_id : arg0,
            addr   : arg1,
        }
    }

    public fun decode(arg0: &vector<u8>) : NetworkAddress {
        from_string(0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(arg0))
    }

    public fun decode_raw(arg0: &vector<u8>) : NetworkAddress {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode(arg0);
        decode(&v0)
    }

    public fun encode(arg0: &NetworkAddress) : vector<u8> {
        let v0 = to_string(arg0);
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&v0)
    }

    public fun from_string(arg0: 0x1::string::String) : NetworkAddress {
        let v0 = 0x1::string::utf8(b"/");
        let v1 = 0x1::string::index_of(&arg0, &v0);
        NetworkAddress{
            net_id : 0x1::string::sub_string(&arg0, 0, v1),
            addr   : 0x1::string::sub_string(&arg0, v1 + 1, 0x1::string::length(&arg0)),
        }
    }

    public fun net_id(arg0: &NetworkAddress) : 0x1::string::String {
        arg0.net_id
    }

    public fun to_string(arg0: &NetworkAddress) : 0x1::string::String {
        let v0 = arg0.net_id;
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, arg0.addr);
        v0
    }

    // decompiled from Move bytecode v6
}

