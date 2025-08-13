module 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::debt {
    struct Debt has copy, drop, store {
        amount: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal,
        borrow_index: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal,
    }

    public fun debt(arg0: &Debt, arg1: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal) : 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        if (0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::eq(arg1, arg0.borrow_index)) {
            return arg0.amount
        };
        0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::div(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::mul(arg0.amount, arg1), arg0.borrow_index)
    }

    public(friend) fun accrue_interest(arg0: &mut Debt, arg1: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal) {
        assert!(0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::le(arg0.borrow_index, arg1), 0x144e6f7899c2a7b7812b9db8e7bc672ba9ff3107c45704dc86f23fe1be8a0eb::error::invariant_borrow_index_incremental());
        if (0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::eq(arg0.borrow_index, arg1)) {
            return
        };
        arg0.amount = debt(arg0, arg1);
        arg0.borrow_index = arg1;
    }

    public fun borrow_index(arg0: &Debt) : &0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        &arg0.borrow_index
    }

    public(friend) fun cleared(arg0: &mut Debt) {
        arg0.amount = 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::zero();
    }

    public fun has_debt(arg0: &Debt) : bool {
        !0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::is_zero(&arg0.amount)
    }

    public(friend) fun new(arg0: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal, arg1: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal) : Debt {
        Debt{
            amount       : arg0,
            borrow_index : arg1,
        }
    }

    public fun snapshot(arg0: &Debt) : (0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal, 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal) {
        (arg0.amount, arg0.borrow_index)
    }

    public fun unsafe_debt_amount(arg0: &Debt) : 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal {
        arg0.amount
    }

    public(friend) fun unsafe_decrease(arg0: &mut Debt, arg1: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal) {
        arg0.amount = 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::sub(arg0.amount, arg1);
    }

    public(friend) fun unsafe_increase(arg0: &mut Debt, arg1: 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::Decimal) {
        arg0.amount = 0x336803ad729ab0e0b690f972023be8c0c03e1ec3929ea0a8d1c1204165793a14::float::add(arg0.amount, arg1);
    }

    // decompiled from Move bytecode v6
}

