module 0xd495c3353f8c03dd75514f78a2852fcd1862a199b7b2227d0da0f4aa4102f9f2::atomic_arbitrage {
    struct AtomicSwapExecuted has copy, drop {
        trader: address,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        dex_count: u8,
        timestamp: u64,
    }

    struct MultiDEXArbitrageCompleted has copy, drop {
        trader: address,
        initial_amount: u64,
        final_amount: u64,
        net_profit: u64,
        gas_used: u64,
        execution_time: u64,
    }

    struct ArbitrageResult has key {
        id: 0x2::object::UID,
        profit: u64,
        success: bool,
        execution_time: u64,
    }

    public entry fun atomic_sui_arbitrage_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_atomic_sui_arbitrage(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<ArbitrageResult>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun calculate_arbitrage_profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 - arg0 * arg1 / 10000;
        let v1 = v0 - v0 * arg2 / 10000;
        if (v1 > arg0) {
            v1 - arg0
        } else {
            0
        }
    }

    public fun destroy_result(arg0: ArbitrageResult) {
        let ArbitrageResult {
            id             : v0,
            profit         : _,
            success        : _,
            execution_time : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun execute_atomic_sui_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ArbitrageResult) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 3);
        let v3 = v0 / 2;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = v3 - v3 * 3 / 1000 + v4 - v4 * 25 / 10000;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v4, arg3));
        let v6 = if (v5 > v0) {
            v5 - v0
        } else {
            0
        };
        assert!(v6 >= arg1, 1);
        let v7 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v6,
            success        : true,
            execution_time : v2,
        };
        let v8 = AtomicSwapExecuted{
            trader     : v1,
            amount_in  : v0,
            amount_out : v5,
            profit     : v6,
            dex_count  : 2,
            timestamp  : v2,
        };
        0x2::event::emit<AtomicSwapExecuted>(v8);
        let v9 = MultiDEXArbitrageCompleted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v5,
            net_profit     : v6,
            gas_used       : 0,
            execution_time : v2,
        };
        0x2::event::emit<MultiDEXArbitrageCompleted>(v9);
        (arg0, v7)
    }

    public fun execute_flash_arbitrage(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : ArbitrageResult {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0 - arg0 * 3 / 1000;
        let v2 = v1 - v1 * 25 / 10000;
        let v3 = if (v2 > arg0) {
            v2 - arg0
        } else {
            0
        };
        let v4 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v3,
            success        : v3 > 0,
            execution_time : v0,
        };
        let v5 = MultiDEXArbitrageCompleted{
            trader         : 0x2::tx_context::sender(arg2),
            initial_amount : arg0,
            final_amount   : v2,
            net_profit     : v3,
            gas_used       : 0,
            execution_time : v0,
        };
        0x2::event::emit<MultiDEXArbitrageCompleted>(v5);
        v4
    }

    public fun execute_three_way_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ArbitrageResult) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 3);
        let v2 = v0 / 3;
        let v3 = v0 / 3;
        let v4 = v0 - v2 - v3;
        let v5 = v2 - v2 * 3 / 1000 + v3 - v3 * 25 / 10000 + v4 - v4 * 35 / 10000;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v4, arg3));
        let v6 = if (v5 > v0) {
            v5 - v0
        } else {
            0
        };
        assert!(v6 >= arg1, 1);
        let v7 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v6,
            success        : true,
            execution_time : v1,
        };
        let v8 = AtomicSwapExecuted{
            trader     : 0x2::tx_context::sender(arg3),
            amount_in  : v0,
            amount_out : v5,
            profit     : v6,
            dex_count  : 3,
            timestamp  : v1,
        };
        0x2::event::emit<AtomicSwapExecuted>(v8);
        (arg0, v7)
    }

    public entry fun flash_arbitrage_entry(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = execute_flash_arbitrage(arg0, arg1, arg2);
        0x2::transfer::transfer<ArbitrageResult>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_execution_time(arg0: &ArbitrageResult) : u64 {
        arg0.execution_time
    }

    public fun get_profit(arg0: &ArbitrageResult) : u64 {
        arg0.profit
    }

    public fun is_successful(arg0: &ArbitrageResult) : bool {
        arg0.success
    }

    public entry fun three_way_arbitrage_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_three_way_arbitrage(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<ArbitrageResult>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

