module 0xa55c195ca44686d3e495a14664f2213399522067ba00b1dba367b133ef1c1d25::mev_bot {
    struct MEV_BOT has drop {
        dummy_field: bool,
    }

    struct ArbitrageEvent has copy, drop, store {
        owner: address,
        pool_a: address,
        pool_b: address,
        profit: u64,
        timestamp: u64,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        owner: address,
        pool_a: address,
        pool_b: address,
        min_profit_threshold: u64,
        max_gas_price: u64,
        is_active: bool,
    }

    public entry fun execute_arbitrage(arg0: &mut Config, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 1);
        assert!(arg0.is_active, 1);
        let v1 = ArbitrageEvent{
            owner     : v0,
            pool_a    : arg0.pool_a,
            pool_b    : arg0.pool_b,
            profit    : 0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ArbitrageEvent>(v1);
    }

    fun init(arg0: MEV_BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                   : 0x2::object::new(arg1),
            owner                : @0x0,
            pool_a               : @0x0,
            pool_b               : @0x0,
            min_profit_threshold : 1000,
            max_gas_price        : 1000,
            is_active            : false,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun set_config(arg0: &mut Config, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == @0x0 || arg0.owner == 0x2::tx_context::sender(arg6), 1);
        assert!(arg2 != arg3, 2);
        arg0.owner = arg1;
        arg0.pool_a = arg2;
        arg0.pool_b = arg3;
        arg0.min_profit_threshold = arg4;
        arg0.max_gas_price = arg5;
        arg0.is_active = true;
    }

    public entry fun update_config(arg0: &mut Config, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.min_profit_threshold = arg1;
        arg0.max_gas_price = arg2;
        arg0.is_active = arg3;
    }

    // decompiled from Move bytecode v6
}

