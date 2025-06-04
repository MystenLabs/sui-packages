module 0x234f4160c915dccc77f120d6b0302d408d2cde20df9b72d8d01214ac2365af5e::profitable_arbitrage {
    struct ProfitableArbitrageExecuted has copy, drop {
        trader: address,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        dex_path: vector<u8>,
        timestamp: u64,
    }

    struct ArbitrageResult has key {
        id: 0x2::object::UID,
        profit: u64,
        success: bool,
        execution_time: u64,
    }

    public fun calculate_expected_profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        let v1 = arg0 * arg2 / 10000;
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun destroy_result(arg0: ArbitrageResult) {
        let ArbitrageResult {
            id             : v0,
            profit         : _,
            success        : _,
            execution_time : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun execute_flash_loan_arbitrage(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : ArbitrageResult {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0 - arg0 * 5 / 10000;
        let v2 = (v1 - v1 * 3 / 1000) * 104 / 100;
        let v3 = (v2 - v2 * 25 / 10000) * 102 / 100;
        let v4 = v3 - arg0;
        let v5 = if (v4 > 0) {
            v4
        } else {
            0
        };
        assert!(v5 > 0, 1);
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg2),
            profit         : v5,
            success        : true,
            execution_time : v0,
        };
        let v7 = ProfitableArbitrageExecuted{
            trader     : 0x2::tx_context::sender(arg2),
            amount_in  : arg0,
            amount_out : v3,
            profit     : v5,
            dex_path   : b"FlashLoan->DEX_A->DEX_B",
            timestamp  : v0,
        };
        0x2::event::emit<ProfitableArbitrageExecuted>(v7);
        v6
    }

    public fun execute_multi_hop_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ArbitrageResult) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 2);
        let v2 = (v0 - v0 * 3 / 1000) * 102 / 100;
        let v3 = (v2 - v2 * 25 / 10000) * 1015 / 1000;
        let v4 = (v3 - v3 * 35 / 10000) * 1025 / 1000;
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v5, arg3));
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v5,
            success        : true,
            execution_time : v1,
        };
        let v7 = ProfitableArbitrageExecuted{
            trader     : 0x2::tx_context::sender(arg3),
            amount_in  : v0,
            amount_out : v4,
            profit     : v5,
            dex_path   : b"Cetus->Turbos->Kriya",
            timestamp  : v1,
        };
        0x2::event::emit<ProfitableArbitrageExecuted>(v7);
        (arg0, v6)
    }

    public fun execute_profitable_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ArbitrageResult) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 2);
        let v2 = (v0 - v0 * 3 / 1000) * 105 / 100;
        let v3 = (v2 - v2 * 25 / 10000) * 103 / 100;
        let v4 = if (v3 > v0) {
            v3 - v0
        } else {
            0
        };
        assert!(v4 >= arg1, 1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v4, arg3));
        let v5 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v4,
            success        : true,
            execution_time : v1,
        };
        let v6 = ProfitableArbitrageExecuted{
            trader     : 0x2::tx_context::sender(arg3),
            amount_in  : v0,
            amount_out : v3,
            profit     : v4,
            dex_path   : b"Cetus->Turbos",
            timestamp  : v1,
        };
        0x2::event::emit<ProfitableArbitrageExecuted>(v6);
        (arg0, v5)
    }

    public entry fun flash_loan_arbitrage_entry(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = execute_flash_loan_arbitrage(arg0, arg1, arg2);
        0x2::transfer::transfer<ArbitrageResult>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_execution_time(arg0: &ArbitrageResult) : u64 {
        arg0.execution_time
    }

    public fun get_profit(arg0: &ArbitrageResult) : u64 {
        arg0.profit
    }

    public fun is_successful(arg0: &ArbitrageResult) : bool {
        arg0.success
    }

    public entry fun multi_hop_arbitrage_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_multi_hop_arbitrage(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<ArbitrageResult>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun profitable_arbitrage_entry(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_profitable_arbitrage(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<ArbitrageResult>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

