module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cs_message {
    struct CSMessage has drop, store {
        msg_type: u8,
        payload: vector<u8>,
    }

    public fun decode(arg0: &vector<u8>) : CSMessage {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        CSMessage{
            msg_type : 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_u8(0x1::vector::borrow<vector<u8>>(&v0, 0)),
            payload  : *0x1::vector::borrow<vector<u8>>(&v0, 1),
        }
    }

    public fun encode(arg0: &CSMessage) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_u8(arg0.msg_type));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.payload));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun from_message_request(arg0: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest) : CSMessage {
        CSMessage{
            msg_type : 1,
            payload  : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::encode(&arg0),
        }
    }

    public fun from_message_result(arg0: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_result::CSMessageResult) : CSMessage {
        CSMessage{
            msg_type : 2,
            payload  : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_result::encode(&arg0),
        }
    }

    public fun msg_type(arg0: &CSMessage) : u8 {
        arg0.msg_type
    }

    public fun new(arg0: u8, arg1: vector<u8>) : CSMessage {
        CSMessage{
            msg_type : arg0,
            payload  : arg1,
        }
    }

    public fun payload(arg0: &CSMessage) : vector<u8> {
        arg0.payload
    }

    public fun request_code() : u8 {
        1
    }

    public fun result_code() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

