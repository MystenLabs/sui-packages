module 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::expiry {
    struct Expiry has drop {
        dummy_field: bool,
    }

    struct ExpiryConfig has drop, store {
        expiry_ms: u64,
    }

    public fun add(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: u64) {
        let v0 = Expiry{dummy_field: false};
        let v1 = ExpiryConfig{expiry_ms: arg2};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::add_rule<Expiry, ExpiryConfig>(arg0, arg1, v0, v1);
    }

    public fun config(arg0: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine) : &ExpiryConfig {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config<Expiry, ExpiryConfig>(arg0)
    }

    public fun enforce(arg0: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::ApprovalRequest, arg2: &0x2::clock::Clock) : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyReceipt<Expiry> {
        assert!(0x2::clock::timestamp_ms(arg2) <= 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config<Expiry, ExpiryConfig>(arg0).expiry_ms, 0);
        let v0 = Expiry{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::new_receipt<Expiry>(v0, arg1)
    }

    public fun expiry_ms(arg0: &ExpiryConfig) : u64 {
        arg0.expiry_ms
    }

    public fun is_expired(arg0: &ExpiryConfig, arg1: u64) : bool {
        arg1 > arg0.expiry_ms
    }

    public fun remove(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap) {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::remove_rule<Expiry, ExpiryConfig>(arg0, arg1);
    }

    public fun set_expiry_ms(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: u64) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = Expiry{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<Expiry, ExpiryConfig>(arg0, v0).expiry_ms = arg2;
    }

    // decompiled from Move bytecode v6
}

