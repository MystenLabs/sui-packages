module 0xec1b1347416d63dce08563ee49316d80878f9e98a3be69833f6cb2416ecee741::hot_potato {
    struct LoanPool has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Loan {
        amount: u64,
    }

    public fun borrow(arg0: &mut LoanPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Loan) {
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.amount), 0);
        let v0 = Loan{amount: arg1};
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.amount, arg1), arg2), v0)
    }

    public fun repay(arg0: &mut LoanPool, arg1: Loan, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let Loan { amount: v0 } = arg1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.amount, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    // decompiled from Move bytecode v6
}

