module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_factory {
    struct StrategyFactory has key {
        id: 0x2::object::UID,
        strategies: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        execution_family_leaves: 0x2::table::Table<vector<u8>, ExecutionFamilyLeaf>,
        count: u64,
    }

    struct ExecutionFamilyLeaf has copy, drop, store {
        opportunity_id: vector<u8>,
        adapter_id: vector<u8>,
        chain_id: vector<u8>,
        execution_family_id: vector<u8>,
    }

    struct Strategy has key {
        id: 0x2::object::UID,
        strategy_id: vector<u8>,
        lead: address,
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        opportunity_id: vector<u8>,
        adapter_id: vector<u8>,
        chain_id: vector<u8>,
        execution_family_id: vector<u8>,
        allocation_bps: u64,
    }

    struct StrategyCreated has copy, drop {
        factory_id: 0x2::object::ID,
        strategy_id: vector<u8>,
        strategy_object_id: 0x2::object::ID,
        lead: address,
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        opportunity_id: vector<u8>,
        adapter_id: vector<u8>,
        chain_id: vector<u8>,
        execution_family_id: vector<u8>,
        allocation_bps: u64,
    }

    public fun id(arg0: &StrategyFactory) : 0x2::object::ID {
        0x2::object::id<StrategyFactory>(arg0)
    }

    public fun contains(arg0: &StrategyFactory, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.strategies, arg1)
    }

    fun assert_execution_family_leaf(arg0: &ExecutionFamilyLeaf, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>) {
        assert_valid_leaf(arg0);
        assert!(arg0.opportunity_id == *arg1, 8);
        assert!(arg0.adapter_id == *arg2, 8);
        assert!(arg0.chain_id == *arg3, 8);
    }

    fun assert_valid_leaf(arg0: &ExecutionFamilyLeaf) {
        assert!(!0x1::vector::is_empty<u8>(&arg0.opportunity_id), 8);
        assert!(!0x1::vector::is_empty<u8>(&arg0.adapter_id), 8);
        assert!(!0x1::vector::is_empty<u8>(&arg0.chain_id), 8);
        assert!(!0x1::vector::is_empty<u8>(&arg0.execution_family_id), 8);
    }

    public entry fun bootstrap(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x2::package::UpgradeCap, arg2: vector<ExecutionFamilyLeaf>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id_address<0x2::package::UpgradeCap>(arg1) == @0xfb7a7925da9332ab039cd7296828f5ebaef5ff7246f1bfa051d0a409fa15eb2d, 1);
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig>(arg0) == @0xdcd2e53c6ebc03cea47bcfc656337f03bf64cf1069bb92419bb67f4969603bba, 2);
        bootstrap_internal(arg0, arg2, arg3);
    }

    fun bootstrap_internal(arg0: &mut 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: vector<ExecutionFamilyLeaf>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::strategy_factory_bootstrapped(arg0), 3);
        let v0 = StrategyFactory{
            id                      : 0x2::object::new(arg2),
            strategies              : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg2),
            execution_family_leaves : 0x2::table::new<vector<u8>, ExecutionFamilyLeaf>(arg2),
            count                   : 0,
        };
        while (!0x1::vector::is_empty<ExecutionFamilyLeaf>(&arg1)) {
            let v1 = 0x1::vector::pop_back<ExecutionFamilyLeaf>(&mut arg1);
            assert_valid_leaf(&v1);
            assert!(!0x2::table::contains<vector<u8>, ExecutionFamilyLeaf>(&v0.execution_family_leaves, v1.opportunity_id), 9);
            0x2::table::add<vector<u8>, ExecutionFamilyLeaf>(&mut v0.execution_family_leaves, v1.opportunity_id, v1);
        };
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::anchor_strategy_factory(arg0, 0x2::object::id<StrategyFactory>(&v0));
        0x2::transfer::share_object<StrategyFactory>(v0);
    }

    public fun count(arg0: &StrategyFactory) : u64 {
        arg0.count
    }

    public fun create_strategy<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &mut StrategyFactory, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::assert_canonical_strategy_factory_binding(arg0, 0x2::object::id<StrategyFactory>(arg1));
        assert!(!0x1::vector::is_empty<u8>(&arg4), 4);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg1.strategies, arg4), 5);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::verify_hash(arg2), 6);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::strategy_lead(arg2) == 0x2::tx_context::sender(arg9), 7);
        let v0 = 0x2::table::borrow<vector<u8>, ExecutionFamilyLeaf>(&arg1.execution_family_leaves, arg5);
        assert_execution_family_leaf(v0, &arg5, &arg6, &arg7);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::assert_allocation_allowed<T0>(arg2, arg5, arg7, arg8);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2_on_chain(arg3, arg6, arg7);
        let v1 = Strategy{
            id                  : 0x2::object::new(arg9),
            strategy_id         : arg4,
            lead                : 0x2::tx_context::sender(arg9),
            guardrails_id       : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg2),
            guardrails_hash     : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg2),
            opportunity_id      : arg5,
            adapter_id          : arg6,
            chain_id            : arg7,
            execution_family_id : v0.execution_family_id,
            allocation_bps      : arg8,
        };
        let v2 = 0x2::object::id<Strategy>(&v1);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg1.strategies, v1.strategy_id, v2);
        arg1.count = arg1.count + 1;
        let v3 = StrategyCreated{
            factory_id          : 0x2::object::id<StrategyFactory>(arg1),
            strategy_id         : v1.strategy_id,
            strategy_object_id  : v2,
            lead                : v1.lead,
            guardrails_id       : v1.guardrails_id,
            guardrails_hash     : v1.guardrails_hash,
            opportunity_id      : v1.opportunity_id,
            adapter_id          : v1.adapter_id,
            chain_id            : v1.chain_id,
            execution_family_id : v1.execution_family_id,
            allocation_bps      : v1.allocation_bps,
        };
        0x2::event::emit<StrategyCreated>(v3);
        0x2::transfer::share_object<Strategy>(v1);
    }

    public fun strategy_object_id(arg0: &StrategyFactory, arg1: vector<u8>) : 0x2::object::ID {
        *0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.strategies, arg1)
    }

    // decompiled from Move bytecode v7
}

