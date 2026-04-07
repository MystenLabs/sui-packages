module 0xebd1fe87f77591a7deae3379bc273d0ebfec4fa8c24bcaef03bfa4425a6ab66e::source_registry {
    struct SourceConfig has copy, drop, store {
        expected_object_id: address,
        source_type: u8,
        label_hash: u64,
    }

    struct SourceMap has key {
        id: 0x2::object::UID,
        entries: 0x2::vec_map::VecMap<u8, SourceConfig>,
        price_oracle_object_id: address,
        price_oracle_source_type: u8,
    }

    struct SourceEvidenceEvent has copy, drop {
        strategy_id: u8,
        actual_object_id: address,
        actual_source_type: u8,
        expected_object_id: address,
        expected_source_type: u8,
        matches_expected: bool,
        timestamp_ms: u64,
    }

    struct PriceSourceEvidenceEvent has copy, drop {
        actual_object_id: address,
        actual_source_type: u8,
        price_cents: u64,
        matches_expected: bool,
        timestamp_ms: u64,
    }

    struct SourceMismatchWarning has copy, drop {
        strategy_id: u8,
        actual_object_id: address,
        expected_object_id: address,
        timestamp_ms: u64,
    }

    public fun create_source_map(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SourceMap{
            id                       : 0x2::object::new(arg1),
            entries                  : 0x2::vec_map::empty<u8, SourceConfig>(),
            price_oracle_object_id   : arg0,
            price_oracle_source_type : 2,
        };
        0x2::transfer::share_object<SourceMap>(v0);
    }

    public fun get_expected_source(arg0: &SourceMap, arg1: u8) : (address, u8) {
        if (!0x2::vec_map::contains<u8, SourceConfig>(&arg0.entries, &arg1)) {
            return (@0x0, 0)
        };
        let v0 = 0x2::vec_map::get<u8, SourceConfig>(&arg0.entries, &arg1);
        (v0.expected_object_id, v0.source_type)
    }

    public fun get_price_oracle(arg0: &SourceMap) : (address, u8) {
        (arg0.price_oracle_object_id, arg0.price_oracle_source_type)
    }

    public fun record_price_source(arg0: &SourceMap, arg1: address, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = arg0.price_oracle_object_id == arg1 && arg0.price_oracle_source_type == arg2;
        let v1 = PriceSourceEvidenceEvent{
            actual_object_id   : arg1,
            actual_source_type : arg2,
            price_cents        : arg3,
            matches_expected   : v0,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PriceSourceEvidenceEvent>(v1);
    }

    public fun record_source(arg0: &SourceMap, arg1: u8, arg2: address, arg3: u8, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let (v1, v2, v3) = if (0x2::vec_map::contains<u8, SourceConfig>(&arg0.entries, &arg1)) {
            let v4 = 0x2::vec_map::get<u8, SourceConfig>(&arg0.entries, &arg1);
            let v5 = v4.expected_object_id == arg2 && v4.source_type == arg3;
            (v4.expected_object_id, v4.source_type, v5)
        } else {
            (@0x0, 0, true)
        };
        let v6 = SourceEvidenceEvent{
            strategy_id          : arg1,
            actual_object_id     : arg2,
            actual_source_type   : arg3,
            expected_object_id   : v1,
            expected_source_type : v2,
            matches_expected     : v3,
            timestamp_ms         : v0,
        };
        0x2::event::emit<SourceEvidenceEvent>(v6);
        if (!v3 && v1 != @0x0) {
            let v7 = SourceMismatchWarning{
                strategy_id        : arg1,
                actual_object_id   : arg2,
                expected_object_id : v1,
                timestamp_ms       : v0,
            };
            0x2::event::emit<SourceMismatchWarning>(v7);
        };
    }

    public(friend) fun set_expected_source(arg0: &mut SourceMap, arg1: u8, arg2: address, arg3: u8, arg4: u64) {
        let v0 = SourceConfig{
            expected_object_id : arg2,
            source_type        : arg3,
            label_hash         : arg4,
        };
        if (0x2::vec_map::contains<u8, SourceConfig>(&arg0.entries, &arg1)) {
            *0x2::vec_map::get_mut<u8, SourceConfig>(&mut arg0.entries, &arg1) = v0;
        } else {
            0x2::vec_map::insert<u8, SourceConfig>(&mut arg0.entries, arg1, v0);
        };
    }

    public(friend) fun set_price_oracle(arg0: &mut SourceMap, arg1: address, arg2: u8) {
        arg0.price_oracle_object_id = arg1;
        arg0.price_oracle_source_type = arg2;
    }

    public fun source_api() : u8 {
        1
    }

    public fun source_fallback() : u8 {
        3
    }

    public fun source_onchain() : u8 {
        0
    }

    public fun source_oracle() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

