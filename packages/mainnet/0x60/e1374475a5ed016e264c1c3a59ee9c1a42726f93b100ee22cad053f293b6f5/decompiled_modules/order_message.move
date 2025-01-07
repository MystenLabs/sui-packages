module 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message {
    struct OrderMessage has copy, drop {
        message_type: u8,
        message: vector<u8>,
    }

    public fun encode(arg0: &OrderMessage) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_u8(arg0.message_type));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.message));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun decode(arg0: &vector<u8>) : OrderMessage {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        OrderMessage{
            message_type : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_u8(0x1::vector::borrow<vector<u8>>(&v0, 0)),
            message      : *0x1::vector::borrow<vector<u8>>(&v0, 1),
        }
    }

    public fun get_message(arg0: &OrderMessage) : vector<u8> {
        arg0.message
    }

    public fun get_type(arg0: &OrderMessage) : u8 {
        arg0.message_type
    }

    public fun new(arg0: u8, arg1: vector<u8>) : OrderMessage {
        OrderMessage{
            message_type : arg0,
            message      : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

