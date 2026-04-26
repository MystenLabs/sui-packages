module 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory {
    struct SoulMemory has key {
        id: 0x2::object::UID,
        soul_id: 0x2::object::ID,
        entries: 0x2::table::Table<u64, 0x2::object::ID>,
        entry_count: u64,
    }

    struct MemoryBlobKey has copy, drop, store {
        timestamp_key: u64,
    }

    struct SoulMemoryCreated has copy, drop {
        memory_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
    }

    struct MemoryEntryAppended has copy, drop {
        memory_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        timestamp_key: u64,
        writer: address,
        writer_kind: u8,
        created_at_ms: u64,
        blob_object_id: 0x2::object::ID,
    }

    public fun append_as_granted_agent(arg0: &mut SoulMemory, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::SoulGrant, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 1);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::assert_active_with_scope(arg1, arg2, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::scope_memory(), arg4, arg5);
        let v0 = 0x2::tx_context::sender(arg5);
        append_impl(arg0, v0, 2, arg3, 0x2::clock::timestamp_ms(arg4), arg5)
    }

    public fun append_as_owner(arg0: &mut SoulMemory, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg4));
        assert!(arg0.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 0);
        let v0 = 0x2::tx_context::sender(arg4);
        append_impl(arg0, v0, 1, arg2, 0x2::clock::timestamp_ms(arg3), arg4)
    }

    public(friend) fun append_founding(arg0: &mut SoulMemory, arg1: address, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        append_impl(arg0, arg1, 0, arg2, 0x2::clock::timestamp_ms(arg3), arg4)
    }

    fun append_impl(arg0: &mut SoulMemory, arg1: address, arg2: u8, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg4;
        while (0x2::table::contains<u64, 0x2::object::ID>(&arg0.entries, v0)) {
            v0 = v0 + 1;
        };
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::object_id(&arg3);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.entries, v0, v1);
        arg0.entry_count = arg0.entry_count + 1;
        let v2 = MemoryBlobKey{timestamp_key: v0};
        0x2::dynamic_object_field::add<MemoryBlobKey, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.id, v2, arg3);
        let v3 = MemoryEntryAppended{
            memory_id      : 0x2::object::id<SoulMemory>(arg0),
            soul_id        : arg0.soul_id,
            timestamp_key  : v0,
            writer         : arg1,
            writer_kind    : arg2,
            created_at_ms  : arg4,
            blob_object_id : v1,
        };
        0x2::event::emit<MemoryEntryAppended>(v3);
        v0
    }

    public fun blob_object_id_for(arg0: &SoulMemory, arg1: u64) : 0x2::object::ID {
        assert!(contains_entry(arg0, arg1), 2);
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.entries, arg1)
    }

    public fun contains_entry(arg0: &SoulMemory, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::object::ID>(&arg0.entries, arg1)
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : SoulMemory {
        let v0 = SoulMemory{
            id          : 0x2::object::new(arg1),
            soul_id     : arg0,
            entries     : 0x2::table::new<u64, 0x2::object::ID>(arg1),
            entry_count : 0,
        };
        let v1 = SoulMemoryCreated{
            memory_id : 0x2::object::id<SoulMemory>(&v0),
            soul_id   : arg0,
        };
        0x2::event::emit<SoulMemoryCreated>(v1);
        v0
    }

    public fun entry_count(arg0: &SoulMemory) : u64 {
        arg0.entry_count
    }

    public(friend) fun share_memory(arg0: SoulMemory) {
        0x2::transfer::share_object<SoulMemory>(arg0);
    }

    public fun soul_id(arg0: &SoulMemory) : 0x2::object::ID {
        arg0.soul_id
    }

    // decompiled from Move bytecode v7
}

