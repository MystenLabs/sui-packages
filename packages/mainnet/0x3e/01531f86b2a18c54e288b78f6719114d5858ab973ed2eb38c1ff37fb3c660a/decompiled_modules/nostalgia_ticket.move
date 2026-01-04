module 0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::nostalgia_ticket {
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

    public(friend) fun mint_ticket(arg0: u16, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u16, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : NostalgiaTicket {
        NostalgiaTicket{
            id           : 0x2::object::new(arg7),
            year         : arg0,
            content_cid  : arg1,
            image_url    : 0x1::string::utf8(arg2),
            name         : 0x1::string::utf8(b"TimeVyn Nostalgia"),
            description  : 0x1::string::utf8(arg3),
            creator      : arg4,
            royalty_bps  : arg5,
            minted_at_ms : arg6,
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

