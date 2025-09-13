module 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote {
    struct QuoteParam has copy, drop, store {
        packet: 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::OutboundPacket,
        options: vector<u8>,
        pay_in_zro: bool,
    }

    public(friend) fun create_param(arg0: 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::OutboundPacket, arg1: vector<u8>, arg2: bool) : QuoteParam {
        QuoteParam{
            packet     : arg0,
            options    : arg1,
            pay_in_zro : arg2,
        }
    }

    public fun options(arg0: &QuoteParam) : &vector<u8> {
        &arg0.options
    }

    public fun packet(arg0: &QuoteParam) : &0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::outbound_packet::OutboundPacket {
        &arg0.packet
    }

    public fun pay_in_zro(arg0: &QuoteParam) : bool {
        arg0.pay_in_zro
    }

    // decompiled from Move bytecode v6
}

