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

    struct GuardrailsRefinementAnchorKey has copy, drop, store {
        strategy_id: vector<u8>,
    }

    struct GuardrailsRefinementAnchor has copy, drop, store {
        v1_guardrails_id: 0x2::object::ID,
        v1_guardrails_hash: vector<u8>,
        v2_guardrails_id: 0x2::object::ID,
        v2_guardrails_hash: vector<u8>,
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

    struct Top30GuardrailsRefinementAnchored has copy, drop {
        registry_id: 0x2::object::ID,
        strategy_id: vector<u8>,
        v1_guardrails_id: 0x2::object::ID,
        v1_guardrails_hash: vector<u8>,
        v2_guardrails_id: 0x2::object::ID,
        v2_guardrails_hash: vector<u8>,
    }

    struct GuardrailsRefinementAnchored has copy, drop {
        registry_id: 0x2::object::ID,
        strategy_id: vector<u8>,
        v1_guardrails_id: 0x2::object::ID,
        v1_guardrails_hash: vector<u8>,
        v2_guardrails_id: 0x2::object::ID,
        v2_guardrails_hash: vector<u8>,
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

    fun anchor_and_emit_refinement(arg0: &mut StrategyRegistry, arg1: &AdminCap, arg2: vector<u8>, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::Guardrails, arg4: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::id(arg3);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::guardrails_hash(arg3);
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg4);
        let v3 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg4);
        anchor_guardrails_refinement(arg0, arg1, arg2, v0, v1, v2, v3, arg5);
        let v4 = GuardrailsRefinementAnchored{
            registry_id        : 0x2::object::id<StrategyRegistry>(arg0),
            strategy_id        : arg2,
            v1_guardrails_id   : v0,
            v1_guardrails_hash : v1,
            v2_guardrails_id   : v2,
            v2_guardrails_hash : v3,
        };
        0x2::event::emit<GuardrailsRefinementAnchored>(v4);
    }

    public(friend) fun anchor_guardrails_refinement(arg0: &mut StrategyRegistry, arg1: &AdminCap, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg7);
        let v0 = GuardrailsRefinementAnchorKey{strategy_id: arg2};
        assert!(!0x2::dynamic_field::exists<GuardrailsRefinementAnchorKey>(&arg0.id, v0), 17);
        let v1 = GuardrailsRefinementAnchor{
            v1_guardrails_id   : arg3,
            v1_guardrails_hash : arg4,
            v2_guardrails_id   : arg5,
            v2_guardrails_hash : arg6,
        };
        0x2::dynamic_field::add<GuardrailsRefinementAnchorKey, GuardrailsRefinementAnchor>(&mut arg0.id, v0, v1);
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

    public fun anchor_safe_plus_roi_refinement<T0>(arg0: &mut StrategyRegistry, arg1: &AdminCap, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::Guardrails, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: &0x2::tx_context::TxContext) {
        assert_exact_refinement_shape<T0>(arg2, arg3, @0x75f3c8537f486afbd500c874e5c897cf84341a34dcd11916869d94658fea426a, x"4349c76a59a6ba8dd8a13054f6b0670508c3b90f187351be5e9dfe87e93d93fd", b"USDC", b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC", b"dayop487e57366b", true, true);
        anchor_and_emit_refinement(arg0, arg1, b"day-autopilot-safe-plus-roi", arg2, arg3, arg4);
    }

    public fun anchor_top30_refinement<T0>(arg0: &mut StrategyRegistry, arg1: &AdminCap, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::Guardrails, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: &0x2::tx_context::TxContext) {
        assert_usdc<T0>();
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::Guardrails>(arg2) == @0x789341ea271ad1171fe0d8b6df181c9d6cdbc21b518475246005ffa17db29cb8, 19);
        assert_top30_refinement_shape<T0>(arg2, arg3, true);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::id(arg2);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::guardrails_hash(arg2);
        let v2 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg3);
        let v3 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg3);
        anchor_guardrails_refinement(arg0, arg1, b"day-autopilot-top-30d-monthly", v0, v1, v2, v3, arg4);
        let v4 = Top30GuardrailsRefinementAnchored{
            registry_id        : 0x2::object::id<StrategyRegistry>(arg0),
            strategy_id        : b"day-autopilot-top-30d-monthly",
            v1_guardrails_id   : v0,
            v1_guardrails_hash : v1,
            v2_guardrails_id   : v2,
            v2_guardrails_hash : v3,
        };
        0x2::event::emit<Top30GuardrailsRefinementAnchored>(v4);
    }

    public fun anchor_top_roi_refinement<T0>(arg0: &mut StrategyRegistry, arg1: &AdminCap, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::Guardrails, arg3: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg4: &0x2::tx_context::TxContext) {
        assert_exact_refinement_shape<T0>(arg2, arg3, @0x57964e0ec2609ef2d72cfea07f61afe1b3feb96c9dbc77951c2f8014fc0fe15b, x"2d8d0d135e36755bcb00f3c01411dafe46735903333a9d0a4326ce3ef7b0f94c", b"USDY", b"960b531667636f39e85867775f52f6b1f220a058c4de786905bdf761e06a56bb::usdy::USDY", b"dayopbc1052eaa6", true, true);
        anchor_and_emit_refinement(arg0, arg1, b"day-autopilot-top-roi-10m-monthly", arg2, arg3, arg4);
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

    public fun assert_canonical_guardrails_refinement(arg0: &StrategyRegistry, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: vector<u8>) {
        let v0 = GuardrailsRefinementAnchorKey{strategy_id: arg1};
        assert!(0x2::dynamic_field::exists<GuardrailsRefinementAnchorKey>(&arg0.id, v0), 18);
        let v1 = 0x2::dynamic_field::borrow<GuardrailsRefinementAnchorKey, GuardrailsRefinementAnchor>(&arg0.id, v0);
        assert!(v1.v1_guardrails_id == arg2, 18);
        assert!(v1.v1_guardrails_hash == arg3, 18);
        assert!(v1.v2_guardrails_id == arg4, 18);
        assert!(v1.v2_guardrails_hash == arg5, 18);
    }

    public(friend) fun assert_canonical_leader_policy_and_latch(arg0: &StrategyRegistry, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = LeaderPolicyAnchorKey{strategy_id: arg1};
        assert!(0x2::dynamic_field::exists<LeaderPolicyAnchorKey>(&arg0.id, v0), 16);
        let v1 = 0x2::dynamic_field::borrow<LeaderPolicyAnchorKey, LeaderPolicyAnchor>(&arg0.id, v0);
        assert!(v1.policy_id == arg2, 16);
        assert!(v1.latch_id == arg3, 16);
    }

    fun assert_exact_refinement_shape<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::Guardrails, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: bool, arg8: bool) {
        if (arg7) {
            assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::Guardrails>(arg0) == arg2, 19);
            assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::guardrails_hash(arg0) == arg3, 19);
        };
        if (arg8) {
            assert_original_type<T0>(arg5);
        };
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::verify_hash(arg0), 19);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::verify_hash(arg1), 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::strategy_lead(arg0) == @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::strategy_lead(arg1) == @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::asset_allowed(arg0, arg4), 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::allocation_allowed(arg0, arg6, 10000), 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::asset_type_count(arg1) == 1, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::opportunity_count(arg1) == 1, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::chain_count(arg1) == 1, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::max_allocation_bps(arg1) == 10000, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::allocation_allowed<T0>(arg1, arg6, b"sui", 10000), 20);
    }

    fun assert_original_type<T0>(arg0: vector<u8>) {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == arg0, 21);
    }

    fun assert_required_guardrails_refinement(arg0: &StrategyRegistry, arg1: &vector<u8>, arg2: 0x2::object::ID, arg3: &vector<u8>) {
        let v0 = b"day-autopilot-top-30d-monthly";
        let v1 = if (arg1 != &v0) {
            let v2 = b"day-autopilot-top-roi-10m-monthly";
            if (arg1 != &v2) {
                let v3 = b"day-autopilot-safe-plus-roi";
                arg1 != &v3
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            return
        };
        let v4 = GuardrailsRefinementAnchorKey{strategy_id: *arg1};
        assert!(0x2::dynamic_field::exists<GuardrailsRefinementAnchorKey>(&arg0.id, v4), 18);
        let v5 = 0x2::dynamic_field::borrow<GuardrailsRefinementAnchorKey, GuardrailsRefinementAnchor>(&arg0.id, v4);
        let v6 = b"day-autopilot-top-30d-monthly";
        let (v7, v8) = if (arg1 == &v6) {
            (0x2::object::id_from_address(@0x789341ea271ad1171fe0d8b6df181c9d6cdbc21b518475246005ffa17db29cb8), x"76961077934bb9149397e1cd1aa6d9744a213fa2fec92b9ab98bdbb8099f9827")
        } else {
            let v9 = b"day-autopilot-top-roi-10m-monthly";
            if (arg1 == &v9) {
                (0x2::object::id_from_address(@0x57964e0ec2609ef2d72cfea07f61afe1b3feb96c9dbc77951c2f8014fc0fe15b), x"2d8d0d135e36755bcb00f3c01411dafe46735903333a9d0a4326ce3ef7b0f94c")
            } else {
                (0x2::object::id_from_address(@0x75f3c8537f486afbd500c874e5c897cf84341a34dcd11916869d94658fea426a), x"4349c76a59a6ba8dd8a13054f6b0670508c3b90f187351be5e9dfe87e93d93fd")
            }
        };
        assert!(v5.v1_guardrails_id == v7, 18);
        assert!(v5.v1_guardrails_hash == v8, 18);
        assert!(v5.v2_guardrails_id == arg2, 18);
        assert!(&v5.v2_guardrails_hash == arg3, 18);
    }

    fun assert_top30_refinement_shape<T0>(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::Guardrails, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: bool) {
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::verify_hash(arg0), 19);
        if (arg2) {
            assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::guardrails_hash(arg0) == x"76961077934bb9149397e1cd1aa6d9744a213fa2fec92b9ab98bdbb8099f9827", 19);
        };
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::verify_hash(arg1), 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::strategy_lead(arg0) == @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::strategy_lead(arg1) == @0xc7166e26852d600068350ca65b6252880a3e17b540e2080e683f796303e1d491, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::asset_allowed(arg0, b"USDC"), 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails::allocation_allowed(arg0, b"dayope3465f1716", 10000), 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::asset_type_count(arg1) == 1, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::opportunity_count(arg1) == 1, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::chain_count(arg1) == 1, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::max_allocation_bps(arg1) == 10000, 20);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::allocation_allowed<T0>(arg1, b"dayope3465f1716", b"sui", 10000), 20);
    }

    fun assert_usdc<T0>() {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC", 21);
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

    public fun guardrails_refinement_anchored(arg0: &StrategyRegistry, arg1: vector<u8>) : bool {
        let v0 = GuardrailsRefinementAnchorKey{strategy_id: arg1};
        0x2::dynamic_field::exists<GuardrailsRefinementAnchorKey>(&arg0.id, v0)
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
        assert_required_guardrails_refinement(arg0, &arg2, v0, &v1);
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

