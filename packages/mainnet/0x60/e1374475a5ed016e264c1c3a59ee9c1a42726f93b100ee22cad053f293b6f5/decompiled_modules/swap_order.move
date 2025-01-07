module 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order {
    struct SwapOrder has copy, drop, store {
        id: u128,
        emitter: 0x1::string::String,
        src_nid: 0x1::string::String,
        dst_nid: 0x1::string::String,
        creator: 0x1::string::String,
        destination_address: 0x1::string::String,
        token: 0x1::string::String,
        amount: u128,
        to_token: 0x1::string::String,
        to_amount: u128,
        data: vector<u8>,
    }

    public(friend) fun emit(arg0: SwapOrder) {
        0x2::event::emit<SwapOrder>(arg0);
    }

    public fun encode(arg0: &SwapOrder) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_u128(get_id(arg0)));
        let v1 = get_emitter(arg0);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&v1));
        let v2 = get_src_nid(arg0);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&v2));
        let v3 = get_dst_nid(arg0);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&v3));
        let v4 = get_creator(arg0);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&v4));
        let v5 = get_destination_address(arg0);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&v5));
        let v6 = get_token(arg0);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&v6));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_u128(get_amount(arg0)));
        let v7 = get_to_token(arg0);
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_string(&v7));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_u128(get_to_amount(arg0)));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(get_data(arg0)));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun decode(arg0: &vector<u8>) : SwapOrder {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        SwapOrder{
            id                  : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_u128(0x1::vector::borrow<vector<u8>>(&v0, 0)),
            emitter             : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 1)),
            src_nid             : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 2)),
            dst_nid             : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 3)),
            creator             : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 4)),
            destination_address : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 5)),
            token               : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 6)),
            amount              : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_u128(0x1::vector::borrow<vector<u8>>(&v0, 7)),
            to_token            : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_string(0x1::vector::borrow<vector<u8>>(&v0, 8)),
            to_amount           : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_u128(0x1::vector::borrow<vector<u8>>(&v0, 9)),
            data                : *0x1::vector::borrow<vector<u8>>(&v0, 10),
        }
    }

    public(friend) fun deduct_amount(arg0: &mut SwapOrder, arg1: u128) {
        arg0.amount = arg0.amount - arg1;
    }

    public(friend) fun deduct_to_amount(arg0: &mut SwapOrder, arg1: u128) {
        arg0.to_amount = arg0.to_amount - arg1;
    }

    public fun get_amount(arg0: &SwapOrder) : u128 {
        arg0.amount
    }

    public fun get_creator(arg0: &SwapOrder) : 0x1::string::String {
        arg0.creator
    }

    public fun get_data(arg0: &SwapOrder) : &vector<u8> {
        &arg0.data
    }

    public fun get_destination_address(arg0: &SwapOrder) : 0x1::string::String {
        arg0.destination_address
    }

    public fun get_dst_nid(arg0: &SwapOrder) : 0x1::string::String {
        arg0.dst_nid
    }

    public fun get_emitter(arg0: &SwapOrder) : 0x1::string::String {
        arg0.emitter
    }

    public fun get_id(arg0: &SwapOrder) : u128 {
        arg0.id
    }

    public fun get_src_nid(arg0: &SwapOrder) : 0x1::string::String {
        arg0.src_nid
    }

    public fun get_to_amount(arg0: &SwapOrder) : u128 {
        arg0.to_amount
    }

    public fun get_to_token(arg0: &SwapOrder) : 0x1::string::String {
        arg0.to_token
    }

    public fun get_token(arg0: &SwapOrder) : 0x1::string::String {
        arg0.token
    }

    public fun new(arg0: u128, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u128, arg8: 0x1::string::String, arg9: u128, arg10: vector<u8>) : SwapOrder {
        SwapOrder{
            id                  : arg0,
            emitter             : arg1,
            src_nid             : arg2,
            dst_nid             : arg3,
            creator             : arg4,
            destination_address : arg5,
            token               : arg6,
            amount              : arg7,
            to_token            : arg8,
            to_amount           : arg9,
            data                : arg10,
        }
    }

    // decompiled from Move bytecode v6
}

