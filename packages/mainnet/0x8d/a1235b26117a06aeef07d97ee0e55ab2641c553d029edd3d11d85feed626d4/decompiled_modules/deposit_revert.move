module 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::deposit_revert {
    struct DepositRevert has drop {
        token_address: 0x1::string::String,
        to: address,
        amount: u64,
    }

    public fun encode(arg0: &DepositRevert, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&arg0.token_address));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_address(&arg0.to));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_u64(arg0.amount));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun amount(arg0: &DepositRevert) : u64 {
        arg0.amount
    }

    public fun decode(arg0: &vector<u8>) : DepositRevert {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        wrap_deposit_revert(0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 1)), 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_address(0x1::vector::borrow<vector<u8>>(&v0, 2)), 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_u64(0x1::vector::borrow<vector<u8>>(&v0, 3)))
    }

    public fun to(arg0: &DepositRevert) : address {
        arg0.to
    }

    public fun token_address(arg0: &DepositRevert) : 0x1::string::String {
        arg0.token_address
    }

    public fun wrap_deposit_revert(arg0: 0x1::string::String, arg1: address, arg2: u64) : DepositRevert {
        DepositRevert{
            token_address : arg0,
            to            : arg1,
            amount        : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

