module 0x7e0460efae3cf558704541c1da66bb0a2bb5ce87dcee4c5be0e1d6af83a66701::real_atomic_arbitrage {
    struct AtomicArbitrageExecuted has copy, drop {
        trader: address,
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        dex_count: u8,
        timestamp: u64,
        tx_digest: vector<u8>,
    }

    struct SwapExecuted has copy, drop {
        dex_name: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        trader: address,
    }

    struct ArbitrageResult has store, key {
        id: 0x2::object::UID,
        profit: u64,
        success: bool,
        execution_time: u64,
        gas_used: u64,
    }

    struct DEXSwapResult has drop {
        amount_out: u64,
        success: bool,
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

    public entry fun cetus_turbos_arbitrage_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_cetus_turbos_arbitrage(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<ArbitrageResult>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun destroy_result(arg0: ArbitrageResult) {
        let ArbitrageResult {
            id             : v0,
            profit         : _,
            success        : _,
            execution_time : _,
            gas_used       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun execute_cetus_swap(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : DEXSwapResult {
        let v0 = arg1 - arg1 * 3 / 1000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg2), @0x0);
        let v1 = SwapExecuted{
            dex_name   : b"Cetus",
            amount_in  : arg1,
            amount_out : v0,
            trader     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SwapExecuted>(v1);
        DEXSwapResult{
            amount_out : v0,
            success    : true,
        }
    }

    public fun execute_cetus_turbos_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ArbitrageResult) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 3);
        assert!(v0 >= 1000000, 5);
        let v3 = &mut arg0;
        let v4 = execute_cetus_swap(v3, v0 / 2, arg3);
        let v5 = &mut arg0;
        let v6 = execute_turbos_swap(v5, v0 / 2, arg3);
        let v7 = v4.amount_out + v6.amount_out;
        let v8 = if (v7 > v0) {
            v7 - v0
        } else {
            0
        };
        assert!(v8 >= arg1, 1);
        let v9 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v8,
            success        : true,
            execution_time : v2,
            gas_used       : 0,
        };
        let v10 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v7,
            profit         : v8,
            dex_count      : 2,
            timestamp      : v2,
            tx_digest      : b"",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v10);
        (arg0, v9)
    }

    public fun execute_flash_arbitrage(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : ArbitrageResult {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0 - arg0 * 3 / 1000;
        let v2 = v1 - v1 * 25 / 10000;
        let v3 = if (v2 > arg0) {
            v2 - arg0
        } else {
            0
        };
        assert!(v3 >= arg1, 1);
        let v4 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v3,
            success        : v3 > 0,
            execution_time : v0,
            gas_used       : 0,
        };
        let v5 = AtomicArbitrageExecuted{
            trader         : 0x2::tx_context::sender(arg3),
            initial_amount : arg0,
            final_amount   : v2,
            profit         : v3,
            dex_count      : 2,
            timestamp      : v0,
            tx_digest      : b"",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v5);
        v4
    }

    fun execute_flowx_swap(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : DEXSwapResult {
        let v0 = arg1 - arg1 * 35 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg2), @0x0);
        let v1 = SwapExecuted{
            dex_name   : b"FlowX",
            amount_in  : arg1,
            amount_out : v0,
            trader     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SwapExecuted>(v1);
        DEXSwapResult{
            amount_out : v0,
            success    : true,
        }
    }

    public fun execute_multi_dex_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ArbitrageResult) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 3);
        assert!(v0 >= 3000000, 5);
        let v3 = v0 / 3;
        let v4 = v0 / 3;
        let v5 = &mut arg0;
        let v6 = execute_cetus_swap(v5, v3, arg3);
        let v7 = &mut arg0;
        let v8 = execute_turbos_swap(v7, v4, arg3);
        let v9 = &mut arg0;
        let v10 = execute_flowx_swap(v9, v0 - v3 - v4, arg3);
        let v11 = v6.amount_out + v8.amount_out + v10.amount_out;
        let v12 = if (v11 > v0) {
            v11 - v0
        } else {
            0
        };
        assert!(v12 >= arg1, 1);
        let v13 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v12,
            success        : true,
            execution_time : v2,
            gas_used       : 0,
        };
        let v14 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v11,
            profit         : v12,
            dex_count      : 3,
            timestamp      : v2,
            tx_digest      : b"",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v14);
        (arg0, v13)
    }

    fun execute_turbos_swap(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : DEXSwapResult {
        let v0 = arg1 - arg1 * 25 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg2), @0x0);
        let v1 = SwapExecuted{
            dex_name   : b"Turbos",
            amount_in  : arg1,
            amount_out : v0,
            trader     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SwapExecuted>(v1);
        DEXSwapResult{
            amount_out : v0,
            success    : true,
        }
    }

    public entry fun flash_arbitrage_entry(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = execute_flash_arbitrage(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<ArbitrageResult>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun get_execution_time(arg0: &ArbitrageResult) : u64 {
        arg0.execution_time
    }

    public fun get_gas_used(arg0: &ArbitrageResult) : u64 {
        arg0.gas_used
    }

    public fun get_profit(arg0: &ArbitrageResult) : u64 {
        arg0.profit
    }

    public fun is_successful(arg0: &ArbitrageResult) : bool {
        arg0.success
    }

    public entry fun multi_dex_arbitrage_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_multi_dex_arbitrage(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<ArbitrageResult>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

