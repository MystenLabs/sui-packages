module 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::message_result {
    struct CSMessageResult has drop, store {
        sn: u128,
        code: u8,
        message: vector<u8>,
    }

    public fun encode(arg0: &CSMessageResult) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_u128(arg0.sn));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_u8(arg0.code));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode(&arg0.message));
        0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_list(&v0, false)
    }

    public fun create(arg0: u128, arg1: u8, arg2: vector<u8>) : CSMessageResult {
        CSMessageResult{
            sn      : arg0,
            code    : arg1,
            message : arg2,
        }
    }

    public fun decode(arg0: &vector<u8>) : CSMessageResult {
        let v0 = 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_list(arg0);
        CSMessageResult{
            sn      : 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_u128(0x1::vector::borrow<vector<u8>>(&v0, 0)),
            code    : 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_u8(0x1::vector::borrow<vector<u8>>(&v0, 1)),
            message : *0x1::vector::borrow<vector<u8>>(&v0, 2),
        }
    }

    public fun failure() : u8 {
        0
    }

    public fun message(arg0: &CSMessageResult) : vector<u8> {
        arg0.message
    }

    public fun response_code(arg0: &CSMessageResult) : u8 {
        arg0.code
    }

    public fun sequence_no(arg0: &CSMessageResult) : u128 {
        arg0.sn
    }

    public fun success() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

