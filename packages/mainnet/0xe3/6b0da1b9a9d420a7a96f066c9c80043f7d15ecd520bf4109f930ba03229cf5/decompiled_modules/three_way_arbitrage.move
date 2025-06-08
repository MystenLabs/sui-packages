module 0xe36b0da1b9a9d420a7a96f066c9c80043f7d15ecd520bf4109f930ba03229cf5::three_way_arbitrage {
    struct SwapExecuted has copy, drop {
        dex_name: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        pool_address: address,
        trader: address,
    }

    struct ThreeWayArbitrageExecuted has copy, drop {
        trader: address,
        initial_amount: u64,
        dex1_amount_out: u64,
        dex2_amount_out: u64,
        dex3_amount_out: u64,
        final_amount: u64,
        profit: u64,
        timestamp: u64,
    }

    public fun calculate_three_way_profit(arg0: u64) : u64 {
        let v0 = arg0 / 3;
        let v1 = v0 * 999 / 1000 + v0 * 997 / 1000 + v0 * 998 / 1000;
        if (v1 > arg0) {
            v1 - arg0
        } else {
            0
        }
    }

    public entry fun execute_three_way_arbitrage_simulation<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = arg1 / 3;
        let v2 = simulate_swap(v1, 999, 1000, b"Cetus", v0);
        let v3 = simulate_swap(v1, 997, 1000, b"Turbos", v0);
        let v4 = simulate_swap(v1, 998, 1000, b"Kriya", v0);
        let v5 = v2 + v3 + v4;
        let v6 = if (v5 > arg1) {
            v5 - arg1
        } else {
            0
        };
        assert!(v6 >= arg2, 2);
        let v7 = ThreeWayArbitrageExecuted{
            trader          : v0,
            initial_amount  : 0x2::coin::value<T0>(&arg0),
            dex1_amount_out : v2,
            dex2_amount_out : v3,
            dex3_amount_out : v4,
            final_amount    : v5,
            profit          : v6,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ThreeWayArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v0);
    }

    fun simulate_swap(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: address) : u64 {
        let v0 = arg0 * arg1 / arg2;
        let v1 = SwapExecuted{
            dex_name     : arg3,
            amount_in    : arg0,
            amount_out   : v0,
            pool_address : @0x0,
            trader       : arg4,
        };
        0x2::event::emit<SwapExecuted>(v1);
        v0
    }

    public entry fun test_three_way_calculation(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0 / 3;
        let v1 = ThreeWayArbitrageExecuted{
            trader          : 0x2::tx_context::sender(arg1),
            initial_amount  : arg0,
            dex1_amount_out : v0,
            dex2_amount_out : v0,
            dex3_amount_out : v0,
            final_amount    : v0 * 3,
            profit          : 0,
            timestamp       : 0,
        };
        0x2::event::emit<ThreeWayArbitrageExecuted>(v1);
    }

    // decompiled from Move bytecode v6
}

