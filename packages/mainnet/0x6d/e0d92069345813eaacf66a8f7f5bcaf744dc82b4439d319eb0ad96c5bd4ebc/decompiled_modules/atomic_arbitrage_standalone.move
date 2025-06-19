module 0x6de0d92069345813eaacf66a8f7f5bcaf744dc82b4439d319eb0ad96c5bd4ebc::atomic_arbitrage_standalone {
    struct RealArbitrageExecuted has copy, drop {
        route: vector<u8>,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        timestamp: u64,
    }

    public entry fun arb_sui_usdc_aftermath(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        calculate_min_output(v0, 500);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        let v1 = calculate_arbitrage_profit(v0);
        assert!(v1 >= arg2, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_AFTERMATH_STANDALONE",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
    }

    public entry fun arb_sui_usdc_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        calculate_min_output(v0, 500);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        let v1 = calculate_arbitrage_profit(v0);
        assert!(v1 >= arg2, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_BLUEFIN_STANDALONE",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
    }

    public entry fun arb_sui_usdc_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        calculate_min_output(v0, 500);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        let v1 = calculate_arbitrage_profit(v0);
        assert!(v1 >= arg2, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_CETUS_STANDALONE",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
    }

    public entry fun arb_sui_usdc_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        calculate_min_output(v0, 500);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        let v1 = calculate_arbitrage_profit(v0);
        assert!(v1 >= arg2, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_DEEPBOOK_STANDALONE",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
    }

    public entry fun arb_sui_usdc_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        calculate_min_output(v0, 500);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        let v1 = calculate_arbitrage_profit(v0);
        assert!(v1 >= arg2, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_KRIYA_STANDALONE",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
    }

    public entry fun arb_sui_usdc_real(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        calculate_min_output(v0, 500);
        let v1 = calculate_arbitrage_profit(v0);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        assert!(arg3 > 0, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_REAL_STANDALONE",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
    }

    public entry fun arb_sui_usdc_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        calculate_min_output(v0, 500);
        0x2::transfer::public_freeze_object<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        let v1 = calculate_arbitrage_profit(v0);
        assert!(v1 >= arg2, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_TURBOS_STANDALONE",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
    }

    fun calculate_arbitrage_profit(arg0: u64) : u64 {
        let v0 = if (arg0 > 1000000) {
            2
        } else {
            1
        };
        arg0 / 1000 * v0
    }

    public fun calculate_min_output(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0, 1104);
        arg0 * (10000 - arg1) / 10000
    }

    // decompiled from Move bytecode v6
}

