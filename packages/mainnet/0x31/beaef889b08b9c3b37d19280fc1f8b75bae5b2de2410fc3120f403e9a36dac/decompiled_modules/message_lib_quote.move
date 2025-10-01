module 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote {
    struct QuoteParam has copy, drop, store {
        packet: 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::OutboundPacket,
        options: vector<u8>,
        pay_in_zro: bool,
    }

    public(friend) fun create_param(arg0: 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::OutboundPacket, arg1: vector<u8>, arg2: bool) : QuoteParam {
        QuoteParam{
            packet     : arg0,
            options    : arg1,
            pay_in_zro : arg2,
        }
    }

    public fun options(arg0: &QuoteParam) : &vector<u8> {
        &arg0.options
    }

    public fun packet(arg0: &QuoteParam) : &0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::outbound_packet::OutboundPacket {
        &arg0.packet
    }

    public fun pay_in_zro(arg0: &QuoteParam) : bool {
        arg0.pay_in_zro
    }

    // decompiled from Move bytecode v6
}

