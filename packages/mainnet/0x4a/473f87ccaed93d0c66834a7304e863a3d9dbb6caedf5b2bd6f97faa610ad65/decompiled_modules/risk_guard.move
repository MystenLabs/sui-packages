module 0x4a473f87ccaed93d0c66834a7304e863a3d9dbb6caedf5b2bd6f97faa610ad65::risk_guard {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        max_notional_mist: u64,
        max_slippage_bps: u64,
        min_profit_bps: u64,
    }

    struct LimitsUpdatedEvent has copy, drop {
        admin: address,
        max_notional_mist: u64,
        max_slippage_bps: u64,
        min_profit_bps: u64,
    }

    struct PausedEvent has copy, drop {
        admin: address,
    }

    struct ResumedEvent has copy, drop {
        admin: address,
    }

    struct TradeCheckedEvent has copy, drop {
        requested_notional_mist: u64,
        requested_slippage_bps: u64,
        expected_profit_bps: u64,
        strategy_id: 0x1::string::String,
    }

    public fun admin(arg0: &Config) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &Config, arg1: address) {
        assert!(arg0.admin == arg1, 1);
    }

    public entry fun create_config(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 6);
        assert!(arg1 > 0, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Config{
            id                : 0x2::object::new(arg3),
            admin             : v0,
            paused            : false,
            max_notional_mist : arg0,
            max_slippage_bps  : arg1,
            min_profit_bps    : arg2,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = LimitsUpdatedEvent{
            admin             : v0,
            max_notional_mist : arg0,
            max_slippage_bps  : arg1,
            min_profit_bps    : arg2,
        };
        0x2::event::emit<LimitsUpdatedEvent>(v2);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun max_notional_mist(arg0: &Config) : u64 {
        arg0.max_notional_mist
    }

    public fun max_slippage_bps(arg0: &Config) : u64 {
        arg0.max_slippage_bps
    }

    public fun min_profit_bps(arg0: &Config) : u64 {
        arg0.min_profit_bps
    }

    public entry fun pause(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg1));
        arg0.paused = true;
        let v0 = PausedEvent{admin: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<PausedEvent>(v0);
    }

    public entry fun preflight_check(arg0: &Config, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String) {
        preflight_check_internal(arg0, arg1, arg2, arg3);
        let v0 = TradeCheckedEvent{
            requested_notional_mist : arg1,
            requested_slippage_bps  : arg2,
            expected_profit_bps     : arg3,
            strategy_id             : arg4,
        };
        0x2::event::emit<TradeCheckedEvent>(v0);
    }

    fun preflight_check_internal(arg0: &Config, arg1: u64, arg2: u64, arg3: u64) {
        assert!(!arg0.paused, 2);
        assert!(arg1 <= arg0.max_notional_mist, 3);
        assert!(arg2 <= arg0.max_slippage_bps, 4);
        assert!(arg3 >= arg0.min_profit_bps, 5);
    }

    public entry fun resume(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg1));
        arg0.paused = false;
        let v0 = ResumedEvent{admin: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<ResumedEvent>(v0);
    }

    public entry fun set_limits(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg4));
        set_limits_internal(arg0, arg1, arg2, arg3);
        let v0 = LimitsUpdatedEvent{
            admin             : 0x2::tx_context::sender(arg4),
            max_notional_mist : arg1,
            max_slippage_bps  : arg2,
            min_profit_bps    : arg3,
        };
        0x2::event::emit<LimitsUpdatedEvent>(v0);
    }

    fun set_limits_internal(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 > 0, 6);
        assert!(arg2 > 0, 6);
        arg0.max_notional_mist = arg1;
        arg0.max_slippage_bps = arg2;
        arg0.min_profit_bps = arg3;
    }

    // decompiled from Move bytecode v7
}

