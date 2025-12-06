module 0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::locked_shares {
    struct LockedShares has store, key {
        id: 0x2::object::UID,
        cost: u64,
        market_id: 0x2::object::ID,
        shares: vector<0x4377ddfad1dc3db8b665ac73115c3100ae01e82167aeacd4f2e69e961b99340c::share::Share>,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u64, arg2: vector<0x4377ddfad1dc3db8b665ac73115c3100ae01e82167aeacd4f2e69e961b99340c::share::Share>, arg3: &mut 0x2::tx_context::TxContext) : LockedShares {
        LockedShares{
            id        : 0x2::object::new(arg3),
            cost      : arg1,
            market_id : arg0,
            shares    : arg2,
        }
    }

    public fun cost(arg0: &LockedShares) : u64 {
        arg0.cost
    }

    public fun id(arg0: &LockedShares) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun market_id(arg0: &LockedShares) : 0x2::object::ID {
        arg0.market_id
    }

    public fun shares(arg0: &LockedShares) : &vector<0x4377ddfad1dc3db8b665ac73115c3100ae01e82167aeacd4f2e69e961b99340c::share::Share> {
        &arg0.shares
    }

    public(friend) fun unlock(arg0: LockedShares) : (0x2::object::ID, u64, vector<0x4377ddfad1dc3db8b665ac73115c3100ae01e82167aeacd4f2e69e961b99340c::share::Share>) {
        let LockedShares {
            id        : v0,
            cost      : v1,
            market_id : v2,
            shares    : v3,
        } = arg0;
        0x2::object::delete(v0);
        (v2, v1, v3)
    }

    // decompiled from Move bytecode v6
}

