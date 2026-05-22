module 0x1674e28b68c5928f60f39d5f0e3b20a1dcc22f57dea8a5a8a186c3f81816f474::memory {
    struct Memory has key {
        id: 0x2::object::UID,
        wallet: address,
        agent_id: 0x1::string::String,
        messages: vector<0x1::string::String>,
        summary: 0x1::string::String,
        timestamp: u64,
    }

    struct MemoryArchive has key {
        id: 0x2::object::UID,
        wallet: address,
        memories: vector<address>,
        session_count: u64,
        last_updated: u64,
        total_messages: u64,
    }

    struct MemoryStored has copy, drop {
        memory_id: address,
        wallet: address,
        agent_id: 0x1::string::String,
        timestamp: u64,
    }

    struct BatchMemoryStored has copy, drop {
        archive_id: address,
        wallet: address,
        agent_id: 0x1::string::String,
        message_count: u64,
        session_id: 0x1::string::String,
        timestamp: u64,
        tx_digest: 0x1::string::String,
    }

    public fun batch_store_memory(arg0: &mut MemoryArchive, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        let v1 = arg0.wallet;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::vector::pop_back<0x1::string::String>(&mut arg2));
            let v4 = Memory{
                id        : 0x2::object::new(arg5),
                wallet    : v1,
                agent_id  : arg1,
                messages  : v3,
                summary   : arg3,
                timestamp : 0x2::tx_context::epoch(arg5),
            };
            0x1::vector::push_back<address>(&mut arg0.memories, 0x2::object::id_address<Memory>(&v4));
            0x2::transfer::transfer<Memory>(v4, v1);
            v2 = v2 + 1;
        };
        arg0.session_count = arg0.session_count + 1;
        arg0.last_updated = 0x2::tx_context::epoch(arg5);
        arg0.total_messages = arg0.total_messages + v0;
        let v5 = BatchMemoryStored{
            archive_id    : 0x2::object::id_address<MemoryArchive>(arg0),
            wallet        : v1,
            agent_id      : arg1,
            message_count : v0,
            session_id    : arg3,
            timestamp     : 0x2::tx_context::epoch(arg5),
            tx_digest     : arg4,
        };
        0x2::event::emit<BatchMemoryStored>(v5);
    }

    public fun create_archive(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoryArchive{
            id             : 0x2::object::new(arg0),
            wallet         : 0x2::tx_context::sender(arg0),
            memories       : 0x1::vector::empty<address>(),
            session_count  : 0,
            last_updated   : 0x2::tx_context::epoch(arg0),
            total_messages : 0,
        };
        0x2::transfer::transfer<MemoryArchive>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun get_archive_stats(arg0: &MemoryArchive) : (address, u64, u64, u64, u64) {
        (arg0.wallet, 0x1::vector::length<address>(&arg0.memories), arg0.session_count, arg0.last_updated, arg0.total_messages)
    }

    public fun get_memory_ids(arg0: &MemoryArchive) : vector<address> {
        arg0.memories
    }

    public fun get_memory_summary(arg0: &Memory) : (address, 0x1::string::String, 0x1::string::String, u64) {
        (arg0.wallet, arg0.agent_id, arg0.summary, arg0.timestamp)
    }

    public fun is_owner(arg0: &Memory, arg1: address) : bool {
        arg0.wallet == arg1
    }

    public fun store_memory(arg0: address, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Memory{
            id        : 0x2::object::new(arg4),
            wallet    : arg0,
            agent_id  : arg1,
            messages  : arg2,
            summary   : arg3,
            timestamp : 0x2::tx_context::epoch(arg4),
        };
        0x2::transfer::transfer<Memory>(v0, arg0);
        let v1 = MemoryStored{
            memory_id : 0x2::object::id_address<Memory>(&v0),
            wallet    : arg0,
            agent_id  : arg1,
            timestamp : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<MemoryStored>(v1);
    }

    // decompiled from Move bytecode v7
}

