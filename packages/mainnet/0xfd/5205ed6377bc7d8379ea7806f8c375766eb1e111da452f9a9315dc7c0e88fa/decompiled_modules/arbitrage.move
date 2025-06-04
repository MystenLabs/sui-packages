module 0xfd5205ed6377bc7d8379ea7806f8c375766eb1e111da452f9a9315dc7c0e88fa::arbitrage {
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

    public fun execute_arbitrage_and_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(execute_arbitrage(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

