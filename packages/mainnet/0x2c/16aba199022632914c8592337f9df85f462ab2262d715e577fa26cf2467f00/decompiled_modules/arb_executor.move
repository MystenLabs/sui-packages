module 0x8a280163ccd8d2e1f897290eb3e7f3cb1c33f4e0f110e5bf15d9cc17f98b3ede::arb_executor {
    struct AdminCap has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct BotConfig has key {
        id: 0x2::object::UID,
        min_profit_bps: u64,
        max_trade_size: u64,
        is_paused: bool,
        admin: address,
        last_updated_ms: u64,
    }

    struct ConfigInitialized has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
        min_profit_bps: u64,
        max_trade_size: u64,
    }

    struct ConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        field_name: vector<u8>,
        new_value: u64,
        timestamp_ms: u64,
    }

    struct BotPaused has copy, drop {
        config_id: 0x2::object::ID,
        paused_at_ms: u64,
        admin: address,
    }

    struct BotUnpaused has copy, drop {
        config_id: 0x2::object::ID,
        unpaused_at_ms: u64,
        admin: address,
    }

    struct TradeValidated has copy, drop {
        config_id: 0x2::object::ID,
        input_amount: u64,
        output_amount: u64,
        profit_amount: u64,
        profit_bps: u64,
    }

    struct TradeValidationFailed has copy, drop {
        config_id: 0x2::object::ID,
        input_amount: u64,
        output_amount: u64,
        reason: vector<u8>,
    }

    public fun emit_trade_validated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = TradeValidated{
            config_id     : arg0,
            input_amount  : arg1,
            output_amount : arg2,
            profit_amount : arg3,
            profit_bps    : arg4,
        };
        0x2::event::emit<TradeValidated>(v0);
    }

    public fun emit_trade_validation_failed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>) {
        let v0 = TradeValidationFailed{
            config_id     : arg0,
            input_amount  : arg1,
            output_amount : arg2,
            reason        : arg3,
        };
        0x2::event::emit<TradeValidationFailed>(v0);
    }

    public fun get_admin(arg0: &BotConfig) : address {
        arg0.admin
    }

    public fun get_last_updated_ms(arg0: &BotConfig) : u64 {
        arg0.last_updated_ms
    }

    public fun get_max_trade_size(arg0: &BotConfig) : u64 {
        arg0.max_trade_size
    }

    public fun get_min_profit_bps(arg0: &BotConfig) : u64 {
        arg0.min_profit_bps
    }

    public fun get_pause_status(arg0: &BotConfig) : bool {
        arg0.is_paused
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{
            id    : 0x2::object::new(arg0),
            admin : v0,
        };
        let v2 = BotConfig{
            id              : 0x2::object::new(arg0),
            min_profit_bps  : 50,
            max_trade_size  : 10000000000000,
            is_paused       : false,
            admin           : v0,
            last_updated_ms : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        let v3 = ConfigInitialized{
            config_id      : 0x2::object::uid_to_inner(&v2.id),
            admin          : v0,
            min_profit_bps : v2.min_profit_bps,
            max_trade_size : v2.max_trade_size,
        };
        0x2::event::emit<ConfigInitialized>(v3);
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0x2::transfer::share_object<BotConfig>(v2);
    }

    public fun is_operational(arg0: &BotConfig) : bool {
        !arg0.is_paused
    }

    public fun pause(arg0: &AdminCap, arg1: &mut BotConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == arg0.admin, 0);
        arg1.is_paused = true;
        arg1.last_updated_ms = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v0 = BotPaused{
            config_id    : 0x2::object::uid_to_inner(&arg1.id),
            paused_at_ms : arg1.last_updated_ms,
            admin        : arg0.admin,
        };
        0x2::event::emit<BotPaused>(v0);
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut BotConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == arg0.admin, 0);
        arg1.is_paused = false;
        arg1.last_updated_ms = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v0 = BotUnpaused{
            config_id      : 0x2::object::uid_to_inner(&arg1.id),
            unpaused_at_ms : arg1.last_updated_ms,
            admin          : arg0.admin,
        };
        0x2::event::emit<BotUnpaused>(v0);
    }

    public fun update_max_trade_size(arg0: &AdminCap, arg1: &mut BotConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == arg0.admin, 0);
        assert!(arg2 > 0, 4);
        arg1.max_trade_size = arg2;
        arg1.last_updated_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            config_id    : 0x2::object::uid_to_inner(&arg1.id),
            field_name   : b"max_trade_size",
            new_value    : arg2,
            timestamp_ms : arg1.last_updated_ms,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun update_min_profit_bps(arg0: &AdminCap, arg1: &mut BotConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == arg0.admin, 0);
        assert!(arg2 > 0 && arg2 < 10000, 4);
        arg1.min_profit_bps = arg2;
        arg1.last_updated_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            config_id    : 0x2::object::uid_to_inner(&arg1.id),
            field_name   : b"min_profit_bps",
            new_value    : arg2,
            timestamp_ms : arg1.last_updated_ms,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun validate_trade(arg0: &BotConfig, arg1: u64, arg2: u64) : (bool, u64, u64, vector<u8>) {
        if (!is_operational(arg0)) {
            return (false, 0, 0, b"bot_paused")
        };
        if (!validate_trade_size(arg0, arg1)) {
            return (false, 0, 0, b"exceeds_max_size")
        };
        let (v0, v1) = verify_profit(arg0, arg1, arg2);
        if (!v0) {
            return (false, 0, v1, b"insufficient_profit")
        };
        (true, arg2 - arg1, v1, b"")
    }

    public fun validate_trade_size(arg0: &BotConfig, arg1: u64) : bool {
        arg1 <= arg0.max_trade_size
    }

    public fun verify_profit(arg0: &BotConfig, arg1: u64, arg2: u64) : (bool, u64) {
        if (arg1 == 0) {
            return (false, 0)
        };
        if (arg2 < arg1) {
            return (false, 0)
        };
        let v0 = ((((arg2 - arg1) as u128) * 10000 / (arg1 as u128)) as u64);
        (v0 >= arg0.min_profit_bps, v0)
    }

    // decompiled from Move bytecode v7
}

