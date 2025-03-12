module 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit {
    struct Deposit has drop {
        token_address: 0x1::string::String,
        from: 0x1::string::String,
        to: 0x1::string::String,
        amount: u64,
        data: vector<u8>,
    }

    public fun encode(arg0: &Deposit, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&arg0.token_address));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&arg0.from));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&arg0.to));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_u64(arg0.amount));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.data));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun amount(arg0: &Deposit) : u64 {
        arg0.amount
    }

    public fun data(arg0: &Deposit) : vector<u8> {
        arg0.data
    }

    public fun decode(arg0: &vector<u8>) : Deposit {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        wrap_deposit(0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 1)), 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 2)), 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 3)), 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_u64(0x1::vector::borrow<vector<u8>>(&v0, 4)), *0x1::vector::borrow<vector<u8>>(&v0, 5))
    }

    public fun from(arg0: &Deposit) : 0x1::string::String {
        arg0.from
    }

    public fun get_method(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        *0x1::vector::borrow<vector<u8>>(&v0, 0)
    }

    public fun get_token_type(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 1))
    }

    public fun to(arg0: &Deposit) : 0x1::string::String {
        arg0.to
    }

    public fun token_address(arg0: &Deposit) : 0x1::string::String {
        arg0.token_address
    }

    public fun wrap_deposit(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: vector<u8>) : Deposit {
        Deposit{
            token_address : arg0,
            from          : arg1,
            to            : arg2,
            amount        : arg3,
            data          : arg4,
        }
    }

    // decompiled from Move bytecode v6
}

