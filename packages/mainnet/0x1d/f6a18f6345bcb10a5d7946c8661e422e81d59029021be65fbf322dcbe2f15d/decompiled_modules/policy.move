module 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::policy {
    struct Policy has store, key {
        id: 0x2::object::UID,
        owner: address,
        policy_kind: u8,
        paused: bool,
        has_amount_limit: bool,
        max_amount: u64,
        oxsecure_issuer: address,
        require_receipt: bool,
        allowed_recipients: vector<address>,
        allowed_action_types: vector<u8>,
        bound_protocol: 0x1::option::Option<0x2::object::ID>,
        max_receipt_ttl_ms: u64,
    }

    struct PolicyCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        owner: address,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
        policy_kind: u8,
        has_amount_limit: bool,
        max_amount: u64,
        oxsecure_issuer: address,
        require_receipt: bool,
        allowed_recipient_count: u64,
        allowed_action_type_count: u64,
        has_bound_protocol: bool,
        max_receipt_ttl_ms: u64,
    }

    struct PolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        field: vector<u8>,
    }

    public fun id(arg0: &Policy) : 0x2::object::ID {
        0x2::object::id<Policy>(arg0)
    }

    public fun add_allowed_action_type(arg0: &mut Policy, arg1: &PolicyCap, arg2: u8) {
        assert_cap(arg0, arg1);
        if (!contains_action_type(&arg0.allowed_action_types, arg2)) {
            0x1::vector::push_back<u8>(&mut arg0.allowed_action_types, arg2);
            emit_update(arg0, b"allowed_action_types");
        };
    }

    public fun add_allowed_recipient(arg0: &mut Policy, arg1: &PolicyCap, arg2: address) {
        assert_cap(arg0, arg1);
        if (!contains_recipient(&arg0.allowed_recipients, arg2)) {
            0x1::vector::push_back<address>(&mut arg0.allowed_recipients, arg2);
            emit_update(arg0, b"allowed_recipients");
        };
    }

    public fun admin_kind() : u8 {
        2
    }

    public fun agent_kind() : u8 {
        3
    }

    public fun allowed_action_type_count(arg0: &Policy) : u64 {
        0x1::vector::length<u8>(&arg0.allowed_action_types)
    }

    public fun allowed_recipient_count(arg0: &Policy) : u64 {
        0x1::vector::length<address>(&arg0.allowed_recipients)
    }

    public fun assert_action_type_allowed(arg0: &Policy, arg1: u8) {
        if (0x1::vector::is_empty<u8>(&arg0.allowed_action_types)) {
            return
        };
        assert!(contains_action_type(&arg0.allowed_action_types, arg1), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_action_type_not_allowed());
    }

    public fun assert_amount_allowed(arg0: &Policy, arg1: u64) {
        if (!arg0.has_amount_limit) {
            return
        };
        assert!(arg1 <= arg0.max_amount, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_amount_too_high());
    }

    public fun assert_cap(arg0: &Policy, arg1: &PolicyCap) {
        assert!(arg1.policy_id == 0x2::object::id<Policy>(arg0), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_policy_mismatch());
        assert!(arg1.owner == arg0.owner, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_not_authorized());
    }

    public fun assert_not_paused(arg0: &Policy) {
        assert!(!arg0.paused, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_paused());
    }

    public fun assert_protocol_allowed(arg0: &Policy, arg1: 0x2::object::ID) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.bound_protocol)) {
            return
        };
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.bound_protocol) == arg1, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_protocol_mismatch());
    }

    public fun assert_receipt_expiry_allowed(arg0: &Policy, arg1: u64, arg2: u64) {
        if (arg0.max_receipt_ttl_ms == 0) {
            return
        };
        if (arg2 <= arg1) {
            return
        };
        assert!(arg2 - arg1 <= arg0.max_receipt_ttl_ms, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_receipt_ttl_too_long());
    }

    public fun assert_receipt_not_required(arg0: &Policy) {
        assert!(!arg0.require_receipt, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_receipt_required());
    }

    public fun assert_receipt_protocol_allowed(arg0: &Policy, arg1: &0x1::option::Option<0x2::object::ID>) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.bound_protocol)) {
            return
        };
        assert!(0x1::option::is_some<0x2::object::ID>(arg1), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_protocol_mismatch());
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.bound_protocol) == *0x1::option::borrow<0x2::object::ID>(arg1), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_protocol_mismatch());
    }

    public fun assert_recipient_allowed(arg0: &Policy, arg1: address) {
        if (0x1::vector::is_empty<address>(&arg0.allowed_recipients)) {
            return
        };
        assert!(contains_recipient(&arg0.allowed_recipients, arg1), 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_recipient_not_allowed());
    }

    fun assert_valid_policy_kind(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 255
        };
        assert!(v0, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::errors::e_invalid_policy_kind());
    }

    public fun clear_amount_limit(arg0: &mut Policy, arg1: &PolicyCap) {
        assert_cap(arg0, arg1);
        arg0.has_amount_limit = false;
        arg0.max_amount = 0;
        emit_update(arg0, b"amount_limit");
    }

    public fun clear_bound_protocol(arg0: &mut Policy, arg1: &PolicyCap) {
        assert_cap(arg0, arg1);
        arg0.bound_protocol = 0x1::option::none<0x2::object::ID>();
        emit_update(arg0, b"bound_protocol");
    }

    fun contains_action_type(arg0: &vector<u8>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun contains_recipient(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun create_admin_policy(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::action::admin_update());
        0x1::vector::push_back<u8>(v1, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::action::config_change());
        create_policy_with_rules(2, 0, arg0, true, vector[], v0, 0x1::option::none<0x2::object::ID>(), arg1, arg2);
    }

    public fun create_agent_policy(arg0: u64, arg1: address, arg2: vector<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::action::agent_execute());
        create_policy_with_rules(3, arg0, arg1, true, arg2, v0, 0x1::option::none<0x2::object::ID>(), arg3, arg4);
    }

    public fun create_bound_protocol_policy(arg0: u64, arg1: address, arg2: vector<address>, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        create_policy_with_rules(4, arg0, arg1, true, arg2, arg3, 0x1::option::some<0x2::object::ID>(arg4), arg5, arg6);
    }

    public fun create_flexible_agent_policy(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::action::agent_execute());
        create_policy_with_optional_amount_limit(3, false, 0, arg0, true, vector[], v0, 0x1::option::none<0x2::object::ID>(), arg1, arg2);
    }

    public fun create_policy(arg0: u64, arg1: address, arg2: bool, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        create_policy_with_rules(0, arg0, arg1, arg2, arg3, b"", 0x1::option::none<0x2::object::ID>(), 0, arg4);
    }

    public fun create_policy_with_optional_amount_limit(arg0: u8, arg1: bool, arg2: u64, arg3: address, arg4: bool, arg5: vector<address>, arg6: vector<u8>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert_valid_policy_kind(arg0);
        let v0 = 0x2::tx_context::sender(arg9);
        let (v1, v2) = new_policy(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v1;
        let v4 = PolicyCreated{
            policy_id                 : 0x2::object::id<Policy>(&v3),
            owner                     : v0,
            policy_kind               : arg0,
            has_amount_limit          : arg1,
            max_amount                : arg2,
            oxsecure_issuer           : arg3,
            require_receipt           : arg4,
            allowed_recipient_count   : 0x1::vector::length<address>(&v3.allowed_recipients),
            allowed_action_type_count : 0x1::vector::length<u8>(&v3.allowed_action_types),
            has_bound_protocol        : 0x1::option::is_some<0x2::object::ID>(&v3.bound_protocol),
            max_receipt_ttl_ms        : arg8,
        };
        0x2::event::emit<PolicyCreated>(v4);
        0x2::transfer::public_transfer<Policy>(v3, v0);
        0x2::transfer::public_transfer<PolicyCap>(v2, v0);
    }

    public fun create_policy_with_rules(arg0: u8, arg1: u64, arg2: address, arg3: bool, arg4: vector<address>, arg5: vector<u8>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        create_policy_with_optional_amount_limit(arg0, true, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun create_protocol_policy(arg0: u64, arg1: address, arg2: vector<address>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        create_policy_with_rules(4, arg0, arg1, true, arg2, arg3, 0x1::option::none<0x2::object::ID>(), arg4, arg5);
    }

    public fun create_treasury_policy(arg0: u64, arg1: address, arg2: vector<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::action::treasury_withdraw());
        create_policy_with_rules(1, arg0, arg1, true, arg2, v0, 0x1::option::none<0x2::object::ID>(), arg3, arg4);
    }

    public fun custom_kind() : u8 {
        255
    }

    fun emit_update(arg0: &Policy, arg1: vector<u8>) {
        let v0 = PolicyUpdated{
            policy_id : 0x2::object::id<Policy>(arg0),
            field     : arg1,
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public fun generic_kind() : u8 {
        0
    }

    public fun has_amount_limit(arg0: &Policy) : bool {
        arg0.has_amount_limit
    }

    public fun has_bound_protocol(arg0: &Policy) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.bound_protocol)
    }

    public fun issuer(arg0: &Policy) : address {
        arg0.oxsecure_issuer
    }

    public fun max_amount(arg0: &Policy) : u64 {
        arg0.max_amount
    }

    public fun max_receipt_ttl_ms(arg0: &Policy) : u64 {
        arg0.max_receipt_ttl_ms
    }

    fun new_policy(arg0: address, arg1: u8, arg2: bool, arg3: u64, arg4: address, arg5: bool, arg6: vector<address>, arg7: vector<u8>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (Policy, PolicyCap) {
        let v0 = Policy{
            id                   : 0x2::object::new(arg10),
            owner                : arg0,
            policy_kind          : arg1,
            paused               : false,
            has_amount_limit     : arg2,
            max_amount           : arg3,
            oxsecure_issuer      : arg4,
            require_receipt      : arg5,
            allowed_recipients   : arg6,
            allowed_action_types : arg7,
            bound_protocol       : arg8,
            max_receipt_ttl_ms   : arg9,
        };
        let v1 = PolicyCap{
            id        : 0x2::object::new(arg10),
            policy_id : 0x2::object::id<Policy>(&v0),
            owner     : arg0,
        };
        (v0, v1)
    }

    public fun policy_kind(arg0: &Policy) : u8 {
        arg0.policy_kind
    }

    public fun protocol_kind() : u8 {
        4
    }

    public fun remove_allowed_action_type(arg0: &mut Policy, arg1: &PolicyCap, arg2: u8) {
        assert_cap(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0.allowed_action_types)) {
            if (*0x1::vector::borrow<u8>(&arg0.allowed_action_types, v0) == arg2) {
                0x1::vector::remove<u8>(&mut arg0.allowed_action_types, v0);
                emit_update(arg0, b"allowed_action_types");
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun remove_allowed_recipient(arg0: &mut Policy, arg1: &PolicyCap, arg2: address) {
        assert_cap(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.allowed_recipients)) {
            if (*0x1::vector::borrow<address>(&arg0.allowed_recipients, v0) == arg2) {
                0x1::vector::remove<address>(&mut arg0.allowed_recipients, v0);
                emit_update(arg0, b"allowed_recipients");
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun require_receipt(arg0: &Policy) : bool {
        arg0.require_receipt
    }

    public fun set_allowed_action_types(arg0: &mut Policy, arg1: &PolicyCap, arg2: vector<u8>) {
        assert_cap(arg0, arg1);
        arg0.allowed_action_types = arg2;
        emit_update(arg0, b"allowed_action_types");
    }

    public fun set_bound_protocol(arg0: &mut Policy, arg1: &PolicyCap, arg2: 0x2::object::ID) {
        assert_cap(arg0, arg1);
        arg0.bound_protocol = 0x1::option::some<0x2::object::ID>(arg2);
        emit_update(arg0, b"bound_protocol");
    }

    public fun set_issuer(arg0: &mut Policy, arg1: &PolicyCap, arg2: address) {
        assert_cap(arg0, arg1);
        arg0.oxsecure_issuer = arg2;
        emit_update(arg0, b"oxsecure_issuer");
    }

    public fun set_max_amount(arg0: &mut Policy, arg1: &PolicyCap, arg2: u64) {
        assert_cap(arg0, arg1);
        arg0.has_amount_limit = true;
        arg0.max_amount = arg2;
        emit_update(arg0, b"max_amount");
    }

    public fun set_max_receipt_ttl_ms(arg0: &mut Policy, arg1: &PolicyCap, arg2: u64) {
        assert_cap(arg0, arg1);
        arg0.max_receipt_ttl_ms = arg2;
        emit_update(arg0, b"max_receipt_ttl_ms");
    }

    public fun set_paused(arg0: &mut Policy, arg1: &PolicyCap, arg2: bool) {
        assert_cap(arg0, arg1);
        arg0.paused = arg2;
        emit_update(arg0, b"paused");
    }

    public fun set_policy_kind(arg0: &mut Policy, arg1: &PolicyCap, arg2: u8) {
        assert_cap(arg0, arg1);
        assert_valid_policy_kind(arg2);
        arg0.policy_kind = arg2;
        emit_update(arg0, b"policy_kind");
    }

    public fun set_require_receipt(arg0: &mut Policy, arg1: &PolicyCap, arg2: bool) {
        assert_cap(arg0, arg1);
        arg0.require_receipt = arg2;
        emit_update(arg0, b"require_receipt");
    }

    public fun treasury_kind() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

