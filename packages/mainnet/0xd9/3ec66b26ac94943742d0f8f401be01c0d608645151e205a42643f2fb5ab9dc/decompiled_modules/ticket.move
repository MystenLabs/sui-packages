module 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::ticket {
    struct Ticket has drop, store {
        number: u64,
        asset_ids: vector<0x2::object::ID>,
        claimed: bool,
        type: u8,
    }

    public fun asset_ids(arg0: &Ticket) : &vector<0x2::object::ID> {
        &arg0.asset_ids
    }

    public(friend) fun borrow_mut_asset_ids(arg0: &mut Ticket) : &mut vector<0x2::object::ID> {
        &mut arg0.asset_ids
    }

    public fun is_claimed(arg0: &Ticket) : bool {
        arg0.claimed
    }

    public fun is_offered_by_coin(arg0: &Ticket) : bool {
        arg0.type == 1
    }

    public fun is_offered_by_nft(arg0: &Ticket) : bool {
        arg0.type == 2
    }

    public fun is_offered_by_nft_kiosk(arg0: &Ticket) : bool {
        arg0.type == 3
    }

    public(friend) fun new(arg0: u64, arg1: vector<0x2::object::ID>, arg2: u8) : Ticket {
        assert!(arg2 == 1 || arg2 == 2 || arg2 == 3, 0);
        Ticket{
            number    : arg0,
            asset_ids : arg1,
            claimed   : false,
            type      : arg2,
        }
    }

    public fun number(arg0: &Ticket) : u64 {
        arg0.number
    }

    public(friend) fun set_claimed(arg0: &mut Ticket) {
        arg0.claimed = true;
    }

    public fun ticket_offered_by_coin() : u8 {
        1
    }

    public fun ticket_offered_by_nft() : u8 {
        2
    }

    public fun ticket_offered_by_nft_kiosk() : u8 {
        3
    }

    public fun type(arg0: &Ticket) : u8 {
        arg0.type
    }

    // decompiled from Move bytecode v6
}

