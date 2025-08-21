module 0x849f30a6ef777a28b443bca77997799f92dc4a7b6a80fb879bc81e9f9aa0a239::simple_test {
    struct SimpleFlashLoan<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        fee: u64,
        borrower: address,
    }

    struct FlashLoanCreated has copy, drop {
        loan_amount: u64,
        fee: u64,
        borrower: address,
    }

    struct FlashLoanRepaid has copy, drop {
        repaid_amount: u64,
        borrower: address,
    }

    struct SwapExecuted has copy, drop {
        amount_in: u64,
        amount_out: u64,
        trader: address,
    }

    public fun calculate_test_profit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, bool) {
        let v0 = arg0 * arg1 / 100 * arg2 / 100;
        let v1 = arg0 + arg0 * arg3 / 1000;
        if (v0 >= v1) {
            (v0 - v1, true)
        } else {
            (0, false)
        }
    }

    public fun get_loan_details<T0>(arg0: &SimpleFlashLoan<T0>) : (u64, u64, address) {
        (arg0.amount, arg0.fee, arg0.borrower)
    }

    public fun test_flash_loan<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SimpleFlashLoan<T0>) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = arg0 * 1 / 1000;
        let v2 = SimpleFlashLoan<T0>{
            id       : 0x2::object::new(arg1),
            amount   : arg0,
            fee      : v1,
            borrower : v0,
        };
        let v3 = FlashLoanCreated{
            loan_amount : arg0,
            fee         : v1,
            borrower    : v0,
        };
        0x2::event::emit<FlashLoanCreated>(v3);
        (0x2::coin::zero<T0>(arg1), v2)
    }

    public fun test_only_flash_loan(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = test_flash_loan<0x2::sui::SUI>(arg0, arg1);
        test_repay_flash_loan<0x2::sui::SUI>(v1, v0, arg1);
    }

    public fun test_only_swap(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::zero<0x2::sui::SUI>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(test_swap<0x2::sui::SUI, 0x2::sui::SUI>(v1, arg1, arg2), v0);
    }

    public fun test_repay_flash_loan<T0>(arg0: SimpleFlashLoan<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let SimpleFlashLoan {
            id       : v0,
            amount   : v1,
            fee      : v2,
            borrower : v3,
        } = arg0;
        let v4 = 0x2::coin::value<T0>(&arg1);
        assert!(v4 >= v1 + v2, 2);
        let v5 = FlashLoanRepaid{
            repaid_amount : v4,
            borrower      : v3,
        };
        0x2::event::emit<FlashLoanRepaid>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        0x2::object::delete(v0);
    }

    public fun test_simple_arbitrage<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg3);
        let (v0, v1) = test_flash_loan<T0>(arg0, arg3);
        let v2 = v1;
        let v3 = test_swap<T0, T1>(v0, arg1, arg3);
        let v4 = test_swap<T1, T0>(v3, arg2, arg3);
        let v5 = v2.amount + v2.fee;
        if (0x2::coin::value<T0>(&v4) >= v5) {
            let v6 = 0x2::coin::split<T0>(&mut v4, v5, arg3);
            test_repay_flash_loan<T0>(v2, v6, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg3));
        } else {
            test_repay_flash_loan<T0>(v2, v4, arg3);
        };
    }

    public fun test_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = SwapExecuted{
            amount_in  : v0,
            amount_out : v0 * arg1 / 100,
            trader     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SwapExecuted>(v1);
        0x2::coin::destroy_zero<T0>(arg0);
        0x2::coin::zero<T1>(arg2)
    }

    // decompiled from Move bytecode v6
}

