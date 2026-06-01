module 0x27654ffd6c13d48f471b1ca24cfdc5614885036b22183c8668ae742830f23cb4::hash_registry {
    struct DailyBatchModel has store, key {
        id: 0x2::object::UID,
        timestamp_ms: u64,
        batch_seq: u64,
        hashes: vector<0x1::ascii::String>,
    }

    struct HashRegistry has store, key {
        id: 0x2::object::UID,
        owner: address,
        seq: u64,
    }

    struct BatchAddedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        batch_id: 0x2::object::ID,
        batch_seq: u64,
        timestamp_ms: u64,
    }

    public entry fun add_daily_batch(arg0: &mut HashRegistry, arg1: vector<vector<u8>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(*0x1::vector::borrow<vector<u8>>(&arg1, v1)));
            v1 = v1 + 1;
        };
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = arg0.seq;
        let v4 = 0x2::object::new(arg3);
        let v5 = DailyBatchModel{
            id           : v4,
            timestamp_ms : v2,
            batch_seq    : v3,
            hashes       : v0,
        };
        let v6 = BatchAddedEvent{
            registry_id  : 0x2::object::id<HashRegistry>(arg0),
            batch_id     : 0x2::object::uid_to_inner(&v4),
            batch_seq    : v3,
            timestamp_ms : v2,
        };
        0x2::event::emit<BatchAddedEvent>(v6);
        0x2::dynamic_object_field::add<u64, DailyBatchModel>(&mut arg0.id, v3, v5);
        arg0.seq = v3 + 1;
    }

    public fun borrow_batch(arg0: &HashRegistry, arg1: u64) : &DailyBatchModel {
        0x2::dynamic_object_field::borrow<u64, DailyBatchModel>(&arg0.id, arg1)
    }

    public entry fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HashRegistry{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            seq   : 0,
        };
        0x2::transfer::share_object<HashRegistry>(v0);
    }

    public fun get_batch_count(arg0: &HashRegistry) : u64 {
        arg0.seq
    }

    public fun get_hashes(arg0: &DailyBatchModel) : &vector<0x1::ascii::String> {
        &arg0.hashes
    }

    public fun get_timestamp(arg0: &DailyBatchModel) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v6
}

