module 0xae8d59bff9c4d19c82e4058d747c03308db2c02e6a6288c9977c82df1a0cc820::events {
    struct SoulMinted has copy, drop {
        agent_id: 0x1::string::String,
        soul_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct MemoryImmortalized has copy, drop {
        blob_id: 0x1::string::String,
        tx_hash: vector<u8>,
        evolution_count: u64,
        timestamp_ms: u64,
    }

    public fun emit_memory_immortalized(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u64, arg3: u64) {
        let v0 = MemoryImmortalized{
            blob_id         : arg0,
            tx_hash         : arg1,
            evolution_count : arg2,
            timestamp_ms    : arg3,
        };
        0x2::event::emit<MemoryImmortalized>(v0);
    }

    public fun emit_soul_minted(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u64) {
        let v0 = SoulMinted{
            agent_id     : arg0,
            soul_hash    : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<SoulMinted>(v0);
    }

    // decompiled from Move bytecode v7
}

