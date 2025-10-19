module 0xe06b5ad9c5169a048af818b15a0346f833de7ef67f3950c947b4d46bda132887::flash_loan {
    struct FlashLoanPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_bps: u64,
        total_loans: u64,
        total_fees_earned: u64,
    }

    struct FlashLoanReceipt {
        pool_id: address,
        amount: u64,
        fee: u64,
    }

    struct FlashLoanBorrowed has copy, drop {
        borrower: address,
        amount: u64,
        fee: u64,
    }

    struct FlashLoanRepaid has copy, drop {
        borrower: address,
        amount: u64,
        fee_paid: u64,
    }

    public fun borrow(arg0: &mut FlashLoanPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, FlashLoanReceipt) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 >= arg1, 3);
        assert!(arg1 <= v0, 4);
        let v1 = arg1 * arg0.fee_bps / 10000;
        let v2 = FlashLoanReceipt{
            pool_id : 0x2::object::uid_to_address(&arg0.id),
            amount  : arg1,
            fee     : v1,
        };
        arg0.total_loans = arg0.total_loans + 1;
        let v3 = FlashLoanBorrowed{
            borrower : 0x2::tx_context::sender(arg2),
            amount   : arg1,
            fee      : v1,
        };
        0x2::event::emit<FlashLoanBorrowed>(v3);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), v2)
    }

    public fun deposit(arg0: &mut FlashLoanPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_pool_balance(arg0: &FlashLoanPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_stats(arg0: &FlashLoanPool) : (u64, u64, u64) {
        (arg0.total_loans, arg0.total_fees_earned, arg0.fee_bps)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashLoanPool{
            id                : 0x2::object::new(arg0),
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_bps           : 5,
            total_loans       : 0,
            total_fees_earned : 0,
        };
        0x2::transfer::share_object<FlashLoanPool>(v0);
    }

    public fun repay(arg0: &mut FlashLoanPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: FlashLoanReceipt, arg3: &0x2::tx_context::TxContext) {
        let FlashLoanReceipt {
            pool_id : v0,
            amount  : v1,
            fee     : v2,
        } = arg2;
        assert!(v0 == 0x2::object::uid_to_address(&arg0.id), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1 + v2, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_fees_earned = arg0.total_fees_earned + v2;
        let v3 = FlashLoanRepaid{
            borrower : 0x2::tx_context::sender(arg3),
            amount   : v1,
            fee_paid : v2,
        };
        0x2::event::emit<FlashLoanRepaid>(v3);
    }

    // decompiled from Move bytecode v6
}

