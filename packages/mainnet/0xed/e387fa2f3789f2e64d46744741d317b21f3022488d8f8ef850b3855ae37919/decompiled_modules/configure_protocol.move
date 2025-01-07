module 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::configure_protocol {
    struct ConfigureProtocol has drop {
        sources: vector<0x1::string::String>,
        destinations: vector<0x1::string::String>,
    }

    public fun encode(arg0: &ConfigureProtocol, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_strings(&arg0.sources));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_strings(&arg0.destinations));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun decode(arg0: &vector<u8>) : ConfigureProtocol {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        wrap_protocols(0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_strings(0x1::vector::borrow<vector<u8>>(&v0, 1)), 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_strings(0x1::vector::borrow<vector<u8>>(&v0, 2)))
    }

    public fun destinations(arg0: &ConfigureProtocol) : vector<0x1::string::String> {
        arg0.destinations
    }

    public fun get_method(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        *0x1::vector::borrow<vector<u8>>(&v0, 0)
    }

    public fun sources(arg0: &ConfigureProtocol) : vector<0x1::string::String> {
        arg0.sources
    }

    public fun wrap_protocols(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : ConfigureProtocol {
        ConfigureProtocol{
            sources      : arg0,
            destinations : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

