module 0x4bdcf9574f174552f80898d584dbb12b4575409b996f73318fca5c391dfceef0::market_state {
    struct MarketStatus has copy, drop, store {
        trading_started: bool,
        trading_ended: bool,
        finalized: bool,
    }

    struct MarketState has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        outcome_count: u64,
        outcome_messages: vector<0x1::string::String>,
        status: MarketStatus,
        winning_outcome: 0x1::option::Option<u64>,
        creation_time: u64,
        trading_start: u64,
        trading_end: 0x1::option::Option<u64>,
        finalization_time: 0x1::option::Option<u64>,
    }

    struct TradingStartedEvent has copy, drop {
        market_id: 0x2::object::ID,
        start_time: u64,
    }

    struct TradingEndedEvent has copy, drop {
        market_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct MarketStateFinalizedEvent has copy, drop {
        market_id: 0x2::object::ID,
        winning_outcome: u64,
        timestamp_ms: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : MarketState {
        let v0 = MarketStatus{
            trading_started : false,
            trading_ended   : false,
            finalized       : false,
        };
        MarketState{
            id                : 0x2::object::new(arg5),
            market_id         : arg0,
            dao_id            : arg1,
            outcome_count     : arg2,
            outcome_messages  : arg3,
            status            : v0,
            winning_outcome   : 0x1::option::none<u64>(),
            creation_time     : 0x2::clock::timestamp_ms(arg4),
            trading_start     : 0,
            trading_end       : 0x1::option::none<u64>(),
            finalization_time : 0x1::option::none<u64>(),
        }
    }

    public fun assert_in_trading_or_pre_trading(arg0: &MarketState) {
        assert!(!arg0.status.trading_ended, 3);
        assert!(!arg0.status.finalized, 2);
    }

    public fun assert_market_finalized(arg0: &MarketState) {
        assert!(arg0.status.finalized, 5);
    }

    public fun assert_not_finalized(arg0: &MarketState) {
        assert!(!arg0.status.finalized, 2);
    }

    public fun assert_trading_active(arg0: &MarketState) {
        assert!(arg0.status.trading_started, 6);
        assert!(!arg0.status.trading_ended, 3);
    }

    public fun dao_id(arg0: &MarketState) : 0x2::object::ID {
        arg0.dao_id
    }

    public(friend) fun end_trading(arg0: &mut MarketState, arg1: &0x2::clock::Clock) {
        assert!(arg0.status.trading_started, 6);
        assert!(!arg0.status.trading_ended, 3);
        arg0.status.trading_ended = true;
        let v0 = TradingEndedEvent{
            market_id    : arg0.market_id,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TradingEndedEvent>(v0);
    }

    public(friend) fun finalize(arg0: &mut MarketState, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.status.trading_ended, 4);
        assert!(!arg0.status.finalized, 2);
        assert!(arg1 < arg0.outcome_count, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.status.finalized = true;
        arg0.winning_outcome = 0x1::option::some<u64>(arg1);
        arg0.finalization_time = 0x1::option::some<u64>(v0);
        let v1 = MarketStateFinalizedEvent{
            market_id       : arg0.market_id,
            winning_outcome : arg1,
            timestamp_ms    : v0,
        };
        0x2::event::emit<MarketStateFinalizedEvent>(v1);
    }

    public fun get_creation_time(arg0: &MarketState) : u64 {
        arg0.creation_time
    }

    public fun get_outcome_message(arg0: &MarketState, arg1: u64) : 0x1::string::String {
        assert!(arg1 < arg0.outcome_count, 1);
        *0x1::vector::borrow<0x1::string::String>(&arg0.outcome_messages, arg1)
    }

    public(friend) fun get_trading_end_time(arg0: &MarketState) : 0x1::option::Option<u64> {
        arg0.trading_end
    }

    public fun get_trading_start(arg0: &MarketState) : u64 {
        arg0.trading_start
    }

    public fun get_winning_outcome(arg0: &MarketState) : u64 {
        assert!(arg0.status.finalized, 5);
        *0x1::option::borrow<u64>(&arg0.winning_outcome)
    }

    public fun is_finalized(arg0: &MarketState) : bool {
        arg0.status.finalized
    }

    public fun is_trading_active(arg0: &MarketState) : bool {
        arg0.status.trading_started && !arg0.status.trading_ended
    }

    public fun market_id(arg0: &MarketState) : 0x2::object::ID {
        arg0.market_id
    }

    public fun outcome_count(arg0: &MarketState) : u64 {
        arg0.outcome_count
    }

    public(friend) fun start_trading(arg0: &mut MarketState, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(!arg0.status.trading_started, 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.status.trading_started = true;
        arg0.trading_start = v0;
        arg0.trading_end = 0x1::option::some<u64>(v0 + arg1);
        let v1 = TradingStartedEvent{
            market_id  : arg0.market_id,
            start_time : v0,
        };
        0x2::event::emit<TradingStartedEvent>(v1);
    }

    public fun validate_outcome(arg0: &MarketState, arg1: u64) {
        assert!(arg1 < arg0.outcome_count, 1);
    }

    // decompiled from Move bytecode v6
}

