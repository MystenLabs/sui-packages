module 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::approval {
    struct ApprovalReceipt has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        action_hash: vector<u8>,
        action_type: u8,
        issuer: address,
        protocol_id: 0x1::option::Option<0x2::object::ID>,
        recipient: address,
        amount: u64,
        expires_at_ms: u64,
        nonce: vector<u8>,
    }

    struct ReceiptIssued has copy, drop {
        receipt_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        action_type: u8,
        issuer: address,
        recipient: address,
        amount: u64,
        expires_at_ms: u64,
        has_protocol_id: bool,
    }

    struct ReceiptConsumed has copy, drop {
        receipt_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        action_type: u8,
    }

    fun assert_protocol_matches(arg0: &0x1::option::Option<0x2::object::ID>, arg1: &0x1::option::Option<0x2::object::ID>) {
        if (0x1::option::is_none<0x2::object::ID>(arg1)) {
            assert!(0x1::option::is_none<0x2::object::ID>(arg0), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_protocol_mismatch());
            return
        };
        assert!(0x1::option::is_some<0x2::object::ID>(arg0), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_protocol_mismatch());
        assert!(*0x1::option::borrow<0x2::object::ID>(arg0) == *0x1::option::borrow<0x2::object::ID>(arg1), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_protocol_mismatch());
    }

    public fun assert_valid_bound_receipt(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: &ApprovalReceipt, arg2: vector<u8>, arg3: u8, arg4: 0x2::object::ID, arg5: address, arg6: u64, arg7: &0x2::clock::Clock) {
        assert_valid_receipt_internal(arg0, arg1, arg2, arg3, 0x1::option::some<0x2::object::ID>(arg4), arg5, arg6, arg7);
    }

    public fun assert_valid_receipt(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: &ApprovalReceipt, arg2: vector<u8>, arg3: u8, arg4: address, arg5: u64, arg6: &0x2::clock::Clock) {
        assert_valid_receipt_internal(arg0, arg1, arg2, arg3, 0x1::option::none<0x2::object::ID>(), arg4, arg5, arg6);
    }

    fun assert_valid_receipt_internal(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: &ApprovalReceipt, arg2: vector<u8>, arg3: u8, arg4: 0x1::option::Option<0x2::object::ID>, arg5: address, arg6: u64, arg7: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg1.policy_id == 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::id(arg0), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_policy_mismatch());
        assert!(arg1.action_hash == arg2, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_action_mismatch());
        assert!(arg1.action_type == arg3, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_action_type_mismatch());
        assert_protocol_matches(&arg1.protocol_id, &arg4);
        assert!(arg1.issuer == 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::issuer(arg0), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_invalid_receipt());
        assert!(arg1.recipient == arg5, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_recipient_mismatch());
        assert!(arg1.amount == arg6, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_amount_mismatch());
        assert!(v0 <= arg1.expires_at_ms, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_receipt_expired());
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_action_type_allowed(arg0, arg3);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_receipt_protocol_allowed(arg0, &arg1.protocol_id);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_receipt_expiry_allowed(arg0, v0, arg1.expires_at_ms);
    }

    public fun consume_receipt(arg0: ApprovalReceipt) {
        let ApprovalReceipt {
            id            : v0,
            policy_id     : v1,
            action_hash   : _,
            action_type   : v3,
            issuer        : _,
            protocol_id   : _,
            recipient     : _,
            amount        : _,
            expires_at_ms : _,
            nonce         : _,
        } = arg0;
        let v10 = ReceiptConsumed{
            receipt_id  : 0x2::object::id<ApprovalReceipt>(&arg0),
            policy_id   : v1,
            action_type : v3,
        };
        0x2::event::emit<ReceiptConsumed>(v10);
        0x2::object::delete(v0);
    }

    public fun issue_bound_receipt(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: vector<u8>, arg2: u8, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        issue_receipt_internal(arg0, arg1, arg2, 0x1::option::some<0x2::object::ID>(arg3), arg4, arg5, arg6, b"", arg7, arg8);
    }

    public fun issue_bound_receipt_with_nonce(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: vector<u8>, arg2: u8, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        issue_receipt_internal(arg0, arg1, arg2, 0x1::option::some<0x2::object::ID>(arg3), arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun issue_receipt(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: vector<u8>, arg2: u8, arg3: address, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        issue_receipt_internal(arg0, arg1, arg2, 0x1::option::none<0x2::object::ID>(), arg3, arg4, arg5, b"", arg6, arg7);
    }

    fun issue_receipt_internal(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: vector<u8>, arg2: u8, arg3: 0x1::option::Option<0x2::object::ID>, arg4: address, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::issuer(arg0);
        assert!(0x2::tx_context::sender(arg9) == v0, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_not_authorized());
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_action_type_allowed(arg0, arg2);
        0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::assert_receipt_protocol_allowed(arg0, &arg3);
        let v1 = ApprovalReceipt{
            id            : 0x2::object::new(arg9),
            policy_id     : 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::id(arg0),
            action_hash   : arg1,
            action_type   : arg2,
            issuer        : v0,
            protocol_id   : arg3,
            recipient     : arg4,
            amount        : arg5,
            expires_at_ms : arg6,
            nonce         : arg7,
        };
        let v2 = ReceiptIssued{
            receipt_id      : 0x2::object::id<ApprovalReceipt>(&v1),
            policy_id       : 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::id(arg0),
            action_type     : arg2,
            issuer          : v0,
            recipient       : arg4,
            amount          : arg5,
            expires_at_ms   : arg6,
            has_protocol_id : 0x1::option::is_some<0x2::object::ID>(&v1.protocol_id),
        };
        0x2::event::emit<ReceiptIssued>(v2);
        0x2::transfer::public_transfer<ApprovalReceipt>(v1, arg8);
    }

    public fun issue_receipt_with_nonce(arg0: &0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy::Policy, arg1: vector<u8>, arg2: u8, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        issue_receipt_internal(arg0, arg1, arg2, 0x1::option::none<0x2::object::ID>(), arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v7
}

