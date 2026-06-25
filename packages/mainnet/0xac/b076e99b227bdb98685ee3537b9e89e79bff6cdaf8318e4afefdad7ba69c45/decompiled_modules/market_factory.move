module 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory {
    struct Market has copy, drop, store {
        name: vector<u8>,
        symbol: vector<u8>,
        max_leverage: u64,
        initial_margin_ratio_bps: u64,
        maintenance_margin_ratio_bps: u64,
        total_oi_cap: u64,
        n_max: u64,
        long_oi: u64,
        short_oi: u64,
        session_flag: u8,
        global_funding_index: u64,
        short_borrow_index: u64,
        borrow_rate_bps: u64,
        gap_assumption_bps: u64,
        paused: bool,
    }

    struct MarketRegistry has key {
        id: 0x2::object::UID,
        markets: 0x2::table::Table<vector<u8>, Market>,
        market_count: u64,
    }

    struct MarketCreated has copy, drop {
        symbol: vector<u8>,
        name: vector<u8>,
        max_leverage: u64,
    }

    struct MarketParamsUpdated has copy, drop {
        symbol: vector<u8>,
        max_leverage: u64,
        initial_margin_ratio_bps: u64,
        maintenance_margin_ratio_bps: u64,
        total_oi_cap: u64,
        n_max: u64,
        borrow_rate_bps: u64,
        gap_assumption_bps: u64,
    }

    struct MarketSessionUpdated has copy, drop {
        symbol: vector<u8>,
        session_flag: u8,
    }

    struct MarketPauseToggled has copy, drop {
        symbol: vector<u8>,
        paused: bool,
    }

    public fun borrow_market(arg0: &MarketRegistry, arg1: vector<u8>) : &Market {
        assert!(0x2::table::contains<vector<u8>, Market>(&arg0.markets, arg1), 1);
        0x2::table::borrow<vector<u8>, Market>(&arg0.markets, arg1)
    }

    public fun create_market(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut MarketRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<vector<u8>, Market>(&arg1.markets, arg3), 0);
        assert!(arg4 > 0 && arg4 <= 20, 2);
        assert!(arg5 > 0, 3);
        assert!(arg6 > 0, 3);
        assert!(arg5 >= arg6, 6);
        assert!(arg7 > 0, 7);
        let v0 = Market{
            name                         : arg2,
            symbol                       : arg3,
            max_leverage                 : arg4,
            initial_margin_ratio_bps     : arg5,
            maintenance_margin_ratio_bps : arg6,
            total_oi_cap                 : arg7,
            n_max                        : arg8,
            long_oi                      : 0,
            short_oi                     : 0,
            session_flag                 : 0,
            global_funding_index         : 0,
            short_borrow_index           : 0,
            borrow_rate_bps              : arg9,
            gap_assumption_bps           : arg10,
            paused                       : false,
        };
        0x2::table::add<vector<u8>, Market>(&mut arg1.markets, arg3, v0);
        arg1.market_count = arg1.market_count + 1;
        let v1 = MarketCreated{
            symbol       : arg3,
            name         : arg2,
            max_leverage : arg4,
        };
        0x2::event::emit<MarketCreated>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketRegistry{
            id           : 0x2::object::new(arg0),
            markets      : 0x2::table::new<vector<u8>, Market>(arg0),
            market_count : 0,
        };
        0x2::transfer::share_object<MarketRegistry>(v0);
    }

    public fun market_borrow_rate_bps(arg0: &Market) : u64 {
        arg0.borrow_rate_bps
    }

    public fun market_count(arg0: &MarketRegistry) : u64 {
        arg0.market_count
    }

    public fun market_exists(arg0: &MarketRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, Market>(&arg0.markets, arg1)
    }

    public fun market_gap_assumption_bps(arg0: &Market) : u64 {
        arg0.gap_assumption_bps
    }

    public fun market_global_funding_index(arg0: &Market) : u64 {
        arg0.global_funding_index
    }

    public fun market_initial_margin_ratio_bps(arg0: &Market) : u64 {
        arg0.initial_margin_ratio_bps
    }

    public fun market_long_oi(arg0: &Market) : u64 {
        arg0.long_oi
    }

    public fun market_maintenance_margin_ratio_bps(arg0: &Market) : u64 {
        arg0.maintenance_margin_ratio_bps
    }

    public fun market_max_leverage(arg0: &Market) : u64 {
        arg0.max_leverage
    }

    public fun market_n_max(arg0: &Market) : u64 {
        arg0.n_max
    }

    public fun market_name(arg0: &Market) : vector<u8> {
        arg0.name
    }

    public fun market_paused(arg0: &Market) : bool {
        arg0.paused
    }

    public fun market_session_flag(arg0: &Market) : u8 {
        arg0.session_flag
    }

    public fun market_short_borrow_index(arg0: &Market) : u64 {
        arg0.short_borrow_index
    }

    public fun market_short_oi(arg0: &Market) : u64 {
        arg0.short_oi
    }

    public fun market_symbol(arg0: &Market) : vector<u8> {
        arg0.symbol
    }

    public fun market_total_oi(arg0: &Market) : u64 {
        arg0.long_oi + arg0.short_oi
    }

    public fun market_total_oi_cap(arg0: &Market) : u64 {
        arg0.total_oi_cap
    }

    public fun session_closed() : u8 {
        0
    }

    public fun session_open() : u8 {
        1
    }

    public(friend) fun set_global_funding_index(arg0: &mut MarketRegistry, arg1: vector<u8>, arg2: u64) {
        0x2::table::borrow_mut<vector<u8>, Market>(&mut arg0.markets, arg1).global_funding_index = arg2;
    }

    public(friend) fun set_long_oi(arg0: &mut MarketRegistry, arg1: vector<u8>, arg2: u64) {
        0x2::table::borrow_mut<vector<u8>, Market>(&mut arg0.markets, arg1).long_oi = arg2;
    }

    public(friend) fun set_n_max(arg0: &mut MarketRegistry, arg1: vector<u8>, arg2: u64) {
        0x2::table::borrow_mut<vector<u8>, Market>(&mut arg0.markets, arg1).n_max = arg2;
    }

    public fun set_paused(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut MarketRegistry, arg2: vector<u8>, arg3: bool) {
        assert!(0x2::table::contains<vector<u8>, Market>(&arg1.markets, arg2), 1);
        0x2::table::borrow_mut<vector<u8>, Market>(&mut arg1.markets, arg2).paused = arg3;
        let v0 = MarketPauseToggled{
            symbol : arg2,
            paused : arg3,
        };
        0x2::event::emit<MarketPauseToggled>(v0);
    }

    public fun set_session_flag(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut MarketRegistry, arg2: vector<u8>, arg3: u8) {
        assert!(0x2::table::contains<vector<u8>, Market>(&arg1.markets, arg2), 1);
        assert!(arg3 == 0 || arg3 == 1, 4);
        0x2::table::borrow_mut<vector<u8>, Market>(&mut arg1.markets, arg2).session_flag = arg3;
        let v0 = MarketSessionUpdated{
            symbol       : arg2,
            session_flag : arg3,
        };
        0x2::event::emit<MarketSessionUpdated>(v0);
    }

    public(friend) fun set_short_borrow_index(arg0: &mut MarketRegistry, arg1: vector<u8>, arg2: u64) {
        0x2::table::borrow_mut<vector<u8>, Market>(&mut arg0.markets, arg1).short_borrow_index = arg2;
    }

    public(friend) fun set_short_oi(arg0: &mut MarketRegistry, arg1: vector<u8>, arg2: u64) {
        0x2::table::borrow_mut<vector<u8>, Market>(&mut arg0.markets, arg1).short_oi = arg2;
    }

    public(friend) fun set_total_oi_cap(arg0: &mut MarketRegistry, arg1: vector<u8>, arg2: u64) {
        assert!(arg2 > 0, 7);
        0x2::table::borrow_mut<vector<u8>, Market>(&mut arg0.markets, arg1).total_oi_cap = arg2;
    }

    public fun update_market_params(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut MarketRegistry, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(0x2::table::contains<vector<u8>, Market>(&arg1.markets, arg2), 1);
        assert!(arg3 > 0 && arg3 <= 20, 2);
        assert!(arg4 > 0, 3);
        assert!(arg5 > 0, 3);
        assert!(arg4 >= arg5, 6);
        assert!(arg6 > 0, 7);
        let v0 = 0x2::table::borrow_mut<vector<u8>, Market>(&mut arg1.markets, arg2);
        v0.max_leverage = arg3;
        v0.initial_margin_ratio_bps = arg4;
        v0.maintenance_margin_ratio_bps = arg5;
        v0.total_oi_cap = arg6;
        v0.n_max = arg7;
        v0.borrow_rate_bps = arg8;
        v0.gap_assumption_bps = arg9;
        let v1 = MarketParamsUpdated{
            symbol                       : arg2,
            max_leverage                 : arg3,
            initial_margin_ratio_bps     : arg4,
            maintenance_margin_ratio_bps : arg5,
            total_oi_cap                 : arg6,
            n_max                        : arg7,
            borrow_rate_bps              : arg8,
            gap_assumption_bps           : arg9,
        };
        0x2::event::emit<MarketParamsUpdated>(v1);
    }

    public fun update_total_oi_cap(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::admin_config::AdminCap, arg1: &mut MarketRegistry, arg2: vector<u8>, arg3: u64) {
        assert!(0x2::table::contains<vector<u8>, Market>(&arg1.markets, arg2), 1);
        assert!(arg3 > 0, 7);
        let v0 = 0x2::table::borrow_mut<vector<u8>, Market>(&mut arg1.markets, arg2);
        v0.total_oi_cap = arg3;
        let v1 = MarketParamsUpdated{
            symbol                       : arg2,
            max_leverage                 : v0.max_leverage,
            initial_margin_ratio_bps     : v0.initial_margin_ratio_bps,
            maintenance_margin_ratio_bps : v0.maintenance_margin_ratio_bps,
            total_oi_cap                 : arg3,
            n_max                        : v0.n_max,
            borrow_rate_bps              : v0.borrow_rate_bps,
            gap_assumption_bps           : v0.gap_assumption_bps,
        };
        0x2::event::emit<MarketParamsUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

