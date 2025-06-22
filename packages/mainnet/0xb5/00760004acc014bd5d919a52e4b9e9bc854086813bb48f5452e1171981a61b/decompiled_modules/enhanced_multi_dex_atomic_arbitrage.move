module 0xb500760004acc014bd5d919a52e4b9e9bc854086813bb48f5452e1171981a61b::enhanced_multi_dex_atomic_arbitrage {
    struct EnhancedAtomicArbitrageExecuted has copy, drop {
        dex_a: u8,
        dex_b: u8,
        sui_input: u64,
        usdc_intermediate: u64,
        sui_output: u64,
        profit: u64,
        profit_percentage: u64,
        user: address,
        timestamp: u64,
    }

    public entry fun arb_enhanced_aftermath_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        execute_enhanced_atomic_arbitrage(arg0, 5, 6, arg1, arg2);
    }

    public entry fun arb_enhanced_bluefin_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        execute_enhanced_atomic_arbitrage(arg0, 7, 4, arg1, arg2);
    }

    public entry fun arb_enhanced_flowx_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        execute_enhanced_atomic_arbitrage(arg0, 3, 4, arg1, arg2);
    }

    public entry fun arb_enhanced_flowx_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        execute_enhanced_atomic_arbitrage(arg0, 3, 2, arg1, arg2);
    }

    public entry fun arb_enhanced_turbos_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        execute_enhanced_atomic_arbitrage(arg0, 1, 2, arg1, arg2);
    }

    fun enhanced_dex_a_swap_sui_to_usdc(arg0: u8, arg1: u64) : u64 {
        if (arg0 == 1) {
            arg1 * 25 / 1000
        } else if (arg0 == 3) {
            arg1 * 26 / 1000
        } else if (arg0 == 5) {
            arg1 * 24 / 1000
        } else {
            assert!(arg0 == 7, 1003);
            arg1 * 27 / 1000
        }
    }

    fun enhanced_dex_b_swap_usdc_to_sui(arg0: u8, arg1: u64) : u64 {
        if (arg0 == 2) {
            arg1 * 50
        } else if (arg0 == 4) {
            arg1 * 52
        } else {
            assert!(arg0 == 6, 1003);
            arg1 * 48
        }
    }

    public entry fun execute_enhanced_atomic_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1001);
        assert!(arg1 != arg2, 1003);
        let v1 = enhanced_dex_a_swap_sui_to_usdc(arg1, v0);
        let v2 = enhanced_dex_b_swap_usdc_to_sui(arg2, v1);
        assert!(v2 > v0 + arg3, 1002);
        let v3 = v2 - v0;
        let v4 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v3, arg4);
        0x2::coin::join<0x2::sui::SUI>(&mut v4, arg0);
        let v5 = EnhancedAtomicArbitrageExecuted{
            dex_a             : arg1,
            dex_b             : arg2,
            sui_input         : v0,
            usdc_intermediate : v1,
            sui_output        : v2,
            profit            : v3,
            profit_percentage : v3 * 10000 / v0,
            user              : 0x2::tx_context::sender(arg4),
            timestamp         : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<EnhancedAtomicArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

