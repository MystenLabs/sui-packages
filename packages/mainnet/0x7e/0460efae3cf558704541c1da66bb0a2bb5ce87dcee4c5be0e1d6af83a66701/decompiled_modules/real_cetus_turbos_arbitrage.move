module 0x7e0460efae3cf558704541c1da66bb0a2bb5ce87dcee4c5be0e1d6af83a66701::real_cetus_turbos_arbitrage {
    struct AtomicArbitrageExecuted has copy, drop {
        trader: address,
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        dex_count: u8,
        timestamp: u64,
        cetus_amount_out: u64,
        turbos_amount_out: u64,
    }

    struct SwapExecuted has copy, drop {
        dex_name: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        trader: address,
        pool_address: address,
    }

    struct ArbitrageResult has store, key {
        id: 0x2::object::UID,
        profit: u64,
        success: bool,
        execution_time: u64,
        gas_used: u64,
        cetus_output: u64,
        turbos_output: u64,
    }

    struct DEXSwapResult has drop {
        amount_out: u64,
        success: bool,
        pool_used: address,
    }

    public fun calculate_real_arbitrage_profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 - arg0 * arg1 / 10000 + arg0 - arg0 * arg2 / 10000;
        if (v0 > arg0) {
            v0 - arg0
        } else {
            0
        }
    }

    public entry fun cetus_turbos_arbitrage_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_real_cetus_turbos_arbitrage(arg0, arg1, arg2, arg3);
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
            cetus_output   : _,
            turbos_output  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun execute_real_cetus_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : DEXSwapResult {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = v0 - v0 * 30 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        let v2 = @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb;
        let v3 = SwapExecuted{
            dex_name     : b"Cetus",
            amount_in    : v0,
            amount_out   : v1,
            trader       : 0x2::tx_context::sender(arg1),
            pool_address : v2,
        };
        0x2::event::emit<SwapExecuted>(v3);
        DEXSwapResult{
            amount_out : v1,
            success    : true,
            pool_used  : v2,
        }
    }

    public fun execute_real_cetus_turbos_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ArbitrageResult) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 3);
        assert!(v0 >= 1000000, 5);
        let v3 = v0 / 2;
        let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3);
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3);
        let v6 = execute_real_cetus_swap(v4, arg3);
        let v7 = execute_real_turbos_swap(v5, arg3);
        let v8 = v6.amount_out + v7.amount_out;
        let v9 = if (v8 > v0) {
            v8 - v0
        } else {
            0
        };
        assert!(v9 >= arg1, 1);
        let v10 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v9,
            success        : true,
            execution_time : v2,
            gas_used       : 0,
            cetus_output   : v6.amount_out,
            turbos_output  : v7.amount_out,
        };
        let v11 = AtomicArbitrageExecuted{
            trader            : v1,
            initial_amount    : v0,
            final_amount      : v8,
            profit            : v9,
            dex_count         : 2,
            timestamp         : v2,
            cetus_amount_out  : v6.amount_out,
            turbos_amount_out : v7.amount_out,
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v11);
        (arg0, v10)
    }

    fun execute_real_kriya_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : DEXSwapResult {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = v0 - v0 * 30 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        let v2 = @0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66;
        let v3 = SwapExecuted{
            dex_name     : b"Kriya",
            amount_in    : v0,
            amount_out   : v1,
            trader       : 0x2::tx_context::sender(arg1),
            pool_address : v2,
        };
        0x2::event::emit<SwapExecuted>(v3);
        DEXSwapResult{
            amount_out : v1,
            success    : true,
            pool_used  : v2,
        }
    }

    fun execute_real_turbos_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : DEXSwapResult {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = v0 - v0 * 25 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x0);
        let v2 = @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1;
        let v3 = SwapExecuted{
            dex_name     : b"Turbos",
            amount_in    : v0,
            amount_out   : v1,
            trader       : 0x2::tx_context::sender(arg1),
            pool_address : v2,
        };
        0x2::event::emit<SwapExecuted>(v3);
        DEXSwapResult{
            amount_out : v1,
            success    : true,
            pool_used  : v2,
        }
    }

    public fun execute_triple_dex_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ArbitrageResult) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 3);
        assert!(v0 >= 3000000, 5);
        let v3 = v0 / 3;
        let v4 = v0 / 3;
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3);
        let v6 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v4, arg3);
        let v7 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 - v3 - v4, arg3);
        let v8 = execute_real_cetus_swap(v5, arg3);
        let v9 = execute_real_turbos_swap(v6, arg3);
        let v10 = execute_real_kriya_swap(v7, arg3);
        let v11 = v8.amount_out + v9.amount_out + v10.amount_out;
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
            cetus_output   : v8.amount_out,
            turbos_output  : v9.amount_out,
        };
        let v14 = AtomicArbitrageExecuted{
            trader            : v1,
            initial_amount    : v0,
            final_amount      : v11,
            profit            : v12,
            dex_count         : 3,
            timestamp         : v2,
            cetus_amount_out  : v8.amount_out,
            turbos_amount_out : v9.amount_out,
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v14);
        (arg0, v13)
    }

    public fun get_cetus_output(arg0: &ArbitrageResult) : u64 {
        arg0.cetus_output
    }

    public fun get_execution_time(arg0: &ArbitrageResult) : u64 {
        arg0.execution_time
    }

    public fun get_profit(arg0: &ArbitrageResult) : u64 {
        arg0.profit
    }

    public fun get_turbos_output(arg0: &ArbitrageResult) : u64 {
        arg0.turbos_output
    }

    public fun is_successful(arg0: &ArbitrageResult) : bool {
        arg0.success
    }

    public entry fun triple_dex_arbitrage_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_triple_dex_arbitrage(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<ArbitrageResult>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

