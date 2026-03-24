module 0x72ea785e8d95a709d959c09af247845df91f0b9faa8da8d498954bc48c60d293::crank {
    struct CrankConfig has key {
        id: 0x2::object::UID,
        min_spread_bps: u64,
        min_apy_bps: u64,
        reroute_cooldown_ms: u64,
        last_reroute_ms: u64,
        max_swap_slippage_bps: u64,
        max_heartbeat_gap_ms: u64,
        min_heartbeat_interval_ms: u64,
        last_heartbeat_ms: u64,
        max_tvl_delta_bps: u64,
    }

    struct RerouteValidatedEvent has copy, drop {
        current_strategy: u8,
        target_strategy: u8,
        current_apy: u64,
        target_apy: u64,
        spread_bps: u64,
        timestamp_ms: u64,
    }

    struct HeartbeatEvent has copy, drop {
        timestamp_ms: u64,
    }

    struct AutoPauseEvent has copy, drop {
        last_heartbeat_ms: u64,
        gap_ms: u64,
    }

    struct AutoUnpauseEvent has copy, drop {
        timestamp_ms: u64,
    }

    struct ConfigUpdatedEvent has copy, drop {
        min_spread_bps: u64,
        min_apy_bps: u64,
        reroute_cooldown_ms: u64,
        max_swap_slippage_bps: u64,
    }

    public fun check_crank_liveness<T0>(arg0: &CrankConfig, arg1: &mut 0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::vault::Vault<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 - arg0.last_heartbeat_ms > arg0.max_heartbeat_gap_ms) {
            if (!0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::vault::is_auto_paused<T0>(arg1)) {
                0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::vault::trigger_auto_pause<T0>(arg1);
                let v1 = AutoPauseEvent{
                    last_heartbeat_ms : arg0.last_heartbeat_ms,
                    gap_ms            : v0 - arg0.last_heartbeat_ms,
                };
                0x2::event::emit<AutoPauseEvent>(v1);
            };
        };
    }

    public fun create_config(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CrankConfig{
            id                        : 0x2::object::new(arg1),
            min_spread_bps            : 50,
            min_apy_bps               : 10,
            reroute_cooldown_ms       : 43200000,
            last_reroute_ms           : 0,
            max_swap_slippage_bps     : 30,
            max_heartbeat_gap_ms      : 21600000,
            min_heartbeat_interval_ms : 300000,
            last_heartbeat_ms         : 0x2::clock::timestamp_ms(arg0),
            max_tvl_delta_bps         : 1000,
        };
        0x2::transfer::share_object<CrankConfig>(v0);
    }

    public fun last_heartbeat_ms(arg0: &CrankConfig) : u64 {
        arg0.last_heartbeat_ms
    }

    public fun last_reroute_ms(arg0: &CrankConfig) : u64 {
        arg0.last_reroute_ms
    }

    public fun max_heartbeat_gap_ms(arg0: &CrankConfig) : u64 {
        arg0.max_heartbeat_gap_ms
    }

    public fun max_swap_slippage_bps(arg0: &CrankConfig) : u64 {
        arg0.max_swap_slippage_bps
    }

    public fun max_tvl_delta_bps(arg0: &CrankConfig) : u64 {
        arg0.max_tvl_delta_bps
    }

    public fun min_apy_bps(arg0: &CrankConfig) : u64 {
        arg0.min_apy_bps
    }

    public fun min_spread_bps(arg0: &CrankConfig) : u64 {
        arg0.min_spread_bps
    }

    public fun reroute_cooldown_ms(arg0: &CrankConfig) : u64 {
        arg0.reroute_cooldown_ms
    }

    public(friend) fun update_config(arg0: &mut CrankConfig, arg1: &0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::vault::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::floors::assert_spread(arg2);
        0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::floors::assert_min_apy(arg3);
        0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::floors::assert_cooldown(arg4);
        0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::floors::assert_slippage(arg5);
        arg0.min_spread_bps = arg2;
        arg0.min_apy_bps = arg3;
        arg0.reroute_cooldown_ms = arg4;
        arg0.max_swap_slippage_bps = arg5;
        arg0.max_heartbeat_gap_ms = arg6;
        arg0.min_heartbeat_interval_ms = arg7;
        arg0.max_tvl_delta_bps = arg8;
        let v0 = ConfigUpdatedEvent{
            min_spread_bps        : arg2,
            min_apy_bps           : arg3,
            reroute_cooldown_ms   : arg4,
            max_swap_slippage_bps : arg5,
        };
        0x2::event::emit<ConfigUpdatedEvent>(v0);
    }

    public fun validate_heartbeat<T0>(arg0: &mut CrankConfig, arg1: &mut 0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::vault::Vault<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg0.last_heartbeat_ms >= arg0.min_heartbeat_interval_ms, 606);
        let v1 = 0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::vault::idle_balance<T0>(arg1) + arg2;
        let v2 = 0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::vault::last_heartbeat_tvl<T0>(arg1);
        if (v2 > 0) {
            let v3 = if (v1 > v2) {
                v1 - v2
            } else {
                v2 - v1
            };
            assert!(v3 <= v2 * arg0.max_tvl_delta_bps / 10000, 609);
        };
        0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::vault::update_heartbeat_tvl<T0>(arg1, arg2);
        arg0.last_heartbeat_ms = v0;
        if (0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::vault::is_auto_paused<T0>(arg1)) {
            0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::vault::trigger_auto_unpause<T0>(arg1);
            let v4 = AutoUnpauseEvent{timestamp_ms: v0};
            0x2::event::emit<AutoUnpauseEvent>(v4);
        };
        let v5 = HeartbeatEvent{timestamp_ms: v0};
        0x2::event::emit<HeartbeatEvent>(v5);
    }

    public fun validate_reroute(arg0: &mut CrankConfig, arg1: &0x72ea785e8d95a709d959c09af247845df91f0b9faa8da8d498954bc48c60d293::apy::ApyRegistry, arg2: &0x72ea785e8d95a709d959c09af247845df91f0b9faa8da8d498954bc48c60d293::strategy::StrategyRegistry, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x72ea785e8d95a709d959c09af247845df91f0b9faa8da8d498954bc48c60d293::strategy::count_available(arg2) >= 2, 600);
        assert!(0x72ea785e8d95a709d959c09af247845df91f0b9faa8da8d498954bc48c60d293::strategy::is_available(arg2, arg4), 601);
        assert!(arg3 != arg4, 602);
        let v1 = 0x72ea785e8d95a709d959c09af247845df91f0b9faa8da8d498954bc48c60d293::apy::get_total_apy(arg1, arg3);
        let v2 = 0x72ea785e8d95a709d959c09af247845df91f0b9faa8da8d498954bc48c60d293::apy::get_total_apy(arg1, arg4);
        assert!(v2 > v1, 607);
        let v3 = if (v1 == 0) {
            10000
        } else {
            (v2 - v1) * 10000 / v1
        };
        assert!(v3 >= arg0.min_spread_bps, 603);
        0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::floors::assert_spread(v3);
        assert!(v2 >= arg0.min_apy_bps, 604);
        0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::floors::assert_min_apy(v2);
        let v4 = v0 - arg0.last_reroute_ms;
        assert!(v4 >= arg0.reroute_cooldown_ms, 605);
        0x2f567f02e37a7e97cf603a7118e3b44f58401d4970cac2dda04d6bc71a25d9f5::floors::assert_cooldown(v4);
        arg0.last_reroute_ms = v0;
        let v5 = RerouteValidatedEvent{
            current_strategy : arg3,
            target_strategy  : arg4,
            current_apy      : v1,
            target_apy       : v2,
            spread_bps       : v3,
            timestamp_ms     : v0,
        };
        0x2::event::emit<RerouteValidatedEvent>(v5);
    }

    // decompiled from Move bytecode v6
}

