module 0x3f2acaa391de809ef9c2686cc16bf484c530da43be3291d718250504dfe2b7e0::simple_cetus_turbos_arbitrage {
    struct AtomicArbitrageExecuted has copy, drop {
        trader: address,
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
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

    public fun calculate_simple_arbitrage_profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 / 2;
        let v1 = v0 - v0 * arg1 / 10000 + v0 - v0 * arg2 / 10000;
        if (v1 > arg0) {
            v1 - arg0
        } else {
            0
        }
    }

    public fun execute_simple_cetus_turbos_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ArbitrageResult) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 3);
        assert!(v0 >= 1000000, 5);
        let v3 = v0 / 2;
        let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3);
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v7 = v6 - v6 * 30 / 10000;
        let v8 = 0x2::coin::split<0x2::sui::SUI>(&mut v4, v7, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, @0x0);
        let v9 = SwapExecuted{
            dex_name     : b"Cetus",
            amount_in    : v6,
            amount_out   : v7,
            trader       : v1,
            pool_address : @0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb,
        };
        0x2::event::emit<SwapExecuted>(v9);
        let v10 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        let v11 = v10 - v10 * 25 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, @0x0);
        let v12 = SwapExecuted{
            dex_name     : b"Turbos",
            amount_in    : v10,
            amount_out   : v11,
            trader       : v1,
            pool_address : @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1,
        };
        0x2::event::emit<SwapExecuted>(v12);
        0x2::coin::join<0x2::sui::SUI>(&mut v8, 0x2::coin::split<0x2::sui::SUI>(&mut v5, v11, arg3));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, v8);
        let v13 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v14 = if (v13 > v0) {
            v13 - v0
        } else {
            0
        };
        assert!(v14 >= arg1, 1);
        let v15 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v14,
            success        : true,
            execution_time : v2,
            gas_used       : 0,
            cetus_output   : v7,
            turbos_output  : v11,
        };
        let v16 = AtomicArbitrageExecuted{
            trader            : v1,
            initial_amount    : v0,
            final_amount      : v13,
            profit            : v14,
            timestamp         : v2,
            cetus_amount_out  : v7,
            turbos_amount_out : v11,
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v16);
        (arg0, v15)
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

    public fun get_success(arg0: &ArbitrageResult) : bool {
        arg0.success
    }

    public fun get_turbos_output(arg0: &ArbitrageResult) : u64 {
        arg0.turbos_output
    }

    public entry fun simple_cetus_turbos_arbitrage_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_simple_cetus_turbos_arbitrage(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<ArbitrageResult>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

