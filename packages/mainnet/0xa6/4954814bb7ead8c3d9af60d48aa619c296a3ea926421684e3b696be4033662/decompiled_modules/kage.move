module 0xa64954814bb7ead8c3d9af60d48aa619c296a3ea926421684e3b696be4033662::kage {
    struct MemoryEntry has copy, drop, store {
        id: u64,
        agent: address,
        blob_id: 0x1::string::String,
        blob_hash: vector<u8>,
        tags: vector<0x1::string::String>,
        asset: 0x1::string::String,
        action: 0x1::string::String,
        outcome: 0x1::string::String,
        confidence: u64,
        ttl_epochs: u64,
        written_epoch: u64,
        written_ms: u64,
        conflict_flag: bool,
        conflict_with: 0x1::option::Option<u64>,
        weight: u64,
        namespace: 0x1::string::String,
        inherited_from: 0x1::option::Option<u64>,
        shared_from_graph: 0x1::option::Option<0x2::object::ID>,
    }

    struct AgentRecord has copy, drop, store {
        agent: address,
        name: 0x1::string::String,
        namespace: 0x1::string::String,
        reputation: u64,
        total_writes: u64,
        successful_outcomes: u64,
        failed_outcomes: u64,
        registered_at_ms: u64,
        active: bool,
    }

    struct Subscription has copy, drop, store {
        id: u64,
        subscriber: address,
        watch_tags: vector<0x1::string::String>,
        watch_asset: 0x1::string::String,
        watch_action: 0x1::string::String,
        watch_namespace: 0x1::string::String,
        active: bool,
        trigger_count: u64,
    }

    struct Snapshot has copy, drop, store {
        snapshot_id: u64,
        taken_at_sequence: u64,
        taken_at_ms: u64,
        taken_by: address,
        description: 0x1::string::String,
        memory_count: u64,
        namespace: 0x1::string::String,
        latest_blob_id: 0x1::string::String,
    }

    struct CrossGraphBridge has store, key {
        id: 0x2::object::UID,
        protocol_a: 0x2::object::ID,
        protocol_b: 0x2::object::ID,
        shared_namespace: 0x1::string::String,
        created_by: address,
        active: bool,
        total_shared: u64,
    }

    struct KageProtocol has key {
        id: 0x2::object::UID,
        memory_index: 0x2::table::Table<u64, MemoryEntry>,
        agent_registry: 0x2::table::Table<address, AgentRecord>,
        subscriptions: 0x2::table::Table<u64, Subscription>,
        snapshots: 0x2::table::Table<u64, Snapshot>,
        namespace_index: 0x2::vec_map::VecMap<0x1::string::String, vector<u64>>,
        asset_index: 0x2::vec_map::VecMap<0x1::string::String, vector<u64>>,
        tag_index: 0x2::vec_map::VecMap<0x1::string::String, vector<u64>>,
        active_bridges: 0x2::vec_map::VecMap<0x2::object::ID, bool>,
        total_memories: u64,
        total_subscriptions: u64,
        total_snapshots: u64,
        total_conflicts: u64,
        admin: address,
    }

    struct KageAdminCap has store, key {
        id: 0x2::object::UID,
        protocol_id: 0x2::object::ID,
    }

    struct MemoryWritten has copy, drop {
        memory_id: u64,
        agent: address,
        blob_id: 0x1::string::String,
        tags: vector<0x1::string::String>,
        asset: 0x1::string::String,
        action: 0x1::string::String,
        confidence: u64,
        namespace: 0x1::string::String,
        weight: u64,
        timestamp_ms: u64,
    }

    struct MemoryTriggered has copy, drop {
        subscription_id: u64,
        subscriber: address,
        memory_id: u64,
        blob_id: 0x1::string::String,
        asset: 0x1::string::String,
        action: 0x1::string::String,
        namespace: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ConflictDetected has copy, drop {
        memory_id_a: u64,
        memory_id_b: u64,
        agent_a: address,
        agent_b: address,
        asset: 0x1::string::String,
        action_a: 0x1::string::String,
        action_b: 0x1::string::String,
        namespace: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ReputationUpdated has copy, drop {
        agent: address,
        old_rep: u64,
        new_rep: u64,
        reason: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct SnapshotTaken has copy, drop {
        snapshot_id: u64,
        taken_at_sequence: u64,
        namespace: 0x1::string::String,
        memory_count: u64,
        latest_blob_id: 0x1::string::String,
        taken_by: address,
        timestamp_ms: u64,
    }

    struct MemoryInherited has copy, drop {
        child_memory_id: u64,
        parent_memory_id: u64,
        child_agent: address,
        parent_agent: address,
        namespace: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct CrossGraphMemoryShared has copy, drop {
        bridge_id: 0x2::object::ID,
        memory_id: u64,
        source_protocol: 0x2::object::ID,
        target_protocol: 0x2::object::ID,
        shared_namespace: 0x1::string::String,
        blob_id: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct BridgeCreated has copy, drop {
        bridge_id: 0x2::object::ID,
        protocol_a: 0x2::object::ID,
        protocol_b: 0x2::object::ID,
        shared_namespace: 0x1::string::String,
        created_by: address,
        timestamp_ms: u64,
    }

    struct OutcomeRecorded has copy, drop {
        memory_id: u64,
        agent: address,
        old_outcome: 0x1::string::String,
        new_outcome: 0x1::string::String,
        timestamp_ms: u64,
    }

    fun check_conflict(arg0: &mut KageProtocol, arg1: u64, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &0x1::string::String, arg5: address, arg6: u64) : (bool, 0x1::option::Option<u64>) {
        let v0 = arg0.total_memories;
        if (v0 == 0) {
            return (false, 0x1::option::none<u64>())
        };
        let v1 = 0x1::string::utf8(b"BUY");
        let v2 = 0x1::string::utf8(b"SELL");
        let v3 = *arg3 == v1 || *arg3 == v2;
        if (!v3) {
            return (false, 0x1::option::none<u64>())
        };
        let v4 = if (*arg3 == v1) {
            v2
        } else {
            v1
        };
        let v5 = if (v0 > 20) {
            v0 - 20
        } else {
            0
        };
        let v6 = v5;
        while (v6 < v0) {
            if (0x2::table::contains<u64, MemoryEntry>(&arg0.memory_index, v6)) {
                let v7 = 0x2::table::borrow<u64, MemoryEntry>(&arg0.memory_index, v6);
                let v8 = if (v7.asset == *arg2) {
                    if (v7.namespace == *arg4) {
                        if (v7.action == v4) {
                            if (v7.agent != arg5) {
                                !v7.conflict_flag
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
                if (v8) {
                    arg0.total_conflicts = arg0.total_conflicts + 1;
                    let v9 = ConflictDetected{
                        memory_id_a  : v6,
                        memory_id_b  : arg1,
                        agent_a      : v7.agent,
                        agent_b      : arg5,
                        asset        : *arg2,
                        action_a     : v4,
                        action_b     : *arg3,
                        namespace    : *arg4,
                        timestamp_ms : arg6,
                    };
                    0x2::event::emit<ConflictDetected>(v9);
                    let v10 = 0x2::table::borrow_mut<u64, MemoryEntry>(&mut arg0.memory_index, v6);
                    v10.conflict_flag = true;
                    v10.conflict_with = 0x1::option::some<u64>(arg1);
                    return (true, 0x1::option::some<u64>(v6))
                };
            };
            v6 = v6 + 1;
        };
        (false, 0x1::option::none<u64>())
    }

    public entry fun create_bridge(arg0: &mut KageProtocol, arg1: &mut KageProtocol, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.admin == v0 || arg1.admin == v0, 1);
        let v1 = 0x1::string::utf8(arg2);
        let v2 = 0x2::object::new(arg3);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::object::uid_to_inner(&arg0.id);
        let v5 = 0x2::object::uid_to_inner(&arg1.id);
        let v6 = CrossGraphBridge{
            id               : v2,
            protocol_a       : v4,
            protocol_b       : v5,
            shared_namespace : v1,
            created_by       : v0,
            active           : true,
            total_shared     : 0,
        };
        0x2::vec_map::insert<0x2::object::ID, bool>(&mut arg0.active_bridges, v3, true);
        0x2::vec_map::insert<0x2::object::ID, bool>(&mut arg1.active_bridges, v3, true);
        let v7 = BridgeCreated{
            bridge_id        : v3,
            protocol_a       : v4,
            protocol_b       : v5,
            shared_namespace : v1,
            created_by       : v0,
            timestamp_ms     : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<BridgeCreated>(v7);
        0x2::transfer::share_object<CrossGraphBridge>(v6);
    }

    fun fire_triggers(arg0: &mut KageProtocol, arg1: u64, arg2: &0x1::string::String, arg3: &vector<0x1::string::String>, arg4: &0x1::string::String, arg5: &0x1::string::String, arg6: &0x1::string::String, arg7: u64) {
        let v0 = 0;
        while (v0 < arg0.total_subscriptions) {
            if (0x2::table::contains<u64, Subscription>(&arg0.subscriptions, v0)) {
                let v1 = 0x2::table::borrow<u64, Subscription>(&arg0.subscriptions, v0);
                if (!v1.active) {
                    v0 = v0 + 1;
                    continue
                };
                let v2 = is_empty_str(&v1.watch_asset) || v1.watch_asset == *arg4;
                let v3 = is_empty_str(&v1.watch_action) || v1.watch_action == *arg5;
                let v4 = is_empty_str(&v1.watch_namespace) || v1.watch_namespace == *arg6;
                let v5 = 0x1::vector::is_empty<0x1::string::String>(&v1.watch_tags) || tags_intersect(&v1.watch_tags, arg3);
                let v6 = if (v2) {
                    if (v3) {
                        if (v4) {
                            v5
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v6) {
                    let v7 = MemoryTriggered{
                        subscription_id : v1.id,
                        subscriber      : v1.subscriber,
                        memory_id       : arg1,
                        blob_id         : *arg2,
                        asset           : *arg4,
                        action          : *arg5,
                        namespace       : *arg6,
                        timestamp_ms    : arg7,
                    };
                    0x2::event::emit<MemoryTriggered>(v7);
                    let v8 = 0x2::table::borrow_mut<u64, Subscription>(&mut arg0.subscriptions, v0);
                    v8.trigger_count = v8.trigger_count + 1;
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun get_agent_reputation(arg0: &KageProtocol, arg1: address) : u64 {
        if (!0x2::table::contains<address, AgentRecord>(&arg0.agent_registry, arg1)) {
            return 0
        };
        0x2::table::borrow<address, AgentRecord>(&arg0.agent_registry, arg1).reputation
    }

    public fun get_agent_writes(arg0: &KageProtocol, arg1: address) : u64 {
        if (!0x2::table::contains<address, AgentRecord>(&arg0.agent_registry, arg1)) {
            return 0
        };
        0x2::table::borrow<address, AgentRecord>(&arg0.agent_registry, arg1).total_writes
    }

    fun get_latest_blob_in_namespace(arg0: &KageProtocol, arg1: &0x1::string::String) : 0x1::string::String {
        if (!0x2::vec_map::contains<0x1::string::String, vector<u64>>(&arg0.namespace_index, arg1)) {
            return 0x1::string::utf8(b"")
        };
        let v0 = 0x2::vec_map::get<0x1::string::String, vector<u64>>(&arg0.namespace_index, arg1);
        let v1 = 0x1::vector::length<u64>(v0);
        if (v1 == 0) {
            return 0x1::string::utf8(b"")
        };
        let v2 = *0x1::vector::borrow<u64>(v0, v1 - 1);
        if (!0x2::table::contains<u64, MemoryEntry>(&arg0.memory_index, v2)) {
            return 0x1::string::utf8(b"")
        };
        0x2::table::borrow<u64, MemoryEntry>(&arg0.memory_index, v2).blob_id
    }

    public fun get_memory_blob_id(arg0: &KageProtocol, arg1: u64) : 0x1::string::String {
        assert!(0x2::table::contains<u64, MemoryEntry>(&arg0.memory_index, arg1), 6);
        0x2::table::borrow<u64, MemoryEntry>(&arg0.memory_index, arg1).blob_id
    }

    public fun get_memory_conflict(arg0: &KageProtocol, arg1: u64) : bool {
        if (!0x2::table::contains<u64, MemoryEntry>(&arg0.memory_index, arg1)) {
            return false
        };
        0x2::table::borrow<u64, MemoryEntry>(&arg0.memory_index, arg1).conflict_flag
    }

    public fun get_memory_count(arg0: &KageProtocol) : u64 {
        arg0.total_memories
    }

    public fun get_namespace_memory_count(arg0: &KageProtocol, arg1: &0x1::string::String) : u64 {
        if (!0x2::vec_map::contains<0x1::string::String, vector<u64>>(&arg0.namespace_index, arg1)) {
            return 0
        };
        0x1::vector::length<u64>(0x2::vec_map::get<0x1::string::String, vector<u64>>(&arg0.namespace_index, arg1))
    }

    public fun get_snapshot(arg0: &KageProtocol, arg1: u64) : (u64, u64, u64, 0x1::string::String) {
        assert!(0x2::table::contains<u64, Snapshot>(&arg0.snapshots, arg1), 6);
        let v0 = 0x2::table::borrow<u64, Snapshot>(&arg0.snapshots, arg1);
        (v0.snapshot_id, v0.taken_at_sequence, v0.memory_count, v0.latest_blob_id)
    }

    public fun get_total_conflicts(arg0: &KageProtocol) : u64 {
        arg0.total_conflicts
    }

    public fun get_total_snapshots(arg0: &KageProtocol) : u64 {
        arg0.total_snapshots
    }

    fun index_push(arg0: &mut 0x2::vec_map::VecMap<0x1::string::String, vector<u64>>, arg1: &0x1::string::String, arg2: u64) {
        if (0x2::vec_map::contains<0x1::string::String, vector<u64>>(arg0, arg1)) {
            0x1::vector::push_back<u64>(0x2::vec_map::get_mut<0x1::string::String, vector<u64>>(arg0, arg1), arg2);
        } else {
            0x2::vec_map::insert<0x1::string::String, vector<u64>>(arg0, *arg1, 0x1::vector::singleton<u64>(arg2));
        };
    }

    public entry fun inherit_memory(arg0: &mut KageProtocol, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::table::contains<address, AgentRecord>(&arg0.agent_registry, v0), 2);
        assert!(0x2::table::contains<u64, MemoryEntry>(&arg0.memory_index, arg1), 6);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 3);
        assert!(arg7 >= 1 && arg7 <= 200, 4);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg8);
        let v2 = arg0.total_memories;
        let v3 = 0x2::table::borrow<u64, MemoryEntry>(&arg0.memory_index, arg1);
        let v4 = v3.agent;
        let v5 = v3.asset;
        let v6 = v3.namespace;
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<vector<u8>>(&arg4)) {
            0x1::vector::push_back<0x1::string::String>(&mut v7, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v8)));
            v8 = v8 + 1;
        };
        let v9 = 0x2::table::borrow_mut<address, AgentRecord>(&mut arg0.agent_registry, v0);
        v9.total_writes = v9.total_writes + 1;
        let v10 = 0x1::string::utf8(arg5);
        let v11 = 0x1::string::utf8(arg2);
        let v12 = MemoryEntry{
            id                : v2,
            agent             : v0,
            blob_id           : v11,
            blob_hash         : arg3,
            tags              : v7,
            asset             : v5,
            action            : v10,
            outcome           : 0x1::string::utf8(b"PENDING"),
            confidence        : arg6,
            ttl_epochs        : arg7,
            written_epoch     : 0x2::tx_context::epoch(arg8),
            written_ms        : v1,
            conflict_flag     : false,
            conflict_with     : 0x1::option::none<u64>(),
            weight            : v9.reputation,
            namespace         : v6,
            inherited_from    : 0x1::option::some<u64>(arg1),
            shared_from_graph : 0x1::option::none<0x2::object::ID>(),
        };
        let v13 = &mut arg0.namespace_index;
        index_push(v13, &v6, v2);
        let v14 = &mut arg0.asset_index;
        index_push(v14, &v5, v2);
        0x2::table::add<u64, MemoryEntry>(&mut arg0.memory_index, v2, v12);
        arg0.total_memories = arg0.total_memories + 1;
        let v15 = MemoryInherited{
            child_memory_id  : v2,
            parent_memory_id : arg1,
            child_agent      : v0,
            parent_agent     : v4,
            namespace        : v6,
            timestamp_ms     : v1,
        };
        0x2::event::emit<MemoryInherited>(v15);
        fire_triggers(arg0, v2, &v11, &v7, &v5, &v10, &v6, v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = KageProtocol{
            id                  : v1,
            memory_index        : 0x2::table::new<u64, MemoryEntry>(arg0),
            agent_registry      : 0x2::table::new<address, AgentRecord>(arg0),
            subscriptions       : 0x2::table::new<u64, Subscription>(arg0),
            snapshots           : 0x2::table::new<u64, Snapshot>(arg0),
            namespace_index     : 0x2::vec_map::empty<0x1::string::String, vector<u64>>(),
            asset_index         : 0x2::vec_map::empty<0x1::string::String, vector<u64>>(),
            tag_index           : 0x2::vec_map::empty<0x1::string::String, vector<u64>>(),
            active_bridges      : 0x2::vec_map::empty<0x2::object::ID, bool>(),
            total_memories      : 0,
            total_subscriptions : 0,
            total_snapshots     : 0,
            total_conflicts     : 0,
            admin               : v0,
        };
        let v3 = KageAdminCap{
            id          : 0x2::object::new(arg0),
            protocol_id : 0x2::object::uid_to_inner(&v1),
        };
        0x2::transfer::share_object<KageProtocol>(v2);
        0x2::transfer::transfer<KageAdminCap>(v3, v0);
    }

    fun is_empty_str(arg0: &0x1::string::String) : bool {
        0x1::string::length(arg0) == 0
    }

    public fun is_memory_expired(arg0: &KageProtocol, arg1: u64, arg2: &0x2::tx_context::TxContext) : bool {
        if (!0x2::table::contains<u64, MemoryEntry>(&arg0.memory_index, arg1)) {
            return true
        };
        let v0 = 0x2::table::borrow<u64, MemoryEntry>(&arg0.memory_index, arg1);
        0x2::tx_context::epoch(arg2) > v0.written_epoch + v0.ttl_epochs
    }

    public entry fun record_outcome(arg0: &mut KageProtocol, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<u64, MemoryEntry>(&arg0.memory_index, arg1), 6);
        let v1 = 0x2::table::borrow_mut<u64, MemoryEntry>(&mut arg0.memory_index, arg1);
        assert!(v1.agent == v0, 1);
        let v2 = 0x1::string::utf8(arg2);
        v1.outcome = v2;
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v4 = OutcomeRecorded{
            memory_id    : arg1,
            agent        : v0,
            old_outcome  : v1.outcome,
            new_outcome  : v2,
            timestamp_ms : v3,
        };
        0x2::event::emit<OutcomeRecorded>(v4);
        if (0x2::table::contains<address, AgentRecord>(&arg0.agent_registry, v0)) {
            let v5 = 0x2::table::borrow_mut<address, AgentRecord>(&mut arg0.agent_registry, v0);
            if (v2 == 0x1::string::utf8(b"SUCCESS")) {
                v5.successful_outcomes = v5.successful_outcomes + 1;
                if (v5.reputation < 200) {
                    v5.reputation = v5.reputation + 2;
                };
            } else if (v2 == 0x1::string::utf8(b"FAILURE")) {
                v5.failed_outcomes = v5.failed_outcomes + 1;
                if (v5.reputation > 5) {
                    v5.reputation = v5.reputation - 5;
                } else {
                    v5.reputation = 1;
                };
            };
            let v6 = ReputationUpdated{
                agent        : v0,
                old_rep      : v5.reputation,
                new_rep      : v5.reputation,
                reason       : v2,
                timestamp_ms : v3,
            };
            0x2::event::emit<ReputationUpdated>(v6);
        };
    }

    public entry fun register_agent(arg0: &mut KageProtocol, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, AgentRecord>(&arg0.agent_registry, v0)) {
            let v1 = 0x2::table::borrow_mut<address, AgentRecord>(&mut arg0.agent_registry, v0);
            v1.name = 0x1::string::utf8(arg1);
            v1.namespace = 0x1::string::utf8(arg2);
            v1.active = true;
        } else {
            let v2 = AgentRecord{
                agent               : v0,
                name                : 0x1::string::utf8(arg1),
                namespace           : 0x1::string::utf8(arg2),
                reputation          : 100,
                total_writes        : 0,
                successful_outcomes : 0,
                failed_outcomes     : 0,
                registered_at_ms    : 0x2::tx_context::epoch_timestamp_ms(arg3),
                active              : true,
            };
            0x2::table::add<address, AgentRecord>(&mut arg0.agent_registry, v0, v2);
        };
    }

    public entry fun share_memory_across(arg0: &mut CrossGraphBridge, arg1: &KageProtocol, arg2: &mut KageProtocol, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg4);
        assert!(arg0.active, 8);
        assert!(0x2::table::contains<u64, MemoryEntry>(&arg1.memory_index, arg3), 6);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(0x2::vec_map::contains<0x2::object::ID, bool>(&arg1.active_bridges, &v1), 7);
        let v2 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(0x2::vec_map::contains<0x2::object::ID, bool>(&arg2.active_bridges, &v2), 7);
        let v3 = 0x2::table::borrow<u64, MemoryEntry>(&arg1.memory_index, arg3);
        let v4 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v5 = arg2.total_memories;
        let v6 = MemoryEntry{
            id                : v5,
            agent             : v3.agent,
            blob_id           : v3.blob_id,
            blob_hash         : v3.blob_hash,
            tags              : v3.tags,
            asset             : v3.asset,
            action            : v3.action,
            outcome           : v3.outcome,
            confidence        : v3.confidence,
            ttl_epochs        : v3.ttl_epochs,
            written_epoch     : 0x2::tx_context::epoch(arg4),
            written_ms        : v4,
            conflict_flag     : false,
            conflict_with     : 0x1::option::none<u64>(),
            weight            : v3.weight,
            namespace         : arg0.shared_namespace,
            inherited_from    : 0x1::option::none<u64>(),
            shared_from_graph : 0x1::option::some<0x2::object::ID>(v0),
        };
        let v7 = &mut arg2.namespace_index;
        index_push(v7, &arg0.shared_namespace, v5);
        let v8 = &mut arg2.asset_index;
        index_push(v8, &v3.asset, v5);
        0x2::table::add<u64, MemoryEntry>(&mut arg2.memory_index, v5, v6);
        arg2.total_memories = arg2.total_memories + 1;
        arg0.total_shared = arg0.total_shared + 1;
        let v9 = CrossGraphMemoryShared{
            bridge_id        : 0x2::object::uid_to_inner(&arg0.id),
            memory_id        : v5,
            source_protocol  : v0,
            target_protocol  : 0x2::object::uid_to_inner(&arg2.id),
            shared_namespace : arg0.shared_namespace,
            blob_id          : v3.blob_id,
            timestamp_ms     : v4,
        };
        0x2::event::emit<CrossGraphMemoryShared>(v9);
    }

    public entry fun subscribe(arg0: &mut KageProtocol, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.total_subscriptions;
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, v2)));
            v2 = v2 + 1;
        };
        let v3 = Subscription{
            id              : v0,
            subscriber      : 0x2::tx_context::sender(arg5),
            watch_tags      : v1,
            watch_asset     : 0x1::string::utf8(arg2),
            watch_action    : 0x1::string::utf8(arg3),
            watch_namespace : 0x1::string::utf8(arg4),
            active          : true,
            trigger_count   : 0,
        };
        0x2::table::add<u64, Subscription>(&mut arg0.subscriptions, v0, v3);
        arg0.total_subscriptions = arg0.total_subscriptions + 1;
    }

    fun tags_intersect(arg0: &vector<0x1::string::String>, arg1: &vector<0x1::string::String>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(arg0, v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x1::string::String>(arg1)) {
                if (v1 == 0x1::vector::borrow<0x1::string::String>(arg1, v2)) {
                    return true
                };
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun take_snapshot(arg0: &mut KageProtocol, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, AgentRecord>(&arg0.agent_registry, v0), 2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v2 = arg0.total_snapshots;
        let v3 = 0x1::string::utf8(arg1);
        let v4 = if (0x2::vec_map::contains<0x1::string::String, vector<u64>>(&arg0.namespace_index, &v3)) {
            0x1::vector::length<u64>(0x2::vec_map::get<0x1::string::String, vector<u64>>(&arg0.namespace_index, &v3))
        } else {
            0
        };
        let v5 = get_latest_blob_in_namespace(arg0, &v3);
        let v6 = Snapshot{
            snapshot_id       : v2,
            taken_at_sequence : arg0.total_memories,
            taken_at_ms       : v1,
            taken_by          : v0,
            description       : 0x1::string::utf8(arg2),
            memory_count      : v4,
            namespace         : v3,
            latest_blob_id    : v5,
        };
        0x2::table::add<u64, Snapshot>(&mut arg0.snapshots, v2, v6);
        arg0.total_snapshots = arg0.total_snapshots + 1;
        let v7 = SnapshotTaken{
            snapshot_id       : v2,
            taken_at_sequence : arg0.total_memories,
            namespace         : v3,
            memory_count      : v4,
            latest_blob_id    : v5,
            taken_by          : v0,
            timestamp_ms      : v1,
        };
        0x2::event::emit<SnapshotTaken>(v7);
    }

    public entry fun unsubscribe(arg0: &mut KageProtocol, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Subscription>(&arg0.subscriptions, arg1), 10);
        let v0 = 0x2::table::borrow_mut<u64, Subscription>(&mut arg0.subscriptions, arg1);
        assert!(v0.subscriber == 0x2::tx_context::sender(arg2), 1);
        v0.active = false;
    }

    public entry fun write_memory(arg0: &mut KageProtocol, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::table::contains<address, AgentRecord>(&arg0.agent_registry, v0), 2);
        assert!(!0x1::vector::is_empty<u8>(&arg1), 3);
        assert!(0x1::vector::length<u8>(&arg1) <= 128, 3);
        assert!(arg7 >= 1 && arg7 <= 200, 4);
        assert!(0x1::vector::length<vector<u8>>(&arg3) <= 8, 5);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg9);
        let v2 = arg0.total_memories;
        let v3 = 0x2::table::borrow_mut<address, AgentRecord>(&mut arg0.agent_registry, v0);
        let v4 = v3.reputation;
        v3.total_writes = v3.total_writes + 1;
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<vector<u8>>(&arg3)) {
            0x1::vector::push_back<0x1::string::String>(&mut v5, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v6)));
            v6 = v6 + 1;
        };
        let v7 = 0x1::string::utf8(arg4);
        let v8 = 0x1::string::utf8(arg5);
        let v9 = 0x1::string::utf8(arg8);
        let v10 = 0x1::string::utf8(arg1);
        let (v11, v12) = check_conflict(arg0, v2, &v7, &v8, &v9, v0, v1);
        let v13 = MemoryEntry{
            id                : v2,
            agent             : v0,
            blob_id           : v10,
            blob_hash         : arg2,
            tags              : v5,
            asset             : v7,
            action            : v8,
            outcome           : 0x1::string::utf8(b"PENDING"),
            confidence        : arg6,
            ttl_epochs        : arg7,
            written_epoch     : 0x2::tx_context::epoch(arg9),
            written_ms        : v1,
            conflict_flag     : v11,
            conflict_with     : v12,
            weight            : v4,
            namespace         : v9,
            inherited_from    : 0x1::option::none<u64>(),
            shared_from_graph : 0x1::option::none<0x2::object::ID>(),
        };
        let v14 = &mut arg0.namespace_index;
        index_push(v14, &v9, v2);
        let v15 = &mut arg0.asset_index;
        index_push(v15, &v7, v2);
        let v16 = 0;
        while (v16 < 0x1::vector::length<0x1::string::String>(&v13.tags)) {
            let v17 = &mut arg0.tag_index;
            index_push(v17, 0x1::vector::borrow<0x1::string::String>(&v13.tags, v16), v2);
            v16 = v16 + 1;
        };
        0x2::table::add<u64, MemoryEntry>(&mut arg0.memory_index, v2, v13);
        arg0.total_memories = arg0.total_memories + 1;
        let v18 = MemoryWritten{
            memory_id    : v2,
            agent        : v0,
            blob_id      : v10,
            tags         : v5,
            asset        : v7,
            action       : v8,
            confidence   : arg6,
            namespace    : v9,
            weight       : v4,
            timestamp_ms : v1,
        };
        0x2::event::emit<MemoryWritten>(v18);
        fire_triggers(arg0, v2, &v10, &v5, &v7, &v8, &v9, v1);
    }

    // decompiled from Move bytecode v6
}

