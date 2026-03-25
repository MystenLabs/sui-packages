module 0x23359544a5019e58ef45bedc8ea3e403d9165ce3426d2cc008609c19a6c3d59d::crank {
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

    public fun check_crank_liveness<T0>(arg0: &CrankConfig, arg1: &mut 0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::Vault<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 - arg0.last_heartbeat_ms > arg0.max_heartbeat_gap_ms) {
            if (!0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::is_auto_paused<T0>(arg1)) {
                0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::trigger_auto_pause<T0>(arg1);
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

    public(friend) fun update_config(arg0: &mut CrankConfig, arg1: &0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::floors::assert_spread(arg2);
        0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::floors::assert_min_apy(arg3);
        0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::floors::assert_cooldown(arg4);
        0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::floors::assert_slippage(arg5);
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

    public fun validate_heartbeat<T0>(arg0: &mut CrankConfig, arg1: &mut 0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::Vault<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg0.last_heartbeat_ms >= arg0.min_heartbeat_interval_ms, 606);
        0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::update_heartbeat_tvl<T0>(arg1, arg2);
        arg0.last_heartbeat_ms = v0;
        let v1 = 0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::last_heartbeat_tvl<T0>(arg1);
        let v2 = 0x1::string::utf8(b"tvl_baseline");
        let v3 = 0x1::string::utf8(b"tvl_baseline_ms");
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v2)) {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, v2, v1);
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, v3, v0);
        } else if (v0 - *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v3) > 86400000) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, v2) = v1;
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, v3) = v0;
        } else {
            let v4 = *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v2);
            if (v4 > 0) {
                let v5 = if (v1 > v4) {
                    v1 - v4
                } else {
                    v4 - v1
                };
                assert!((((v5 as u128) * 10000 / (v4 as u128)) as u64) <= 5000, 610);
            };
        };
        if (0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::is_auto_paused<T0>(arg1)) {
            0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::trigger_auto_unpause<T0>(arg1);
            let v6 = AutoUnpauseEvent{timestamp_ms: v0};
            0x2::event::emit<AutoUnpauseEvent>(v6);
        };
        let v7 = HeartbeatEvent{timestamp_ms: v0};
        0x2::event::emit<HeartbeatEvent>(v7);
    }

    public fun validate_reroute(arg0: &mut CrankConfig, arg1: &0x23359544a5019e58ef45bedc8ea3e403d9165ce3426d2cc008609c19a6c3d59d::apy::ApyRegistry, arg2: &0x23359544a5019e58ef45bedc8ea3e403d9165ce3426d2cc008609c19a6c3d59d::strategy::StrategyRegistry, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x23359544a5019e58ef45bedc8ea3e403d9165ce3426d2cc008609c19a6c3d59d::strategy::count_available(arg2) >= 2, 600);
        assert!(0x23359544a5019e58ef45bedc8ea3e403d9165ce3426d2cc008609c19a6c3d59d::strategy::is_available(arg2, arg4), 601);
        assert!(arg3 != arg4, 602);
        let v1 = 0x23359544a5019e58ef45bedc8ea3e403d9165ce3426d2cc008609c19a6c3d59d::apy::get_total_apy(arg1, arg3);
        let v2 = 0x23359544a5019e58ef45bedc8ea3e403d9165ce3426d2cc008609c19a6c3d59d::apy::get_total_apy(arg1, arg4);
        assert!(v2 > v1, 607);
        let v3 = if (v1 == 0) {
            10000
        } else {
            (v2 - v1) * 10000 / v1
        };
        assert!(v3 >= arg0.min_spread_bps, 603);
        0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::floors::assert_spread(v3);
        assert!(v2 >= arg0.min_apy_bps, 604);
        0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::floors::assert_min_apy(v2);
        let v4 = v0 - arg0.last_reroute_ms;
        assert!(v4 >= arg0.reroute_cooldown_ms, 605);
        0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::floors::assert_cooldown(v4);
        if (arg3 != 0) {
            0x23359544a5019e58ef45bedc8ea3e403d9165ce3426d2cc008609c19a6c3d59d::apy::assert_not_stale(arg1, arg3, arg5);
        };
        0x23359544a5019e58ef45bedc8ea3e403d9165ce3426d2cc008609c19a6c3d59d::apy::assert_not_stale(arg1, arg4, arg5);
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

