module 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::approval_policy {
    struct ApprovalPolicy has key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        operator_id: 0x2::object::ID,
        max_auto_approve_amount: u64,
        allowed_action_types: vector<u8>,
        current_epoch: u64,
        epoch_approval_count: u64,
        max_approvals_per_epoch: u64,
        active: bool,
    }

    struct ApprovalPolicyCreated has copy, drop {
        approval_policy_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        operator_id: 0x2::object::ID,
    }

    struct ApprovalPolicyUpdated has copy, drop {
        approval_policy_id: 0x2::object::ID,
        field: vector<u8>,
    }

    struct ApprovalPolicyDeactivated has copy, drop {
        approval_policy_id: 0x2::object::ID,
    }

    struct ApprovalPolicyReactivated has copy, drop {
        approval_policy_id: 0x2::object::ID,
    }

    struct EscalationAutoApproved has copy, drop {
        approval_policy_id: 0x2::object::ID,
        approval_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        deposit_amount: u64,
    }

    public fun allowed_action_types(arg0: &ApprovalPolicy) : vector<u8> {
        arg0.allowed_action_types
    }

    public fun auto_approve<T0>(arg0: &mut ApprovalPolicy, arg1: &mut 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::PendingApproval<T0>, arg2: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::delegation::DelegationPolicy, arg3: &mut 0x2::tx_context::TxContext) : (0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::EscalationReceipt, 0x2::coin::Coin<T0>) {
        assert!(arg0.active, 3);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::delegation::is_active(arg2), 2);
        assert!(arg0.policy_id == 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::policy_id<T0>(arg1), 1);
        assert!(0x2::object::id<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::delegation::DelegationPolicy>(arg2) == 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::policy_id<T0>(arg1), 1);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::deposit_amount<T0>(arg1) <= arg0.max_auto_approve_amount, 4);
        let v0 = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::action_types<T0>(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            assert!(0x1::vector::contains<u8>(&arg0.allowed_action_types, 0x1::vector::borrow<u8>(&v0, v1)), 5);
            v1 = v1 + 1;
        };
        let v2 = 0x2::tx_context::epoch(arg3);
        if (v2 != arg0.current_epoch) {
            arg0.current_epoch = v2;
            arg0.epoch_approval_count = 0;
        };
        if (arg0.max_approvals_per_epoch > 0) {
            assert!(arg0.epoch_approval_count < arg0.max_approvals_per_epoch, 6);
        };
        arg0.epoch_approval_count = arg0.epoch_approval_count + 1;
        let (v3, v4) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::approve_escalation_automated<T0>(arg1, arg2, arg3);
        let v5 = EscalationAutoApproved{
            approval_policy_id : 0x2::object::uid_to_inner(&arg0.id),
            approval_id        : 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::approval_id<T0>(arg1),
            policy_id          : arg0.policy_id,
            deposit_amount     : 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::deposit_amount<T0>(arg1),
        };
        0x2::event::emit<EscalationAutoApproved>(v5);
        (v3, v4)
    }

    public fun create_and_auto_approve<T0>(arg0: &mut ApprovalPolicy, arg1: &mut 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::delegation::DelegationPolicy, arg2: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::identity::AgentIdentity, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: 0x2::coin::Coin<T0>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::EscalationReceipt, 0x2::coin::Coin<T0>) {
        assert!(arg0.active, 3);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::delegation::is_active(arg1), 2);
        assert!(arg0.policy_id == 0x2::object::id<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::delegation::DelegationPolicy>(arg1), 1);
        assert!(0x2::coin::value<T0>(&arg6) <= arg0.max_auto_approve_amount, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg3)) {
            assert!(0x1::vector::contains<u8>(&arg0.allowed_action_types, 0x1::vector::borrow<u8>(&arg3, v0)), 5);
            v0 = v0 + 1;
        };
        let v1 = 0x2::tx_context::epoch(arg10);
        if (v1 != arg0.current_epoch) {
            arg0.current_epoch = v1;
            arg0.epoch_approval_count = 0;
        };
        if (arg0.max_approvals_per_epoch > 0) {
            assert!(arg0.epoch_approval_count < arg0.max_approvals_per_epoch, 6);
        };
        arg0.epoch_approval_count = arg0.epoch_approval_count + 1;
        let (v2, v3) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::create_receipt_atomic<T0>(arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = EscalationAutoApproved{
            approval_policy_id : 0x2::object::uid_to_inner(&arg0.id),
            approval_id        : 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::escalation::receipt_approval_id(&v5),
            policy_id          : arg0.policy_id,
            deposit_amount     : 0x2::coin::value<T0>(&v4),
        };
        0x2::event::emit<EscalationAutoApproved>(v6);
        (v5, v4)
    }

    public fun create_approval_policy(arg0: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::identity::AgentIdentity, arg1: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::delegation::DelegationPolicy, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::identity::AgentIdentity>(arg0) == 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::delegation::operator_id(arg1), 0);
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::id<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::delegation::DelegationPolicy>(arg1);
        let v2 = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::delegation::operator_id(arg1);
        let v3 = ApprovalPolicyCreated{
            approval_policy_id : 0x2::object::uid_to_inner(&v0),
            policy_id          : v1,
            operator_id        : v2,
        };
        0x2::event::emit<ApprovalPolicyCreated>(v3);
        let v4 = ApprovalPolicy{
            id                      : v0,
            policy_id               : v1,
            operator_id             : v2,
            max_auto_approve_amount : arg2,
            allowed_action_types    : arg3,
            current_epoch           : 0x2::tx_context::epoch(arg5),
            epoch_approval_count    : 0,
            max_approvals_per_epoch : arg4,
            active                  : true,
        };
        0x2::transfer::share_object<ApprovalPolicy>(v4);
    }

    public fun current_epoch(arg0: &ApprovalPolicy) : u64 {
        arg0.current_epoch
    }

    public fun deactivate_approval_policy(arg0: &mut ApprovalPolicy, arg1: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::identity::AgentIdentity) {
        assert!(0x2::object::id<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        assert!(arg0.active, 9);
        arg0.active = false;
        let v0 = ApprovalPolicyDeactivated{approval_policy_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<ApprovalPolicyDeactivated>(v0);
    }

    public fun epoch_approval_count(arg0: &ApprovalPolicy) : u64 {
        arg0.epoch_approval_count
    }

    public fun is_active(arg0: &ApprovalPolicy) : bool {
        arg0.active
    }

    public fun max_approvals_per_epoch(arg0: &ApprovalPolicy) : u64 {
        arg0.max_approvals_per_epoch
    }

    public fun max_auto_approve_amount(arg0: &ApprovalPolicy) : u64 {
        arg0.max_auto_approve_amount
    }

    public fun operator_id(arg0: &ApprovalPolicy) : 0x2::object::ID {
        arg0.operator_id
    }

    public fun policy_id(arg0: &ApprovalPolicy) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun reactivate_approval_policy(arg0: &mut ApprovalPolicy, arg1: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::identity::AgentIdentity) {
        assert!(0x2::object::id<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        assert!(!arg0.active, 8);
        arg0.active = true;
        let v0 = ApprovalPolicyReactivated{approval_policy_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<ApprovalPolicyReactivated>(v0);
    }

    public fun update_approval_policy(arg0: &mut ApprovalPolicy, arg1: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::identity::AgentIdentity, arg2: u64, arg3: vector<u8>, arg4: u64) {
        assert!(0x2::object::id<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::identity::AgentIdentity>(arg1) == arg0.operator_id, 0);
        arg0.max_auto_approve_amount = arg2;
        arg0.allowed_action_types = arg3;
        arg0.max_approvals_per_epoch = arg4;
        let v0 = ApprovalPolicyUpdated{
            approval_policy_id : 0x2::object::uid_to_inner(&arg0.id),
            field              : b"all",
        };
        0x2::event::emit<ApprovalPolicyUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

