module 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::sender_allowlist {
    struct SenderAllowlist has drop {
        dummy_field: bool,
    }

    struct SenderAllowlistConfig has drop, store {
        allowed: vector<address>,
    }

    public fun add(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<address>) {
        let v0 = SenderAllowlist{dummy_field: false};
        let v1 = SenderAllowlistConfig{allowed: arg2};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::add_rule<SenderAllowlist, SenderAllowlistConfig>(arg0, arg1, v0, v1);
    }

    public fun add_address(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: address) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = SenderAllowlist{dummy_field: false};
        let v1 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<SenderAllowlist, SenderAllowlistConfig>(arg0, v0);
        if (!0x1::vector::contains<address>(&v1.allowed, &arg2)) {
            0x1::vector::push_back<address>(&mut v1.allowed, arg2);
        };
    }

    public fun allowed(arg0: &SenderAllowlistConfig) : &vector<address> {
        &arg0.allowed
    }

    public fun config(arg0: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine) : &SenderAllowlistConfig {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config<SenderAllowlist, SenderAllowlistConfig>(arg0)
    }

    public fun enforce(arg0: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::ApprovalRequest, arg2: &0x2::tx_context::TxContext) : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyReceipt<SenderAllowlist> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config<SenderAllowlist, SenderAllowlistConfig>(arg0).allowed, &v0), 0);
        let v1 = SenderAllowlist{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::new_receipt<SenderAllowlist>(v1, arg1)
    }

    public fun is_allowed(arg0: &SenderAllowlistConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.allowed, &arg1)
    }

    public fun remove(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap) {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::remove_rule<SenderAllowlist, SenderAllowlistConfig>(arg0, arg1);
    }

    public fun remove_address(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: address) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = SenderAllowlist{dummy_field: false};
        let v1 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<SenderAllowlist, SenderAllowlistConfig>(arg0, v0);
        let v2 = &v1.allowed;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<address>(v2)) {
            if (*0x1::vector::borrow<address>(v2, v3) == arg2) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 9 */
                if (0x1::option::is_some<u64>(&v4)) {
                    0x1::vector::swap_remove<address>(&mut v1.allowed, 0x1::option::destroy_some<u64>(v4));
                };
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    public fun set_allowed(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<address>) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = SenderAllowlist{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<SenderAllowlist, SenderAllowlistConfig>(arg0, v0).allowed = arg2;
    }

    // decompiled from Move bytecode v6
}

