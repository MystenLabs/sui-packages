module 0xfec70b4aa945e1eec796f93ccb3a5c965320d9a98a996b91bb1845450fa1f193::report {
    struct PhotoSeal has store, key {
        id: 0x2::object::UID,
        record_id: 0x1::string::String,
        photo_hash: 0x1::string::String,
        sealer: address,
        sealed_at_ms: u64,
    }

    struct RecordSeal has store, key {
        id: 0x2::object::UID,
        record_id: 0x1::string::String,
        record_hash: 0x1::string::String,
        photo_count: u64,
        sealer: address,
        sealed_at_ms: u64,
    }

    struct PhotoSealed has copy, drop {
        object_id: address,
        record_id: 0x1::string::String,
        photo_hash: 0x1::string::String,
        sealer: address,
        sealed_at_ms: u64,
    }

    struct RecordSealed has copy, drop {
        object_id: address,
        record_id: 0x1::string::String,
        record_hash: 0x1::string::String,
        photo_count: u64,
        sealer: address,
        sealed_at_ms: u64,
    }

    public fun photo_hash(arg0: &PhotoSeal) : 0x1::string::String {
        arg0.photo_hash
    }

    public fun photo_record_id(arg0: &PhotoSeal) : 0x1::string::String {
        arg0.record_id
    }

    public fun photo_sealed_at_ms(arg0: &PhotoSeal) : u64 {
        arg0.sealed_at_ms
    }

    public fun record_hash(arg0: &RecordSeal) : 0x1::string::String {
        arg0.record_hash
    }

    public fun record_photo_count(arg0: &RecordSeal) : u64 {
        arg0.photo_count
    }

    public fun record_record_id(arg0: &RecordSeal) : 0x1::string::String {
        arg0.record_id
    }

    public fun record_sealed_at_ms(arg0: &RecordSeal) : u64 {
        arg0.sealed_at_ms
    }

    public fun seal_photo(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = PhotoSeal{
            id           : 0x2::object::new(arg3),
            record_id    : arg0,
            photo_hash   : arg1,
            sealer       : v0,
            sealed_at_ms : v1,
        };
        let v3 = PhotoSealed{
            object_id    : 0x2::object::uid_to_address(&v2.id),
            record_id    : arg0,
            photo_hash   : arg1,
            sealer       : v0,
            sealed_at_ms : v1,
        };
        0x2::event::emit<PhotoSealed>(v3);
        0x2::transfer::public_freeze_object<PhotoSeal>(v2);
    }

    public fun seal_record(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = RecordSeal{
            id           : 0x2::object::new(arg4),
            record_id    : arg0,
            record_hash  : arg1,
            photo_count  : arg2,
            sealer       : v0,
            sealed_at_ms : v1,
        };
        let v3 = RecordSealed{
            object_id    : 0x2::object::uid_to_address(&v2.id),
            record_id    : arg0,
            record_hash  : arg1,
            photo_count  : arg2,
            sealer       : v0,
            sealed_at_ms : v1,
        };
        0x2::event::emit<RecordSealed>(v3);
        0x2::transfer::public_freeze_object<RecordSeal>(v2);
    }

    // decompiled from Move bytecode v7
}

