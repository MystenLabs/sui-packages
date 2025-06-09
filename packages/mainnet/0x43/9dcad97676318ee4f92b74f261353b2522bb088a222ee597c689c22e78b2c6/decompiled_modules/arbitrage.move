module 0x439dcad97676318ee4f92b74f261353b2522bb088a222ee597c689c22e78b2c6::arbitrage {
    struct ArbitrageBot has key {
        id: 0x2::object::UID,
        owner: address,
        is_active: bool,
        min_profit_threshold: u64,
        max_gas_price: u64,
        total_profit: u64,
        total_trades: u64,
        last_trade_timestamp: u64,
    }

    struct ArbitrageExecuted has copy, drop {
        timestamp: u64,
        profit: u64,
        gas_cost: u64,
        route: vector<u8>,
    }

    struct PerformanceMetrics has copy, drop {
        dummy_field: bool,
    }

    public fun execute_arbitrage(arg0: &mut ArbitrageBot, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert!(arg2 > 0, 10);
        assert!(arg2 > arg0.min_profit_threshold, 4);
        arg0.total_profit = arg0.total_profit + arg2;
        arg0.total_trades = arg0.total_trades + 1;
        arg0.last_trade_timestamp = 0x2::clock::timestamp_ms(arg3);
        let v0 = ArbitrageExecuted{
            timestamp : 0x2::clock::timestamp_ms(arg3),
            profit    : arg2,
            gas_cost  : 0,
            route     : arg1,
        };
        0x2::event::emit<ArbitrageExecuted>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArbitrageBot{
            id                   : 0x2::object::new(arg0),
            owner                : 0x2::tx_context::sender(arg0),
            is_active            : true,
            min_profit_threshold : 1000,
            max_gas_price        : 1000000,
            total_profit         : 0,
            total_trades         : 0,
            last_trade_timestamp : 0,
        };
        0x2::transfer::share_object<ArbitrageBot>(v0);
    }

    public fun set_active(arg0: &mut ArbitrageBot, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.is_active = arg1;
    }

    public fun update_config(arg0: &mut ArbitrageBot, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.min_profit_threshold = arg1;
        arg0.max_gas_price = arg2;
    }

    // decompiled from Move bytecode v6
}

