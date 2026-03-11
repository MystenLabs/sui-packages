module 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::escalation {
    struct PendingApproval<phantom T0> has key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        operator_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        agent_address: address,
        action_types: vector<u8>,
        trigger_type: u8,
        action_data: vector<u8>,
        deposit: 0x2::balance::Balance<T0>,
        deposit_amount: u64,
        reasoning: vector<u8>,
        observation_hash: vector<u8>,
        created_epoch: u64,
        expires_epoch: u64,
        status: u8,
    }

    struct EscalationReceipt {
        approval_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        deposit_amount: u64,
    }

    struct EscalationCreated has copy, drop {
        approval_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        deposit_amount: u64,
    }

    struct EscalationApproved has copy, drop {
        approval_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        operator_id: 0x2::object::ID,
    }

    struct EscalationRejected has copy, drop {
        approval_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        operator_id: 0x2::object::ID,
    }

    struct EscalationExpired has copy, drop {
        approval_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
    }

    public fun agent_id<T0>(arg0: &PendingApproval<T0>) : 0x2::object::ID {
        arg0.agent_id
    }

    public fun operator_id<T0>(arg0: &PendingApproval<T0>) : 0x2::object::ID {
        arg0.operator_id
    }

    public fun action_types<T0>(arg0: &PendingApproval<T0>) : vector<u8> {
        arg0.action_types
    }

    public fun agent_address<T0>(arg0: &PendingApproval<T0>) : address {
        arg0.agent_address
    }

    public fun approval_id<T0>(arg0: &PendingApproval<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun approve_escalation<T0>(arg0: &mut PendingApproval<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy, arg2: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg3: &mut 0x2::tx_context::TxContext) : (EscalationReceipt, 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg2) == arg0.operator_id, 0);
        assert!(arg0.status == 0, 2);
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy>(arg1) == arg0.policy_id, 4);
        arg0.status = 1;
        let v0 = EscalationApproved{
            approval_id : 0x2::object::uid_to_inner(&arg0.id),
            policy_id   : arg0.policy_id,
            operator_id : arg0.operator_id,
        };
        0x2::event::emit<EscalationApproved>(v0);
        let v1 = EscalationReceipt{
            approval_id    : 0x2::object::uid_to_inner(&arg0.id),
            policy_id      : arg0.policy_id,
            agent_id       : arg0.agent_id,
            deposit_amount : arg0.deposit_amount,
        };
        (v1, 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.deposit), arg3))
    }

    public(friend) fun approve_escalation_automated<T0>(arg0: &mut PendingApproval<T0>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy, arg2: &mut 0x2::tx_context::TxContext) : (EscalationReceipt, 0x2::coin::Coin<T0>) {
        assert!(arg0.status == 0, 2);
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy>(arg1) == arg0.policy_id, 4);
        arg0.status = 1;
        let v0 = EscalationApproved{
            approval_id : 0x2::object::uid_to_inner(&arg0.id),
            policy_id   : arg0.policy_id,
            operator_id : arg0.operator_id,
        };
        0x2::event::emit<EscalationApproved>(v0);
        let v1 = EscalationReceipt{
            approval_id    : 0x2::object::uid_to_inner(&arg0.id),
            policy_id      : arg0.policy_id,
            agent_id       : arg0.agent_id,
            deposit_amount : arg0.deposit_amount,
        };
        (v1, 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.deposit), arg2))
    }

    public fun consume_escalation_receipt(arg0: EscalationReceipt) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, u64) {
        let EscalationReceipt {
            approval_id    : v0,
            policy_id      : v1,
            agent_id       : v2,
            deposit_amount : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun create_escalated_request<T0>(arg0: &mut 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1);
        assert!(v0 == 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::agent_id(arg0), 1);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::is_active(arg0), 5);
        let v1 = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::allowed_actions(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg2)) {
            assert!(0x1::vector::contains<u8>(&v1, 0x1::vector::borrow<u8>(&arg2, v2)), 6);
            v2 = v2 + 1;
        };
        let v3 = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::allowed_triggers(arg0);
        assert!(0x1::vector::contains<u8>(&v3, &arg3), 7);
        let v4 = 0x2::coin::value<T0>(&arg5);
        assert!(v4 <= 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::max_deposit_per_intent(arg0), 8);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::total_committed(arg0) + v4 <= 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::max_total_budget(arg0), 9);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::intent_count(arg0) < 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::max_intents(arg0), 10);
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::enforce_rate_controls(arg0, arg8, arg9);
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::increment_tracking(arg0, v4);
        let v5 = 0x2::object::new(arg9);
        let v6 = 0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy>(arg0);
        let v7 = 0x2::tx_context::epoch(arg9);
        let v8 = EscalationCreated{
            approval_id    : 0x2::object::uid_to_inner(&v5),
            policy_id      : v6,
            agent_id       : v0,
            deposit_amount : v4,
        };
        0x2::event::emit<EscalationCreated>(v8);
        let v9 = PendingApproval<T0>{
            id               : v5,
            policy_id        : v6,
            operator_id      : 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::operator_id(arg0),
            agent_id         : v0,
            agent_address    : 0x2::tx_context::sender(arg9),
            action_types     : arg2,
            trigger_type     : arg3,
            action_data      : arg4,
            deposit          : 0x2::coin::into_balance<T0>(arg5),
            deposit_amount   : v4,
            reasoning        : arg6,
            observation_hash : arg7,
            created_epoch    : v7,
            expires_epoch    : v7 + 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::escalation_expiry_epochs(arg0),
            status           : 0,
        };
        0x2::transfer::share_object<PendingApproval<T0>>(v9);
    }

    public(friend) fun create_receipt_atomic<T0>(arg0: &mut 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg2: vector<u8>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (EscalationReceipt, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg1);
        assert!(v0 == 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::agent_id(arg0), 1);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::is_active(arg0), 5);
        let v1 = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::allowed_actions(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg2)) {
            assert!(0x1::vector::contains<u8>(&v1, 0x1::vector::borrow<u8>(&arg2, v2)), 6);
            v2 = v2 + 1;
        };
        let v3 = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::allowed_triggers(arg0);
        assert!(0x1::vector::contains<u8>(&v3, &arg3), 7);
        let v4 = 0x2::coin::value<T0>(&arg4);
        assert!(v4 <= 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::max_deposit_per_intent(arg0), 8);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::total_committed(arg0) + v4 <= 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::max_total_budget(arg0), 9);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::intent_count(arg0) < 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::max_intents(arg0), 10);
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::enforce_rate_controls(arg0, arg7, arg8);
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::increment_tracking(arg0, v4);
        let v5 = 0x2::object::new(arg8);
        let v6 = 0x2::object::uid_to_inner(&v5);
        let v7 = 0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy>(arg0);
        let v8 = EscalationCreated{
            approval_id    : v6,
            policy_id      : v7,
            agent_id       : v0,
            deposit_amount : v4,
        };
        0x2::event::emit<EscalationCreated>(v8);
        let v9 = EscalationApproved{
            approval_id : v6,
            policy_id   : v7,
            operator_id : 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::operator_id(arg0),
        };
        0x2::event::emit<EscalationApproved>(v9);
        0x2::object::delete(v5);
        let v10 = EscalationReceipt{
            approval_id    : v6,
            policy_id      : v7,
            agent_id       : v0,
            deposit_amount : v4,
        };
        (v10, arg4)
    }

    public fun created_epoch<T0>(arg0: &PendingApproval<T0>) : u64 {
        arg0.created_epoch
    }

    public fun deposit_amount<T0>(arg0: &PendingApproval<T0>) : u64 {
        arg0.deposit_amount
    }

    public fun deposit_value<T0>(arg0: &PendingApproval<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.deposit)
    }

    public fun expire_escalation<T0>(arg0: &mut PendingApproval<T0>, arg1: &mut 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(0x2::tx_context::epoch(arg2) > arg0.expires_epoch, 3);
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy>(arg1) == arg0.policy_id, 4);
        arg0.status = 3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.deposit), arg2), arg0.agent_address);
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::decrement_tracking(arg1, 0x2::balance::value<T0>(&arg0.deposit));
        let v0 = EscalationExpired{
            approval_id : 0x2::object::uid_to_inner(&arg0.id),
            policy_id   : arg0.policy_id,
        };
        0x2::event::emit<EscalationExpired>(v0);
    }

    public fun expires_epoch<T0>(arg0: &PendingApproval<T0>) : u64 {
        arg0.expires_epoch
    }

    public fun observation_hash<T0>(arg0: &PendingApproval<T0>) : vector<u8> {
        arg0.observation_hash
    }

    public fun policy_id<T0>(arg0: &PendingApproval<T0>) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun reasoning<T0>(arg0: &PendingApproval<T0>) : vector<u8> {
        arg0.reasoning
    }

    public fun receipt_approval_id(arg0: &EscalationReceipt) : 0x2::object::ID {
        arg0.approval_id
    }

    public fun reject_escalation<T0>(arg0: &mut PendingApproval<T0>, arg1: &mut 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy, arg2: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::identity::AgentIdentity>(arg2) == arg0.operator_id, 0);
        assert!(arg0.status == 0, 2);
        assert!(0x2::object::id<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::DelegationPolicy>(arg1) == arg0.policy_id, 4);
        arg0.status = 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.deposit), arg3), arg0.agent_address);
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::delegation::decrement_tracking(arg1, 0x2::balance::value<T0>(&arg0.deposit));
        let v0 = EscalationRejected{
            approval_id : 0x2::object::uid_to_inner(&arg0.id),
            policy_id   : arg0.policy_id,
            operator_id : arg0.operator_id,
        };
        0x2::event::emit<EscalationRejected>(v0);
    }

    public fun status<T0>(arg0: &PendingApproval<T0>) : u8 {
        arg0.status
    }

    public fun trigger_type<T0>(arg0: &PendingApproval<T0>) : u8 {
        arg0.trigger_type
    }

    // decompiled from Move bytecode v6
}

