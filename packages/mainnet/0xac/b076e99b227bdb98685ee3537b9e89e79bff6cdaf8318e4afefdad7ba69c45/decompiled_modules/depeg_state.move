module 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::depeg_state {
    struct DepegStateConfig has store {
        warn_threshold_1e8: u64,
        reduce_threshold_1e8: u64,
        halt_threshold_1e8: u64,
        normal_threshold_1e8: u64,
        sustain_ms: u64,
    }

    struct DepegStateMachine has key {
        id: 0x2::object::UID,
        state: u8,
        state_entered_at_ms: u64,
        condition_first_seen_at_ms: u64,
        tracked_bucket: u8,
        last_tick_at_ms: u64,
        config: DepegStateConfig,
    }

    struct DepegStateTransition has copy, drop {
        from_state: u8,
        to_state: u8,
        at_ms: u64,
        price_1e8: u64,
    }

    struct DepegConfigUpdated has copy, drop {
        warn_threshold_1e8: u64,
        reduce_threshold_1e8: u64,
        halt_threshold_1e8: u64,
        normal_threshold_1e8: u64,
        sustain_ms: u64,
    }

    fun bucket_to_state(arg0: u8) : u8 {
        if (arg0 == 1) {
            0
        } else if (arg0 == 3) {
            1
        } else if (arg0 == 4) {
            2
        } else if (arg0 == 5) {
            3
        } else {
            0
        }
    }

    fun classify_bucket(arg0: u64, arg1: &DepegStateConfig) : u8 {
        if (arg0 >= arg1.normal_threshold_1e8) {
            1
        } else if (arg0 >= arg1.warn_threshold_1e8) {
            2
        } else if (arg0 >= arg1.reduce_threshold_1e8) {
            3
        } else if (arg0 >= arg1.halt_threshold_1e8) {
            4
        } else {
            5
        }
    }

    public fun current_state(arg0: &DepegStateMachine) : u8 {
        arg0.state
    }

    public fun halt_threshold_1e8(arg0: &DepegStateMachine) : u64 {
        arg0.config.halt_threshold_1e8
    }

    public fun init_depeg_state(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DepegStateConfig{
            warn_threshold_1e8   : 98000000,
            reduce_threshold_1e8 : 95000000,
            halt_threshold_1e8   : 90000000,
            normal_threshold_1e8 : 99500000,
            sustain_ms           : 300000,
        };
        let v1 = DepegStateMachine{
            id                         : 0x2::object::new(arg2),
            state                      : 0,
            state_entered_at_ms        : 0x2::clock::timestamp_ms(arg1),
            condition_first_seen_at_ms : 0,
            tracked_bucket             : 0,
            last_tick_at_ms            : 0,
            config                     : v0,
        };
        0x2::transfer::share_object<DepegStateMachine>(v1);
    }

    public fun is_normal(arg0: &DepegStateMachine) : bool {
        arg0.state == 0
    }

    public fun is_order_entry_allowed(arg0: &DepegStateMachine, arg1: bool) : bool {
        arg0.state == 3 && false || arg0.state == 2 && arg1 || true
    }

    public fun is_reduce_only(arg0: &DepegStateMachine) : bool {
        arg0.state == 2
    }

    public fun is_warn(arg0: &DepegStateMachine) : bool {
        arg0.state == 1
    }

    public fun is_withdrawal_allowed(arg0: &DepegStateMachine) : bool {
        arg0.state != 3
    }

    public fun is_withdrawal_only(arg0: &DepegStateMachine) : bool {
        arg0.state == 3
    }

    public fun normal_threshold_1e8(arg0: &DepegStateMachine) : u64 {
        arg0.config.normal_threshold_1e8
    }

    public fun reduce_threshold_1e8(arg0: &DepegStateMachine) : u64 {
        arg0.config.reduce_threshold_1e8
    }

    public fun state_entered_at_ms(arg0: &DepegStateMachine) : u64 {
        arg0.state_entered_at_ms
    }

    public fun state_normal() : u8 {
        0
    }

    public fun state_reduce_only() : u8 {
        2
    }

    public fun state_warn() : u8 {
        1
    }

    public fun state_withdrawal_only() : u8 {
        3
    }

    public fun sustain_ms(arg0: &DepegStateMachine) : u64 {
        arg0.config.sustain_ms
    }

    public fun tick(arg0: &mut DepegStateMachine, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::depeg_oracle::DepegOracle, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.last_tick_at_ms != 0) {
            assert!(v0 >= arg0.last_tick_at_ms + 1000, 3);
        };
        let v1 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::depeg_oracle::try_read_usdc_px(arg1, arg2);
        if (0x1::option::is_none<u64>(&v1)) {
            arg0.last_tick_at_ms = v0;
            return
        };
        let v2 = *0x1::option::borrow<u64>(&v1);
        let v3 = classify_bucket(v2, &arg0.config);
        if (v3 == 2) {
            arg0.tracked_bucket = v3;
            arg0.condition_first_seen_at_ms = v0;
            arg0.last_tick_at_ms = v0;
            return
        };
        if (v3 != arg0.tracked_bucket) {
            arg0.tracked_bucket = v3;
            arg0.condition_first_seen_at_ms = v0;
            arg0.last_tick_at_ms = v0;
            return
        };
        if (v0 - arg0.condition_first_seen_at_ms >= arg0.config.sustain_ms) {
            let v4 = bucket_to_state(v3);
            if (v4 != arg0.state) {
                arg0.state = v4;
                arg0.state_entered_at_ms = v0;
                let v5 = DepegStateTransition{
                    from_state : arg0.state,
                    to_state   : v4,
                    at_ms      : v0,
                    price_1e8  : v2,
                };
                0x2::event::emit<DepegStateTransition>(v5);
            };
        };
        arg0.last_tick_at_ms = v0;
    }

    public fun update_config(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut DepegStateMachine, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg4 > 0, 1);
        assert!(arg4 < arg3, 1);
        assert!(arg3 < arg2, 1);
        assert!(arg2 < arg5, 1);
        assert!(arg5 <= 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::depeg_oracle::price_scale(), 1);
        assert!(arg6 > 0, 2);
        arg1.config.warn_threshold_1e8 = arg2;
        arg1.config.reduce_threshold_1e8 = arg3;
        arg1.config.halt_threshold_1e8 = arg4;
        arg1.config.normal_threshold_1e8 = arg5;
        arg1.config.sustain_ms = arg6;
        let v0 = DepegConfigUpdated{
            warn_threshold_1e8   : arg2,
            reduce_threshold_1e8 : arg3,
            halt_threshold_1e8   : arg4,
            normal_threshold_1e8 : arg5,
            sustain_ms           : arg6,
        };
        0x2::event::emit<DepegConfigUpdated>(v0);
    }

    public fun warn_threshold_1e8(arg0: &DepegStateMachine) : u64 {
        arg0.config.warn_threshold_1e8
    }

    // decompiled from Move bytecode v7
}

