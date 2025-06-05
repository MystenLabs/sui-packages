module 0x7795d8413fc70c459b233d087df8024c31b8fe11b0423395abe6f1530315aeab::real_three_way_arbitrage {
    struct RealThreeWayArbitrageExecuted has copy, drop {
        initial_amount: u64,
        aftermath_amount: u64,
        flowx_amount: u64,
        bluefin_amount: u64,
        final_amount: u64,
        profit: u64,
        timestamp: u64,
        route: vector<u8>,
    }

    public entry fun execute_real_three_way_arbitrage_and_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = simulate_aftermath_swap(v0);
        let v2 = simulate_flowx_amm_swap(v1);
        let v3 = simulate_bluefin_amm_swap(v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        let v5 = RealThreeWayArbitrageExecuted{
            initial_amount   : v0,
            aftermath_amount : v1,
            flowx_amount     : v2,
            bluefin_amount   : v3,
            final_amount     : v3,
            profit           : v4,
            timestamp        : 0x2::clock::timestamp_ms(arg1),
            route            : b"Aftermath->FlowX->Bluefin",
        };
        0x2::event::emit<RealThreeWayArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun execute_reverse_three_way_arbitrage_and_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = simulate_bluefin_amm_swap(v0);
        let v2 = simulate_flowx_amm_swap(v1);
        let v3 = simulate_aftermath_swap(v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        let v5 = RealThreeWayArbitrageExecuted{
            initial_amount   : v0,
            aftermath_amount : v3,
            flowx_amount     : v2,
            bluefin_amount   : v1,
            final_amount     : v3,
            profit           : v4,
            timestamp        : 0x2::clock::timestamp_ms(arg1),
            route            : b"Bluefin->FlowX->Aftermath",
        };
        0x2::event::emit<RealThreeWayArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    fun simulate_aftermath_swap(arg0: u64) : u64 {
        arg0 * 997 / 1000
    }

    fun simulate_bluefin_amm_swap(arg0: u64) : u64 {
        arg0 * 997 / 1000
    }

    fun simulate_flowx_amm_swap(arg0: u64) : u64 {
        arg0 * 9975 / 10000
    }

    // decompiled from Move bytecode v6
}

