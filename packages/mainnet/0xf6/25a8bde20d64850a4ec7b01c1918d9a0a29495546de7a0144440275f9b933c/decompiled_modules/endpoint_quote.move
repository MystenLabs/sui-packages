module 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_quote {
    struct QuoteParam has copy, drop, store {
        dst_eid: u32,
        receiver: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32,
        message: vector<u8>,
        options: vector<u8>,
        pay_in_zro: bool,
    }

    public fun create_param(arg0: u32, arg1: 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32, arg2: vector<u8>, arg3: vector<u8>, arg4: bool) : QuoteParam {
        QuoteParam{
            dst_eid    : arg0,
            receiver   : arg1,
            message    : arg2,
            options    : arg3,
            pay_in_zro : arg4,
        }
    }

    public fun dst_eid(arg0: &QuoteParam) : u32 {
        arg0.dst_eid
    }

    public fun message(arg0: &QuoteParam) : &vector<u8> {
        &arg0.message
    }

    public fun options(arg0: &QuoteParam) : &vector<u8> {
        &arg0.options
    }

    public fun pay_in_zro(arg0: &QuoteParam) : bool {
        arg0.pay_in_zro
    }

    public fun receiver(arg0: &QuoteParam) : 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::bytes32::Bytes32 {
        arg0.receiver
    }

    // decompiled from Move bytecode v6
}

