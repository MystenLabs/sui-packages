module 0x7f3578ebe174b0343cd96391b2a1c75d5db4ad82c793650b3950bdb5634192e5::memory_registry {
    struct MemoryRecorded has copy, drop {
        run_id: 0x1::string::String,
        content_hash: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        walrus_object_id: 0x1::string::String,
        seal_policy_id: 0x1::string::String,
        owner: address,
        recorder: address,
    }

    public fun record_memory(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &0x2::tx_context::TxContext) {
        let v0 = MemoryRecorded{
            run_id           : arg0,
            content_hash     : arg1,
            walrus_blob_id   : arg2,
            walrus_object_id : arg3,
            seal_policy_id   : arg4,
            owner            : arg5,
            recorder         : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<MemoryRecorded>(v0);
    }

    // decompiled from Move bytecode v7
}

