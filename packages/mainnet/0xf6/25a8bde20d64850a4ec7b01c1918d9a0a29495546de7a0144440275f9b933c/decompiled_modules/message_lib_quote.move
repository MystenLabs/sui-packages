module 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote {
    struct QuoteParam has copy, drop, store {
        packet: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::OutboundPacket,
        options: vector<u8>,
        pay_in_zro: bool,
    }

    public(friend) fun create_param(arg0: 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::OutboundPacket, arg1: vector<u8>, arg2: bool) : QuoteParam {
        QuoteParam{
            packet     : arg0,
            options    : arg1,
            pay_in_zro : arg2,
        }
    }

    public fun options(arg0: &QuoteParam) : &vector<u8> {
        &arg0.options
    }

    public fun packet(arg0: &QuoteParam) : &0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::outbound_packet::OutboundPacket {
        &arg0.packet
    }

    public fun pay_in_zro(arg0: &QuoteParam) : bool {
        arg0.pay_in_zro
    }

    // decompiled from Move bytecode v6
}

