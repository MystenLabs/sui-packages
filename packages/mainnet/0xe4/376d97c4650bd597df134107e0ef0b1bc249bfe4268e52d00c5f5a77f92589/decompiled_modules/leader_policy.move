module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::leader_policy {
    struct LeaderPolicy has store, key {
        id: 0x2::object::UID,
        version: u8,
        registry_id: 0x2::object::ID,
        strategy_id: vector<u8>,
        leader_may_force_exit: bool,
    }

    struct ExitModeLatch has key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        entered: bool,
        entered_at_ms: u64,
    }

    struct EnteredExitModeAuthorization {
        registry_id: 0x2::object::ID,
        strategy_id: vector<u8>,
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        policy_id: 0x2::object::ID,
        latch_id: 0x2::object::ID,
        entered_at_ms: u64,
    }

    struct ReallocationPolicyWitness {
        policy_id: 0x2::object::ID,
        latch_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        strategy_id: vector<u8>,
        guardrails_id: 0x2::object::ID,
        guardrails_hash: vector<u8>,
        verified_leader: address,
        source_accounting_id: 0x2::object::ID,
        source_opportunity_id: vector<u8>,
        destination_accounting_id: 0x2::object::ID,
        destination_opportunity_id: vector<u8>,
        allocation_bps: u64,
    }

    public(friend) fun assert_policy_binding(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: &LeaderPolicy) {
        assert!(arg2.version == 1, 1);
        assert!(arg2.registry_id == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::id(arg0), 2);
        let v0 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::record(arg0, arg2.strategy_id);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::strategy_id(v0) == arg2.strategy_id, 3);
        let v1 = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::guardrails_hash(v0);
        assert!(0x1::vector::length<u8>(&v1) == 32, 4);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::guardrails_id(v0) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg1), 4);
        assert!(v1 == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg1), 4);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::verify_hash(arg1), 4);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::leader(v0) == 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::strategy_lead(arg1), 5);
    }

    public(friend) fun authorize_entered_exit_mode(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: &LeaderPolicy, arg3: &ExitModeLatch) : EnteredExitModeAuthorization {
        assert_policy_binding(arg0, arg1, arg2);
        assert!(arg2.leader_may_force_exit, 6);
        assert!(arg3.policy_id == 0x2::object::id<LeaderPolicy>(arg2), 3);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::assert_canonical_leader_policy_and_latch(arg0, arg2.strategy_id, 0x2::object::id<LeaderPolicy>(arg2), 0x2::object::id<ExitModeLatch>(arg3));
        assert!(arg3.entered, 8);
        EnteredExitModeAuthorization{
            registry_id     : arg2.registry_id,
            strategy_id     : arg2.strategy_id,
            guardrails_id   : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg1),
            guardrails_hash : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg1),
            policy_id       : 0x2::object::id<LeaderPolicy>(arg2),
            latch_id        : 0x2::object::id<ExitModeLatch>(arg3),
            entered_at_ms   : arg3.entered_at_ms,
        }
    }

    public(friend) fun consume_entered_exit_mode_authorization(arg0: EnteredExitModeAuthorization) : (0x2::object::ID, vector<u8>, 0x2::object::ID, vector<u8>, 0x2::object::ID, 0x2::object::ID, u64) {
        let EnteredExitModeAuthorization {
            registry_id     : v0,
            strategy_id     : v1,
            guardrails_id   : v2,
            guardrails_hash : v3,
            policy_id       : v4,
            latch_id        : v5,
            entered_at_ms   : v6,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public(friend) fun consume_reallocation_witness(arg0: ReallocationPolicyWitness) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, vector<u8>, 0x2::object::ID, vector<u8>, address, 0x2::object::ID, vector<u8>, 0x2::object::ID, vector<u8>, u64) {
        let ReallocationPolicyWitness {
            policy_id                  : v0,
            latch_id                   : v1,
            registry_id                : v2,
            strategy_id                : v3,
            guardrails_id              : v4,
            guardrails_hash            : v5,
            verified_leader            : v6,
            source_accounting_id       : v7,
            source_opportunity_id      : v8,
            destination_accounting_id  : v9,
            destination_opportunity_id : v10,
            allocation_bps             : v11,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11)
    }

    public(friend) fun enter_latch(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: &LeaderPolicy, arg3: &mut ExitModeLatch, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_policy_binding(arg0, arg1, arg2);
        assert!(arg3.policy_id == 0x2::object::id<LeaderPolicy>(arg2), 3);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::assert_canonical_leader_policy_and_latch(arg0, arg2.strategy_id, 0x2::object::id<LeaderPolicy>(arg2), 0x2::object::id<ExitModeLatch>(arg3));
        assert!(arg2.leader_may_force_exit, 6);
        assert!(!arg3.entered, 7);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::leader(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::record(arg0, arg2.strategy_id)) == 0x2::tx_context::sender(arg5), 5);
        arg3.entered = true;
        arg3.entered_at_ms = arg4;
    }

    public fun exit_mode_entered(arg0: &ExitModeLatch) : bool {
        arg0.entered
    }

    public fun exit_mode_entered_at_ms(arg0: &ExitModeLatch) : u64 {
        arg0.entered_at_ms
    }

    public(friend) fun freeze_policy(arg0: LeaderPolicy) {
        0x2::transfer::freeze_object<LeaderPolicy>(arg0);
    }

    public(friend) fun issue_reallocation_witness(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::StrategyRegistry, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::GuardrailsV2, arg2: &LeaderPolicy, arg3: &ExitModeLatch, arg4: u64, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: 0x2::object::ID, arg8: vector<u8>, arg9: &0x2::tx_context::TxContext) : ReallocationPolicyWitness {
        assert_policy_binding(arg0, arg1, arg2);
        assert!(arg3.policy_id == 0x2::object::id<LeaderPolicy>(arg2), 3);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::assert_canonical_leader_policy_and_latch(arg0, arg2.strategy_id, 0x2::object::id<LeaderPolicy>(arg2), 0x2::object::id<ExitModeLatch>(arg3));
        assert!(!arg3.entered, 7);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::assert_accepts_reallocation(arg0, arg2.strategy_id);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::leader(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::strategy_registry::record(arg0, arg2.strategy_id)) == v0, 5);
        ReallocationPolicyWitness{
            policy_id                  : 0x2::object::id<LeaderPolicy>(arg2),
            latch_id                   : 0x2::object::id<ExitModeLatch>(arg3),
            registry_id                : arg2.registry_id,
            strategy_id                : arg2.strategy_id,
            guardrails_id              : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::id(arg1),
            guardrails_hash            : 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::guardrails_v2::guardrails_hash(arg1),
            verified_leader            : v0,
            source_accounting_id       : arg5,
            source_opportunity_id      : arg6,
            destination_accounting_id  : arg7,
            destination_opportunity_id : arg8,
            allocation_bps             : arg4,
        }
    }

    public fun latch_policy_id(arg0: &ExitModeLatch) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun leader_may_force_exit(arg0: &LeaderPolicy) : bool {
        arg0.leader_may_force_exit
    }

    public(friend) fun new_latch(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : ExitModeLatch {
        ExitModeLatch{
            id            : 0x2::object::new(arg1),
            policy_id     : arg0,
            entered       : false,
            entered_at_ms : 0,
        }
    }

    public(friend) fun new_policy(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : LeaderPolicy {
        LeaderPolicy{
            id                    : 0x2::object::new(arg3),
            version               : 1,
            registry_id           : arg0,
            strategy_id           : arg1,
            leader_may_force_exit : arg2,
        }
    }

    public fun policy_id(arg0: &LeaderPolicy) : 0x2::object::ID {
        0x2::object::id<LeaderPolicy>(arg0)
    }

    public fun policy_registry_id(arg0: &LeaderPolicy) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun policy_strategy_id(arg0: &LeaderPolicy) : vector<u8> {
        arg0.strategy_id
    }

    public(friend) fun share_latch(arg0: ExitModeLatch) {
        0x2::transfer::share_object<ExitModeLatch>(arg0);
    }

    // decompiled from Move bytecode v7
}

