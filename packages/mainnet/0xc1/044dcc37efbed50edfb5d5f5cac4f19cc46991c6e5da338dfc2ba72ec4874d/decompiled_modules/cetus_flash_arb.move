module 0xc1044dcc37efbed50edfb5d5f5cac4f19cc46991c6e5da338dfc2ba72ec4874d::cetus_flash_arb {
    struct FlashArbSuccess has copy, drop {
        user: address,
        borrow_amount: u64,
        final_amount: u64,
        profit: u64,
        path: vector<u8>,
    }

    struct FlashArbFailed has copy, drop {
        reason: vector<u8>,
        borrow_amount: u64,
    }

    public fun calculate_cetus_fee(arg0: u64) : u64 {
        arg0 * 3 / 1000
    }

    public fun calculate_repayment(arg0: u64) : u64 {
        arg0 + calculate_cetus_fee(arg0)
    }

    public entry fun execute_simple_arbitrage<T0, T1>(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 101);
        0x2::tx_context::sender(arg7);
        let v0 = FlashArbFailed{
            reason        : b"Contract needs actual Cetus/Turbos function calls",
            borrow_amount : arg3,
        };
        0x2::event::emit<FlashArbFailed>(v0);
    }

    public fun is_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        let v0 = calculate_repayment(arg0);
        if (arg1 <= v0) {
            return false
        };
        arg1 - v0 >= arg2
    }

    // decompiled from Move bytecode v6
}

