module 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::trade_validator {
    struct BlocklistRegistry has key {
        id: 0x2::object::UID,
        blocked: 0x2::table::Table<address, bool>,
    }

    struct TradeValidated has copy, drop {
        trader: address,
        symbol: vector<u8>,
        direction: u8,
        size: u64,
        notional_value: u64,
    }

    struct BlocklistUpdated has copy, drop {
        addr: address,
        blocked: bool,
    }

    public fun add_to_blocklist(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut BlocklistRegistry, arg2: address) {
        if (!0x2::table::contains<address, bool>(&arg1.blocked, arg2)) {
            0x2::table::add<address, bool>(&mut arg1.blocked, arg2, true);
        };
        let v0 = BlocklistUpdated{
            addr    : arg2,
            blocked : true,
        };
        0x2::event::emit<BlocklistUpdated>(v0);
    }

    public fun assert_trade_allowed(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::GlobalParams, arg1: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::MarketRegistry, arg2: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::BreakerRegistry, arg3: vector<u8>, arg4: bool) {
        assert!(is_trade_allowed(arg0, arg1, arg2, arg3, arg4), 12);
    }

    public fun direction_long() : u8 {
        0
    }

    public fun direction_short() : u8 {
        1
    }

    public fun e_trade_not_allowed() : u64 {
        12
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BlocklistRegistry{
            id      : 0x2::object::new(arg0),
            blocked : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<BlocklistRegistry>(v0);
    }

    public fun is_blocklisted(arg0: &BlocklistRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.blocked, arg1)
    }

    public fun is_trade_allowed(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::GlobalParams, arg1: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::MarketRegistry, arg2: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::BreakerRegistry, arg3: vector<u8>, arg4: bool) : bool {
        if (0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::is_paused(arg0)) {
            return false
        };
        if (!0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_exists(arg1, arg3)) {
            return false
        };
        if (0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_paused(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::borrow_market(arg1, arg3))) {
            return false
        };
        if (0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::breaker_exists(arg2, arg3)) {
            if (0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::is_emergency(arg2, arg3) && !arg4) {
                return false
            };
        };
        true
    }

    public fun remove_from_blocklist(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut BlocklistRegistry, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.blocked, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.blocked, arg2);
        };
        let v0 = BlocklistUpdated{
            addr    : arg2,
            blocked : false,
        };
        0x2::event::emit<BlocklistUpdated>(v0);
    }

    public fun validate_off_hours(arg0: &mut 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::off_hours::OffHoursRegistry, arg1: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::MarketRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        if (!0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::off_hours::config_exists(arg0, arg2)) {
            return
        };
        let v0 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::borrow_market(arg1, arg2);
        0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::off_hours::check_off_hours_rules(arg0, arg2, arg3, arg4, arg5, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::compute_notional_value(arg6, arg7), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_max_leverage(v0), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_total_oi_cap(v0), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_long_oi(v0), 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_short_oi(v0), arg6, arg7, arg8);
    }

    public fun validate_trade(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::GlobalParams, arg1: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::MarketRegistry, arg2: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::BreakerRegistry, arg3: &BlocklistRegistry, arg4: address, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: bool) {
        assert!(arg7 > 0, 9);
        assert!(arg6 == 0 || arg6 == 1, 11);
        assert!(!0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::is_paused(arg0), 0);
        assert!(0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_exists(arg1, arg5), 1);
        let v0 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::borrow_market(arg1, arg5);
        assert!(!0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_paused(v0), 2);
        assert!(!is_blocklisted(arg3, arg4), 3);
        let v1 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::breaker_exists(arg2, arg5) && 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::is_emergency(arg2, arg5);
        if ((0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_session_flag(v0) == 0 || v1) && !arg10) {
            abort 4
        };
        if (arg10) {
            return
        };
        assert!(arg8 > 0, 10);
        let v2 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::compute_notional_value(arg7, arg9);
        assert!(arg8 >= 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::margin_calculator::compute_initial_margin(v2, 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_initial_margin_ratio_bps(v0)), 5);
        assert!((v2 as u128) <= (arg8 as u128) * (0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_max_leverage(v0) as u128), 6);
        let v3 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_long_oi(v0);
        let v4 = 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_short_oi(v0);
        assert!((v3 as u128) + (v4 as u128) + (v2 as u128) <= (0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_total_oi_cap(v0) as u128), 7);
        let v5 = if (0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::breaker_exists(arg2, arg5)) {
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::circuit_breaker::get_effective_n_max(arg2, arg5)
        } else {
            0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::market_factory::market_n_max(v0)
        };
        let (v6, v7) = if (arg6 == 0) {
            ((v3 as u128) + (v2 as u128), (v4 as u128))
        } else {
            ((v3 as u128), (v4 as u128) + (v2 as u128))
        };
        if (v6 > v7 && arg6 == 0) {
            assert!(v6 - v7 <= (v5 as u128), 8);
        } else if (v7 > v6 && arg6 == 1) {
            assert!(v7 - v6 <= (v5 as u128), 8);
        };
        let v8 = TradeValidated{
            trader         : arg4,
            symbol         : arg5,
            direction      : arg6,
            size           : arg7,
            notional_value : v2,
        };
        0x2::event::emit<TradeValidated>(v8);
    }

    // decompiled from Move bytecode v7
}

