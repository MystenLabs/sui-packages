module 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory {
    struct GhostMemory has store, key {
        id: 0x2::object::UID,
        created_at_ms: u64,
        creator: address,
        royalty_bps: u16,
    }

    public fun id(arg0: &GhostMemory) : 0x2::object::ID {
        0x2::object::id<GhostMemory>(arg0)
    }

    public fun created_at_ms(arg0: &GhostMemory) : u64 {
        arg0.created_at_ms
    }

    public fun creator(arg0: &GhostMemory) : address {
        arg0.creator
    }

    public(friend) fun destroy(arg0: GhostMemory) {
        let GhostMemory {
            id            : v0,
            created_at_ms : _,
            creator       : _,
            royalty_bps   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun mint(arg0: u64, arg1: address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : GhostMemory {
        GhostMemory{
            id            : 0x2::object::new(arg3),
            created_at_ms : arg0,
            creator       : arg1,
            royalty_bps   : arg2,
        }
    }

    public fun royalty_bps(arg0: &GhostMemory) : u16 {
        arg0.royalty_bps
    }

    // decompiled from Move bytecode v7
}

