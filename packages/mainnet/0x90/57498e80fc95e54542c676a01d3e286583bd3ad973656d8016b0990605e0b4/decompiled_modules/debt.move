module 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::debt {
    struct Debt has copy, drop, store {
        amount: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal,
        borrow_index: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal,
    }

    public fun debt(arg0: &Debt, arg1: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal) : 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal {
        if (0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::eq(arg1, arg0.borrow_index)) {
            return arg0.amount
        };
        0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::div(0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::mul(arg0.amount, arg1), arg0.borrow_index)
    }

    public(friend) fun accrue_interest(arg0: &mut Debt, arg1: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal) {
        assert!(0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::le(arg0.borrow_index, arg1), 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::invariant_borrow_index_incremental());
        if (0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::eq(arg0.borrow_index, arg1)) {
            return
        };
        arg0.amount = debt(arg0, arg1);
        arg0.borrow_index = arg1;
    }

    public fun borrow_index(arg0: &Debt) : &0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal {
        &arg0.borrow_index
    }

    public(friend) fun cleared(arg0: &mut Debt) {
        arg0.amount = 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::zero();
    }

    public fun has_debt(arg0: &Debt) : bool {
        !0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::is_zero(&arg0.amount)
    }

    public(friend) fun new(arg0: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal, arg1: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal) : Debt {
        Debt{
            amount       : arg0,
            borrow_index : arg1,
        }
    }

    public fun snapshot(arg0: &Debt) : (0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal, 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal) {
        (arg0.amount, arg0.borrow_index)
    }

    public fun unsafe_debt_amount(arg0: &Debt) : 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal {
        arg0.amount
    }

    public(friend) fun unsafe_decrease(arg0: &mut Debt, arg1: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal) {
        arg0.amount = 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::sub(arg0.amount, arg1);
    }

    public(friend) fun unsafe_increase(arg0: &mut Debt, arg1: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal) {
        arg0.amount = 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::add(arg0.amount, arg1);
    }

    // decompiled from Move bytecode v6
}

