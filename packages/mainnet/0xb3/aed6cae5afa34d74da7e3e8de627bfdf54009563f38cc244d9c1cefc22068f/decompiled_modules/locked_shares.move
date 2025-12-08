module 0xb3aed6cae5afa34d74da7e3e8de627bfdf54009563f38cc244d9c1cefc22068f::locked_shares {
    struct LockedShares has store, key {
        id: 0x2::object::UID,
        cost: u64,
        market_id: 0x2::object::ID,
        shares: vector<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share>,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u64, arg2: vector<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share>, arg3: &mut 0x2::tx_context::TxContext) : LockedShares {
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

    public fun shares(arg0: &LockedShares) : &vector<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share> {
        &arg0.shares
    }

    public(friend) fun unlock(arg0: LockedShares) : (0x2::object::ID, u64, vector<0xdb709f9960b3fbd3dbe708c76bb7a66e20578dd10606d3a156084fbf92cab546::share::Share>) {
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

