module 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::schema_version {
    struct SchemaVersionCreated has copy, drop {
        form_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
        version_number: u64,
        blob_id: vector<u8>,
    }

    struct SchemaVersion has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        blob_id: vector<u8>,
        version_number: u64,
        parent_blob_id: 0x1::option::Option<vector<u8>>,
        created_at: u64,
    }

    public fun blob_id(arg0: &SchemaVersion) : vector<u8> {
        arg0.blob_id
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: 0x1::option::Option<vector<u8>>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        let v0 = SchemaVersion{
            id             : 0x2::object::new(arg5),
            form_id        : arg0,
            blob_id        : arg1,
            version_number : arg2,
            parent_blob_id : arg3,
            created_at     : 0x2::tx_context::epoch(arg5),
        };
        let v1 = SchemaVersionCreated{
            form_id        : arg0,
            version_id     : 0x2::object::uid_to_inner(&v0.id),
            version_number : arg2,
            blob_id        : v0.blob_id,
        };
        0x2::event::emit<SchemaVersionCreated>(v1);
        0x2::transfer::transfer<SchemaVersion>(v0, arg4);
    }

    public fun created_at(arg0: &SchemaVersion) : u64 {
        arg0.created_at
    }

    public fun form_id(arg0: &SchemaVersion) : 0x2::object::ID {
        arg0.form_id
    }

    public fun parent_blob_id(arg0: &SchemaVersion) : 0x1::option::Option<vector<u8>> {
        arg0.parent_blob_id
    }

    public fun version_number(arg0: &SchemaVersion) : u64 {
        arg0.version_number
    }

    // decompiled from Move bytecode v6
}

