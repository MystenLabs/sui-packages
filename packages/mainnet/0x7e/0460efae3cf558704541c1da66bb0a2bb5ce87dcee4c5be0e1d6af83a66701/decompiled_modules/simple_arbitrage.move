module 0x7e0460efae3cf558704541c1da66bb0a2bb5ce87dcee4c5be0e1d6af83a66701::simple_arbitrage {
    struct ArbitrageExecuted has copy, drop {
        trader: address,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        success: bool,
    }

    public entry fun execute_flash_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = v0 * 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 * (v2 * 7 / 100 - v2 * 5 / 10000) / v2, arg1));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = ArbitrageExecuted{
            trader     : v1,
            amount_in  : v0,
            amount_out : v3,
            profit     : v3 - v0,
            success    : true,
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    public entry fun execute_multi_dex_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 / 2, arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, v2);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, 0x2::coin::value<0x2::sui::SUI>(&arg0), arg1));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut v2, v0 * 3 / 100, arg1));
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = ArbitrageExecuted{
            trader     : v1,
            amount_in  : v0,
            amount_out : v3,
            profit     : v3 - v0,
            success    : true,
        };
        0x2::event::emit<ArbitrageExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    public entry fun execute_simple_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0 * 5 / 100, arg1));
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v3 = ArbitrageExecuted{
            trader     : v1,
            amount_in  : v0,
            amount_out : v2,
            profit     : v2 - v0,
            success    : true,
        };
        0x2::event::emit<ArbitrageExecuted>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    // decompiled from Move bytecode v6
}

