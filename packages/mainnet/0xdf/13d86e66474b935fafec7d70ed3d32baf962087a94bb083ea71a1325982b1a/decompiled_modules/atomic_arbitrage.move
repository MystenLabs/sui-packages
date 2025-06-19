module 0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::atomic_arbitrage {
    struct RealArbitrageExecuted has copy, drop {
        route: vector<u8>,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        timestamp: u64,
    }

    public entry fun arb_sui_usdc_bluefin(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::dex_bluefin::swap_sui_to_usdc_bluefin(arg0, 0, arg4, arg5);
        let v1 = if (v0 > 1000000) {
            v0 / 100
        } else {
            0
        };
        assert!(v1 >= arg2, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_BLUEFIN",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
        complete_arbitrage(v0, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun arb_sui_usdc_cetus(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::dex_cetus::swap_sui_to_usdc_cetus(arg0, 0, arg4, arg5);
        let v1 = if (v0 > 1000000) {
            v0 / 100
        } else {
            0
        };
        assert!(v1 >= arg2, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_CETUS",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
        complete_arbitrage(v0, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun arb_sui_usdc_deepbook(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::dex_deepbook::swap_sui_to_usdc(arg0, arg1, 0, arg4, arg5);
        let v1 = if (v0 > 1000000) {
            v0 / 100
        } else {
            0
        };
        assert!(v1 >= arg2, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_DEEPBOOK",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
        complete_arbitrage(v0, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun arb_sui_usdc_kriya(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::dex_kriya::swap_sui_to_usdc(arg0, arg1, 0, arg4, arg5);
        let v1 = if (v0 > 1000000) {
            v0 / 100
        } else {
            0
        };
        assert!(v1 >= arg2, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_KRIYA",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
        complete_arbitrage(v0, 0x2::clock::timestamp_ms(arg4));
    }

    public entry fun arb_sui_usdc_real(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        0x2::tx_context::sender(arg6);
        0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::dex_proven::swap_sui_to_usdc_real(arg0, arg1, 0, arg5, arg6);
        let v1 = if (v0 > 1000000) {
            v0 / 100
        } else {
            0
        };
        assert!(v1 >= arg3, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_REAL",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
        complete_arbitrage(v0, 0x2::clock::timestamp_ms(arg5));
    }

    public entry fun arb_sui_usdc_turbos(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg3, 1102);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        0xdf13d86e66474b935fafec7d70ed3d32baf962087a94bb083ea71a1325982b1a::dex_turbos::swap_sui_to_usdc(arg0, arg1, 0, arg4, arg5);
        let v1 = if (v0 > 1000000) {
            v0 / 100
        } else {
            0
        };
        assert!(v1 >= arg2, 1101);
        let v2 = RealArbitrageExecuted{
            route         : b"SUI_USDC_TURBOS",
            input_amount  : v0,
            output_amount : v0 + v1,
            profit        : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RealArbitrageExecuted>(v2);
        complete_arbitrage(v0, 0x2::clock::timestamp_ms(arg4));
    }

    fun complete_arbitrage(arg0: u64, arg1: u64) {
    }

    fun validate_arbitrage_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
    }

    // decompiled from Move bytecode v6
}

