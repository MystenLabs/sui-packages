module 0x785e755b23e21589ff041689940ece21e03d2323f8bc69fed0a3853c3e58965f::production_optimized_atomic_arbitrage {
    struct ArbitrageExecuted has copy, drop {
        dex_pair: u16,
        input: u64,
        output: u64,
        profit: u64,
        efficiency: u16,
    }

    public entry fun arb_aftermath_deepbook_stable(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        execute_optimized_arbitrage(arg0, 1286, arg1, arg2);
    }

    public entry fun arb_bluefin_premium_max(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        execute_optimized_arbitrage(arg0, 1799, arg1, arg2);
    }

    public entry fun arb_flowx_cetus_yield(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        execute_optimized_arbitrage(arg0, 516, arg1, arg2);
    }

    public entry fun arb_flowx_kriya_balanced(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        execute_optimized_arbitrage(arg0, 515, arg1, arg2);
    }

    public entry fun arb_turbos_kriya_max(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        execute_optimized_arbitrage(arg0, 259, arg1, arg2);
    }

    public fun calculate_expected_profit(arg0: u64, arg1: u16) : u64 {
        let v0 = ((arg1 >> 8 & 255) as u8);
        let v1 = ((arg1 & 255) as u8);
        let v2 = if (v0 == 1) {
            arg0 * 25 / 1000
        } else if (v0 == 2) {
            arg0 * 26 / 1000
        } else if (v0 == 7) {
            arg0 * 27 / 1000
        } else {
            arg0 * 24 / 1000
        };
        let v3 = if (v1 == 3) {
            v2 * 50
        } else if (v1 == 4) {
            v2 * 52
        } else if (v1 == 7) {
            v2 * 54
        } else {
            v2 * 46
        };
        if (v3 > arg0) {
            v3 - arg0
        } else {
            0
        }
    }

    public entry fun execute_optimized_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u16, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1001);
        let v1 = ((arg1 >> 8 & 255) as u8);
        let v2 = ((arg1 & 255) as u8);
        assert!(v1 != v2, 1003);
        let v3 = if (v1 == 1) {
            v0 * 25 / 1000
        } else if (v1 == 2) {
            v0 * 26 / 1000
        } else if (v1 == 7) {
            v0 * 27 / 1000
        } else {
            v0 * 24 / 1000
        };
        let v4 = if (v2 == 3) {
            v3 * 50
        } else if (v2 == 4) {
            v3 * 52
        } else if (v2 == 7) {
            v3 * 54
        } else if (v2 == 5) {
            v3 * 48
        } else {
            v3 * 46
        };
        assert!(v4 > v0 + arg2, 1002);
        let v5 = v4 - v0;
        let v6 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v5, arg3);
        0x2::coin::join<0x2::sui::SUI>(&mut v6, arg0);
        let v7 = ArbitrageExecuted{
            dex_pair   : arg1,
            input      : v0,
            output     : v4,
            profit     : v5,
            efficiency : ((v5 * 10000 / v0) as u16),
        };
        0x2::event::emit<ArbitrageExecuted>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, 0x2::tx_context::sender(arg3));
    }

    public fun get_optimal_pair(arg0: u64) : u16 {
        if (arg0 >= 100000000) {
            1799
        } else if (arg0 >= 50000000) {
            516
        } else {
            259
        }
    }

    // decompiled from Move bytecode v6
}

