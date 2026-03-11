module 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation {
    struct CooldownMsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LastIntentTsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RequiresApprovalAboveKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RateLimitConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RateLimitStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct EscalationExpiryEpochsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RateLimitConfig has copy, drop, store {
        max_actions_per_window: u64,
        window_duration_ms: u64,
    }

    struct RateLimitState has copy, drop, store {
        window_start_ms: u64,
        action_count: u64,
    }

    struct DelegationPolicy has key {
        id: 0x2::object::UID,
        operator_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        allowed_actions: vector<u8>,
        allowed_triggers: vector<u8>,
        max_deposit_per_intent: u64,
        max_total_budget: u64,
        total_committed: u64,
        max_intents: u64,
        intent_count: u64,
        active: bool,
        agent_address: address,
        created_at: u64,
    }

    struct DelegationReceipt {
        policy_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        deposit_value: u64,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        operator_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
    }

    struct PolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        field: vector<u8>,
    }

    struct PolicyRevoked has copy, drop {
        policy_id: 0x2::object::ID,
    }

    struct PolicyReactivated has copy, drop {
        policy_id: 0x2::object::ID,
    }

    struct DelegatedActionAuthorized has copy, drop {
        policy_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        deposit_amount: u64,
        intent_count: u64,
        total_committed: u64,
    }

    struct CommitmentReleased has copy, drop {
        policy_id: 0x2::object::ID,
        amount: u64,
        new_total_committed: u64,
        new_intent_count: u64,
    }

    public fun agent_id(arg0: &DelegationPolicy) : 0x2::object::ID {
        arg0.agent_id
    }

    public fun allowed_actions(arg0: &DelegationPolicy) : vector<u8> {
        arg0.allowed_actions
    }

    public fun allowed_triggers(arg0: &DelegationPolicy) : vector<u8> {
        arg0.allowed_triggers
    }

    public fun authorize<T0>(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: vector<u8>, arg3: u8, arg4: &0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : DelegationReceipt {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1) == arg0.agent_id, 1);
        assert!(arg0.active, 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg2)) {
            assert!(0x1::vector::contains<u8>(&arg0.allowed_actions, 0x1::vector::borrow<u8>(&arg2, v0)), 3);
            v0 = v0 + 1;
        };
        assert!(0x1::vector::contains<u8>(&arg0.allowed_triggers, &arg3), 4);
        let v1 = 0x2::coin::value<T0>(arg4);
        assert!(v1 <= arg0.max_deposit_per_intent, 5);
        assert!(arg0.total_committed + v1 <= arg0.max_total_budget, 6);
        let v2 = RequiresApprovalAboveKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RequiresApprovalAboveKey>(&arg0.id, v2)) {
            let v3 = RequiresApprovalAboveKey{dummy_field: false};
            assert!(v1 <= *0x2::dynamic_field::borrow<RequiresApprovalAboveKey, u64>(&arg0.id, v3), 13);
        };
        assert!(arg0.intent_count < arg0.max_intents, 7);
        enforce_rate_controls(arg0, arg5, arg6);
        arg0.total_committed = arg0.total_committed + v1;
        arg0.intent_count = arg0.intent_count + 1;
        let v4 = DelegatedActionAuthorized{
            policy_id       : 0x2::object::uid_to_inner(&arg0.id),
            agent_id        : arg0.agent_id,
            deposit_amount  : v1,
            intent_count    : arg0.intent_count,
            total_committed : arg0.total_committed,
        };
        0x2::event::emit<DelegatedActionAuthorized>(v4);
        DelegationReceipt{
            policy_id     : 0x2::object::uid_to_inner(&arg0.id),
            agent_id      : arg0.agent_id,
            deposit_value : v1,
        }
    }

    public fun consume_receipt(arg0: DelegationReceipt) : (0x2::object::ID, 0x2::object::ID, u64) {
        let DelegationReceipt {
            policy_id     : v0,
            agent_id      : v1,
            deposit_value : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun create_policy(arg0: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg0);
        let v2 = PolicyCreated{
            policy_id   : 0x2::object::uid_to_inner(&v0),
            operator_id : v1,
            agent_id    : arg1,
        };
        0x2::event::emit<PolicyCreated>(v2);
        let v3 = DelegationPolicy{
            id                     : v0,
            operator_id            : v1,
            agent_id               : arg1,
            allowed_actions        : arg3,
            allowed_triggers       : arg4,
            max_deposit_per_intent : arg5,
            max_total_budget       : arg6,
            total_committed        : 0,
            max_intents            : arg7,
            intent_count           : 0,
            active                 : true,
            agent_address          : arg2,
            created_at             : 0x2::tx_context::epoch(arg8),
        };
        0x2::transfer::share_object<DelegationPolicy>(v3);
    }

    public fun created_at(arg0: &DelegationPolicy) : u64 {
        arg0.created_at
    }

    public(friend) fun decrement_tracking(arg0: &mut DelegationPolicy, arg1: u64) {
        assert!(arg1 <= arg0.total_committed, 15);
        arg0.total_committed = arg0.total_committed - arg1;
        arg0.intent_count = arg0.intent_count - 1;
    }

    public(friend) fun enforce_rate_controls(arg0: &mut DelegationPolicy, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.agent_address, 12);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = CooldownMsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<CooldownMsKey>(&arg0.id, v1)) {
            let v2 = CooldownMsKey{dummy_field: false};
            let v3 = LastIntentTsKey{dummy_field: false};
            let v4 = *0x2::dynamic_field::borrow<LastIntentTsKey, u64>(&arg0.id, v3);
            if (v4 > 0) {
                assert!(v0 >= v4 + *0x2::dynamic_field::borrow<CooldownMsKey, u64>(&arg0.id, v2), 10);
            };
            let v5 = LastIntentTsKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<LastIntentTsKey, u64>(&mut arg0.id, v5) = v0;
        };
        let v6 = RateLimitConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RateLimitConfigKey>(&arg0.id, v6)) {
            let v7 = RateLimitConfigKey{dummy_field: false};
            let v8 = *0x2::dynamic_field::borrow<RateLimitConfigKey, RateLimitConfig>(&arg0.id, v7);
            let v9 = RateLimitStateKey{dummy_field: false};
            let v10 = 0x2::dynamic_field::borrow_mut<RateLimitStateKey, RateLimitState>(&mut arg0.id, v9);
            if (v0 >= v10.window_start_ms + v8.window_duration_ms) {
                v10.window_start_ms = v0;
                v10.action_count = 0;
            };
            assert!(v10.action_count < v8.max_actions_per_window, 11);
            v10.action_count = v10.action_count + 1;
        };
    }

    public(friend) fun escalation_expiry_epochs(arg0: &DelegationPolicy) : u64 {
        let v0 = EscalationExpiryEpochsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<EscalationExpiryEpochsKey>(&arg0.id, v0)) {
            let v2 = EscalationExpiryEpochsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<EscalationExpiryEpochsKey, u64>(&arg0.id, v2)
        } else {
            3
        }
    }

    public fun get_agent_address(arg0: &DelegationPolicy) : address {
        arg0.agent_address
    }

    public fun get_cooldown_ms(arg0: &DelegationPolicy) : 0x1::option::Option<u64> {
        let v0 = CooldownMsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<CooldownMsKey>(&arg0.id, v0)) {
            let v2 = CooldownMsKey{dummy_field: false};
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<CooldownMsKey, u64>(&arg0.id, v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_escalation_expiry_epochs(arg0: &DelegationPolicy) : 0x1::option::Option<u64> {
        let v0 = EscalationExpiryEpochsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<EscalationExpiryEpochsKey>(&arg0.id, v0)) {
            let v2 = EscalationExpiryEpochsKey{dummy_field: false};
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<EscalationExpiryEpochsKey, u64>(&arg0.id, v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_last_intent_ts(arg0: &DelegationPolicy) : 0x1::option::Option<u64> {
        let v0 = LastIntentTsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<LastIntentTsKey>(&arg0.id, v0)) {
            let v2 = LastIntentTsKey{dummy_field: false};
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<LastIntentTsKey, u64>(&arg0.id, v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_rate_limit_config(arg0: &DelegationPolicy) : 0x1::option::Option<RateLimitConfig> {
        let v0 = RateLimitConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RateLimitConfigKey>(&arg0.id, v0)) {
            let v2 = RateLimitConfigKey{dummy_field: false};
            0x1::option::some<RateLimitConfig>(*0x2::dynamic_field::borrow<RateLimitConfigKey, RateLimitConfig>(&arg0.id, v2))
        } else {
            0x1::option::none<RateLimitConfig>()
        }
    }

    public fun get_rate_limit_state(arg0: &DelegationPolicy) : 0x1::option::Option<RateLimitState> {
        let v0 = RateLimitStateKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RateLimitStateKey>(&arg0.id, v0)) {
            let v2 = RateLimitStateKey{dummy_field: false};
            0x1::option::some<RateLimitState>(*0x2::dynamic_field::borrow<RateLimitStateKey, RateLimitState>(&arg0.id, v2))
        } else {
            0x1::option::none<RateLimitState>()
        }
    }

    public fun get_requires_approval_above(arg0: &DelegationPolicy) : 0x1::option::Option<u64> {
        let v0 = RequiresApprovalAboveKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RequiresApprovalAboveKey>(&arg0.id, v0)) {
            let v2 = RequiresApprovalAboveKey{dummy_field: false};
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<RequiresApprovalAboveKey, u64>(&arg0.id, v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun increment_tracking(arg0: &mut DelegationPolicy, arg1: u64) {
        arg0.total_committed = arg0.total_committed + arg1;
        arg0.intent_count = arg0.intent_count + 1;
    }

    public fun intent_count(arg0: &DelegationPolicy) : u64 {
        arg0.intent_count
    }

    public fun is_active(arg0: &DelegationPolicy) : bool {
        arg0.active
    }

    public fun max_deposit_per_intent(arg0: &DelegationPolicy) : u64 {
        arg0.max_deposit_per_intent
    }

    public fun max_intents(arg0: &DelegationPolicy) : u64 {
        arg0.max_intents
    }

    public fun max_total_budget(arg0: &DelegationPolicy) : u64 {
        arg0.max_total_budget
    }

    public fun operator_id(arg0: &DelegationPolicy) : 0x2::object::ID {
        arg0.operator_id
    }

    public fun rate_limit_action_count(arg0: &RateLimitState) : u64 {
        arg0.action_count
    }

    public fun rate_limit_max_actions(arg0: &RateLimitConfig) : u64 {
        arg0.max_actions_per_window
    }

    public fun rate_limit_window_ms(arg0: &RateLimitConfig) : u64 {
        arg0.window_duration_ms
    }

    public fun rate_limit_window_start(arg0: &RateLimitState) : u64 {
        arg0.window_start_ms
    }

    public fun reactivate_policy(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        assert!(!arg0.active, 8);
        arg0.active = true;
        let v0 = PolicyReactivated{policy_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<PolicyReactivated>(v0);
    }

    public fun release_commitment(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: u64) {
        let v0 = 0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1);
        assert!(v0 == arg0.agent_id || v0 == arg0.operator_id, 14);
        assert!(arg0.intent_count > 0, 9);
        assert!(arg2 <= arg0.total_committed, 15);
        arg0.total_committed = arg0.total_committed - arg2;
        arg0.intent_count = arg0.intent_count - 1;
        let v1 = CommitmentReleased{
            policy_id           : 0x2::object::uid_to_inner(&arg0.id),
            amount              : arg2,
            new_total_committed : arg0.total_committed,
            new_intent_count    : arg0.intent_count,
        };
        0x2::event::emit<CommitmentReleased>(v1);
    }

    public fun revoke_policy(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        assert!(arg0.active, 2);
        arg0.active = false;
        let v0 = PolicyRevoked{policy_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<PolicyRevoked>(v0);
    }

    public fun set_agent_address(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: address) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        arg0.agent_address = arg2;
        let v0 = PolicyUpdated{
            policy_id : 0x2::object::uid_to_inner(&arg0.id),
            field     : b"agent_address",
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public fun set_cooldown(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: u64) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        let v0 = CooldownMsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<CooldownMsKey>(&arg0.id, v0)) {
            let v1 = CooldownMsKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<CooldownMsKey, u64>(&mut arg0.id, v1) = arg2;
        } else {
            let v2 = CooldownMsKey{dummy_field: false};
            0x2::dynamic_field::add<CooldownMsKey, u64>(&mut arg0.id, v2, arg2);
        };
        let v3 = LastIntentTsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<LastIntentTsKey>(&arg0.id, v3)) {
            let v4 = LastIntentTsKey{dummy_field: false};
            0x2::dynamic_field::add<LastIntentTsKey, u64>(&mut arg0.id, v4, 0);
        };
        let v5 = PolicyUpdated{
            policy_id : 0x2::object::uid_to_inner(&arg0.id),
            field     : b"cooldown_ms",
        };
        0x2::event::emit<PolicyUpdated>(v5);
    }

    public fun set_escalation_expiry_epochs(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: u64) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        assert!(arg2 >= 1 && arg2 <= 365, 16);
        let v0 = EscalationExpiryEpochsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<EscalationExpiryEpochsKey>(&arg0.id, v0)) {
            let v1 = EscalationExpiryEpochsKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<EscalationExpiryEpochsKey, u64>(&mut arg0.id, v1) = arg2;
        } else {
            let v2 = EscalationExpiryEpochsKey{dummy_field: false};
            0x2::dynamic_field::add<EscalationExpiryEpochsKey, u64>(&mut arg0.id, v2, arg2);
        };
        let v3 = PolicyUpdated{
            policy_id : 0x2::object::uid_to_inner(&arg0.id),
            field     : b"escalation_expiry_epochs",
        };
        0x2::event::emit<PolicyUpdated>(v3);
    }

    public fun set_rate_limit(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: u64, arg3: u64) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        let v0 = RateLimitConfig{
            max_actions_per_window : arg2,
            window_duration_ms     : arg3,
        };
        let v1 = RateLimitConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RateLimitConfigKey>(&arg0.id, v1)) {
            let v2 = RateLimitConfigKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<RateLimitConfigKey, RateLimitConfig>(&mut arg0.id, v2) = v0;
        } else {
            let v3 = RateLimitConfigKey{dummy_field: false};
            0x2::dynamic_field::add<RateLimitConfigKey, RateLimitConfig>(&mut arg0.id, v3, v0);
        };
        let v4 = RateLimitStateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<RateLimitStateKey>(&arg0.id, v4)) {
            let v5 = RateLimitStateKey{dummy_field: false};
            let v6 = RateLimitState{
                window_start_ms : 0,
                action_count    : 0,
            };
            0x2::dynamic_field::add<RateLimitStateKey, RateLimitState>(&mut arg0.id, v5, v6);
        };
        let v7 = PolicyUpdated{
            policy_id : 0x2::object::uid_to_inner(&arg0.id),
            field     : b"rate_limit",
        };
        0x2::event::emit<PolicyUpdated>(v7);
    }

    public fun set_requires_approval_above(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: u64) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        let v0 = RequiresApprovalAboveKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RequiresApprovalAboveKey>(&arg0.id, v0)) {
            let v1 = RequiresApprovalAboveKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<RequiresApprovalAboveKey, u64>(&mut arg0.id, v1) = arg2;
        } else {
            let v2 = RequiresApprovalAboveKey{dummy_field: false};
            0x2::dynamic_field::add<RequiresApprovalAboveKey, u64>(&mut arg0.id, v2, arg2);
        };
        let v3 = PolicyUpdated{
            policy_id : 0x2::object::uid_to_inner(&arg0.id),
            field     : b"requires_approval_above",
        };
        0x2::event::emit<PolicyUpdated>(v3);
    }

    public fun total_committed(arg0: &DelegationPolicy) : u64 {
        arg0.total_committed
    }

    public fun update_allowed_actions(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: vector<u8>) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        arg0.allowed_actions = arg2;
        let v0 = PolicyUpdated{
            policy_id : 0x2::object::uid_to_inner(&arg0.id),
            field     : b"allowed_actions",
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public fun update_allowed_triggers(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: vector<u8>) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        arg0.allowed_triggers = arg2;
        let v0 = PolicyUpdated{
            policy_id : 0x2::object::uid_to_inner(&arg0.id),
            field     : b"allowed_triggers",
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public fun update_limits(arg0: &mut DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: u64, arg3: u64, arg4: u64) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        arg0.max_deposit_per_intent = arg2;
        arg0.max_total_budget = arg3;
        arg0.max_intents = arg4;
        let v0 = PolicyUpdated{
            policy_id : 0x2::object::uid_to_inner(&arg0.id),
            field     : b"limits",
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

