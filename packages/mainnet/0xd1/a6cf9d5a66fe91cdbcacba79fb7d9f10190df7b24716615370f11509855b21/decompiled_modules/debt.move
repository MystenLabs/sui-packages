module 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::debt {
    struct Debt has copy, drop, store {
        amount: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        borrow_index: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    public(friend) fun debt(arg0: &Debt, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        if (0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::eq(arg1, arg0.borrow_index)) {
            return arg0.amount
        };
        0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul(arg0.amount, arg1), arg0.borrow_index)
    }

    public(friend) fun accrue_interest(arg0: &mut Debt, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) {
        assert!(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::le(arg0.borrow_index, arg1), 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::error::invariant_borrow_index_incremental());
        if (0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::eq(arg0.borrow_index, arg1)) {
            return
        };
        arg0.amount = debt(arg0, arg1);
        arg0.borrow_index = arg1;
    }

    public(friend) fun borrow_index(arg0: &Debt) : &0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        &arg0.borrow_index
    }

    public(friend) fun cleared(arg0: &mut Debt) {
        arg0.amount = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::zero();
    }

    public(friend) fun has_debt(arg0: &Debt) : bool {
        !0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::is_zero(&arg0.amount)
    }

    public(friend) fun new(arg0: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) : Debt {
        Debt{
            amount       : arg0,
            borrow_index : arg1,
        }
    }

    public(friend) fun unsafe_debt_amount(arg0: &Debt) : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal {
        arg0.amount
    }

    public(friend) fun unsafe_decrease(arg0: &mut Debt, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) {
        arg0.amount = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::sub(arg0.amount, arg1);
    }

    public(friend) fun unsafe_increase(arg0: &mut Debt, arg1: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) {
        arg0.amount = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::add(arg0.amount, arg1);
    }

    // decompiled from Move bytecode v6
}

