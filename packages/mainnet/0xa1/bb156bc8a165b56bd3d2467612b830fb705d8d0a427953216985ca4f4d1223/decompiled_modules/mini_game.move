module 0xa1bb156bc8a165b56bd3d2467612b830fb705d8d0a427953216985ca4f4d1223::mini_game {
    struct TicketData has copy, drop, store {
        receiver: address,
        mini_game_type: 0x1::string::String,
    }

    public fun add_tickets(arg0: &mut 0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::mogul::MogulCentral, arg1: &mut 0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::ticket::TicketRegistry, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = TicketData{
            receiver       : arg5,
            mini_game_type : arg3,
        };
        0x829da0ffcd021c5df97c06cd5b10de273eb51ade2a4518558da6b164b84fcfd4::ticket::give_ticket<TicketData>(arg1, arg0, arg4, 0x1::string::utf8(b"MINI_GAME"), v0, arg2, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

