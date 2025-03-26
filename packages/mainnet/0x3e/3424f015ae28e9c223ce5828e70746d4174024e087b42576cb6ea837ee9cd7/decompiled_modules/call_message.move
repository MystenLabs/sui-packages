module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::call_message {
    struct CallMessage has drop {
        data: vector<u8>,
    }

    public fun decode(arg0: &vector<u8>) : CallMessage {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        CallMessage{data: *0x1::vector::borrow<vector<u8>>(&v0, 0)}
    }

    public fun encode(arg0: CallMessage) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.data));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun msg_type() : u8 {
        0
    }

    public fun new(arg0: vector<u8>) : CallMessage {
        CallMessage{data: arg0}
    }

    // decompiled from Move bytecode v6
}

