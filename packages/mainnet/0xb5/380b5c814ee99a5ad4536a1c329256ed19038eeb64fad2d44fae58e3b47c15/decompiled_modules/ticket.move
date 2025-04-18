module 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::ticket {
    struct Ticket has drop, store {
        number: u64,
        asset_ids: vector<0x2::object::ID>,
        claimed: bool,
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

    public(friend) fun new(arg0: u64, arg1: vector<0x2::object::ID>) : Ticket {
        Ticket{
            number    : arg0,
            asset_ids : arg1,
            claimed   : false,
        }
    }

    public fun number(arg0: &Ticket) : u64 {
        arg0.number
    }

    public(friend) fun set_claimed(arg0: &mut Ticket) {
        arg0.claimed = true;
    }

    // decompiled from Move bytecode v6
}

