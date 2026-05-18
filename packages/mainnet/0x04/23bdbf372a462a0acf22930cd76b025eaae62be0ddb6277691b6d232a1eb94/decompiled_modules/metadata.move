module 0x423bdbf372a462a0acf22930cd76b025eaae62be0ddb6277691b6d232a1eb94::metadata {
    struct MetadataRecord has store, key {
        id: 0x2::object::UID,
        blob_id: vector<u8>,
        schema_hash: vector<u8>,
        record_type: u8,
        form_blob_id: 0x1::option::Option<vector<u8>>,
        owner_address: address,
        created_at_ms: u64,
    }

    struct MetadataAnchored has copy, drop {
        record_id: address,
        blob_id: vector<u8>,
        schema_hash: vector<u8>,
        record_type: u8,
        form_blob_id: 0x1::option::Option<vector<u8>>,
        owner_address: address,
        created_at_ms: u64,
    }

    public entry fun anchor_record(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: 0x1::option::Option<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 1 || arg2 == 2, 1);
        assert!(0x1::vector::length<u8>(&arg0) > 0, 2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 3);
        if (arg2 == 2) {
            assert!(0x1::option::is_some<vector<u8>>(&arg3), 1);
        } else {
            assert!(0x1::option::is_none<vector<u8>>(&arg3), 1);
        };
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = MetadataRecord{
            id            : 0x2::object::new(arg4),
            blob_id       : arg0,
            schema_hash   : arg1,
            record_type   : arg2,
            form_blob_id  : arg3,
            owner_address : v0,
            created_at_ms : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        let v2 = MetadataAnchored{
            record_id     : 0x2::object::uid_to_address(&v1.id),
            blob_id       : v1.blob_id,
            schema_hash   : v1.schema_hash,
            record_type   : v1.record_type,
            form_blob_id  : v1.form_blob_id,
            owner_address : v1.owner_address,
            created_at_ms : v1.created_at_ms,
        };
        0x2::event::emit<MetadataAnchored>(v2);
        0x2::transfer::public_transfer<MetadataRecord>(v1, v0);
    }

    public entry fun seal_approve(arg0: vector<u8>) {
    }

    // decompiled from Move bytecode v7
}

