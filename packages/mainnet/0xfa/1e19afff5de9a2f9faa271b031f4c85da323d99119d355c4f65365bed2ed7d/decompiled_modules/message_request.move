module 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::message_request {
    struct CSMessageRequest has copy, drop, store {
        from: 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::network_address::NetworkAddress,
        to: 0x1::string::String,
        sn: u128,
        message_type: u8,
        data: vector<u8>,
        protocols: vector<0x1::string::String>,
    }

    public fun encode(arg0: &CSMessageRequest) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::network_address::encode(&arg0.from));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_string(&arg0.to));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_u128(arg0.sn));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_u8(arg0.message_type));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode(&arg0.data));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_strings(&arg0.protocols));
        0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_list(&v0, false)
    }

    public fun create(arg0: 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::network_address::NetworkAddress, arg1: 0x1::string::String, arg2: u128, arg3: u8, arg4: vector<u8>, arg5: vector<0x1::string::String>) : CSMessageRequest {
        CSMessageRequest{
            from         : arg0,
            to           : arg1,
            sn           : arg2,
            message_type : arg3,
            data         : arg4,
            protocols    : arg5,
        }
    }

    public fun data(arg0: &CSMessageRequest) : vector<u8> {
        arg0.data
    }

    public fun decode(arg0: &vector<u8>) : CSMessageRequest {
        let v0 = 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_list(arg0);
        create(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::network_address::decode(0x1::vector::borrow<vector<u8>>(&v0, 0)), 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 1)), 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_u128(0x1::vector::borrow<vector<u8>>(&v0, 2)), 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_u8(0x1::vector::borrow<vector<u8>>(&v0, 3)), *0x1::vector::borrow<vector<u8>>(&v0, 4), 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_strings(0x1::vector::borrow<vector<u8>>(&v0, 5)))
    }

    public fun default() : CSMessageRequest {
        CSMessageRequest{
            from         : 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::network_address::from_string(0x1::string::utf8(b"sui/babe")),
            to           : 0x1::string::utf8(b"babe"),
            sn           : 0,
            message_type : 0,
            data         : 0x1::vector::empty<u8>(),
            protocols    : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    public fun from(arg0: &CSMessageRequest) : 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::network_address::NetworkAddress {
        arg0.from
    }

    public fun from_nid(arg0: &CSMessageRequest) : 0x1::string::String {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::network_address::net_id(&arg0.from)
    }

    public fun msg_type(arg0: &CSMessageRequest) : u8 {
        arg0.message_type
    }

    public fun protocols(arg0: &CSMessageRequest) : vector<0x1::string::String> {
        arg0.protocols
    }

    public(friend) fun set_msg_type(arg0: &mut CSMessageRequest, arg1: u8) {
        arg0.message_type = arg1;
    }

    public(friend) fun set_protocols(arg0: &mut CSMessageRequest, arg1: vector<0x1::string::String>) {
        arg0.protocols = arg1;
    }

    public fun sn(arg0: &CSMessageRequest) : u128 {
        arg0.sn
    }

    public fun to(arg0: &CSMessageRequest) : 0x1::string::String {
        arg0.to
    }

    // decompiled from Move bytecode v6
}

