module 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::debt {
    struct Debt has copy, drop, store {
        amount: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
        borrow_index: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal,
    }

    public(friend) fun debt(arg0: &Debt, arg1: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal) : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        if (0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::eq(arg1, arg0.borrow_index)) {
            return arg0.amount
        };
        0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::div(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::mul(arg0.amount, arg1), arg0.borrow_index)
    }

    public(friend) fun accrue_interest(arg0: &mut Debt, arg1: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal) {
        assert!(0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::le(arg0.borrow_index, arg1), 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::error::invariant_borrow_index_incremental());
        if (0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::eq(arg0.borrow_index, arg1)) {
            return
        };
        arg0.amount = debt(arg0, arg1);
        arg0.borrow_index = arg1;
    }

    public(friend) fun borrow_index(arg0: &Debt) : &0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        &arg0.borrow_index
    }

    public(friend) fun cleared(arg0: &mut Debt) {
        arg0.amount = 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::zero();
    }

    public(friend) fun has_debt(arg0: &Debt) : bool {
        !0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::is_zero(&arg0.amount)
    }

    public(friend) fun new(arg0: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal, arg1: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal) : Debt {
        Debt{
            amount       : arg0,
            borrow_index : arg1,
        }
    }

    public(friend) fun unsafe_debt_amount(arg0: &Debt) : 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal {
        arg0.amount
    }

    public(friend) fun unsafe_decrease(arg0: &mut Debt, arg1: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal) {
        arg0.amount = 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::sub(arg0.amount, arg1);
    }

    public(friend) fun unsafe_increase(arg0: &mut Debt, arg1: 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::Decimal) {
        arg0.amount = 0x3a2341506a50725e93850c5584ab6441bda2c70e82626e15691701e8681bdf5d::float::add(arg0.amount, arg1);
    }

    // decompiled from Move bytecode v6
}

