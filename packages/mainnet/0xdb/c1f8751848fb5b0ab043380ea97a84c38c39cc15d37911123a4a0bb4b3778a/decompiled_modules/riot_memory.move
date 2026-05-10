module 0xdbc1f8751848fb5b0ab043380ea97a84c38c39cc15d37911123a4a0bb4b3778a::riot_memory {
    struct MemoryAnchor has store, key {
        id: 0x2::object::UID,
        agent_id: 0x1::string::String,
        memwal_space_id: 0x1::string::String,
        delegate_key_hash: 0x1::string::String,
        latest_blob_id: 0x1::string::String,
        version: u64,
    }

    struct MemoryAnchorCreated has copy, drop {
        agent_id: 0x1::string::String,
        memwal_space_id: 0x1::string::String,
    }

    struct MemorySynced has copy, drop {
        agent_id: 0x1::string::String,
        new_blob_id: 0x1::string::String,
        version: u64,
    }

    public entry fun create_memory_anchor(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoryAnchor{
            id                : 0x2::object::new(arg4),
            agent_id          : arg0,
            memwal_space_id   : arg1,
            delegate_key_hash : arg2,
            latest_blob_id    : arg3,
            version           : 1,
        };
        let v1 = MemoryAnchorCreated{
            agent_id        : v0.agent_id,
            memwal_space_id : v0.memwal_space_id,
        };
        0x2::event::emit<MemoryAnchorCreated>(v1);
        0x2::transfer::transfer<MemoryAnchor>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun get_agent_id(arg0: &MemoryAnchor) : 0x1::string::String {
        arg0.agent_id
    }

    public fun get_memory_state(arg0: &MemoryAnchor) : (0x1::string::String, 0x1::string::String, u64) {
        (arg0.memwal_space_id, arg0.latest_blob_id, arg0.version)
    }

    public entry fun sync_memory(arg0: &mut MemoryAnchor, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.latest_blob_id = arg1;
        arg0.version = arg0.version + 1;
        let v0 = MemorySynced{
            agent_id    : arg0.agent_id,
            new_blob_id : arg0.latest_blob_id,
            version     : arg0.version,
        };
        0x2::event::emit<MemorySynced>(v0);
    }

    // decompiled from Move bytecode v7
}

