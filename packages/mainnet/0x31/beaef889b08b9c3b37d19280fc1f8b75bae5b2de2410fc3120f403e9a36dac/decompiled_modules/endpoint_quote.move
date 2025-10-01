module 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_quote {
    struct QuoteParam has copy, drop, store {
        dst_eid: u32,
        receiver: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        message: vector<u8>,
        options: vector<u8>,
        pay_in_zro: bool,
    }

    public fun create_param(arg0: u32, arg1: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg2: vector<u8>, arg3: vector<u8>, arg4: bool) : QuoteParam {
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

    public fun receiver(arg0: &QuoteParam) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.receiver
    }

    // decompiled from Move bytecode v6
}

