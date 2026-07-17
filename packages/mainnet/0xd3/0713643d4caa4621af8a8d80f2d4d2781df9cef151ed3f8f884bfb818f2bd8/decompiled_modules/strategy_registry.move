module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry {
    struct StrategyRegistry has key {
        id: 0x2::object::UID,
        strategies: 0x2::table::Table<vector<u8>, StrategyRecord>,
        count: u64,
        admin_cap_id: 0x2::object::ID,
        governance: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct StrategyRecord has copy, drop, store {
        strategy_id: vector<u8>,
        leader: address,
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        status: u8,
        created_at: u64,
    }

    struct LeaderPolicyAnchorKey has copy, drop, store {
        strategy_id: vector<u8>,
    }

    struct LeaderPolicyAnchor has copy, drop, store {
        policy_id: 0x2::object::ID,
        latch_id: 0x2::object::ID,
    }

    struct RegistryBootstrapped has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        governance: address,
    }

    struct StrategyRegistered has copy, drop {
        strategy_id: vector<u8>,
        leader: address,
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        created_at: u64,
    }

    struct StrategyLifecycleChanged has copy, drop {
        strategy_id: vector<u8>,
        previous_status: u8,
        new_status: u8,
    }

    public fun id(arg0: &StrategyRegistry) : 0x2::object::ID {
        0x2::object::id<StrategyRegistry>(arg0)
    }

    public fun contains(arg0: &StrategyRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, StrategyRecord>(&arg0.strategies, arg1)
    }

    public fun guardrails_hash(arg0: &StrategyRecord) : vector<u8> {
        arg0.guardrails_hash
    }

    public fun accepts_new_deposit(arg0: &StrategyRegistry, arg1: vector<u8>) : bool {
        contains(arg0, arg1) && status(arg0, arg1) == 0
    }

    public fun accepts_reallocation(arg0: &StrategyRegistry, arg1: vector<u8>) : bool {
        contains(arg0, arg1) && status(arg0, arg1) == 0
    }

    public fun active_status() : u8 {
        0
    }

    public fun admin_cap_id(arg0: &StrategyRegistry) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public(friend) fun anchor_leader_policy(arg0: &mut StrategyRegistry, arg1: &AdminCap, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg5);
        assert!(0x2::table::contains<vector<u8>, StrategyRecord>(&arg0.strategies, arg2), 4);
        let v0 = LeaderPolicyAnchorKey{strategy_id: arg2};
        assert!(!0x2::dynamic_field::exists<LeaderPolicyAnchorKey>(&arg0.id, v0), 15);
        let v1 = LeaderPolicyAnchorKey{strategy_id: arg2};
        let v2 = LeaderPolicyAnchor{
            policy_id : arg3,
            latch_id  : arg4,
        };
        0x2::dynamic_field::add<LeaderPolicyAnchorKey, LeaderPolicyAnchor>(&mut arg0.id, v1, v2);
    }

    public fun assert_accepts_new_deposit(arg0: &StrategyRegistry, arg1: vector<u8>) {
        assert!(status(arg0, arg1) == 0, 9);
    }

    public fun assert_accepts_reallocation(arg0: &StrategyRegistry, arg1: vector<u8>) {
        assert!(status(arg0, arg1) == 0, 9);
    }

    fun assert_admin(arg0: &StrategyRegistry, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.governance, 13);
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 2);
    }

    fun assert_canonical_bootstrap_targets(arg0: address, arg1: address) {
        assert!(arg0 == @0xfb7a7925da9332ab039cd7296828f5ebaef5ff7246f1bfa051d0a409fa15eb2d, 1);
        assert!(arg1 == @0xdcd2e53c6ebc03cea47bcfc656337f03bf64cf1069bb92419bb67f4969603bba, 14);
    }

    public(friend) fun assert_canonical_leader_policy_and_latch(arg0: &StrategyRegistry, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = LeaderPolicyAnchorKey{strategy_id: arg1};
        assert!(0x2::dynamic_field::exists<LeaderPolicyAnchorKey>(&arg0.id, v0), 16);
        let v1 = 0x2::dynamic_field::borrow<LeaderPolicyAnchorKey, LeaderPolicyAnchor>(&arg0.id, v0);
        assert!(v1.policy_id == arg2, 16);
        assert!(v1.latch_id == arg3, 16);
    }

    public entry fun bootstrap(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x2::package::UpgradeCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_canonical_bootstrap_targets(0x2::object::id_address<0x2::package::UpgradeCap>(arg1), 0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig>(arg0));
        bootstrap_internal(arg0, arg2, arg3);
    }

    fun bootstrap_internal(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0 && arg1 != @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 12);
        assert!(!0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::strategy_registry_bootstrapped(arg0), 10);
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::id<AdminCap>(&v0);
        let v2 = StrategyRegistry{
            id           : 0x2::object::new(arg2),
            strategies   : 0x2::table::new<vector<u8>, StrategyRecord>(arg2),
            count        : 0,
            admin_cap_id : v1,
            governance   : arg1,
        };
        let v3 = 0x2::object::id<StrategyRegistry>(&v2);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::anchor_strategy_registry(arg0, v3, v1, arg1);
        let v4 = RegistryBootstrapped{
            registry_id  : v3,
            admin_cap_id : v1,
            governance   : arg1,
        };
        0x2::event::emit<RegistryBootstrapped>(v4);
        0x2::transfer::transfer<AdminCap>(v0, arg1);
        0x2::transfer::share_object<StrategyRegistry>(v2);
    }

    fun borrow_record_mut(arg0: &mut StrategyRegistry, arg1: vector<u8>) : &mut StrategyRecord {
        assert!(0x2::table::contains<vector<u8>, StrategyRecord>(&arg0.strategies, arg1), 4);
        0x2::table::borrow_mut<vector<u8>, StrategyRecord>(&mut arg0.strategies, arg1)
    }

    public fun canonical_exit_mode_latch_id(arg0: &StrategyRegistry, arg1: vector<u8>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = LeaderPolicyAnchorKey{strategy_id: arg1};
        if (!0x2::dynamic_field::exists<LeaderPolicyAnchorKey>(&arg0.id, v0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<LeaderPolicyAnchorKey, LeaderPolicyAnchor>(&arg0.id, v0).latch_id)
    }

    public fun canonical_leader_policy_id(arg0: &StrategyRegistry, arg1: vector<u8>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = LeaderPolicyAnchorKey{strategy_id: arg1};
        if (!0x2::dynamic_field::exists<LeaderPolicyAnchorKey>(&arg0.id, v0)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<LeaderPolicyAnchorKey, LeaderPolicyAnchor>(&arg0.id, v0).policy_id)
    }

    public fun count(arg0: &StrategyRegistry) : u64 {
        arg0.count
    }

    public fun created_at(arg0: &StrategyRecord) : u64 {
        arg0.created_at
    }

    public fun governance(arg0: &StrategyRegistry) : address {
        arg0.governance
    }

    public fun guardrails_id(arg0: &StrategyRecord) : 0x2::object::ID {
        arg0.guardrails_id
    }

    public fun leader(arg0: &StrategyRecord) : address {
        arg0.leader
    }

    public fun leader_policy_anchored(arg0: &StrategyRegistry, arg1: vector<u8>) : bool {
        let v0 = LeaderPolicyAnchorKey{strategy_id: arg1};
        0x2::dynamic_field::exists<LeaderPolicyAnchorKey>(&arg0.id, v0)
    }

    public fun pause_strategy(arg0: &mut StrategyRegistry, arg1: &AdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg3);
        let v0 = borrow_record_mut(arg0, arg2);
        assert!(v0.status == 0, 5);
        v0.status = 1;
        let v1 = StrategyLifecycleChanged{
            strategy_id     : arg2,
            previous_status : 0,
            new_status      : 1,
        };
        0x2::event::emit<StrategyLifecycleChanged>(v1);
    }

    public fun paused_status() : u8 {
        1
    }

    public fun record(arg0: &StrategyRegistry, arg1: vector<u8>) : &StrategyRecord {
        assert!(0x2::table::contains<vector<u8>, StrategyRecord>(&arg0.strategies, arg1), 4);
        0x2::table::borrow<vector<u8>, StrategyRecord>(&arg0.strategies, arg1)
    }

    public fun record_status(arg0: &StrategyRecord) : u8 {
        arg0.status
    }

    public fun register_strategy(arg0: &mut StrategyRegistry, arg1: &AdminCap, arg2: vector<u8>, arg3: address, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg6);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 6);
        assert!(arg3 != @0x0, 7);
        assert!(!0x2::table::contains<vector<u8>, StrategyRecord>(&arg0.strategies, arg2), 3);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::verify_hash(arg4), 8);
        assert!(arg3 == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::strategy_lead(arg4), 11);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg4);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = StrategyRecord{
            strategy_id     : arg2,
            leader          : arg3,
            guardrails_id   : v0,
            guardrails_hash : v1,
            status          : 0,
            created_at      : v2,
        };
        0x2::table::add<vector<u8>, StrategyRecord>(&mut arg0.strategies, arg2, v3);
        arg0.count = arg0.count + 1;
        let v4 = StrategyRegistered{
            strategy_id     : arg2,
            leader          : arg3,
            guardrails_id   : v0,
            guardrails_hash : v1,
            created_at      : v2,
        };
        0x2::event::emit<StrategyRegistered>(v4);
    }

    public fun resume_strategy(arg0: &mut StrategyRegistry, arg1: &AdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg3);
        let v0 = borrow_record_mut(arg0, arg2);
        assert!(v0.status == 1, 5);
        v0.status = 0;
        let v1 = StrategyLifecycleChanged{
            strategy_id     : arg2,
            previous_status : 1,
            new_status      : 0,
        };
        0x2::event::emit<StrategyLifecycleChanged>(v1);
    }

    public fun retire_strategy(arg0: &mut StrategyRegistry, arg1: &AdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg3);
        let v0 = borrow_record_mut(arg0, arg2);
        let v1 = v0.status;
        assert!(v1 != 2, 5);
        v0.status = 2;
        let v2 = StrategyLifecycleChanged{
            strategy_id     : arg2,
            previous_status : v1,
            new_status      : 2,
        };
        0x2::event::emit<StrategyLifecycleChanged>(v2);
    }

    public fun retired_status() : u8 {
        2
    }

    public fun status(arg0: &StrategyRegistry, arg1: vector<u8>) : u8 {
        record(arg0, arg1).status
    }

    public fun strategy_id(arg0: &StrategyRecord) : vector<u8> {
        arg0.strategy_id
    }

    // decompiled from Move bytecode v7
}

