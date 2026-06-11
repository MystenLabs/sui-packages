module 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::enforcement {
    struct ActionEnforced has copy, drop {
        policy_id: 0x2::object::ID,
        action_type: u8,
        recipient: address,
        amount: u64,
        has_protocol_id: bool,
    }

    public fun assert_action(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::approval::ApprovalReceipt, arg2: vector<u8>, arg3: u8, arg4: address, arg5: u64, arg6: &0x2::clock::Clock) {
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_not_paused(arg0);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_amount_allowed(arg0, arg5);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_recipient_allowed(arg0, arg4);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_action_type_allowed(arg0, arg3);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::approval::assert_valid_receipt(arg0, &arg1, arg2, arg3, arg4, arg5, arg6);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::approval::consume_receipt(arg1);
        let v0 = ActionEnforced{
            policy_id       : 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::id(arg0),
            action_type     : arg3,
            recipient       : arg4,
            amount          : arg5,
            has_protocol_id : false,
        };
        0x2::event::emit<ActionEnforced>(v0);
    }

    public fun assert_action_with_circuit_breaker(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::CircuitBreaker, arg2: u8, arg3: &vector<0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::MetricValue>, arg4: 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::approval::ApprovalReceipt, arg5: vector<u8>, arg6: u8, arg7: address, arg8: u64, arg9: &0x2::clock::Clock) {
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::assert_policy(arg1, arg0);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::assert_rules(arg1, arg2, arg3, true);
        assert_action(arg0, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun assert_basic_action_policy(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: u8, arg2: address, arg3: u64) {
        assert_basic_policy(arg0, arg2, arg3);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_action_type_allowed(arg0, arg1);
    }

    public fun assert_basic_action_policy_with_circuit_breaker(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::CircuitBreaker, arg2: u8, arg3: &vector<0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::MetricValue>, arg4: u8, arg5: address, arg6: u64) {
        assert_basic_policy_with_circuit_breaker(arg0, arg1, arg2, arg3, arg5, arg6);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_action_type_allowed(arg0, arg4);
    }

    public fun assert_basic_policy(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: address, arg2: u64) {
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_receipt_not_required(arg0);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_not_paused(arg0);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_amount_allowed(arg0, arg2);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_recipient_allowed(arg0, arg1);
    }

    public fun assert_basic_policy_with_circuit_breaker(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::CircuitBreaker, arg2: u8, arg3: &vector<0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::MetricValue>, arg4: address, arg5: u64) {
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::assert_policy(arg1, arg0);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::assert_rules(arg1, arg2, arg3, false);
        assert_basic_policy(arg0, arg4, arg5);
    }

    public fun assert_basic_protocol_policy(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: u8, arg2: 0x2::object::ID, arg3: address, arg4: u64) {
        assert_basic_action_policy(arg0, arg1, arg3, arg4);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_protocol_allowed(arg0, arg2);
    }

    public fun assert_protocol_action(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::approval::ApprovalReceipt, arg2: vector<u8>, arg3: u8, arg4: 0x2::object::ID, arg5: address, arg6: u64, arg7: &0x2::clock::Clock) {
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_not_paused(arg0);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_amount_allowed(arg0, arg6);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_recipient_allowed(arg0, arg5);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_action_type_allowed(arg0, arg3);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_protocol_allowed(arg0, arg4);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::approval::assert_valid_bound_receipt(arg0, &arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::approval::consume_receipt(arg1);
        let v0 = ActionEnforced{
            policy_id       : 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::id(arg0),
            action_type     : arg3,
            recipient       : arg5,
            amount          : arg6,
            has_protocol_id : true,
        };
        0x2::event::emit<ActionEnforced>(v0);
    }

    public fun assert_protocol_action_with_circuit_breaker(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::CircuitBreaker, arg2: u8, arg3: &vector<0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::MetricValue>, arg4: 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::approval::ApprovalReceipt, arg5: vector<u8>, arg6: u8, arg7: 0x2::object::ID, arg8: address, arg9: u64, arg10: &0x2::clock::Clock) {
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::assert_policy(arg1, arg0);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::circuit_breaker::assert_rules(arg1, arg2, arg3, true);
        assert_protocol_action(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    // decompiled from Move bytecode v7
}

