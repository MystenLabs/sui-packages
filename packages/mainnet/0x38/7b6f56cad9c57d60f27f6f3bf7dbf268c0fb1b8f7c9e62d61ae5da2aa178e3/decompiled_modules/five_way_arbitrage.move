module 0x387b6f56cad9c57d60f27f6f3bf7dbf268c0fb1b8f7c9e62d61ae5da2aa178e3::five_way_arbitrage {
    struct SwapExecuted has copy, drop {
        dex_name: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        timestamp: u64,
    }

    struct FiveWayArbitrageExecuted has copy, drop {
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        gas_used: u64,
        timestamp: u64,
        dex_sequence: vector<vector<u8>>,
    }

    public fun calculate_best_arbitrage_path(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (u64, vector<vector<u8>>) {
        (calculate_five_way_profit(arg0, arg1, arg2), vector[b"Cetus", b"Turbos", b"Kriya", b"Aftermath", b"Bluefin"])
    }

    public fun calculate_five_way_profit(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = simulate_bluefin_swap(simulate_aftermath_swap(simulate_kriya_swap(simulate_turbos_swap(simulate_cetus_swap(arg0)))));
        let v1 = if (v0 > arg0) {
            v0 - arg0
        } else {
            0
        };
        let v2 = FiveWayArbitrageExecuted{
            initial_amount : arg0,
            final_amount   : v0,
            profit         : v1,
            gas_used       : 0,
            timestamp      : 0x2::clock::timestamp_ms(arg1),
            dex_sequence   : vector[b"Cetus", b"Turbos", b"Kriya", b"Aftermath", b"Bluefin"],
        };
        0x2::event::emit<FiveWayArbitrageExecuted>(v2);
        v0
    }

    public fun execute_five_way_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = v0 / 5;
        let v3 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2);
        let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2);
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2);
        let v6 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2);
        let v7 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v2, arg2);
        let v8 = simulate_cetus_swap_with_coin(v3, arg2);
        let v9 = simulate_turbos_swap_with_coin(v4, arg2);
        let v10 = simulate_kriya_swap_with_coin(v5, arg2);
        let v11 = simulate_aftermath_swap_with_coin(v6, arg2);
        0x2::coin::join<0x2::sui::SUI>(&mut v8, v9);
        0x2::coin::join<0x2::sui::SUI>(&mut v8, v10);
        0x2::coin::join<0x2::sui::SUI>(&mut v8, v11);
        0x2::coin::join<0x2::sui::SUI>(&mut v8, simulate_bluefin_swap_with_coin(v7, arg2));
        0x2::coin::join<0x2::sui::SUI>(&mut v8, arg0);
        let v12 = 0x2::coin::value<0x2::sui::SUI>(&v8);
        let v13 = SwapExecuted{
            dex_name   : b"Cetus",
            amount_in  : v2,
            amount_out : simulate_cetus_swap(v2),
            timestamp  : v1,
        };
        0x2::event::emit<SwapExecuted>(v13);
        let v14 = SwapExecuted{
            dex_name   : b"Turbos",
            amount_in  : v2,
            amount_out : simulate_turbos_swap(v2),
            timestamp  : v1,
        };
        0x2::event::emit<SwapExecuted>(v14);
        let v15 = SwapExecuted{
            dex_name   : b"Kriya",
            amount_in  : v2,
            amount_out : simulate_kriya_swap(v2),
            timestamp  : v1,
        };
        0x2::event::emit<SwapExecuted>(v15);
        let v16 = SwapExecuted{
            dex_name   : b"Aftermath",
            amount_in  : v2,
            amount_out : simulate_aftermath_swap(v2),
            timestamp  : v1,
        };
        0x2::event::emit<SwapExecuted>(v16);
        let v17 = SwapExecuted{
            dex_name   : b"Bluefin",
            amount_in  : v2,
            amount_out : simulate_bluefin_swap(v2),
            timestamp  : v1,
        };
        0x2::event::emit<SwapExecuted>(v17);
        let v18 = if (v12 > v0) {
            v12 - v0
        } else {
            0
        };
        let v19 = FiveWayArbitrageExecuted{
            initial_amount : v0,
            final_amount   : v12,
            profit         : v18,
            gas_used       : 0,
            timestamp      : v1,
            dex_sequence   : vector[b"Cetus", b"Turbos", b"Kriya", b"Aftermath", b"Bluefin"],
        };
        0x2::event::emit<FiveWayArbitrageExecuted>(v19);
        v8
    }

    public fun execute_five_way_arbitrage_and_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = execute_five_way_arbitrage(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun execute_optimized_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::value<0x2::sui::SUI>(&arg0);
        execute_five_way_arbitrage(arg0, arg1, arg2)
    }

    public fun simulate_aftermath_swap(arg0: u64) : u64 {
        arg0 * 997 / 1000
    }

    fun simulate_aftermath_swap_with_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = simulate_aftermath_swap(v0);
        if (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 - v1, arg1), @0x0);
        };
        arg0
    }

    public fun simulate_bluefin_swap(arg0: u64) : u64 {
        arg0 * 999 / 1000
    }

    fun simulate_bluefin_swap_with_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = simulate_bluefin_swap(v0);
        if (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 - v1, arg1), @0x0);
        };
        arg0
    }

    public fun simulate_cetus_swap(arg0: u64) : u64 {
        arg0 * 997 / 1000
    }

    fun simulate_cetus_swap_with_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = simulate_cetus_swap(v0);
        if (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 - v1, arg1), @0x0);
        };
        arg0
    }

    public fun simulate_kriya_swap(arg0: u64) : u64 {
        arg0 * 998 / 1000
    }

    fun simulate_kriya_swap_with_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = simulate_kriya_swap(v0);
        if (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 - v1, arg1), @0x0);
        };
        arg0
    }

    public fun simulate_turbos_swap(arg0: u64) : u64 {
        arg0 * 9975 / 10000
    }

    fun simulate_turbos_swap_with_coin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = simulate_turbos_swap(v0);
        if (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 - v1, arg1), @0x0);
        };
        arg0
    }

    public fun test_five_way_calculation(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        calculate_five_way_profit(arg0, arg1, arg2)
    }

    public fun test_five_way_execution(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        execute_five_way_arbitrage(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

