module 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::crank {
    struct CrankConfig has key {
        id: 0x2::object::UID,
    }

    struct CrankExecutedEvent has copy, drop {
        timestamp_ms: u64,
        current_strategy: u8,
        best_strategy: u8,
        rerouted: bool,
    }

    struct CrankSkippedEvent has copy, drop {
        reason: u8,
        timestamp_ms: u64,
    }

    public fun admin_lock_config(arg0: &0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::vault::AdminCap, arg1: &mut CrankConfig) {
        let v0 = 0x1::string::utf8(b"config_locked");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, bool>(&mut arg1.id, v0) = true;
        } else {
            0x2::dynamic_field::add<0x1::string::String, bool>(&mut arg1.id, v0, true);
        };
    }

    public fun admin_set_cooldown_ms(arg0: &0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::vault::AdminCap, arg1: &mut CrankConfig, arg2: u64) {
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg1.id, 0x1::string::utf8(b"cooldown_ms")) = arg2;
    }

    public fun admin_set_min_apy_bps(arg0: &0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::vault::AdminCap, arg1: &mut CrankConfig, arg2: u64) {
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg1.id, 0x1::string::utf8(b"min_apy_bps")) = arg2;
    }

    public fun admin_set_min_protocols(arg0: &0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::vault::AdminCap, arg1: &mut CrankConfig, arg2: u64) {
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg1.id, 0x1::string::utf8(b"min_protocols")) = arg2;
    }

    public fun admin_set_min_spread_bps(arg0: &0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::vault::AdminCap, arg1: &mut CrankConfig, arg2: u64) {
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg1.id, 0x1::string::utf8(b"min_spread_bps")) = arg2;
    }

    public fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CrankConfig{id: 0x2::object::new(arg0)};
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"min_spread_bps"), 50);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"cooldown_ms"), 14400000);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"min_apy_bps"), 10);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"min_protocols"), 2);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"last_crank_ms"), 0);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"last_reroute_ms"), 0);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"total_cranks"), 0);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v0.id, 0x1::string::utf8(b"total_reroutes"), 0);
        0x2::transfer::share_object<CrankConfig>(v0);
    }

    public fun get_cooldown_ms(arg0: &CrankConfig) : u64 {
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"cooldown_ms"))
    }

    public fun get_last_crank_ms(arg0: &CrankConfig) : u64 {
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"last_crank_ms"))
    }

    public fun get_last_reroute_ms(arg0: &CrankConfig) : u64 {
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"last_reroute_ms"))
    }

    public fun get_min_protocols(arg0: &CrankConfig) : u64 {
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"min_protocols"))
    }

    public fun get_min_spread_bps(arg0: &CrankConfig) : u64 {
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"min_spread_bps"))
    }

    public fun get_total_cranks(arg0: &CrankConfig) : u64 {
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"total_cranks"))
    }

    public fun get_total_reroutes(arg0: &CrankConfig) : u64 {
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"total_reroutes"))
    }

    fun is_config_locked(arg0: &CrankConfig) : bool {
        let v0 = 0x1::string::utf8(b"config_locked");
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0) && *0x2::dynamic_field::borrow<0x1::string::String, bool>(&arg0.id, v0)
    }

    public fun is_cooldown_elapsed(arg0: &CrankConfig, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) - get_last_crank_ms(arg0) >= get_cooldown_ms(arg0)
    }

    public fun record_no_reroute(arg0: &CrankConfig, arg1: u8, arg2: &0x2::clock::Clock) {
        let v0 = CrankExecutedEvent{
            timestamp_ms     : 0x2::clock::timestamp_ms(arg2),
            current_strategy : arg1,
            best_strategy    : arg1,
            rerouted         : false,
        };
        0x2::event::emit<CrankExecutedEvent>(v0);
    }

    public fun set_cooldown_ms(arg0: &mut CrankConfig, arg1: u64) {
        assert!(!is_config_locked(arg0), 403);
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"cooldown_ms")) = arg1;
    }

    public fun set_min_apy_bps(arg0: &mut CrankConfig, arg1: u64) {
        assert!(!is_config_locked(arg0), 403);
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"min_apy_bps")) = arg1;
    }

    public fun set_min_protocols(arg0: &mut CrankConfig, arg1: u64) {
        assert!(!is_config_locked(arg0), 403);
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"min_protocols")) = arg1;
    }

    public fun set_min_spread_bps(arg0: &mut CrankConfig, arg1: u64) {
        assert!(!is_config_locked(arg0), 403);
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"min_spread_bps")) = arg1;
    }

    public fun validate_and_record_crank(arg0: &mut CrankConfig, arg1: &0x2::clock::Clock) {
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"last_crank_ms")) = 0x2::clock::timestamp_ms(arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"total_cranks"));
        *v0 = *v0 + 1;
    }

    public fun validate_reroute(arg0: &mut CrankConfig, arg1: &0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::StrategyRegistry, arg2: u8, arg3: u8, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 - get_last_reroute_ms(arg0) >= get_cooldown_ms(arg0), 400);
        assert!(0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::count_available(arg1) >= get_min_protocols(arg0), 402);
        let (v1, v2) = 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::should_reroute(arg1, arg2, get_min_spread_bps(arg0));
        assert!(v1 && v2 == arg3, 401);
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"last_reroute_ms")) = v0;
        let v3 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"total_reroutes"));
        *v3 = *v3 + 1;
        let v4 = CrankExecutedEvent{
            timestamp_ms     : v0,
            current_strategy : arg2,
            best_strategy    : arg3,
            rerouted         : true,
        };
        0x2::event::emit<CrankExecutedEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

