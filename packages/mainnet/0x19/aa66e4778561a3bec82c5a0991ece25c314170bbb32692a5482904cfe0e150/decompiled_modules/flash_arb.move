module 0x19aa66e4778561a3bec82c5a0991ece25c314170bbb32692a5482904cfe0e150::flash_arb {
    struct FlashArbExecuted has copy, drop {
        path: vector<u8>,
        borrow_amount: u64,
        repay_amount: u64,
        profit: u64,
        user: address,
    }

    struct ArbFailed has copy, drop {
        reason: vector<u8>,
        borrow_amount: u64,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        borrow_amount: u64,
        fee_amount: u64,
    }

    public fun calculate_fee(arg0: u64) : u64 {
        arg0 * 3 / 1000
    }

    public fun calculate_repayment(arg0: u64) : u64 {
        arg0 + calculate_fee(arg0)
    }

    public entry fun execute_flash_arbitrage<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 101);
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2) = simulate_flash_borrow<T0, T1>(arg0);
        let v3 = v2;
        let (v4, _) = simulate_arbitrage_swaps<T0, T1>(v1, arg0, arg2);
        let v6 = FlashArbExecuted{
            path          : b"FLASH_ARB",
            borrow_amount : arg0,
            repay_amount  : arg0 + receipt_fee_amount<T0, T1>(&v3),
            profit        : repay_flash_loan<T0, T1>(v4, v3, arg0, arg1),
            user          : v0,
        };
        0x2::event::emit<FlashArbExecuted>(v6);
    }

    public fun is_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        let v0 = calculate_repayment(arg0);
        let v1 = if (arg1 > v0) {
            arg1 - v0
        } else {
            0
        };
        v1 >= arg2
    }

    fun receipt_fee_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.fee_amount
    }

    fun repay_flash_loan<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: FlashSwapReceipt<T0, T1>, arg2: u64, arg3: u64) : u64 {
        let FlashSwapReceipt {
            borrow_amount : v0,
            fee_amount    : v1,
        } = arg1;
        let v2 = v0 + v1;
        let v3 = 0x2::balance::value<T0>(&arg0);
        assert!(v3 >= v2, 100);
        let v4 = if (v3 > v2) {
            v3 - v2
        } else {
            0
        };
        assert!(v4 >= arg3, 103);
        0x2::balance::destroy_zero<T0>(arg0);
        v4
    }

    fun simulate_arbitrage_swaps<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        0x2::balance::destroy_zero<T0>(arg0);
        (0x2::balance::zero<T0>(), arg1 + arg1 * 1 / 100)
    }

    fun simulate_flash_borrow<T0, T1>(arg0: u64) : (0x2::balance::Balance<T0>, FlashSwapReceipt<T0, T1>) {
        let v0 = FlashSwapReceipt<T0, T1>{
            borrow_amount : arg0,
            fee_amount    : arg0 * 3 / 1000,
        };
        (0x2::balance::zero<T0>(), v0)
    }

    // decompiled from Move bytecode v6
}

