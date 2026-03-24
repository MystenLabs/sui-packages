module 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::rate_limit {
    struct RateLimit has drop {
        dummy_field: bool,
    }

    struct RateLimitConfig has drop, store {
        max_per_window: u64,
        window_ms: u64,
        window_count: u64,
        window_start_ms: u64,
    }

    public fun add(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = RateLimit{dummy_field: false};
        let v1 = RateLimitConfig{
            max_per_window  : arg2,
            window_ms       : arg3,
            window_count    : 0,
            window_start_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::add_rule<RateLimit, RateLimitConfig>(arg0, arg1, v0, v1);
    }

    public fun config(arg0: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine) : &RateLimitConfig {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config<RateLimit, RateLimitConfig>(arg0)
    }

    public fun enforce(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::ApprovalRequest, arg2: &0x2::clock::Clock) : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyReceipt<RateLimit> {
        let v0 = RateLimit{dummy_field: false};
        let v1 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<RateLimit, RateLimitConfig>(arg0, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        if (v2 >= v1.window_start_ms + v1.window_ms) {
            v1.window_count = 0;
            v1.window_start_ms = v2;
        };
        if (v1.max_per_window > 0) {
            assert!(v1.window_count < v1.max_per_window, 0);
        };
        v1.window_count = v1.window_count + 1;
        let v3 = RateLimit{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::new_receipt<RateLimit>(v3, arg1)
    }

    public fun max_per_window(arg0: &RateLimitConfig) : u64 {
        arg0.max_per_window
    }

    public fun remove(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap) {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::remove_rule<RateLimit, RateLimitConfig>(arg0, arg1);
    }

    public fun set_max_per_window(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: u64) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = RateLimit{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<RateLimit, RateLimitConfig>(arg0, v0).max_per_window = arg2;
    }

    public fun set_window_ms(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: u64) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = RateLimit{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<RateLimit, RateLimitConfig>(arg0, v0).window_ms = arg2;
    }

    public fun window_count(arg0: &RateLimitConfig) : u64 {
        arg0.window_count
    }

    public fun window_ms(arg0: &RateLimitConfig) : u64 {
        arg0.window_ms
    }

    public fun window_start_ms(arg0: &RateLimitConfig) : u64 {
        arg0.window_start_ms
    }

    // decompiled from Move bytecode v6
}

