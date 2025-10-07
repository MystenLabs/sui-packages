module 0x598880e1602c692051799b34fa409fe2468d62ba9322681545df802553eb146d::automation_policy {
    struct AutomationPolicy has store, key {
        id: 0x2::object::UID,
        automation_id: 0x1::string::String,
        owner: address,
        wallet_id: 0x1::string::String,
        is_paused: bool,
        is_expired: bool,
        expiry_timestamp: u64,
        daily_budget_mist: u64,
        budget_used_today_mist: u64,
        budget_reset_timestamp: u64,
        max_gas_per_run_mist: u64,
        max_runs_per_hour: u64,
        runs_this_hour: u64,
        hour_reset_timestamp: u64,
        allowed_packages: vector<address>,
        allowed_modules: vector<0x1::string::String>,
        allowed_functions: vector<0x1::string::String>,
        time_window_enabled: bool,
        time_window_start_hour: u8,
        time_window_end_hour: u8,
        created_at: u64,
        updated_at: u64,
        last_execution_at: u64,
        total_executions: u64,
        total_gas_used_mist: u64,
    }

    struct PolicyValidationEvent has copy, drop {
        policy_id: 0x2::object::ID,
        automation_id: 0x1::string::String,
        allowed: bool,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct BudgetUpdateEvent has copy, drop {
        policy_id: 0x2::object::ID,
        gas_used_mist: u64,
        budget_remaining_mist: u64,
        timestamp: u64,
    }

    struct PolicyCreatedEvent has copy, drop {
        policy_id: 0x2::object::ID,
        automation_id: 0x1::string::String,
        owner: address,
        timestamp: u64,
    }

    struct PolicyPausedEvent has copy, drop {
        policy_id: 0x2::object::ID,
        automation_id: 0x1::string::String,
        timestamp: u64,
    }

    struct PolicyResumedEvent has copy, drop {
        policy_id: 0x2::object::ID,
        automation_id: 0x1::string::String,
        timestamp: u64,
    }

    public entry fun add_allowed_function(arg0: &mut AutomationPolicy, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        0x1::vector::push_back<address>(&mut arg0.allowed_packages, arg1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.allowed_modules, arg2);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.allowed_functions, arg3);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg4);
    }

    public fun can_execute(arg0: &mut AutomationPolicy, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.is_paused) {
            emit_validation_event(arg0, false, b"Policy is paused (kill-switch active)", v0);
            return false
        };
        if (arg0.expiry_timestamp > 0 && v0 > arg0.expiry_timestamp) {
            arg0.is_expired = true;
            emit_validation_event(arg0, false, b"Policy has expired", v0);
            return false
        };
        if (v0 >= arg0.budget_reset_timestamp) {
            arg0.budget_used_today_mist = 0;
            arg0.budget_reset_timestamp = get_next_midnight(v0);
        };
        if (arg0.budget_used_today_mist + arg1 > arg0.daily_budget_mist) {
            emit_validation_event(arg0, false, b"Daily budget exceeded", v0);
            return false
        };
        if (arg1 > arg0.max_gas_per_run_mist) {
            emit_validation_event(arg0, false, b"Gas estimate exceeds per-run limit", v0);
            return false
        };
        if (v0 >= arg0.hour_reset_timestamp) {
            arg0.runs_this_hour = 0;
            arg0.hour_reset_timestamp = get_next_hour(v0);
        };
        if (arg0.runs_this_hour >= arg0.max_runs_per_hour) {
            emit_validation_event(arg0, false, b"Rate limit exceeded", v0);
            return false
        };
        if (arg0.time_window_enabled) {
            let v1 = get_current_hour_utc(v0);
            if (v1 < arg0.time_window_start_hour || v1 >= arg0.time_window_end_hour) {
                emit_validation_event(arg0, false, b"Outside allowed time window", v0);
                return false
            };
        };
        emit_validation_event(arg0, true, b"Policy validation passed", v0);
        true
    }

    public entry fun create_policy(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = AutomationPolicy{
            id                     : 0x2::object::new(arg5),
            automation_id          : arg0,
            owner                  : 0x2::tx_context::sender(arg5),
            wallet_id              : arg1,
            is_paused              : false,
            is_expired             : false,
            expiry_timestamp       : 0,
            daily_budget_mist      : arg2,
            budget_used_today_mist : 0,
            budget_reset_timestamp : get_next_midnight(v0),
            max_gas_per_run_mist   : arg3,
            max_runs_per_hour      : 60,
            runs_this_hour         : 0,
            hour_reset_timestamp   : get_next_hour(v0),
            allowed_packages       : 0x1::vector::empty<address>(),
            allowed_modules        : 0x1::vector::empty<0x1::string::String>(),
            allowed_functions      : 0x1::vector::empty<0x1::string::String>(),
            time_window_enabled    : false,
            time_window_start_hour : 0,
            time_window_end_hour   : 23,
            created_at             : v0,
            updated_at             : v0,
            last_execution_at      : 0,
            total_executions       : 0,
            total_gas_used_mist    : 0,
        };
        let v2 = PolicyCreatedEvent{
            policy_id     : 0x2::object::uid_to_inner(&v1.id),
            automation_id : v1.automation_id,
            owner         : v1.owner,
            timestamp     : v0,
        };
        0x2::event::emit<PolicyCreatedEvent>(v2);
        0x2::transfer::public_share_object<AutomationPolicy>(v1);
    }

    fun emit_validation_event(arg0: &AutomationPolicy, arg1: bool, arg2: vector<u8>, arg3: u64) {
        let v0 = PolicyValidationEvent{
            policy_id     : 0x2::object::uid_to_inner(&arg0.id),
            automation_id : arg0.automation_id,
            allowed       : arg1,
            reason        : 0x1::string::utf8(arg2),
            timestamp     : arg3,
        };
        0x2::event::emit<PolicyValidationEvent>(v0);
    }

    fun get_current_hour_utc(arg0: u64) : u8 {
        ((arg0 / 3600000 % 24) as u8)
    }

    fun get_next_hour(arg0: u64) : u64 {
        (arg0 / 3600000 + 1) * 3600000
    }

    fun get_next_midnight(arg0: u64) : u64 {
        (arg0 / 86400000 + 1) * 86400000
    }

    public fun get_policy_state(arg0: &AutomationPolicy) : (bool, bool, u64, u64, u64, u64, u64, u64) {
        (arg0.is_paused, arg0.is_expired, arg0.budget_used_today_mist, arg0.daily_budget_mist, arg0.runs_this_hour, arg0.max_runs_per_hour, arg0.total_executions, arg0.total_gas_used_mist)
    }

    public entry fun pause(arg0: &mut AutomationPolicy, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.is_paused = true;
        arg0.updated_at = v0;
        let v1 = PolicyPausedEvent{
            policy_id     : 0x2::object::uid_to_inner(&arg0.id),
            automation_id : arg0.automation_id,
            timestamp     : v0,
        };
        0x2::event::emit<PolicyPausedEvent>(v1);
    }

    public entry fun record_execution(arg0: &mut AutomationPolicy, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.budget_used_today_mist = arg0.budget_used_today_mist + arg1;
        arg0.total_gas_used_mist = arg0.total_gas_used_mist + arg1;
        arg0.runs_this_hour = arg0.runs_this_hour + 1;
        arg0.total_executions = arg0.total_executions + 1;
        arg0.last_execution_at = v0;
        arg0.updated_at = v0;
        let v1 = if (arg0.daily_budget_mist > arg0.budget_used_today_mist) {
            arg0.daily_budget_mist - arg0.budget_used_today_mist
        } else {
            0
        };
        let v2 = BudgetUpdateEvent{
            policy_id             : 0x2::object::uid_to_inner(&arg0.id),
            gas_used_mist         : arg1,
            budget_remaining_mist : v1,
            timestamp             : v0,
        };
        0x2::event::emit<BudgetUpdateEvent>(v2);
    }

    public entry fun resume(arg0: &mut AutomationPolicy, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.is_paused = false;
        arg0.updated_at = v0;
        let v1 = PolicyResumedEvent{
            policy_id     : 0x2::object::uid_to_inner(&arg0.id),
            automation_id : arg0.automation_id,
            timestamp     : v0,
        };
        0x2::event::emit<PolicyResumedEvent>(v1);
    }

    public entry fun set_expiry(arg0: &mut AutomationPolicy, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.expiry_timestamp = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    public entry fun set_time_window(arg0: &mut AutomationPolicy, arg1: bool, arg2: u8, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        arg0.time_window_enabled = arg1;
        arg0.time_window_start_hour = arg2;
        arg0.time_window_end_hour = arg3;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg4);
    }

    public entry fun update_budget(arg0: &mut AutomationPolicy, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.daily_budget_mist = arg1;
        arg0.max_gas_per_run_mist = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
    }

    public entry fun update_rate_limit(arg0: &mut AutomationPolicy, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.max_runs_per_hour = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
    }

    // decompiled from Move bytecode v6
}

