module 0xc3cb3994a0bb382b0e8c4fb394218e20a392363bcb67f9fa9cdcb3b21e7e6923::registry {
    struct MemoryCreated has copy, drop {
        creator: address,
        media_walrus_blob_id: 0x1::string::String,
        metadata_walrus_blob_id: 0x1::string::String,
        title: 0x1::string::String,
        category: 0x1::string::String,
        location_name: 0x1::string::String,
        lat: 0x1::string::String,
        lng: 0x1::string::String,
        year: u64,
        timestamp_ms: u64,
        proof_tx_digest: 0x1::string::String,
        visibility: 0x1::string::String,
    }

    struct ProfileUpdated has copy, drop {
        owner: address,
        profile_metadata_blob_id: 0x1::string::String,
        avatar_walrus_blob_id: 0x1::string::String,
        display_name: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct MemorySaved has copy, drop {
        owner: address,
        metadata_walrus_blob_id: 0x1::string::String,
        memory_creator: address,
        timestamp_ms: u64,
    }

    struct MemoryUnsaved has copy, drop {
        owner: address,
        metadata_walrus_blob_id: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct MemoryArchived has copy, drop {
        owner: address,
        metadata_walrus_blob_id: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct MemoryRestored has copy, drop {
        owner: address,
        metadata_walrus_blob_id: 0x1::string::String,
        timestamp_ms: u64,
    }

    public entry fun archive_memory(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoryArchived{
            owner                   : 0x2::tx_context::sender(arg2),
            metadata_walrus_blob_id : arg0,
            timestamp_ms            : arg1,
        };
        0x2::event::emit<MemoryArchived>(v0);
    }

    public entry fun register_memory(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoryCreated{
            creator                 : 0x2::tx_context::sender(arg11),
            media_walrus_blob_id    : arg0,
            metadata_walrus_blob_id : arg1,
            title                   : arg2,
            category                : arg3,
            location_name           : arg4,
            lat                     : arg5,
            lng                     : arg6,
            year                    : arg7,
            timestamp_ms            : arg8,
            proof_tx_digest         : arg9,
            visibility              : arg10,
        };
        0x2::event::emit<MemoryCreated>(v0);
    }

    public entry fun restore_memory(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoryRestored{
            owner                   : 0x2::tx_context::sender(arg2),
            metadata_walrus_blob_id : arg0,
            timestamp_ms            : arg1,
        };
        0x2::event::emit<MemoryRestored>(v0);
    }

    public entry fun save_memory(arg0: 0x1::string::String, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MemorySaved{
            owner                   : 0x2::tx_context::sender(arg3),
            metadata_walrus_blob_id : arg0,
            memory_creator          : arg1,
            timestamp_ms            : arg2,
        };
        0x2::event::emit<MemorySaved>(v0);
    }

    public entry fun unsave_memory(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoryUnsaved{
            owner                   : 0x2::tx_context::sender(arg2),
            metadata_walrus_blob_id : arg0,
            timestamp_ms            : arg1,
        };
        0x2::event::emit<MemoryUnsaved>(v0);
    }

    public entry fun update_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileUpdated{
            owner                    : 0x2::tx_context::sender(arg4),
            profile_metadata_blob_id : arg0,
            avatar_walrus_blob_id    : arg1,
            display_name             : arg2,
            timestamp_ms             : arg3,
        };
        0x2::event::emit<ProfileUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

