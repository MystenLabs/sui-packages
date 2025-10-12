module 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::debt {
    struct Debt has copy, drop, store {
        amount: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
        borrow_index: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal,
    }

    public fun debt(arg0: &Debt, arg1: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) : 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal {
        if (0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::eq(arg1, arg0.borrow_index)) {
            return arg0.amount
        };
        0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::div(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(arg0.amount, arg1), arg0.borrow_index)
    }

    public(friend) fun accrue_interest(arg0: &mut Debt, arg1: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        assert!(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::le(arg0.borrow_index, arg1), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::error::invariant_borrow_index_incremental());
        if (0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::eq(arg0.borrow_index, arg1)) {
            return
        };
        arg0.amount = debt(arg0, arg1);
        arg0.borrow_index = arg1;
    }

    public fun borrow_index(arg0: &Debt) : &0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal {
        &arg0.borrow_index
    }

    public(friend) fun cleared(arg0: &mut Debt) {
        arg0.amount = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::zero();
    }

    public fun has_debt(arg0: &Debt) : bool {
        !0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::is_zero(&arg0.amount)
    }

    public(friend) fun new(arg0: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, arg1: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) : Debt {
        Debt{
            amount       : arg0,
            borrow_index : arg1,
        }
    }

    public fun snapshot(arg0: &Debt) : (0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        (arg0.amount, arg0.borrow_index)
    }

    public fun unsafe_debt_amount(arg0: &Debt) : 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal {
        arg0.amount
    }

    public(friend) fun unsafe_decrease(arg0: &mut Debt, arg1: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        arg0.amount = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::sub(arg0.amount, arg1);
    }

    public(friend) fun unsafe_increase(arg0: &mut Debt, arg1: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) {
        arg0.amount = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::add(arg0.amount, arg1);
    }

    // decompiled from Move bytecode v6
}

