module 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::debt {
    struct Debt has copy, drop, store {
        amount: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        borrow_index: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
    }

    public fun debt(arg0: &Debt, arg1: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        if (0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::eq(arg1, arg0.borrow_index)) {
            return arg0.amount
        };
        0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul(arg0.amount, arg1), arg0.borrow_index)
    }

    public(friend) fun accrue_interest(arg0: &mut Debt, arg1: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) {
        assert!(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::le(arg0.borrow_index, arg1), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::invariant_borrow_index_incremental());
        if (0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::eq(arg0.borrow_index, arg1)) {
            return
        };
        arg0.amount = debt(arg0, arg1);
        arg0.borrow_index = arg1;
    }

    public fun borrow_index(arg0: &Debt) : &0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        &arg0.borrow_index
    }

    public(friend) fun cleared(arg0: &mut Debt) {
        arg0.amount = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::zero();
    }

    public fun has_debt(arg0: &Debt) : bool {
        !0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::is_zero(&arg0.amount)
    }

    public(friend) fun new(arg0: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg1: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) : Debt {
        Debt{
            amount       : arg0,
            borrow_index : arg1,
        }
    }

    public fun snapshot(arg0: &Debt) : (0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) {
        (arg0.amount, arg0.borrow_index)
    }

    public fun unsafe_debt_amount(arg0: &Debt) : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal {
        arg0.amount
    }

    public(friend) fun unsafe_decrease(arg0: &mut Debt, arg1: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) {
        arg0.amount = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::sub(arg0.amount, arg1);
    }

    public(friend) fun unsafe_increase(arg0: &mut Debt, arg1: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) {
        arg0.amount = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::add(arg0.amount, arg1);
    }

    // decompiled from Move bytecode v6
}

