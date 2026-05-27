module 0xefed65928f6d4e28b242dc042faa22f1aa16632c76c37b091f952a0cfe3bf363::registry {
    struct NotaryRecord has store, key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        file_name: 0x1::string::String,
        file_hash: 0x1::string::String,
        file_size: u64,
        owner: address,
        timestamp: u64,
    }

    struct DocumentRegistered has copy, drop {
        blob_id: 0x1::string::String,
        file_hash: 0x1::string::String,
        owner: address,
        timestamp: u64,
    }

    public fun register_document(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : NotaryRecord {
        assert!(0x1::string::length(&arg0) > 0, 1);
        assert!(0x1::string::length(&arg2) > 0, 2);
        assert!(0x1::string::length(&arg1) > 0, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = DocumentRegistered{
            blob_id   : arg0,
            file_hash : arg2,
            owner     : v0,
            timestamp : v1,
        };
        0x2::event::emit<DocumentRegistered>(v2);
        NotaryRecord{
            id        : 0x2::object::new(arg5),
            blob_id   : arg0,
            file_name : arg1,
            file_hash : arg2,
            file_size : arg3,
            owner     : v0,
            timestamp : v1,
        }
    }

    // decompiled from Move bytecode v7
}

