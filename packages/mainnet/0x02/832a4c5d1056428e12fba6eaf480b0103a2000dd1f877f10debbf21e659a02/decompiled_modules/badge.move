module 0x2832a4c5d1056428e12fba6eaf480b0103a2000dd1f877f10debbf21e659a02::badge {
    struct Badge has store, key {
        id: 0x2::object::UID,
        owner: address,
        badge_type: u64,
        issued_at_epoch: u64,
    }

    public fun badge_type(arg0: &Badge) : u64 {
        arg0.badge_type
    }

    public fun issued_at_epoch(arg0: &Badge) : u64 {
        arg0.issued_at_epoch
    }

    public fun mint_for_owner(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Badge {
        Badge{
            id              : 0x2::object::new(arg2),
            owner           : arg0,
            badge_type      : arg1,
            issued_at_epoch : 0x2::tx_context::epoch(arg2),
        }
    }

    public fun owner(arg0: &Badge) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v7
}

