module 0x4a8c8ac50a071eb6da77040d59fad272f05262ac6d9856995f80ffadfea6fae6::nostalgia_ticket {
    struct NostalgiaTicket has store, key {
        id: 0x2::object::UID,
        year: u16,
        content_cid: vector<u8>,
        creator: address,
        royalty_bps: u16,
        minted_at_ms: u64,
    }

    public fun creator(arg0: &NostalgiaTicket) : address {
        arg0.creator
    }

    public(friend) fun mint_ticket(arg0: u16, arg1: vector<u8>, arg2: address, arg3: u16, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : NostalgiaTicket {
        NostalgiaTicket{
            id           : 0x2::object::new(arg5),
            year         : arg0,
            content_cid  : arg1,
            creator      : arg2,
            royalty_bps  : arg3,
            minted_at_ms : arg4,
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

