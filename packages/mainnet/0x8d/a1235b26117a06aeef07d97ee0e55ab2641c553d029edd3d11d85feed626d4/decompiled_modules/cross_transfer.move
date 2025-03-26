module 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer {
    struct XCrossTransfer has drop {
        from: 0x1::string::String,
        to: 0x1::string::String,
        value: u128,
        data: vector<u8>,
    }

    public fun encode(arg0: &XCrossTransfer, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&arg0.from));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&arg0.to));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_u128(arg0.value));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.data));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun data(arg0: &XCrossTransfer) : vector<u8> {
        arg0.data
    }

    public fun decode(arg0: &vector<u8>) : XCrossTransfer {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        XCrossTransfer{
            from  : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 1)),
            to    : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 2)),
            value : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_u128(0x1::vector::borrow<vector<u8>>(&v0, 3)),
            data  : *0x1::vector::borrow<vector<u8>>(&v0, 4),
        }
    }

    public fun from(arg0: &XCrossTransfer) : 0x1::string::String {
        arg0.from
    }

    public fun get_method(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        *0x1::vector::borrow<vector<u8>>(&v0, 0)
    }

    public fun to(arg0: &XCrossTransfer) : 0x1::string::String {
        arg0.to
    }

    public fun value(arg0: &XCrossTransfer) : u128 {
        arg0.value
    }

    public fun wrap_cross_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u128, arg3: vector<u8>) : XCrossTransfer {
        XCrossTransfer{
            from  : arg0,
            to    : arg1,
            value : arg2,
            data  : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

