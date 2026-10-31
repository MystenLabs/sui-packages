module 0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SignerSet has copy, drop, store {
        pubkeys: vector<vector<u8>>,
        threshold: u64,
        epoch: u64,
    }

    struct Rotation has copy, drop, store {
        pubkeys: vector<vector<u8>>,
        threshold: u64,
        timelock_ms: u64,
        ready_ms: u64,
    }

    struct FeedRegistry has key {
        id: 0x2::object::UID,
        chain: 0x1::string::String,
        signers: SignerSet,
        timelock_ms: u64,
        pending: 0x1::option::Option<Rotation>,
        feeds: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        dispute_bond: u64,
        forfeited: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct FeedConfig has copy, drop, store {
        name: 0x1::string::String,
        unit: 0x1::string::String,
        decimals: u8,
        category: 0x1::string::String,
        method: 0x1::string::String,
        min_sources: u64,
        heartbeat_ms: u64,
        deviation_bps: u64,
        max_staleness_ms: u64,
        max_report_age_ms: u64,
        max_jump_bps: u64,
        jump_confirmations: u64,
        jump_min_span_ms: u64,
        agree_bps: u64,
        min_conf_bps: u64,
        history_len: u64,
        dispute_window_ms: u64,
    }

    struct PendingConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingConfig has drop, store {
        config: FeedConfig,
        ready_ms: u64,
    }

    struct Point has copy, drop, store {
        value: u64,
        ts_ms: u64,
        round: u64,
    }

    struct Held has copy, drop, store {
        value: u64,
        up: bool,
        count: u64,
        first_ts_ms: u64,
    }

    struct Snapshot has store {
        value: u64,
        point_ts_ms: u64,
        created_ms: u64,
        status: u8,
        challenger: address,
        bond: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Feed has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
        key: 0x1::string::String,
        config: FeedConfig,
        paused: bool,
        round: u64,
        last_ts_ms: u64,
        has_value: bool,
        latest: Point,
        sources: u64,
        conf_bps: u64,
        held: 0x1::option::Option<Held>,
        history: vector<Point>,
        head: u64,
        snapshots: 0x2::table::Table<u64, Snapshot>,
    }

    struct Observation has copy, drop {
        chain: 0x1::string::String,
        package: address,
        registry: address,
        feed: address,
        key: 0x1::string::String,
        epoch: u64,
        round: u64,
        value: u64,
        ts_ms: u64,
        sources: u64,
        conf_bps: u64,
    }

    struct SettleAttestation has copy, drop {
        chain: 0x1::string::String,
        package: address,
        registry: address,
        feed: address,
        key: 0x1::string::String,
        epoch: u64,
        at_ts_ms: u64,
        value: u64,
    }

    struct RegistryCreated has copy, drop {
        registry: 0x2::object::ID,
        chain: 0x1::string::String,
        threshold: u64,
        signers: u64,
    }

    struct FeedCreated has copy, drop {
        registry: 0x2::object::ID,
        feed: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct ConfigUpdated has copy, drop {
        feed: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct ConfigProposed has copy, drop {
        feed: 0x2::object::ID,
        key: 0x1::string::String,
        ready_ms: u64,
    }

    struct ConfigCancelled has copy, drop {
        feed: 0x2::object::ID,
        key: 0x1::string::String,
    }

    struct PausedSet has copy, drop {
        feed: 0x2::object::ID,
        key: 0x1::string::String,
        paused: bool,
    }

    struct Updated has copy, drop {
        feed: 0x2::object::ID,
        key: 0x1::string::String,
        round: u64,
        value: u64,
        ts_ms: u64,
        sources: u64,
        conf_bps: u64,
        signers: vector<u8>,
        values: vector<u64>,
    }

    struct JumpHeld has copy, drop {
        feed: 0x2::object::ID,
        key: 0x1::string::String,
        round: u64,
        value: u64,
        latest: u64,
        count: u64,
        needed: u64,
    }

    struct RotationProposed has copy, drop {
        registry: 0x2::object::ID,
        ready_ms: u64,
        threshold: u64,
        signers: u64,
    }

    struct RotationCancelled has copy, drop {
        registry: 0x2::object::ID,
    }

    struct RotationApplied has copy, drop {
        registry: 0x2::object::ID,
        epoch: u64,
        threshold: u64,
        signers: u64,
    }

    struct SignerRevoked has copy, drop {
        registry: 0x2::object::ID,
        pubkey: vector<u8>,
        epoch: u64,
    }

    struct SnapshotProposed has copy, drop {
        feed: 0x2::object::ID,
        key: 0x1::string::String,
        at_ts_ms: u64,
        value: u64,
        point_ts_ms: u64,
        by_quorum: bool,
    }

    struct SnapshotDisputed has copy, drop {
        feed: 0x2::object::ID,
        key: 0x1::string::String,
        at_ts_ms: u64,
        challenger: address,
        bond: u64,
    }

    struct SnapshotResolved has copy, drop {
        feed: 0x2::object::ID,
        key: 0x1::string::String,
        at_ts_ms: u64,
        value: u64,
        upheld: bool,
        by_admin: bool,
    }

    fun abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun admin_resolve(arg0: &AdminCap, arg1: &mut FeedRegistry, arg2: &mut Feed, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.registry == 0x2::object::id<FeedRegistry>(arg1), 7);
        assert!(arg4 > 0, 21);
        assert!(0x2::table::contains<u64, Snapshot>(&arg2.snapshots, arg3), 30);
        resolve(arg1, arg2, arg3, arg4, true, arg5);
    }

    public fun apply_config(arg0: &mut Feed, arg1: &0x2::clock::Clock) {
        let v0 = PendingConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<PendingConfigKey>(&arg0.id, v0), 41);
        let v1 = PendingConfigKey{dummy_field: false};
        let PendingConfig {
            config   : v2,
            ready_ms : v3,
        } = 0x2::dynamic_field::remove<PendingConfigKey, PendingConfig>(&mut arg0.id, v1);
        assert!(0x2::clock::timestamp_ms(arg1) >= v3, 5);
        arg0.config = v2;
        arg0.held = 0x1::option::none<Held>();
        let v4 = ConfigUpdated{
            feed : 0x2::object::id<Feed>(arg0),
            key  : arg0.key,
        };
        0x2::event::emit<ConfigUpdated>(v4);
    }

    public fun apply_rotation(arg0: &mut FeedRegistry, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<Rotation>(&arg0.pending), 4);
        let v0 = 0x1::option::extract<Rotation>(&mut arg0.pending);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.ready_ms, 5);
        let v1 = arg0.signers.epoch + 1;
        let v2 = SignerSet{
            pubkeys   : v0.pubkeys,
            threshold : v0.threshold,
            epoch     : v1,
        };
        arg0.signers = v2;
        arg0.timelock_ms = v0.timelock_ms;
        let v3 = RotationApplied{
            registry  : 0x2::object::id<FeedRegistry>(arg0),
            epoch     : v1,
            threshold : v0.threshold,
            signers   : 0x1::vector::length<vector<u8>>(&v0.pubkeys),
        };
        0x2::event::emit<RotationApplied>(v3);
    }

    public fun attest_settlement(arg0: &mut FeedRegistry, arg1: &mut Feed, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.registry == 0x2::object::id<FeedRegistry>(arg0), 7);
        assert!(arg3 > 0, 21);
        let v0 = 0x1::vector::length<u8>(&arg4);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == v0, 10);
        check_signers(arg0, &arg4);
        let v1 = settle_message(arg0, arg1, arg2, arg3);
        let v2 = 0;
        while (v2 < v0) {
            assert!(0x2::ed25519::ed25519_verify(0x1::vector::borrow<vector<u8>>(&arg5, v2), 0x1::vector::borrow<vector<u8>>(&arg0.signers.pubkeys, (*0x1::vector::borrow<u8>(&arg4, v2) as u64)), &v1), 14);
            v2 = v2 + 1;
        };
        let v3 = 0x2::clock::timestamp_ms(arg6);
        if (!0x2::table::contains<u64, Snapshot>(&arg1.snapshots, arg2)) {
            assert!(v3 >= arg2, 27);
            let v4 = Snapshot{
                value       : arg3,
                point_ts_ms : arg2,
                created_ms  : v3,
                status      : 0,
                challenger  : @0x0,
                bond        : 0x2::balance::zero<0x2::sui::SUI>(),
            };
            0x2::table::add<u64, Snapshot>(&mut arg1.snapshots, arg2, v4);
            let v5 = SnapshotProposed{
                feed        : 0x2::object::id<Feed>(arg1),
                key         : arg1.key,
                at_ts_ms    : arg2,
                value       : arg3,
                point_ts_ms : arg2,
                by_quorum   : true,
            };
            0x2::event::emit<SnapshotProposed>(v5);
        } else {
            resolve(arg0, arg1, arg2, arg3, false, arg7);
        };
    }

    public fun cancel_config(arg0: &AdminCap, arg1: &mut Feed) {
        let v0 = PendingConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<PendingConfigKey>(&arg1.id, v0), 41);
        let v1 = PendingConfigKey{dummy_field: false};
        0x2::dynamic_field::remove<PendingConfigKey, PendingConfig>(&mut arg1.id, v1);
        let v2 = ConfigCancelled{
            feed : 0x2::object::id<Feed>(arg1),
            key  : arg1.key,
        };
        0x2::event::emit<ConfigCancelled>(v2);
    }

    public fun cancel_rotation(arg0: &AdminCap, arg1: &mut FeedRegistry) {
        assert!(0x1::option::is_some<Rotation>(&arg1.pending), 4);
        arg1.pending = 0x1::option::none<Rotation>();
        let v0 = RotationCancelled{registry: 0x2::object::id<FeedRegistry>(arg1)};
        0x2::event::emit<RotationCancelled>(v0);
    }

    public fun chain(arg0: &FeedRegistry) : 0x1::string::String {
        arg0.chain
    }

    fun check_signers(arg0: &FeedRegistry, arg1: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg1);
        assert!(v0 >= arg0.signers.threshold, 11);
        let v1 = 0;
        while (v1 < v0) {
            assert!((*0x1::vector::borrow<u8>(arg1, v1) as u64) < 0x1::vector::length<vector<u8>>(&arg0.signers.pubkeys), 13);
            if (v1 > 0) {
                assert!(*0x1::vector::borrow<u8>(arg1, v1) > *0x1::vector::borrow<u8>(arg1, v1 - 1), 12);
            };
            v1 = v1 + 1;
        };
    }

    public fun config(arg0: &Feed) : FeedConfig {
        arg0.config
    }

    public fun config_decimals(arg0: &FeedConfig) : u8 {
        arg0.decimals
    }

    public fun config_dispute_window_ms(arg0: &FeedConfig) : u64 {
        arg0.dispute_window_ms
    }

    public fun config_max_staleness_ms(arg0: &FeedConfig) : u64 {
        arg0.max_staleness_ms
    }

    public fun create_feed(arg0: &AdminCap, arg1: &mut FeedRegistry, arg2: 0x1::string::String, arg3: FeedConfig, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        validate_config(&arg3);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.feeds, arg2), 6);
        let v0 = Point{
            value : 0,
            ts_ms : 0,
            round : 0,
        };
        let v1 = Feed{
            id         : 0x2::object::new(arg4),
            registry   : 0x2::object::id<FeedRegistry>(arg1),
            key        : arg2,
            config     : arg3,
            paused     : false,
            round      : 0,
            last_ts_ms : 0,
            has_value  : false,
            latest     : v0,
            sources    : 0,
            conf_bps   : 0,
            held       : 0x1::option::none<Held>(),
            history    : 0x1::vector::empty<Point>(),
            head       : 0,
            snapshots  : 0x2::table::new<u64, Snapshot>(arg4),
        };
        let v2 = 0x2::object::id<Feed>(&v1);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg1.feeds, arg2, v2);
        let v3 = FeedCreated{
            registry : 0x2::object::id<FeedRegistry>(arg1),
            feed     : v2,
            key      : arg2,
        };
        0x2::event::emit<FeedCreated>(v3);
        0x2::transfer::share_object<Feed>(v1);
        v2
    }

    public fun create_registry(arg0: &AdminCap, arg1: 0x1::string::String, arg2: vector<vector<u8>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        validate_signers(&arg2, arg3);
        let v0 = SignerSet{
            pubkeys   : arg2,
            threshold : arg3,
            epoch     : 1,
        };
        let v1 = FeedRegistry{
            id           : 0x2::object::new(arg6),
            chain        : arg1,
            signers      : v0,
            timelock_ms  : arg4,
            pending      : 0x1::option::none<Rotation>(),
            feeds        : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg6),
            dispute_bond : arg5,
            forfeited    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = RegistryCreated{
            registry  : 0x2::object::id<FeedRegistry>(&v1),
            chain     : v1.chain,
            threshold : arg3,
            signers   : 0x1::vector::length<vector<u8>>(&arg2),
        };
        0x2::event::emit<RegistryCreated>(v2);
        0x2::transfer::share_object<FeedRegistry>(v1);
    }

    public fun decimals(arg0: &Feed) : u8 {
        arg0.config.decimals
    }

    public fun dispute(arg0: &FeedRegistry, arg1: &mut Feed, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.registry == 0x2::object::id<FeedRegistry>(arg0), 7);
        assert!(0x2::table::contains<u64, Snapshot>(&arg1.snapshots, arg2), 30);
        let v0 = 0x2::table::borrow_mut<u64, Snapshot>(&mut arg1.snapshots, arg2);
        assert!(v0.status == 0, 32);
        assert!(0x2::clock::timestamp_ms(arg4) < v0.created_ms + arg1.config.dispute_window_ms, 31);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= arg0.dispute_bond, 33);
        0x2::balance::join<0x2::sui::SUI>(&mut v0.bond, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        v0.status = 1;
        v0.challenger = 0x2::tx_context::sender(arg5);
        let v2 = SnapshotDisputed{
            feed       : 0x2::object::id<Feed>(arg1),
            key        : arg1.key,
            at_ts_ms   : arg2,
            challenger : 0x2::tx_context::sender(arg5),
            bond       : v1,
        };
        0x2::event::emit<SnapshotDisputed>(v2);
    }

    public fun dispute_bond(arg0: &FeedRegistry) : u64 {
        arg0.dispute_bond
    }

    public fun epoch(arg0: &FeedRegistry) : u64 {
        arg0.signers.epoch
    }

    public fun feed_id(arg0: &FeedRegistry, arg1: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.feeds, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.feeds, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun feed_registry(arg0: &Feed) : 0x2::object::ID {
        arg0.registry
    }

    public fun finalize(arg0: &mut Feed, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(!arg0.paused, 9);
        assert!(!0x2::table::contains<u64, Snapshot>(&arg0.snapshots, arg1), 26);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1, 27);
        assert!(arg0.last_ts_ms > arg1 || v0 > arg1 + arg0.config.max_report_age_ms, 27);
        let (v1, v2, v3) = value_at(arg0, arg1);
        assert!(v1, 28);
        assert!(arg1 - v3 <= arg0.config.max_staleness_ms, 29);
        let v4 = Snapshot{
            value       : v2,
            point_ts_ms : v3,
            created_ms  : v0,
            status      : 0,
            challenger  : @0x0,
            bond        : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::table::add<u64, Snapshot>(&mut arg0.snapshots, arg1, v4);
        let v5 = SnapshotProposed{
            feed        : 0x2::object::id<Feed>(arg0),
            key         : arg0.key,
            at_ts_ms    : arg1,
            value       : v2,
            point_ts_ms : v3,
            by_quorum   : false,
        };
        0x2::event::emit<SnapshotProposed>(v5);
    }

    public fun forfeited(arg0: &FeedRegistry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.forfeited)
    }

    public fun has_value(arg0: &Feed) : bool {
        arg0.has_value
    }

    public fun held(arg0: &Feed) : (bool, u64, u64) {
        if (0x1::option::is_none<Held>(&arg0.held)) {
            return (false, 0, 0)
        };
        let v0 = 0x1::option::borrow<Held>(&arg0.held);
        (true, v0.value, v0.count)
    }

    public fun history_at(arg0: &Feed, arg1: u64) : (u64, u64, u64) {
        let v0 = nth_newest(arg0, arg1);
        (v0.value, v0.ts_ms, v0.round)
    }

    public fun history_size(arg0: &Feed) : u64 {
        0x1::vector::length<Point>(&arg0.history)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &Feed) : bool {
        arg0.paused
    }

    public fun key(arg0: &Feed) : 0x1::string::String {
        arg0.key
    }

    public fun last_ts_ms(arg0: &Feed) : u64 {
        arg0.last_ts_ms
    }

    public fun latest(arg0: &Feed) : (u64, u64, u64) {
        (arg0.latest.value, arg0.latest.ts_ms, arg0.latest.round)
    }

    fun median(arg0: &vector<u64>) : u64 {
        let v0 = sorted(arg0);
        let v1 = 0x1::vector::length<u64>(&v0);
        if (v1 % 2 == 1) {
            *0x1::vector::borrow<u64>(&v0, v1 / 2)
        } else {
            ((((*0x1::vector::borrow<u64>(&v0, v1 / 2 - 1) as u128) + (*0x1::vector::borrow<u64>(&v0, v1 / 2) as u128)) / 2) as u64)
        }
    }

    public fun new_config(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64) : FeedConfig {
        let v0 = FeedConfig{
            name               : arg0,
            unit               : arg1,
            decimals           : arg2,
            category           : arg3,
            method             : arg4,
            min_sources        : arg5,
            heartbeat_ms       : arg6,
            deviation_bps      : arg7,
            max_staleness_ms   : arg8,
            max_report_age_ms  : arg9,
            max_jump_bps       : arg10,
            jump_confirmations : arg11,
            jump_min_span_ms   : arg12,
            agree_bps          : arg13,
            min_conf_bps       : arg14,
            history_len        : arg15,
            dispute_window_ms  : arg16,
        };
        validate_config(&v0);
        v0
    }

    fun nth_newest(arg0: &Feed, arg1: u64) : Point {
        let v0 = 0x1::vector::length<Point>(&arg0.history);
        *0x1::vector::borrow<Point>(&arg0.history, (arg0.head + v0 + v0 - 1 - arg1) % v0)
    }

    public fun observation_message(arg0: &FeedRegistry, arg1: &Feed, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : vector<u8> {
        let v0 = Observation{
            chain    : arg0.chain,
            package  : 0x1::type_name::original_id<Observation>(),
            registry : 0x2::object::id_address<FeedRegistry>(arg0),
            feed     : 0x2::object::id_address<Feed>(arg1),
            key      : arg1.key,
            epoch    : arg0.signers.epoch,
            round    : arg2,
            value    : arg3,
            ts_ms    : arg4,
            sources  : arg5,
            conf_bps : arg6,
        };
        let v1 = b"Y2K/oracle/obs/v1";
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<Observation>(&v0));
        v1
    }

    public fun pending_config_ready_ms(arg0: &Feed) : 0x1::option::Option<u64> {
        let v0 = PendingConfigKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<PendingConfigKey>(&arg0.id, v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = PendingConfigKey{dummy_field: false};
        0x1::option::some<u64>(0x2::dynamic_field::borrow<PendingConfigKey, PendingConfig>(&arg0.id, v1).ready_ms)
    }

    public fun pending_ready_ms(arg0: &FeedRegistry) : 0x1::option::Option<u64> {
        if (0x1::option::is_none<Rotation>(&arg0.pending)) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(0x1::option::borrow<Rotation>(&arg0.pending).ready_ms)
        }
    }

    public fun propose_config(arg0: &AdminCap, arg1: &FeedRegistry, arg2: &mut Feed, arg3: FeedConfig, arg4: &0x2::clock::Clock) {
        assert!(arg2.registry == 0x2::object::id<FeedRegistry>(arg1), 7);
        validate_config(&arg3);
        assert!(arg3.decimals == arg2.config.decimals && arg3.history_len == arg2.config.history_len, 40);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg1.timelock_ms;
        let v1 = PendingConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PendingConfigKey>(&arg2.id, v1)) {
            let v2 = PendingConfigKey{dummy_field: false};
            0x2::dynamic_field::remove<PendingConfigKey, PendingConfig>(&mut arg2.id, v2);
        };
        let v3 = PendingConfigKey{dummy_field: false};
        let v4 = PendingConfig{
            config   : arg3,
            ready_ms : v0,
        };
        0x2::dynamic_field::add<PendingConfigKey, PendingConfig>(&mut arg2.id, v3, v4);
        let v5 = ConfigProposed{
            feed     : 0x2::object::id<Feed>(arg2),
            key      : arg2.key,
            ready_ms : v0,
        };
        0x2::event::emit<ConfigProposed>(v5);
    }

    public fun propose_rotation(arg0: &AdminCap, arg1: &mut FeedRegistry, arg2: vector<vector<u8>>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        validate_signers(&arg2, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg5) + arg1.timelock_ms;
        let v1 = Rotation{
            pubkeys     : arg2,
            threshold   : arg3,
            timelock_ms : arg4,
            ready_ms    : v0,
        };
        arg1.pending = 0x1::option::some<Rotation>(v1);
        let v2 = RotationProposed{
            registry  : 0x2::object::id<FeedRegistry>(arg1),
            ready_ms  : v0,
            threshold : arg3,
            signers   : 0x1::vector::length<vector<u8>>(&arg2),
        };
        0x2::event::emit<RotationProposed>(v2);
    }

    fun push_history(arg0: &mut Feed, arg1: Point) {
        let v0 = arg0.config.history_len;
        let v1 = 0x1::vector::length<Point>(&arg0.history);
        if (v1 < v0) {
            0x1::vector::push_back<Point>(&mut arg0.history, arg1);
            arg0.head = (v1 + 1) % v0;
        } else {
            *0x1::vector::borrow_mut<Point>(&mut arg0.history, arg0.head) = arg1;
            arg0.head = (arg0.head + 1) % v0;
        };
    }

    public fun quality(arg0: &Feed) : (u64, u64) {
        (arg0.sources, arg0.conf_bps)
    }

    public fun read(arg0: &Feed, arg1: &0x2::clock::Clock) : (u64, u64) {
        read_fresh(arg0, arg0.config.max_staleness_ms, arg1)
    }

    public fun read_fresh(arg0: &Feed, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64) {
        assert!(!arg0.paused, 9);
        assert!(arg0.has_value, 22);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (v0 > arg0.latest.ts_ms) {
            v0 - arg0.latest.ts_ms
        } else {
            0
        };
        assert!(v1 <= arg1 && v1 <= arg0.config.max_staleness_ms, 23);
        (arg0.latest.value, arg0.latest.ts_ms)
    }

    public fun read_full(arg0: &Feed, arg1: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = read(arg0, arg1);
        (v0, v1, arg0.latest.round)
    }

    public fun read_settlement(arg0: &Feed, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        assert!(0x2::table::contains<u64, Snapshot>(&arg0.snapshots, arg1), 30);
        let v0 = 0x2::table::borrow<u64, Snapshot>(&arg0.snapshots, arg1);
        assert!(v0.status == 2 || v0.status == 0 && 0x2::clock::timestamp_ms(arg2) >= v0.created_ms + arg0.config.dispute_window_ms, 35);
        v0.value
    }

    public fun read_twap(arg0: &Feed, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let (_, _) = read(arg0, arg2);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 > 0 && arg1 <= v2, 24);
        let v3 = v2 - arg1;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Point>(&arg0.history)) {
            let v6 = nth_newest(arg0, v5);
            let v7 = if (v6.ts_ms > v2) {
                v2
            } else {
                v6.ts_ms
            };
            if (v7 <= v3) {
                return (((v4 + (v6.value as u128) * ((v2 - v3) as u128)) / (arg1 as u128)) as u64)
            };
            v4 = v4 + (v6.value as u128) * ((v2 - v7) as u128);
            v2 = v7;
            v5 = v5 + 1;
        };
        abort 25
    }

    fun resolve(arg0: &mut FeedRegistry, arg1: &mut Feed, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Snapshot>(&mut arg1.snapshots, arg2);
        assert!(v0.status == 1, 34);
        let v1 = v0.value == arg3;
        let v2 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0.bond);
        if (v1) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.forfeited, v2);
        } else if (0x2::balance::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg5), v0.challenger);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        };
        v0.value = arg3;
        v0.status = 2;
        let v3 = SnapshotResolved{
            feed     : 0x2::object::id<Feed>(arg1),
            key      : arg1.key,
            at_ts_ms : arg2,
            value    : arg3,
            upheld   : v1,
            by_admin : arg4,
        };
        0x2::event::emit<SnapshotResolved>(v3);
    }

    public fun revoke_signer(arg0: &AdminCap, arg1: &mut FeedRegistry, arg2: vector<u8>) {
        let (v0, v1) = 0x1::vector::index_of<vector<u8>>(&arg1.signers.pubkeys, &arg2);
        assert!(v0, 38);
        let v2 = 0x1::vector::length<vector<u8>>(&arg1.signers.pubkeys) - 1;
        assert!(v2 >= arg1.signers.threshold && arg1.signers.threshold * 2 > v2, 39);
        0x1::vector::remove<vector<u8>>(&mut arg1.signers.pubkeys, v1);
        arg1.signers.epoch = arg1.signers.epoch + 1;
        let v3 = SignerRevoked{
            registry : 0x2::object::id<FeedRegistry>(arg1),
            pubkey   : arg2,
            epoch    : arg1.signers.epoch,
        };
        0x2::event::emit<SignerRevoked>(v3);
    }

    public fun round(arg0: &Feed) : u64 {
        arg0.round
    }

    public fun set_dispute_bond(arg0: &AdminCap, arg1: &mut FeedRegistry, arg2: u64) {
        arg1.dispute_bond = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Feed, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedSet{
            feed   : 0x2::object::id<Feed>(arg1),
            key    : arg1.key,
            paused : arg2,
        };
        0x2::event::emit<PausedSet>(v0);
    }

    public fun settle_message(arg0: &FeedRegistry, arg1: &Feed, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = SettleAttestation{
            chain    : arg0.chain,
            package  : 0x1::type_name::original_id<Observation>(),
            registry : 0x2::object::id_address<FeedRegistry>(arg0),
            feed     : 0x2::object::id_address<Feed>(arg1),
            key      : arg1.key,
            epoch    : arg0.signers.epoch,
            at_ts_ms : arg2,
            value    : arg3,
        };
        let v1 = b"Y2K/oracle/settle/v1";
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<SettleAttestation>(&v0));
        v1
    }

    public fun signers(arg0: &FeedRegistry) : vector<vector<u8>> {
        arg0.signers.pubkeys
    }

    public fun snapshot(arg0: &Feed, arg1: u64) : (bool, u8, u64, u64) {
        if (!0x2::table::contains<u64, Snapshot>(&arg0.snapshots, arg1)) {
            return (false, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<u64, Snapshot>(&arg0.snapshots, arg1);
        (true, v0.status, v0.value, v0.created_ms + arg0.config.dispute_window_ms)
    }

    fun sorted(arg0: &vector<u64>) : vector<u64> {
        let v0 = *arg0;
        let v1 = 1;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            while (v1 > 0 && *0x1::vector::borrow<u64>(&v0, v1 - 1) > *0x1::vector::borrow<u64>(&v0, v1)) {
                0x1::vector::swap<u64>(&mut v0, v1 - 1, v1);
                v1 = v1 - 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun submit(arg0: &FeedRegistry, arg1: &mut Feed, arg2: u64, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock) {
        assert!(arg1.registry == 0x2::object::id<FeedRegistry>(arg0), 7);
        assert!(!arg1.paused, 9);
        assert!(arg2 == arg1.round + 1, 15);
        let v0 = 0x1::vector::length<u8>(&arg3);
        let v1 = if (0x1::vector::length<u64>(&arg4) == v0) {
            if (0x1::vector::length<u64>(&arg5) == v0) {
                if (0x1::vector::length<u64>(&arg6) == v0) {
                    if (0x1::vector::length<u64>(&arg7) == v0) {
                        0x1::vector::length<vector<u8>>(&arg8) == v0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 10);
        check_signers(arg0, &arg3);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        let v3 = arg1.config;
        let v4 = 18446744073709551615;
        let v5 = v4;
        let v6 = 18446744073709551615;
        let v7 = v6;
        let v8 = 10000;
        let v9 = v8;
        let v10 = 0;
        while (v10 < v0) {
            let v11 = *0x1::vector::borrow<u64>(&arg4, v10);
            let v12 = *0x1::vector::borrow<u64>(&arg5, v10);
            let v13 = *0x1::vector::borrow<u64>(&arg6, v10);
            let v14 = *0x1::vector::borrow<u64>(&arg7, v10);
            assert!(v11 > 0, 21);
            assert!(v14 <= 10000, 36);
            assert!(v12 <= v2 + 30000, 17);
            assert!(v12 + v3.max_report_age_ms >= v2, 16);
            let v15 = observation_message(arg0, arg1, arg2, v11, v12, v13, v14);
            assert!(0x2::ed25519::ed25519_verify(0x1::vector::borrow<vector<u8>>(&arg8, v10), 0x1::vector::borrow<vector<u8>>(&arg0.signers.pubkeys, (*0x1::vector::borrow<u8>(&arg3, v10) as u64)), &v15), 14);
            if (v12 < v4) {
                v5 = v12;
            };
            if (v13 < v6) {
                v7 = v13;
            };
            if (v14 < v8) {
                v9 = v14;
            };
            v10 = v10 + 1;
        };
        assert!(v7 >= v3.min_sources, 20);
        assert!(v9 >= v3.min_conf_bps, 37);
        assert!(v5 > arg1.last_ts_ms, 18);
        let v16 = median(&arg4);
        v10 = 0;
        while (v10 < v0) {
            assert!(within(*0x1::vector::borrow<u64>(&arg4, v10), v16, v3.agree_bps), 19);
            v10 = v10 + 1;
        };
        arg1.round = arg2;
        arg1.last_ts_ms = v5;
        let v17 = if (arg1.has_value) {
            if (v3.max_jump_bps > 0) {
                if (v3.jump_confirmations > 1) {
                    !within(v16, arg1.latest.value, v3.max_jump_bps)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v17) {
            let v18 = v16 > arg1.latest.value;
            let (v19, v20) = if (0x1::option::is_some<Held>(&arg1.held) && 0x1::option::borrow<Held>(&arg1.held).up == v18) {
                let v21 = 0x1::option::borrow<Held>(&arg1.held);
                (v21.count + 1, v21.first_ts_ms)
            } else {
                (1, v5)
            };
            if (v19 < v3.jump_confirmations || v5 - v20 < v3.jump_min_span_ms) {
                let v22 = Held{
                    value       : v16,
                    up          : v18,
                    count       : v19,
                    first_ts_ms : v20,
                };
                arg1.held = 0x1::option::some<Held>(v22);
                let v23 = JumpHeld{
                    feed   : 0x2::object::id<Feed>(arg1),
                    key    : arg1.key,
                    round  : arg2,
                    value  : v16,
                    latest : arg1.latest.value,
                    count  : v19,
                    needed : v3.jump_confirmations,
                };
                0x2::event::emit<JumpHeld>(v23);
                return
            };
        };
        arg1.held = 0x1::option::none<Held>();
        let v24 = Point{
            value : v16,
            ts_ms : v5,
            round : arg2,
        };
        arg1.latest = v24;
        arg1.has_value = true;
        arg1.sources = v7;
        arg1.conf_bps = v9;
        push_history(arg1, v24);
        let v25 = Updated{
            feed     : 0x2::object::id<Feed>(arg1),
            key      : arg1.key,
            round    : arg2,
            value    : v16,
            ts_ms    : v5,
            sources  : v7,
            conf_bps : v9,
            signers  : arg3,
            values   : arg4,
        };
        0x2::event::emit<Updated>(v25);
    }

    public fun threshold(arg0: &FeedRegistry) : u64 {
        arg0.signers.threshold
    }

    public fun timelock_ms(arg0: &FeedRegistry) : u64 {
        arg0.timelock_ms
    }

    fun validate_config(arg0: &FeedConfig) {
        assert!(arg0.decimals <= 18, 8);
        assert!(arg0.min_sources >= 1, 8);
        assert!(arg0.max_staleness_ms > 0 && arg0.max_report_age_ms > 0, 8);
        let v0 = if (arg0.agree_bps <= 10000) {
            if (arg0.min_conf_bps <= 10000) {
                arg0.deviation_bps <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8);
        assert!(arg0.jump_confirmations >= 1, 8);
        assert!(arg0.history_len >= 2 && arg0.history_len <= 1024, 8);
    }

    fun validate_signers(arg0: &vector<vector<u8>>, arg1: u64) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        assert!(v0 > 0 && v0 <= 32, 2);
        assert!(arg1 * 2 > v0 && arg1 <= v0, 2);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg0, v1)) == 32, 1);
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(*0x1::vector::borrow<vector<u8>>(arg0, v1) != *0x1::vector::borrow<vector<u8>>(arg0, v2), 3);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun value_after(arg0: &Feed, arg1: u64) : (bool, u64, u64, u64) {
        assert!(!arg0.paused, 9);
        let v0 = 0x1::vector::length<Point>(&arg0.history);
        let v1 = 0;
        let v2 = false;
        let v3 = Point{
            value : 0,
            ts_ms : 0,
            round : 0,
        };
        while (v1 < v0) {
            let v4 = nth_newest(arg0, v1);
            if (v4.ts_ms <= arg1) {
                break
            };
            v3 = v4;
            v2 = true;
            v1 = v1 + 1;
        };
        let v5 = if (v2) {
            if (v1 == v0) {
                v0 == arg0.config.history_len
            } else {
                false
            }
        } else {
            false
        };
        if (v5) {
            return (false, 0, 0, 0)
        };
        (v2, v3.value, v3.ts_ms, v3.round)
    }

    public fun value_at(arg0: &Feed, arg1: u64) : (bool, u64, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Point>(&arg0.history)) {
            let v1 = nth_newest(arg0, v0);
            if (v1.ts_ms <= arg1) {
                return (true, v1.value, v1.ts_ms)
            };
            v0 = v0 + 1;
        };
        (false, 0, 0)
    }

    public fun withdraw_forfeited(arg0: &AdminCap, arg1: &mut FeedRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.forfeited, 0x2::balance::value<0x2::sui::SUI>(&arg1.forfeited)), arg2)
    }

    fun within(arg0: u64, arg1: u64, arg2: u64) : bool {
        (abs_diff(arg0, arg1) as u128) * (10000 as u128) <= (arg2 as u128) * (arg1 as u128)
    }

    // decompiled from Move bytecode v7
}

