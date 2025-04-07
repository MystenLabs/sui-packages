module 0xa17a409164d1676db71b411ab50813ba2c7dd547d2df538c699049566f1ff922::transfer_msg {
    struct TransferMsg has drop {
        token: vector<u8>,
        from: vector<u8>,
        to: vector<u8>,
        amount: u64,
        data: vector<u8>,
    }

    public fun encode(arg0: TransferMsg) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.token));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.from));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.to));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_u64(arg0.amount));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.data));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun amount(arg0: &TransferMsg) : u64 {
        arg0.amount
    }

    public fun data(arg0: &TransferMsg) : vector<u8> {
        arg0.data
    }

    public fun decode(arg0: &vector<u8>) : TransferMsg {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        TransferMsg{
            token  : *0x1::vector::borrow<vector<u8>>(&v0, 0),
            from   : *0x1::vector::borrow<vector<u8>>(&v0, 1),
            to     : *0x1::vector::borrow<vector<u8>>(&v0, 2),
            amount : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_u64(0x1::vector::borrow<vector<u8>>(&v0, 3)),
            data   : *0x1::vector::borrow<vector<u8>>(&v0, 4),
        }
    }

    public fun from(arg0: &TransferMsg) : vector<u8> {
        arg0.from
    }

    public fun new(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>) : TransferMsg {
        TransferMsg{
            token  : arg0,
            from   : arg1,
            to     : arg2,
            amount : arg3,
            data   : arg4,
        }
    }

    public fun to(arg0: &TransferMsg) : vector<u8> {
        arg0.to
    }

    public fun token(arg0: &TransferMsg) : vector<u8> {
        arg0.token
    }

    // decompiled from Move bytecode v6
}

