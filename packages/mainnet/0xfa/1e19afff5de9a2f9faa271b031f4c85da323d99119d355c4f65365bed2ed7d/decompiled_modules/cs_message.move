module 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cs_message {
    struct CSMessage has drop, store {
        msg_type: u8,
        payload: vector<u8>,
    }

    public fun encode(arg0: &CSMessage) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_u8(arg0.msg_type));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode(&arg0.payload));
        0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_list(&v0, false)
    }

    public fun decode(arg0: &vector<u8>) : CSMessage {
        let v0 = 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_list(arg0);
        CSMessage{
            msg_type : 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_u8(0x1::vector::borrow<vector<u8>>(&v0, 0)),
            payload  : *0x1::vector::borrow<vector<u8>>(&v0, 1),
        }
    }

    public fun from_message_request(arg0: 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::message_request::CSMessageRequest) : CSMessage {
        CSMessage{
            msg_type : 1,
            payload  : 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::message_request::encode(&arg0),
        }
    }

    public fun from_message_result(arg0: 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::message_result::CSMessageResult) : CSMessage {
        CSMessage{
            msg_type : 2,
            payload  : 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::message_result::encode(&arg0),
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

