module 0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::simple_memory {
    struct SimpleMemory has store, key {
        id: 0x2::object::UID,
        created_at_ms: u64,
        creator: address,
        royalty_bps: u16,
    }

    public fun id(arg0: &SimpleMemory) : 0x2::object::ID {
        0x2::object::id<SimpleMemory>(arg0)
    }

    public fun creator(arg0: &SimpleMemory) : address {
        arg0.creator
    }

    public(friend) fun mint(arg0: u64, arg1: address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : SimpleMemory {
        SimpleMemory{
            id            : 0x2::object::new(arg3),
            created_at_ms : arg0,
            creator       : arg1,
            royalty_bps   : arg2,
        }
    }

    public fun royalty_bps(arg0: &SimpleMemory) : u16 {
        arg0.royalty_bps
    }

    // decompiled from Move bytecode v6
}

