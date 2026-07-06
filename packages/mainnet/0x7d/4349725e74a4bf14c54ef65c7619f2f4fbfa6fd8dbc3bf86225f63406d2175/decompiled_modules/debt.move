module 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::debt {
    struct Debt has copy, drop, store {
        amount: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
        borrow_index: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
    }

    public(friend) fun debt(arg0: &Debt, arg1: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal) : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal {
        if (0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::eq(arg1, arg0.borrow_index)) {
            return arg0.amount
        };
        0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::div(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::mul(arg0.amount, arg1), arg0.borrow_index)
    }

    public(friend) fun accrue_interest(arg0: &mut Debt, arg1: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal) {
        assert!(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::le(arg0.borrow_index, arg1), 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::error::invariant_borrow_index_incremental());
        if (0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::eq(arg0.borrow_index, arg1)) {
            return
        };
        arg0.amount = debt(arg0, arg1);
        arg0.borrow_index = arg1;
    }

    public(friend) fun borrow_index(arg0: &Debt) : &0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal {
        &arg0.borrow_index
    }

    public(friend) fun cleared(arg0: &mut Debt) {
        arg0.amount = 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::zero();
    }

    public(friend) fun has_debt(arg0: &Debt) : bool {
        !0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::is_zero(&arg0.amount)
    }

    public(friend) fun new(arg0: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal, arg1: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal) : Debt {
        Debt{
            amount       : arg0,
            borrow_index : arg1,
        }
    }

    public(friend) fun unsafe_debt_amount(arg0: &Debt) : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal {
        arg0.amount
    }

    public(friend) fun unsafe_decrease(arg0: &mut Debt, arg1: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal) {
        arg0.amount = 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::sub(arg0.amount, arg1);
    }

    public(friend) fun unsafe_increase(arg0: &mut Debt, arg1: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal) {
        arg0.amount = 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::add(arg0.amount, arg1);
    }

    // decompiled from Move bytecode v7
}

