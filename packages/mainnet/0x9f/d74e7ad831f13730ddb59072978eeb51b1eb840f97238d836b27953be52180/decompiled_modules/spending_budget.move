module 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::spending_budget {
    struct SpendingBudget has drop {
        dummy_field: bool,
    }

    struct SpendingBudgetConfig has drop, store {
        max_per_window: u64,
        max_per_tx: u64,
        window_ms: u64,
        window_spent: u64,
        window_start_ms: u64,
    }

    struct SpendingDeclaration has copy, drop {
        engine_id: 0x2::object::ID,
        declared_value: u64,
        cumulative_spent: u64,
        timestamp_ms: u64,
    }

    public fun add(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = SpendingBudget{dummy_field: false};
        let v1 = SpendingBudgetConfig{
            max_per_window  : arg2,
            max_per_tx      : arg3,
            window_ms       : arg4,
            window_spent    : 0,
            window_start_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::add_rule<SpendingBudget, SpendingBudgetConfig>(arg0, arg1, v0, v1);
    }

    public fun config(arg0: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine) : &SpendingBudgetConfig {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config<SpendingBudget, SpendingBudgetConfig>(arg0)
    }

    public fun enforce(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::ApprovalRequest, arg2: u64, arg3: &0x2::clock::Clock) : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyReceipt<SpendingBudget> {
        assert!(arg2 > 0, 2);
        let v0 = SpendingBudget{dummy_field: false};
        let v1 = 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<SpendingBudget, SpendingBudgetConfig>(arg0, v0);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        if (v2 >= v1.window_start_ms + v1.window_ms) {
            v1.window_spent = 0;
            v1.window_start_ms = v2;
        };
        if (v1.max_per_tx > 0) {
            assert!(arg2 <= v1.max_per_tx, 0);
        };
        assert!(v1.window_spent + arg2 <= v1.max_per_window, 1);
        v1.window_spent = v1.window_spent + arg2;
        let v3 = SpendingDeclaration{
            engine_id        : 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::engine_id(arg1),
            declared_value   : arg2,
            cumulative_spent : v1.window_spent,
            timestamp_ms     : v2,
        };
        0x2::event::emit<SpendingDeclaration>(v3);
        let v4 = SpendingBudget{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::new_receipt<SpendingBudget>(v4, arg1)
    }

    public fun max_per_tx(arg0: &SpendingBudgetConfig) : u64 {
        arg0.max_per_tx
    }

    public fun max_per_window(arg0: &SpendingBudgetConfig) : u64 {
        arg0.max_per_window
    }

    public fun remaining(arg0: &SpendingBudgetConfig) : u64 {
        if (arg0.window_spent >= arg0.max_per_window) {
            0
        } else {
            arg0.max_per_window - arg0.window_spent
        }
    }

    public fun remove(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap) {
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::remove_rule<SpendingBudget, SpendingBudgetConfig>(arg0, arg1);
    }

    public fun set_max_per_tx(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: u64) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = SpendingBudget{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<SpendingBudget, SpendingBudgetConfig>(arg0, v0).max_per_tx = arg2;
    }

    public fun set_max_per_window(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: u64) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = SpendingBudget{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<SpendingBudget, SpendingBudgetConfig>(arg0, v0).max_per_window = arg2;
    }

    public fun set_window_ms(arg0: &mut 0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine, arg1: &0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyAdminCap, arg2: u64) {
        assert!(0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::admin_cap_engine_id(arg1) == 0x2::object::id<0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::PolicyEngine>(arg0), 0);
        let v0 = SpendingBudget{dummy_field: false};
        0x9fd74e7ad831f13730ddb59072978eeb51b1eb840f97238d836b27953be52180::policy_engine::rule_config_mut<SpendingBudget, SpendingBudgetConfig>(arg0, v0).window_ms = arg2;
    }

    public fun window_ms(arg0: &SpendingBudgetConfig) : u64 {
        arg0.window_ms
    }

    public fun window_spent(arg0: &SpendingBudgetConfig) : u64 {
        arg0.window_spent
    }

    public fun window_start_ms(arg0: &SpendingBudgetConfig) : u64 {
        arg0.window_start_ms
    }

    // decompiled from Move bytecode v6
}

