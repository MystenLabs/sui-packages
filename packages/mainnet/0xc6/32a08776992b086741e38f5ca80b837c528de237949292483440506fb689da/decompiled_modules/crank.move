module 0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::crank {
    struct ReroutePayload has copy, drop, store {
        vault_id: address,
        from_strategy: u8,
        to_strategy: u8,
        invested_amount_usdc: u64,
        expected_yield_amount: u64,
        apy_improvement_bps: u64,
        break_even_months: u64,
        should_reroute: bool,
        hot_potato_safe: bool,
        timestamp_ms: u64,
    }

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
        tee_public_key: vector<u8>,
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

    struct ConfigUpdatedEvent has copy, drop {
        min_spread_bps: u64,
        min_apy_bps: u64,
        reroute_cooldown_ms: u64,
        max_swap_slippage_bps: u64,
    }

    fun assert_reroute_rules<T0>(arg0: &mut CrankConfig, arg1: &0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::strategy::StrategyRegistry, arg2: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg3: u8, arg4: u8, arg5: ReroutePayload, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::object::id<0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>>(arg2);
        assert!(arg5.vault_id == 0x2::object::id_to_address(&v1), 1007);
        assert!(arg5.from_strategy == arg3, 1008);
        assert!(arg5.to_strategy == arg4, 1008);
        assert!(v0 < arg5.timestamp_ms + 300000, 1009);
        assert!(0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::strategy::count_available(arg1) >= 2, 600);
        assert!(v0 >= arg0.last_reroute_ms + arg0.reroute_cooldown_ms, 1004);
        assert!(arg5.hot_potato_safe, 1010);
        assert!(arg5.should_reroute, 1011);
        assert!(arg5.break_even_months <= 24, 1011);
        arg0.last_reroute_ms = v0;
        let v2 = RerouteValidatedEvent{
            current_strategy : arg3,
            target_strategy  : arg4,
            current_apy      : 0,
            target_apy       : 0,
            spread_bps       : 0,
            timestamp_ms     : v0,
        };
        0x2::event::emit<RerouteValidatedEvent>(v2);
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
            tee_public_key            : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<CrankConfig>(v0);
    }

    public(friend) fun decode_tee_payload(arg0: vector<u8>) : ReroutePayload {
        let v0 = 0x2::bcs::new(arg0);
        ReroutePayload{
            vault_id              : 0x2::bcs::peel_address(&mut v0),
            from_strategy         : 0x2::bcs::peel_u8(&mut v0),
            to_strategy           : 0x2::bcs::peel_u8(&mut v0),
            invested_amount_usdc  : 0x2::bcs::peel_u64(&mut v0),
            expected_yield_amount : 0x2::bcs::peel_u64(&mut v0),
            apy_improvement_bps   : 0x2::bcs::peel_u64(&mut v0),
            break_even_months     : 0x2::bcs::peel_u64(&mut v0),
            should_reroute        : 0x2::bcs::peel_bool(&mut v0),
            hot_potato_safe       : 0x2::bcs::peel_bool(&mut v0),
            timestamp_ms          : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun finish_reroute_with_tee<T0, T1>(arg0: &CrankConfig, arg1: &0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::strategy::StrategyRegistry, arg2: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg3: 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::BorrowReceipt<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>) {
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg0.tee_public_key, &arg6), 1006);
        let v0 = decode_tee_payload(arg6);
        let v1 = 0x2::object::id<0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>>(arg2);
        assert!(v0.vault_id == 0x2::object::id_to_address(&v1), 1007);
        assert!(v0.to_strategy == arg5, 1008);
        assert!(0x2::balance::value<T1>(&arg4) >= v0.expected_yield_amount, 608);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::commit_strategy<T0, T1>(arg2, 0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::strategy::borrow_protocol_access_cap(arg1), arg3, arg4, arg5, v0.invested_amount_usdc);
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

    public fun tee_public_key(arg0: &CrankConfig) : &vector<u8> {
        &arg0.tee_public_key
    }

    public(friend) fun update_config(arg0: &mut CrankConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>) {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_spread(arg1);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_min_apy(arg2);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_cooldown(arg3);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_slippage(arg4, false);
        arg0.min_spread_bps = arg1;
        arg0.min_apy_bps = arg2;
        arg0.reroute_cooldown_ms = arg3;
        arg0.max_swap_slippage_bps = arg4;
        arg0.max_heartbeat_gap_ms = arg5;
        arg0.min_heartbeat_interval_ms = arg6;
        arg0.max_tvl_delta_bps = arg7;
        arg0.tee_public_key = arg8;
        let v0 = ConfigUpdatedEvent{
            min_spread_bps        : arg1,
            min_apy_bps           : arg2,
            reroute_cooldown_ms   : arg3,
            max_swap_slippage_bps : arg4,
        };
        0x2::event::emit<ConfigUpdatedEvent>(v0);
    }

    public(friend) fun update_tee_key(arg0: &mut CrankConfig, arg1: vector<u8>) {
        arg0.tee_public_key = arg1;
    }

    public fun validate_heartbeat<T0>(arg0: &mut CrankConfig, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg2: &0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::strategy::StrategyRegistry, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg0.last_heartbeat_ms >= arg0.min_heartbeat_interval_ms, 606);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::update_heartbeat_tvl<T0>(arg1, arg3, 0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::strategy::borrow_protocol_access_cap(arg2));
        arg0.last_heartbeat_ms = v0;
        let v1 = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::last_heartbeat_tvl<T0>(arg1);
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
        let v6 = HeartbeatEvent{timestamp_ms: v0};
        0x2::event::emit<HeartbeatEvent>(v6);
    }

    public fun validate_reroute<T0>(arg0: &mut CrankConfig, arg1: &0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::apy::ApyRegistry, arg2: &0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::strategy::StrategyRegistry, arg3: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg4: u8, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg0.tee_public_key, &arg6), 1006);
        assert_reroute_rules<T0>(arg0, arg2, arg3, arg4, arg5, decode_tee_payload(arg6), arg8);
    }

    public fun validate_reroute_legacy<T0>(arg0: &mut CrankConfig, arg1: &0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::apy::ApyRegistry, arg2: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::apy::get_total_apy(arg1, arg3);
        let v2 = 0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::apy::get_total_apy(arg1, arg4);
        assert!(v2 > v1, 1001);
        let v3 = if (v1 == 0) {
            10000
        } else {
            (v2 - v1) * 10000 / v1
        };
        assert!(v3 >= arg0.min_spread_bps, 1002);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_spread(v3);
        assert!(v2 >= arg0.min_apy_bps, 1003);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_min_apy(v2);
        let v4 = v0 - arg0.last_reroute_ms;
        assert!(v4 >= arg0.reroute_cooldown_ms, 1004);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_cooldown(v4);
        if (arg3 != 0) {
            0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::apy::assert_not_stale(arg1, arg3, arg5);
        };
        0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::apy::assert_not_stale(arg1, arg4, arg5);
        let (_, v6) = 0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::strategy::decode_strategy(arg4);
        if (v6 == 2) {
            assert!(!0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::is_depeg_active<T0>(arg2), 1005);
        };
        arg0.last_reroute_ms = v0;
        let v7 = RerouteValidatedEvent{
            current_strategy : arg3,
            target_strategy  : arg4,
            current_apy      : v1,
            target_apy       : v2,
            spread_bps       : v3,
            timestamp_ms     : v0,
        };
        0x2::event::emit<RerouteValidatedEvent>(v7);
    }

    public fun withdraw_yield_with_tee<T0, T1>(arg0: &CrankConfig, arg1: &0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::strategy::StrategyRegistry, arg2: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::YieldPromise<T0>) {
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.tee_public_key, &arg3), 1006);
        let v0 = 0x2::bcs::new(arg3);
        let v1 = 0x2::object::id<0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>>(arg2);
        assert!(0x2::bcs::peel_address(&mut v0) == 0x2::object::id_to_address(&v1), 1007);
        assert!(0x2::bcs::peel_u8(&mut v0) == 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::current_strategy<T0>(arg2), 1008);
        assert!(0x2::clock::timestamp_ms(arg5) < 0x2::bcs::peel_u64(&mut v0) + 300000, 1009);
        let v2 = 0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::strategy::borrow_protocol_access_cap(arg1);
        (0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::take_yield_balance<T0, T1>(arg2, v2), 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::issue_yield_promise<T0, T1>(arg2, v2, 0x2::bcs::peel_u64(&mut v0)))
    }

    // decompiled from Move bytecode v6
}

