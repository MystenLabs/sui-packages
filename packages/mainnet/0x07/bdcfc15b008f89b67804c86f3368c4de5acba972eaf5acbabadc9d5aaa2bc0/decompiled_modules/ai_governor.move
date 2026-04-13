module 0x7bdcfc15b008f89b67804c86f3368c4de5acba972eaf5acbabadc9d5aaa2bc0::ai_governor {
    struct AIGovernor has key {
        id: 0x2::object::UID,
        fractal_reserve: 0x2::object::ID,
        nine_forms: 0x2::object::ID,
        triple_ledger: 0x2::object::ID,
        last_execution_time: u64,
        execution_count: u64,
        frequency_ms: u64,
        current_equilibrium: u64,
        target_equilibrium: u64,
        equilibrium_deviation: u64,
        is_negative_deviation: bool,
        peg_defense_enabled: bool,
        defense_threshold: u64,
        max_defense_per_cycle: u64,
        is_active: bool,
        is_paused: bool,
        operator: address,
    }

    struct ExecutionResult has copy, drop, store {
        cycle_number: u64,
        timestamp: u64,
        equilibrium_before: u64,
        equilibrium_after: u64,
        action_taken: 0x1::string::String,
        coins_moved: u64,
        coins_released: u64,
        coins_absorbed: u64,
    }

    struct AICycleExecuted has copy, drop {
        cycle_number: u64,
        equilibrium_value: u64,
        deviation: u64,
        action: 0x1::string::String,
        timestamp: u64,
    }

    struct PegDefenseTriggered has copy, drop {
        cycle_number: u64,
        deviation: u64,
        coins_released: u64,
        timestamp: u64,
    }

    public fun adjust_target_equilibrium(arg0: &mut AIGovernor, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.operator, 0);
        arg0.target_equilibrium = arg1;
    }

    public fun change_operator(arg0: &mut AIGovernor, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.operator, 0);
        arg0.operator = arg1;
    }

    public fun current_equilibrium(arg0: &AIGovernor) : u64 {
        arg0.current_equilibrium
    }

    public fun emergency_pause(arg0: &mut AIGovernor, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 0);
        arg0.is_paused = true;
    }

    public fun emergency_shutdown(arg0: &mut AIGovernor, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 0);
        arg0.is_active = false;
        arg0.is_paused = true;
    }

    public fun emergency_unpause(arg0: &mut AIGovernor, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 0);
        arg0.is_paused = false;
    }

    public fun equilibrium_deviation(arg0: &AIGovernor) : u64 {
        arg0.equilibrium_deviation
    }

    public fun execute_ai_cycle(arg0: &mut AIGovernor, arg1: &mut 0x7bdcfc15b008f89b67804c86f3368c4de5acba972eaf5acbabadc9d5aaa2bc0::sicilian_vino::FractalReserve, arg2: &mut 0x7bdcfc15b008f89b67804c86f3368c4de5acba972eaf5acbabadc9d5aaa2bc0::nine_forms_capital::NineFormsState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 0);
        assert!(!arg0.is_paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 - arg0.last_execution_time < arg0.frequency_ms) {
            return
        };
        arg0.last_execution_time = v0;
        arg0.execution_count = arg0.execution_count + 1;
        let v1 = 0x7bdcfc15b008f89b67804c86f3368c4de5acba972eaf5acbabadc9d5aaa2bc0::nine_forms_capital::weighted_equilibrium(arg2);
        let v2 = v1 < arg0.target_equilibrium;
        let v3 = if (v2) {
            arg0.target_equilibrium - v1
        } else {
            v1 - arg0.target_equilibrium
        };
        arg0.equilibrium_deviation = v3;
        arg0.is_negative_deviation = v2;
        arg0.current_equilibrium = v1;
        let v4 = 0x1::string::utf8(b"NO_ACTION");
        if (arg0.peg_defense_enabled) {
            let v5 = if (arg0.target_equilibrium > 0) {
                v3 * 10000 / arg0.target_equilibrium
            } else {
                0
            };
            if (!v2 && v5 > arg0.defense_threshold) {
                if (v5 * 1000 / arg0.defense_threshold > arg0.max_defense_per_cycle) {
                };
                v4 = 0x1::string::utf8(b"ABSORB_COINS");
            } else if (v2 && v5 > arg0.defense_threshold) {
                let v6 = v5 * 1000 / arg0.defense_threshold;
                let v7 = if (v6 > arg0.max_defense_per_cycle) {
                    arg0.max_defense_per_cycle
                } else {
                    v6
                };
                v4 = 0x1::string::utf8(b"RELEASE_COINS");
                let v8 = PegDefenseTriggered{
                    cycle_number   : arg0.execution_count,
                    deviation      : v5,
                    coins_released : v7,
                    timestamp      : v0,
                };
                0x2::event::emit<PegDefenseTriggered>(v8);
            };
        };
        0x7bdcfc15b008f89b67804c86f3368c4de5acba972eaf5acbabadc9d5aaa2bc0::sicilian_vino::recalculate_equilibrium(arg1, arg3);
        arg0.current_equilibrium = 0x7bdcfc15b008f89b67804c86f3368c4de5acba972eaf5acbabadc9d5aaa2bc0::sicilian_vino::equilibrium_value(arg1);
        let v9 = AICycleExecuted{
            cycle_number      : arg0.execution_count,
            equilibrium_value : arg0.current_equilibrium,
            deviation         : v3,
            action            : v4,
            timestamp         : v0,
        };
        0x2::event::emit<AICycleExecuted>(v9);
    }

    public fun execute_micro_trades(arg0: &mut AIGovernor, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.operator, 0);
        assert!(!arg0.is_paused, 3);
        0x2::clock::timestamp_ms(arg3);
        arg0.execution_count = arg0.execution_count + arg1;
    }

    public fun execution_count(arg0: &AIGovernor) : u64 {
        arg0.execution_count
    }

    public fun initialize_ai_governor(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AIGovernor{
            id                    : 0x2::object::new(arg4),
            fractal_reserve       : arg0,
            nine_forms            : arg1,
            triple_ledger         : arg2,
            last_execution_time   : 0x2::tx_context::epoch_timestamp_ms(arg4),
            execution_count       : 0,
            frequency_ms          : 5950,
            current_equilibrium   : 1000000,
            target_equilibrium    : 1000000,
            equilibrium_deviation : 0,
            is_negative_deviation : false,
            peg_defense_enabled   : true,
            defense_threshold     : 50,
            max_defense_per_cycle : 1000000,
            is_active             : true,
            is_paused             : false,
            operator              : arg3,
        };
        0x2::transfer::share_object<AIGovernor>(v0);
    }

    public fun is_active(arg0: &AIGovernor) : bool {
        arg0.is_active
    }

    public fun is_paused(arg0: &AIGovernor) : bool {
        arg0.is_paused
    }

    public fun peg_defense_enabled(arg0: &AIGovernor) : bool {
        arg0.peg_defense_enabled
    }

    public fun set_defense_threshold(arg0: &mut AIGovernor, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.operator, 0);
        arg0.defense_threshold = arg1;
    }

    public fun set_max_defense_per_cycle(arg0: &mut AIGovernor, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.operator, 0);
        arg0.max_defense_per_cycle = arg1;
    }

    public fun target_equilibrium(arg0: &AIGovernor) : u64 {
        arg0.target_equilibrium
    }

    public fun toggle_peg_defense(arg0: &mut AIGovernor, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.operator, 0);
        arg0.peg_defense_enabled = arg1;
    }

    // decompiled from Move bytecode v6
}

