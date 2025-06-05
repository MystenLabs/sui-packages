module 0x7795d8413fc70c459b233d087df8024c31b8fe11b0423395abe6f1530315aeab::minimal_aftermath_arbitrage {
    struct AftermathArbitrageExecuted has copy, drop {
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        timestamp: u64,
    }

    public fun execute_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = v0 * 997 / 1000 * 9975 / 10000 * 9995 / 10000;
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        let v3 = AftermathArbitrageExecuted{
            initial_amount : v0,
            final_amount   : v1,
            profit         : v2,
            timestamp      : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AftermathArbitrageExecuted>(v3);
        arg0
    }

    // decompiled from Move bytecode v6
}

