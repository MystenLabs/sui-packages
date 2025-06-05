module 0x7795d8413fc70c459b233d087df8024c31b8fe11b0423395abe6f1530315aeab::three_way_aftermath_flowx_bluefin {
    struct ThreeWayArbitrageExecuted has copy, drop {
        initial_amount: u64,
        aftermath_amount: u64,
        flowx_amount: u64,
        final_amount: u64,
        profit: u64,
        timestamp: u64,
    }

    public entry fun execute_three_way_arbitrage_and_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = simulate_aftermath_swap(v0);
        let v2 = simulate_flowx_swap(v1);
        let v3 = simulate_bluefin_swap(v2);
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        let v5 = ThreeWayArbitrageExecuted{
            initial_amount   : v0,
            aftermath_amount : v1,
            flowx_amount     : v2,
            final_amount     : v3,
            profit           : v4,
            timestamp        : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ThreeWayArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    fun simulate_aftermath_swap(arg0: u64) : u64 {
        arg0 * 997 / 1000
    }

    fun simulate_bluefin_swap(arg0: u64) : u64 {
        arg0 * 997 / 1000
    }

    fun simulate_flowx_swap(arg0: u64) : u64 {
        arg0 * 9975 / 10000
    }

    // decompiled from Move bytecode v6
}

