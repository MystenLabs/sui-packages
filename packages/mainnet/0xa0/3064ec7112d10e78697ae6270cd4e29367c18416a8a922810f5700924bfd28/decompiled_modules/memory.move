module 0xa03064ec7112d10e78697ae6270cd4e29367c18416a8a922810f5700924bfd28::memory {
    struct Memory has store, key {
        id: 0x2::object::UID,
        owner: address,
        title: 0x1::string::String,
        text_blob_id: 0x1::string::String,
        image_blob_ids: vector<0x1::string::String>,
        created_at_ms: u64,
        archived: bool,
    }

    struct MemoryCreated has copy, drop {
        memory_id: address,
        owner: address,
        created_at_ms: u64,
    }

    public entry fun archive(arg0: &mut Memory, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        arg0.archived = true;
    }

    public entry fun create_memory(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = Memory{
            id             : 0x2::object::new(arg4),
            owner          : 0x2::tx_context::sender(arg4),
            title          : arg0,
            text_blob_id   : arg1,
            image_blob_ids : arg2,
            created_at_ms  : v0,
            archived       : false,
        };
        let v2 = MemoryCreated{
            memory_id     : 0x2::object::uid_to_address(&v1.id),
            owner         : 0x2::tx_context::sender(arg4),
            created_at_ms : v0,
        };
        0x2::event::emit<MemoryCreated>(v2);
        0x2::transfer::public_transfer<Memory>(v1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

