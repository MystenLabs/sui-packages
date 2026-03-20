module 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::debt {
    struct Debt has copy, drop, store {
        amount: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
        borrow_index: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal,
    }

    public(friend) fun debt(arg0: &Debt, arg1: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        if (0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::eq(arg1, arg0.borrow_index)) {
            return arg0.amount
        };
        0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::div(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::mul(arg0.amount, arg1), arg0.borrow_index)
    }

    public(friend) fun accrue_interest(arg0: &mut Debt, arg1: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal) {
        assert!(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::le(arg0.borrow_index, arg1), 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::error::invariant_borrow_index_incremental());
        if (0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::eq(arg0.borrow_index, arg1)) {
            return
        };
        arg0.amount = debt(arg0, arg1);
        arg0.borrow_index = arg1;
    }

    public(friend) fun borrow_index(arg0: &Debt) : &0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        &arg0.borrow_index
    }

    public(friend) fun cleared(arg0: &mut Debt) {
        arg0.amount = 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::zero();
    }

    public(friend) fun has_debt(arg0: &Debt) : bool {
        !0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::is_zero(&arg0.amount)
    }

    public(friend) fun new(arg0: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal, arg1: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal) : Debt {
        Debt{
            amount       : arg0,
            borrow_index : arg1,
        }
    }

    public(friend) fun unsafe_debt_amount(arg0: &Debt) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        arg0.amount
    }

    public(friend) fun unsafe_decrease(arg0: &mut Debt, arg1: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal) {
        arg0.amount = 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(arg0.amount, arg1);
    }

    public(friend) fun unsafe_increase(arg0: &mut Debt, arg1: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal) {
        arg0.amount = 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::add(arg0.amount, arg1);
    }

    // decompiled from Move bytecode v6
}

