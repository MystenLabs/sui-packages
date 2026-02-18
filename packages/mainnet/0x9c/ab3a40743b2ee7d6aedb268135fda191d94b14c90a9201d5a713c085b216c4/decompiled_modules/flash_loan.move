module 0x9cab3a40743b2ee7d6aedb268135fda191d94b14c90a9201d5a713c085b216c4::flash_loan {
    struct FlashLender has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_bps: u64,
    }

    struct LoanReceipt {
        amount: u64,
        fee: u64,
    }

    struct LoanTaken has copy, drop {
        borrower: address,
        amount: u64,
        fee: u64,
    }

    public fun borrow(arg0: &mut FlashLender, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, LoanReceipt) {
        let v0 = arg1 * arg0.fee_bps / 10000;
        let v1 = LoanTaken{
            borrower : 0x2::tx_context::sender(arg2),
            amount   : arg1,
            fee      : v0,
        };
        0x2::event::emit<LoanTaken>(v1);
        let v2 = LoanReceipt{
            amount : arg1,
            fee    : v0,
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), v2)
    }

    public fun create_lender(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashLender{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            fee_bps : 5,
        };
        0x2::transfer::share_object<FlashLender>(v0);
    }

    public fun repay(arg0: &mut FlashLender, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: LoanReceipt) {
        let LoanReceipt {
            amount : v0,
            fee    : v1,
        } = arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0 + v1, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    // decompiled from Move bytecode v6
}

