module 0x7795d8413fc70c459b233d087df8024c31b8fe11b0423395abe6f1530315aeab::aftermath_flowx_bluefin_arbitrage {
    struct SwapExecuted has copy, drop {
        dex: vector<u8>,
        input_amount: u64,
        output_amount: u64,
        timestamp: u64,
    }

    struct AftermathFlowxBluefinArbitrageExecuted has copy, drop {
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        timestamp: u64,
        gas_used: u64,
    }

    public fun calculate_aftermath_flowx_bluefin_profit(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = test_aftermath_flowx_bluefin_calculation(arg0, arg1, arg2);
        if (v0 > arg0) {
            v0 - arg0
        } else {
            0
        }
    }

    public fun execute_aftermath_flowx_bluefin_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = v0 * 997 / 1000;
        let v3 = SwapExecuted{
            dex           : b"Aftermath",
            input_amount  : v0,
            output_amount : v2,
            timestamp     : v1,
        };
        0x2::event::emit<SwapExecuted>(v3);
        let v4 = v2 * 9975 / 10000;
        let v5 = SwapExecuted{
            dex           : b"FlowX",
            input_amount  : v2,
            output_amount : v4,
            timestamp     : v1,
        };
        0x2::event::emit<SwapExecuted>(v5);
        let v6 = v4 * 9995 / 10000;
        let v7 = SwapExecuted{
            dex           : b"Bluefin",
            input_amount  : v4,
            output_amount : v6,
            timestamp     : v1,
        };
        0x2::event::emit<SwapExecuted>(v7);
        let v8 = if (v6 > v0) {
            v6 - v0
        } else {
            0
        };
        let v9 = AftermathFlowxBluefinArbitrageExecuted{
            initial_amount : v0,
            final_amount   : v6,
            profit         : v8,
            timestamp      : v1,
            gas_used       : 0,
        };
        0x2::event::emit<AftermathFlowxBluefinArbitrageExecuted>(v9);
        arg0
    }

    public fun execute_aftermath_flowx_bluefin_arbitrage_and_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = execute_aftermath_flowx_bluefin_arbitrage(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun test_aftermath_flowx_bluefin_calculation(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0 * 997 / 1000 * 9975 / 10000 * 9995 / 10000;
        let v1 = if (v0 > arg0) {
            v0 - arg0
        } else {
            0
        };
        let v2 = AftermathFlowxBluefinArbitrageExecuted{
            initial_amount : arg0,
            final_amount   : v0,
            profit         : v1,
            timestamp      : 0x2::clock::timestamp_ms(arg1),
            gas_used       : 0,
        };
        0x2::event::emit<AftermathFlowxBluefinArbitrageExecuted>(v2);
        v0
    }

    // decompiled from Move bytecode v6
}

