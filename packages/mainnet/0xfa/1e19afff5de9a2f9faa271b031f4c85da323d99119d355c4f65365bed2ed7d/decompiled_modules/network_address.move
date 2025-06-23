module 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::network_address {
    struct NetworkAddress has copy, drop, store {
        net_id: 0x1::string::String,
        addr: 0x1::string::String,
    }

    public fun decode(arg0: &vector<u8>) : NetworkAddress {
        from_string(0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_string(arg0))
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

    public fun decode_raw(arg0: &vector<u8>) : NetworkAddress {
        let v0 = 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode(arg0);
        decode(&v0)
    }

    public fun encode(arg0: &NetworkAddress) : vector<u8> {
        let v0 = to_string(arg0);
        0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_string(&v0)
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

