module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::debt {
    struct Debt has copy, drop, store {
        amount: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
        borrow_index: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
    }

    public fun debt(arg0: &Debt, arg1: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal) : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal {
        if (0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::eq(arg1, arg0.borrow_index)) {
            return arg0.amount
        };
        0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::div(0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::mul(arg0.amount, arg1), arg0.borrow_index)
    }

    public(friend) fun accrue_interest(arg0: &mut Debt, arg1: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal) {
        assert!(0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::le(arg0.borrow_index, arg1), 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::error::invariant_borrow_index_incremental());
        if (0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::eq(arg0.borrow_index, arg1)) {
            return
        };
        arg0.amount = debt(arg0, arg1);
        arg0.borrow_index = arg1;
    }

    public fun borrow_index(arg0: &Debt) : &0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal {
        &arg0.borrow_index
    }

    public(friend) fun cleared(arg0: &mut Debt) {
        arg0.amount = 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::zero();
    }

    public fun has_debt(arg0: &Debt) : bool {
        !0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::is_zero(&arg0.amount)
    }

    public(friend) fun new(arg0: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, arg1: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal) : Debt {
        Debt{
            amount       : arg0,
            borrow_index : arg1,
        }
    }

    public fun snapshot(arg0: &Debt) : (0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal) {
        (arg0.amount, arg0.borrow_index)
    }

    public fun unsafe_debt_amount(arg0: &Debt) : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal {
        arg0.amount
    }

    public(friend) fun unsafe_decrease(arg0: &mut Debt, arg1: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal) {
        arg0.amount = 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::sub(arg0.amount, arg1);
    }

    public(friend) fun unsafe_increase(arg0: &mut Debt, arg1: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal) {
        arg0.amount = 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::add(arg0.amount, arg1);
    }

    // decompiled from Move bytecode v6
}

