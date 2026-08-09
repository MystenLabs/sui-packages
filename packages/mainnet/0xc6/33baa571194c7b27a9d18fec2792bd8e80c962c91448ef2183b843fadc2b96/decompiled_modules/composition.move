module 0xc633baa571194c7b27a9d18fec2792bd8e80c962c91448ef2183b843fadc2b96::composition {
    struct Target has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
        weight_bps: u64,
    }

    struct Pending has drop, store {
        targets: vector<Target>,
        snapshot_blob_id: vector<u8>,
        proposed_ms: u64,
        effective_ms: u64,
    }

    struct Composition has store {
        targets: vector<Target>,
        snapshot_blob_id: vector<u8>,
        pending: vector<Pending>,
        timelock_ms: u64,
        last_change_ms: u64,
    }

    struct CompositionProposed has copy, drop {
        tokens: vector<0x1::type_name::TypeName>,
        weights: vector<u64>,
        snapshot_blob_id: vector<u8>,
        effective_ms: u64,
        proposer: address,
    }

    struct CompositionExecuted has copy, drop {
        tokens: vector<0x1::type_name::TypeName>,
        weights: vector<u64>,
        snapshot_blob_id: vector<u8>,
        timestamp_ms: u64,
    }

    struct CompositionCancelled has copy, drop {
        cancelled_by: address,
        timestamp_ms: u64,
    }

    public fun bps_total() : u64 {
        10000
    }

    fun build_targets(arg0: &vector<0x1::type_name::TypeName>, arg1: &vector<u64>) : vector<Target> {
        let v0 = 0x1::vector::empty<Target>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(arg0)) {
            let v2 = Target{
                token_type : *0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v1),
                weight_bps : *0x1::vector::borrow<u64>(arg1, v1),
            };
            0x1::vector::push_back<Target>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun cancel_pending(arg0: &mut Composition, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<Pending>(&arg0.pending), 307);
        0x1::vector::pop_back<Pending>(&mut arg0.pending);
        let v0 = CompositionCancelled{
            cancelled_by : 0x2::tx_context::sender(arg2),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CompositionCancelled>(v0);
    }

    public fun contains(arg0: &Composition, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Target>(&arg0.targets)) {
            if (0x1::vector::borrow<Target>(&arg0.targets, v0).token_type == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun execute_pending(arg0: &mut Composition, arg1: &0xc633baa571194c7b27a9d18fec2792bd8e80c962c91448ef2183b843fadc2b96::oracle::OracleConfig, arg2: &0x2::clock::Clock) {
        assert!(!0x1::vector::is_empty<Pending>(&arg0.pending), 307);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1::vector::pop_back<Pending>(&mut arg0.pending);
        assert!(v0 >= v1.effective_ms, 308);
        let (v2, v3) = split_targets(&v1.targets);
        let v4 = v3;
        let v5 = v2;
        validate(arg1, &v5, &v4);
        arg0.targets = v1.targets;
        arg0.snapshot_blob_id = v1.snapshot_blob_id;
        arg0.last_change_ms = v0;
        let v6 = CompositionExecuted{
            tokens           : v5,
            weights          : v4,
            snapshot_blob_id : arg0.snapshot_blob_id,
            timestamp_ms     : v0,
        };
        0x2::event::emit<CompositionExecuted>(v6);
    }

    public fun has_pending(arg0: &Composition) : bool {
        !0x1::vector::is_empty<Pending>(&arg0.pending)
    }

    public fun last_change_ms(arg0: &Composition) : u64 {
        arg0.last_change_ms
    }

    public fun max_weight_bps() : u64 {
        4000
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Composition {
        Composition{
            targets          : 0x1::vector::empty<Target>(),
            snapshot_blob_id : 0x1::vector::empty<u8>(),
            pending          : 0x1::vector::empty<Pending>(),
            timelock_ms      : 86400000,
            last_change_ms   : 0,
        }
    }

    public fun pending_effective_ms(arg0: &Composition) : u64 {
        if (0x1::vector::is_empty<Pending>(&arg0.pending)) {
            return 0
        };
        0x1::vector::borrow<Pending>(&arg0.pending, 0).effective_ms
    }

    public(friend) fun propose(arg0: &mut Composition, arg1: &0xc633baa571194c7b27a9d18fec2792bd8e80c962c91448ef2183b843fadc2b96::oracle::OracleConfig, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u64>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::is_empty<Pending>(&arg0.pending), 309);
        validate(arg1, &arg2, &arg3);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = v0 + arg0.timelock_ms;
        let v2 = Pending{
            targets          : build_targets(&arg2, &arg3),
            snapshot_blob_id : arg4,
            proposed_ms      : v0,
            effective_ms     : v1,
        };
        0x1::vector::push_back<Pending>(&mut arg0.pending, v2);
        let v3 = CompositionProposed{
            tokens           : arg2,
            weights          : arg3,
            snapshot_blob_id : arg4,
            effective_ms     : v1,
            proposer         : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<CompositionProposed>(v3);
    }

    public(friend) fun set_genesis(arg0: &mut Composition, arg1: &0xc633baa571194c7b27a9d18fec2792bd8e80c962c91448ef2183b843fadc2b96::oracle::OracleConfig, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u64>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(0x1::vector::is_empty<Target>(&arg0.targets), 310);
        validate(arg1, &arg2, &arg3);
        arg0.targets = build_targets(&arg2, &arg3);
        arg0.snapshot_blob_id = arg4;
        arg0.last_change_ms = 0x2::clock::timestamp_ms(arg5);
        let v0 = CompositionExecuted{
            tokens           : arg2,
            weights          : arg3,
            snapshot_blob_id : arg0.snapshot_blob_id,
            timestamp_ms     : arg0.last_change_ms,
        };
        0x2::event::emit<CompositionExecuted>(v0);
    }

    public(friend) fun set_timelock(arg0: &mut Composition, arg1: u64) {
        assert!(arg1 >= 3600000 && arg1 <= 604800000, 311);
        arg0.timelock_ms = arg1;
    }

    public fun snapshot_blob_id(arg0: &Composition) : vector<u8> {
        arg0.snapshot_blob_id
    }

    fun split_targets(arg0: &vector<Target>) : (vector<0x1::type_name::TypeName>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<Target>(arg0)) {
            let v3 = 0x1::vector::borrow<Target>(arg0, v2);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v3.token_type);
            0x1::vector::push_back<u64>(&mut v1, v3.weight_bps);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun targets(arg0: &Composition) : (vector<0x1::type_name::TypeName>, vector<u64>) {
        split_targets(&arg0.targets)
    }

    public fun timelock_ms(arg0: &Composition) : u64 {
        arg0.timelock_ms
    }

    public fun token_at(arg0: &Composition, arg1: u64) : 0x1::type_name::TypeName {
        0x1::vector::borrow<Target>(&arg0.targets, arg1).token_type
    }

    public fun token_count(arg0: &Composition) : u64 {
        0x1::vector::length<Target>(&arg0.targets)
    }

    fun validate(arg0: &0xc633baa571194c7b27a9d18fec2792bd8e80c962c91448ef2183b843fadc2b96::oracle::OracleConfig, arg1: &vector<0x1::type_name::TypeName>, arg2: &vector<u64>) {
        let v0 = 0x1::vector::length<0x1::type_name::TypeName>(arg1);
        assert!(v0 == 0x1::vector::length<u64>(arg2), 302);
        assert!(v0 >= 5, 303);
        assert!(v0 <= 5, 304);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(arg1, v2);
            let v4 = *0x1::vector::borrow<u64>(arg2, v2);
            assert!(v4 > 0, 300);
            assert!(v4 <= 4000, 301);
            assert!(0xc633baa571194c7b27a9d18fec2792bd8e80c962c91448ef2183b843fadc2b96::oracle::has_feed(arg0, v3), 306);
            assert!(!0xc633baa571194c7b27a9d18fec2792bd8e80c962c91448ef2183b843fadc2b96::oracle::is_breaker_tripped(arg0, v3), 312);
            let v5 = v2 + 1;
            while (v5 < v0) {
                assert!(*0x1::vector::borrow<0x1::type_name::TypeName>(arg1, v5) != v3, 305);
                v5 = v5 + 1;
            };
            v1 = v1 + v4;
            v2 = v2 + 1;
        };
        assert!(v1 == 10000, 300);
    }

    public fun weight_of(arg0: &Composition, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Target>(&arg0.targets)) {
            let v1 = 0x1::vector::borrow<Target>(&arg0.targets, v0);
            if (v1.token_type == arg1) {
                return v1.weight_bps
            };
            v0 = v0 + 1;
        };
        0
    }

    // decompiled from Move bytecode v7
}

