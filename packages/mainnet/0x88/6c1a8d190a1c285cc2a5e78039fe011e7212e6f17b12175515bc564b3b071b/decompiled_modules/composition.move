module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition {
    struct Target has copy, drop, store {
        token: 0x1::type_name::TypeName,
        weight_bps: u64,
    }

    struct Pending has drop, store {
        targets: vector<Target>,
        weight_only: bool,
        snapshot_blob_id: vector<u8>,
        effective_ms: u64,
    }

    struct Composition has store {
        targets: vector<Target>,
        pending: vector<Pending>,
        snapshot_blob_id: vector<u8>,
        last_change_ms: u64,
    }

    struct CompositionProposed has copy, drop {
        weight_only: bool,
        effective_ms: u64,
        snapshot_blob_id: vector<u8>,
    }

    struct CompositionExecuted has copy, drop {
        token_count: u64,
        timestamp_ms: u64,
    }

    struct CompositionCancelled has copy, drop {
        timestamp_ms: u64,
    }

    public(friend) fun assert_constituent(arg0: &Composition, arg1: 0x1::type_name::TypeName) {
        assert!(is_constituent(arg0, arg1), 804);
    }

    fun assert_feeds_ready(arg0: &vector<0x1::type_name::TypeName>, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(arg0)) {
            let v1 = *0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v0);
            if (0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::is_bound(arg1, v1)) {
                assert!(!0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::is_tripped(arg1, v1), 812);
            } else {
                assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::is_pending(arg1, v1), 811);
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun assert_migration_valid(arg0: &Composition, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy) {
        assert!(!has_pending(arg0), 805);
        if (0x1::vector::is_empty<Target>(&arg0.targets)) {
            return
        };
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Target>(&arg0.targets)) {
            let v3 = 0x1::vector::borrow<Target>(&arg0.targets, v2);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v3.token);
            0x1::vector::push_back<u64>(&mut v1, v3.weight_bps);
            v2 = v2 + 1;
        };
        validate(&v0, &v1, arg1);
    }

    fun assert_targets_live(arg0: &vector<Target>, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Target>(arg0)) {
            let v1 = 0x1::vector::borrow<Target>(arg0, v0).token;
            assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::is_bound(arg1, v1), 813);
            assert!(!0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::is_tripped(arg1, v1), 812);
            v0 = v0 + 1;
        };
    }

    fun build(arg0: &vector<0x1::type_name::TypeName>, arg1: &vector<u64>) : vector<Target> {
        let v0 = 0x1::vector::empty<Target>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(arg0)) {
            let v2 = Target{
                token      : *0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v1),
                weight_bps : *0x1::vector::borrow<u64>(arg1, v1),
            };
            0x1::vector::push_back<Target>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun cancel(arg0: &mut Composition, arg1: &0x2::clock::Clock) {
        assert!(!0x1::vector::is_empty<Pending>(&arg0.pending), 806);
        0x1::vector::pop_back<Pending>(&mut arg0.pending);
        let v0 = CompositionCancelled{timestamp_ms: 0x2::clock::timestamp_ms(arg1)};
        0x2::event::emit<CompositionCancelled>(v0);
    }

    public(friend) fun execute(arg0: &mut Composition, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices, arg2: &0x2::clock::Clock) {
        assert!(!0x1::vector::is_empty<Pending>(&arg0.pending), 806);
        let v0 = 0x1::vector::pop_back<Pending>(&mut arg0.pending);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= v0.effective_ms, 807);
        assert_targets_live(&v0.targets, arg1);
        arg0.targets = v0.targets;
        arg0.snapshot_blob_id = v0.snapshot_blob_id;
        arg0.last_change_ms = v1;
        let v2 = CompositionExecuted{
            token_count  : 0x1::vector::length<Target>(&arg0.targets),
            timestamp_ms : v1,
        };
        0x2::event::emit<CompositionExecuted>(v2);
    }

    public(friend) fun has_pending(arg0: &Composition) : bool {
        !0x1::vector::is_empty<Pending>(&arg0.pending)
    }

    public(friend) fun is_constituent(arg0: &Composition, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Target>(&arg0.targets)) {
            if (0x1::vector::borrow<Target>(&arg0.targets, v0).token == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun is_initialised(arg0: &Composition) : bool {
        !0x1::vector::is_empty<Target>(&arg0.targets)
    }

    public(friend) fun last_change_ms(arg0: &Composition) : u64 {
        arg0.last_change_ms
    }

    public(friend) fun new() : Composition {
        Composition{
            targets          : 0x1::vector::empty<Target>(),
            pending          : 0x1::vector::empty<Pending>(),
            snapshot_blob_id : b"",
            last_change_ms   : 0,
        }
    }

    public(friend) fun pending_effective_ms(arg0: &Composition) : u64 {
        assert!(!0x1::vector::is_empty<Pending>(&arg0.pending), 806);
        0x1::vector::borrow<Pending>(&arg0.pending, 0).effective_ms
    }

    public(friend) fun propose(arg0: &mut Composition, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices, arg3: vector<0x1::type_name::TypeName>, arg4: vector<u64>, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        assert!(0x1::vector::is_empty<Pending>(&arg0.pending), 805);
        validate(&arg3, &arg4, arg1);
        assert_feeds_ready(&arg3, arg2);
        let v0 = same_token_set(arg0, &arg3);
        let v1 = if (v0) {
            0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::reweight_timelock_ms(arg1)
        } else {
            0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::composition_timelock_ms(arg1)
        };
        let v2 = 0x2::clock::timestamp_ms(arg6) + v1;
        let v3 = Pending{
            targets          : build(&arg3, &arg4),
            weight_only      : v0,
            snapshot_blob_id : arg5,
            effective_ms     : v2,
        };
        0x1::vector::push_back<Pending>(&mut arg0.pending, v3);
        let v4 = CompositionProposed{
            weight_only      : v0,
            effective_ms     : v2,
            snapshot_blob_id : arg5,
        };
        0x2::event::emit<CompositionProposed>(v4);
    }

    fun same_token_set(arg0: &Composition, arg1: &vector<0x1::type_name::TypeName>) : bool {
        let v0 = 0x1::vector::length<Target>(&arg0.targets);
        if (v0 != 0x1::vector::length<0x1::type_name::TypeName>(arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = false;
            let v3 = 0;
            while (v3 < v0) {
                if (*0x1::vector::borrow<0x1::type_name::TypeName>(arg1, v3) == 0x1::vector::borrow<Target>(&arg0.targets, v1).token) {
                    v2 = true;
                    break
                };
                v3 = v3 + 1;
            };
            if (!v2) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public(friend) fun set_genesis(arg0: &mut Composition, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u64>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(0x1::vector::is_empty<Target>(&arg0.targets), 808);
        validate(&arg2, &arg3, arg1);
        arg0.targets = build(&arg2, &arg3);
        arg0.snapshot_blob_id = arg4;
        arg0.last_change_ms = 0x2::clock::timestamp_ms(arg5);
        let v0 = CompositionExecuted{
            token_count  : 0x1::vector::length<Target>(&arg0.targets),
            timestamp_ms : arg0.last_change_ms,
        };
        0x2::event::emit<CompositionExecuted>(v0);
    }

    public(friend) fun snapshot_blob_id(arg0: &Composition) : vector<u8> {
        arg0.snapshot_blob_id
    }

    public(friend) fun target_at(arg0: &Composition, arg1: u64) : (0x1::type_name::TypeName, u64) {
        let v0 = 0x1::vector::borrow<Target>(&arg0.targets, arg1);
        (v0.token, v0.weight_bps)
    }

    public(friend) fun token_count(arg0: &Composition) : u64 {
        0x1::vector::length<Target>(&arg0.targets)
    }

    public(friend) fun tokens(arg0: &Composition) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Target>(&arg0.targets)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::vector::borrow<Target>(&arg0.targets, v1).token);
            v1 = v1 + 1;
        };
        v0
    }

    fun validate(arg0: &vector<0x1::type_name::TypeName>, arg1: &vector<u64>, arg2: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy) {
        let v0 = 0x1::vector::length<0x1::type_name::TypeName>(arg0);
        assert!(v0 == 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::index_size(arg2), 802);
        assert!(0x1::vector::length<u64>(arg1) == v0, 802);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(arg1, v2);
            assert!(v3 > 0, 809);
            assert!(v3 <= 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::max_weight_bps(arg2), 801);
            v1 = v1 + v3;
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v2);
            let v5 = v2 + 1;
            while (v5 < v0) {
                assert!(*0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v5) != v4, 803);
                v5 = v5 + 1;
            };
            assert!(!0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::is_denomination(arg2, v4), 810);
            v2 = v2 + 1;
        };
        assert!(v1 == 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::bps_divisor(), 800);
    }

    public(friend) fun weight_of(arg0: &Composition, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Target>(&arg0.targets)) {
            let v1 = 0x1::vector::borrow<Target>(&arg0.targets, v0);
            if (v1.token == arg1) {
                return v1.weight_bps
            };
            v0 = v0 + 1;
        };
        abort 804
    }

    // decompiled from Move bytecode v7
}

