module 0x5b8add37cfe12f7e9973623010b6c3a019d920936832d7a1347f381776a5e035::seal {
    struct SealCap has store, key {
        id: 0x2::object::UID,
    }

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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SealCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<SealCap>(v0, 0x2::tx_context::sender(arg0));
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

    public fun photo_sealer(arg0: &PhotoSeal) : address {
        arg0.sealer
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

    public fun record_sealer(arg0: &RecordSeal) : address {
        arg0.sealer
    }

    public fun seal_photo(arg0: &SealCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = PhotoSeal{
            id           : 0x2::object::new(arg4),
            record_id    : arg1,
            photo_hash   : arg2,
            sealer       : v0,
            sealed_at_ms : v1,
        };
        let v3 = PhotoSealed{
            object_id    : 0x2::object::uid_to_address(&v2.id),
            record_id    : arg1,
            photo_hash   : arg2,
            sealer       : v0,
            sealed_at_ms : v1,
        };
        0x2::event::emit<PhotoSealed>(v3);
        0x2::transfer::public_freeze_object<PhotoSeal>(v2);
    }

    public fun seal_record(arg0: &SealCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = RecordSeal{
            id           : 0x2::object::new(arg5),
            record_id    : arg1,
            record_hash  : arg2,
            photo_count  : arg3,
            sealer       : v0,
            sealed_at_ms : v1,
        };
        let v3 = RecordSealed{
            object_id    : 0x2::object::uid_to_address(&v2.id),
            record_id    : arg1,
            record_hash  : arg2,
            photo_count  : arg3,
            sealer       : v0,
            sealed_at_ms : v1,
        };
        0x2::event::emit<RecordSealed>(v3);
        0x2::transfer::public_freeze_object<RecordSeal>(v2);
    }

    // decompiled from Move bytecode v7
}

