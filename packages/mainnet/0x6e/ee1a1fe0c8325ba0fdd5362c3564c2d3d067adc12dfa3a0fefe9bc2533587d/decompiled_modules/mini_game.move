module 0x6eee1a1fe0c8325ba0fdd5362c3564c2d3d067adc12dfa3a0fefe9bc2533587d::mini_game {
    struct TicketData has copy, drop, store {
        receiver: address,
        mini_game_type: 0x1::string::String,
    }

    public fun add_tickets(arg0: &mut 0x9ff43380566c5424f5775b1c09737d6a5996d378be2459414783c244175868d5::mogul::MogulCentral, arg1: &mut 0x9ff43380566c5424f5775b1c09737d6a5996d378be2459414783c244175868d5::ticket::TicketRegistry, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = TicketData{
            receiver       : arg5,
            mini_game_type : arg3,
        };
        0x9ff43380566c5424f5775b1c09737d6a5996d378be2459414783c244175868d5::ticket::give_ticket<TicketData>(arg1, arg0, arg4, 0x1::string::utf8(b"MINI_GAME"), v0, arg2, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

