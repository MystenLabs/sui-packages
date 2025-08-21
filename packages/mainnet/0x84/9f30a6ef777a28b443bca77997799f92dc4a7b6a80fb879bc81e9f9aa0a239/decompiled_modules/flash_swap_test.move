module 0x849f30a6ef777a28b443bca77997799f92dc4a7b6a80fb879bc81e9f9aa0a239::flash_swap_test {
    struct FlashLoanEvent has copy, drop {
        amount: u64,
        success: bool,
    }

    struct SwapEvent has copy, drop {
        input_amount: u64,
        output_amount: u64,
        rate: u64,
    }

    struct ArbitrageEvent has copy, drop {
        loan_amount: u64,
        profit: u64,
        success: bool,
    }

    public entry fun run_integration_test(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 1000000000;
        test_flash_loan(v0, arg0);
        test_swap<0x2::sui::SUI, 0x2::sui::SUI>(v0, 105, arg0);
        test_flash_loan_arbitrage<0x2::sui::SUI, 0x2::sui::SUI>(v0, 105, 96, arg0);
    }

    public fun simulate_cetus_swap<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg1 * 99 / 100;
        let v1 = SwapEvent{
            input_amount  : arg1,
            output_amount : v0,
            rate          : 99,
        };
        0x2::event::emit<SwapEvent>(v1);
        v0
    }

    public fun simulate_deepbook_flash_loan(arg0: address, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashLoanEvent{
            amount  : arg2,
            success : true,
        };
        0x2::event::emit<FlashLoanEvent>(v0);
    }

    public fun test_flash_loan(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::coin::zero<0x2::sui::SUI>(arg1));
        let v0 = FlashLoanEvent{
            amount  : arg0,
            success : true,
        };
        0x2::event::emit<FlashLoanEvent>(v0);
    }

    public fun test_flash_loan_arbitrage<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0 * arg1 / 100 * arg2 / 100;
        let v1 = if (v0 > arg0) {
            v0 - arg0
        } else {
            0
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::zero<T0>(arg3), 0x2::tx_context::sender(arg3));
        };
        let v2 = ArbitrageEvent{
            loan_amount : arg0,
            profit      : v1,
            success     : v0 >= arg0,
        };
        0x2::event::emit<ArbitrageEvent>(v2);
    }

    public fun test_swap<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::zero<T1>(arg2), 0x2::tx_context::sender(arg2));
        let v0 = SwapEvent{
            input_amount  : arg0,
            output_amount : arg0 * arg1 / 100,
            rate          : arg1,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

