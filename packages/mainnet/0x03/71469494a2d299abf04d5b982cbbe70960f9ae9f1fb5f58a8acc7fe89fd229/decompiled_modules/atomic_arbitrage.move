module 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::atomic_arbitrage {
    struct AtomicArbitrageExecuted has copy, drop {
        trader: address,
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        timestamp: u64,
        route: vector<u8>,
    }

    struct ArbitrageResult has store, key {
        id: 0x2::object::UID,
        profit: u64,
        success: bool,
        execution_time: u64,
        route: vector<u8>,
    }

    public entry fun arb_cross_dex_simple(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_invalid_amount_error());
        let v3 = v0 * 30 / 10000 + v0 * 25 / 10000;
        if (v3 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg3), @0x0);
        };
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v5 = if (v4 > v0) {
            v4 - v0
        } else {
            0
        };
        assert!(v5 >= arg1, 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_insufficient_profit_error());
        let v6 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v5,
            success        : true,
            execution_time : v2,
            route          : b"Cross-DEX-Simple",
        };
        let v7 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v4,
            profit         : v5,
            timestamp      : v2,
            route          : b"Cross-DEX-Simple",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v6, v1);
    }

    public entry fun arb_sui_usdc_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_invalid_amount_error());
        assert!(v0 >= 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_min_sui_amount(), 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_invalid_amount_error());
        let v3 = v0 * 30 / 10000;
        let v4 = v0 - v3;
        let v5 = v4 * 25 / 10000;
        let v6 = v4 - v5;
        let v7 = if (v6 > v0) {
            v6 - v0
        } else {
            0
        };
        let v8 = v3 + v5;
        if (v8 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v8, arg3), @0x0);
        };
        assert!(v7 >= arg1, 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::constants::get_insufficient_profit_error());
        let v9 = ArbitrageResult{
            id             : 0x2::object::new(arg3),
            profit         : v7,
            success        : true,
            execution_time : v2,
            route          : b"SUI-USDC-SUI",
        };
        let v10 = AtomicArbitrageExecuted{
            trader         : v1,
            initial_amount : v0,
            final_amount   : v6,
            profit         : v7,
            timestamp      : v2,
            route          : b"SUI-USDC-SUI",
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
        0x2::transfer::transfer<ArbitrageResult>(v9, v1);
    }

    // decompiled from Move bytecode v6
}

