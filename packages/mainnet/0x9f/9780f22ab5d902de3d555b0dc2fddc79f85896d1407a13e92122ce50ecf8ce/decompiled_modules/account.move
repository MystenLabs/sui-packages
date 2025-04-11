module 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::account {
    struct Account has store {
        lifetime_total_bets: u64,
        lifetime_total_wins: u64,
        debit_balance: u64,
        credit_balance: u64,
    }

    public(friend) fun empty() : Account {
        Account{
            lifetime_total_bets : 0,
            lifetime_total_wins : 0,
            debit_balance       : 0,
            credit_balance      : 0,
        }
    }

    public(friend) fun credit(arg0: &mut Account, arg1: u64) {
        arg0.credit_balance = arg0.credit_balance + arg1;
    }

    public(friend) fun debit(arg0: &mut Account, arg1: u64) {
        arg0.debit_balance = arg0.debit_balance + arg1;
    }

    fun reset_balances(arg0: &mut Account) {
        arg0.credit_balance = 0;
        arg0.debit_balance = 0;
    }

    public(friend) fun settle(arg0: &mut Account) : (u64, u64) {
        let v0 = arg0.credit_balance;
        let v1 = arg0.debit_balance;
        reset_balances(arg0);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

