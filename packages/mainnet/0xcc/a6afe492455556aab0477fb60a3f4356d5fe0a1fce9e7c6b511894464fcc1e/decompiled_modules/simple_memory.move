module 0xcca6afe492455556aab0477fb60a3f4356d5fe0a1fce9e7c6b511894464fcc1e::simple_memory {
    struct SimpleMemory has store, key {
        id: 0x2::object::UID,
        created_at_ms: u64,
    }

    public fun id(arg0: &SimpleMemory) : 0x2::object::ID {
        0x2::object::id<SimpleMemory>(arg0)
    }

    public(friend) fun mint(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : SimpleMemory {
        SimpleMemory{
            id            : 0x2::object::new(arg1),
            created_at_ms : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

