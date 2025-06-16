module 0x7cd4a20b197615a3f40dcb33f733d0cbb9f305ec45bab539b1ad51abacc42c6::flash_arbitrage {
    struct FlashArbitrageExecuted has copy, drop {
        flash_amount: u64,
        profit_amount: u64,
        route_length: u64,
        executor: address,
        success: bool,
    }

    public fun assess_flash_risk(arg0: u64, arg1: &vector<u8>) : bool {
        if (arg0 <= 1000000000000) {
            if (0x1::vector::length<u8>(arg1) >= 2) {
                0x1::vector::length<u8>(arg1) <= 5
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun calculate_arbitrage_profit(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 2) {
            arg0 * 2 / 100
        } else if (arg1 == 3) {
            arg0 * 3 / 100
        } else {
            arg0 * 1 / 100
        }
    }

    public entry fun execute_flash_arbitrage(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 700);
        assert!(arg0 <= 1000000000000, 702);
        assert!(arg1 >= 1000000, 702);
        assert!(0x1::vector::length<u8>(&arg2) >= 2, 705);
        let v0 = 0x1::vector::length<u8>(&arg2);
        let v1 = calculate_arbitrage_profit(arg0, v0);
        assert!(v1 >= arg1, 702);
        let v2 = FlashArbitrageExecuted{
            flash_amount  : arg0,
            profit_amount : v1,
            route_length  : v0,
            executor      : 0x2::tx_context::sender(arg4),
            success       : true,
        };
        0x2::event::emit<FlashArbitrageExecuted>(v2);
    }

    public fun get_max_flash_amount() : u64 {
        1000000000000
    }

    public fun get_min_profit_threshold() : u64 {
        1000000
    }

    // decompiled from Move bytecode v6
}

