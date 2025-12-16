module 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::nostalgia_ticket {
    struct NostalgiaTicket has store, key {
        id: 0x2::object::UID,
        year: u16,
        content_cid: vector<u8>,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        royalty_bps: u16,
        minted_at_ms: u64,
    }

    public fun creator(arg0: &NostalgiaTicket) : address {
        arg0.creator
    }

    public(friend) fun mint_ticket(arg0: u16, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: u16, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : NostalgiaTicket {
        NostalgiaTicket{
            id           : 0x2::object::new(arg6),
            year         : arg0,
            content_cid  : arg1,
            image_url    : 0x1::string::utf8(arg2),
            name         : 0x1::string::utf8(b"TimeVyn Nostalgia"),
            description  : 0x1::string::utf8(b"A blast from the past."),
            creator      : arg3,
            royalty_bps  : arg4,
            minted_at_ms : arg5,
        }
    }

    public fun royalty_bps(arg0: &NostalgiaTicket) : u16 {
        arg0.royalty_bps
    }

    public fun ticket_id(arg0: &NostalgiaTicket) : 0x2::object::ID {
        0x2::object::id<NostalgiaTicket>(arg0)
    }

    // decompiled from Move bytecode v6
}

