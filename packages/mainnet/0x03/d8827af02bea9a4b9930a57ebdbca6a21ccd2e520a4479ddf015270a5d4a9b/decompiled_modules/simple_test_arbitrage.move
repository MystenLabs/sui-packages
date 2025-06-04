module 0x3d8827af02bea9a4b9930a57ebdbca6a21ccd2e520a4479ddf015270a5d4a9b::simple_test_arbitrage {
    struct TestArbitrageExecuted has copy, drop {
        executor: address,
        input_amount: u64,
        output_amount: u64,
        buy_dex: u8,
        sell_dex: u8,
        timestamp: u64,
    }

    public fun execute_simple_test(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = TestArbitrageExecuted{
            executor      : v1,
            input_amount  : v0,
            output_amount : v0,
            buy_dex       : arg1,
            sell_dex      : arg2,
            timestamp     : 0,
        };
        0x2::event::emit<TestArbitrageExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v1);
    }

    public fun get_dex_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"Cetus")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Turbos")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Bluefin")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Kriya")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Aftermath")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"FlowX")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"DeepBook")
        } else {
            0x1::string::utf8(b"Unknown")
        }
    }

    // decompiled from Move bytecode v6
}

