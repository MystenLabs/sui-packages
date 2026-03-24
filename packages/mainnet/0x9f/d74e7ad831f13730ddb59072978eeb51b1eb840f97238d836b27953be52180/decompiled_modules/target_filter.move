module 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::target_filter {
    struct TargetFilter has drop {
        dummy_field: bool,
    }

    struct TargetFilterConfig has drop, store {
        allowed_targets: vector<vector<u8>>,
        blocked_targets: vector<vector<u8>>,
    }

    struct TargetDeclaration has copy, drop {
        engine_id: 0x2::object::ID,
        declared_target: vector<u8>,
    }

    public fun add(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>) {
        let v0 = TargetFilter{dummy_field: false};
        let v1 = TargetFilterConfig{
            allowed_targets : arg2,
            blocked_targets : arg3,
        };
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::add_rule<TargetFilter, TargetFilterConfig>(arg0, arg1, v0, v1);
    }

    public fun allow_target(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<u8>) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = TargetFilter{dummy_field: false};
        let v1 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<TargetFilter, TargetFilterConfig>(arg0, v0);
        if (!contains(&v1.allowed_targets, &arg2)) {
            0x1::vector::push_back<vector<u8>>(&mut v1.allowed_targets, arg2);
        };
    }

    public fun allowed_targets(arg0: &TargetFilterConfig) : &vector<vector<u8>> {
        &arg0.allowed_targets
    }

    public fun block_target(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<u8>) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = TargetFilter{dummy_field: false};
        let v1 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<TargetFilter, TargetFilterConfig>(arg0, v0);
        if (!contains(&v1.blocked_targets, &arg2)) {
            0x1::vector::push_back<vector<u8>>(&mut v1.blocked_targets, arg2);
        };
    }

    public fun blocked_targets(arg0: &TargetFilterConfig) : &vector<vector<u8>> {
        &arg0.blocked_targets
    }

    public fun config(arg0: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine) : &TargetFilterConfig {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config<TargetFilter, TargetFilterConfig>(arg0)
    }

    fun contains(arg0: &vector<vector<u8>>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            if (0x1::vector::borrow<vector<u8>>(arg0, v0) == arg1) {
                v1 = true;
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = false;
        v1
    }

    public fun disallow_target(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<u8>) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = TargetFilter{dummy_field: false};
        let v1 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<TargetFilter, TargetFilterConfig>(arg0, v0);
        let v2 = &v1.allowed_targets;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<vector<u8>>(v2)) {
            if (*0x1::vector::borrow<vector<u8>>(v2, v3) == arg2) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 9 */
                if (0x1::option::is_some<u64>(&v4)) {
                    0x1::vector::swap_remove<vector<u8>>(&mut v1.allowed_targets, 0x1::option::destroy_some<u64>(v4));
                };
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    public fun enforce(arg0: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::ApprovalRequest, arg2: vector<u8>) : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyReceipt<TargetFilter> {
        let v0 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config<TargetFilter, TargetFilterConfig>(arg0);
        if (!0x1::vector::is_empty<vector<u8>>(&v0.allowed_targets)) {
            assert!(contains(&v0.allowed_targets, &arg2), 0);
        };
        if (!0x1::vector::is_empty<vector<u8>>(&v0.blocked_targets)) {
            assert!(!contains(&v0.blocked_targets, &arg2), 1);
        };
        let v1 = TargetDeclaration{
            engine_id       : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::engine_id(arg1),
            declared_target : arg2,
        };
        0x2::event::emit<TargetDeclaration>(v1);
        let v2 = TargetFilter{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::new_receipt<TargetFilter>(v2, arg1)
    }

    public fun is_target_permitted(arg0: &TargetFilterConfig, arg1: &vector<u8>) : bool {
        if (!0x1::vector::is_empty<vector<u8>>(&arg0.allowed_targets) && !contains(&arg0.allowed_targets, arg1)) {
            return false
        };
        if (!0x1::vector::is_empty<vector<u8>>(&arg0.blocked_targets) && contains(&arg0.blocked_targets, arg1)) {
            return false
        };
        true
    }

    public fun remove(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap) {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::remove_rule<TargetFilter, TargetFilterConfig>(arg0, arg1);
    }

    public fun set_allowed_targets(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<vector<u8>>) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = TargetFilter{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<TargetFilter, TargetFilterConfig>(arg0, v0).allowed_targets = arg2;
    }

    public fun set_blocked_targets(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<vector<u8>>) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = TargetFilter{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<TargetFilter, TargetFilterConfig>(arg0, v0).blocked_targets = arg2;
    }

    public fun unblock_target(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: vector<u8>) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = TargetFilter{dummy_field: false};
        let v1 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<TargetFilter, TargetFilterConfig>(arg0, v0);
        let v2 = &v1.blocked_targets;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<vector<u8>>(v2)) {
            if (*0x1::vector::borrow<vector<u8>>(v2, v3) == arg2) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 9 */
                if (0x1::option::is_some<u64>(&v4)) {
                    0x1::vector::swap_remove<vector<u8>>(&mut v1.blocked_targets, 0x1::option::destroy_some<u64>(v4));
                };
                return
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    // decompiled from Move bytecode v6
}

