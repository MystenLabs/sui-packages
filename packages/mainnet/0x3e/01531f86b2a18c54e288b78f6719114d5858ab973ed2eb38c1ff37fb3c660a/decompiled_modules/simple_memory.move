module 0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::simple_memory {
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

