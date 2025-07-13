module 0xdcb7d258698e8c3922b4089950dcdba007aee5f68ba675b5452f6f199430bf1::claude_compliant_atomic_arbitrage {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct AtomicArbitrageExecuted has copy, drop {
        dex_a: vector<u8>,
        dex_b: vector<u8>,
        input_amount: u64,
        intermediate_amount: u64,
        output_amount: u64,
        profit: u64,
        executor: address,
        timestamp: u64,
    }

    public entry fun execute_atomic_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 > 0, 1);
        let v2 = simulate_dex_a_swap(v1);
        assert!(v2 >= arg1, 2);
        let v3 = simulate_dex_b_swap(v2);
        assert!(v3 >= arg2, 2);
        let v4 = if (v3 > v1) {
            v3 - v1
        } else {
            0
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        let v5 = AtomicArbitrageExecuted{
            dex_a               : b"DEX_A",
            dex_b               : b"DEX_B",
            input_amount        : v1,
            intermediate_amount : v2,
            output_amount       : v3,
            profit              : v4,
            executor            : v0,
            timestamp           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg4), v0);
    }

    public entry fun execute_reverse_atomic_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 > 0, 1);
        let v2 = simulate_dex_b_swap_reverse(v1);
        assert!(v2 >= arg1, 2);
        let v3 = simulate_dex_a_swap_reverse(v2);
        assert!(v3 >= arg2, 2);
        let v4 = if (v3 > v1) {
            v3 - v1
        } else {
            0
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        let v5 = AtomicArbitrageExecuted{
            dex_a               : b"DEX_B",
            dex_b               : b"DEX_A",
            input_amount        : v1,
            intermediate_amount : v2,
            output_amount       : v3,
            profit              : v4,
            executor            : v0,
            timestamp           : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AtomicArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg4), v0);
    }

    fun simulate_dex_a_swap(arg0: u64) : u64 {
        arg0 * 1000
    }

    fun simulate_dex_a_swap_reverse(arg0: u64) : u64 {
        arg0 * 998 / 1000000
    }

    fun simulate_dex_b_swap(arg0: u64) : u64 {
        arg0 * 999 / 1000000
    }

    fun simulate_dex_b_swap_reverse(arg0: u64) : u64 {
        arg0 * 1001
    }

    // decompiled from Move bytecode v6
}

