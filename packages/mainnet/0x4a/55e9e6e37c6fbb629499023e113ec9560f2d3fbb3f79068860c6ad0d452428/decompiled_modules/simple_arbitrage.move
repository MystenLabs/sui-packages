module 0x4a55e9e6e37c6fbb629499023e113ec9560f2d3fbb3f79068860c6ad0d452428::simple_arbitrage {
    struct ArbitrageExecuted has copy, drop {
        trader: address,
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
    }

    public entry fun simple_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = ArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v0,
            profit         : v0 / 100,
        };
        0x2::event::emit<ArbitrageExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    public entry fun test_function(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

