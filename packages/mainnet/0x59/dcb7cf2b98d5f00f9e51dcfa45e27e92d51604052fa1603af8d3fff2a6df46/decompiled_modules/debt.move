module 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::debt {
    struct Debt has copy, drop, store {
        amount: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
        borrow_index: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal,
    }

    public(friend) fun debt(arg0: &Debt, arg1: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        if (0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::eq(arg1, arg0.borrow_index)) {
            return arg0.amount
        };
        0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::div(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::mul(arg0.amount, arg1), arg0.borrow_index)
    }

    public(friend) fun accrue_interest(arg0: &mut Debt, arg1: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal) {
        assert!(0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::le(arg0.borrow_index, arg1), 0x59dcb7cf2b98d5f00f9e51dcfa45e27e92d51604052fa1603af8d3fff2a6df46::error::invariant_borrow_index_incremental());
        if (0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::eq(arg0.borrow_index, arg1)) {
            return
        };
        arg0.amount = debt(arg0, arg1);
        arg0.borrow_index = arg1;
    }

    public(friend) fun borrow_index(arg0: &Debt) : &0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        &arg0.borrow_index
    }

    public(friend) fun cleared(arg0: &mut Debt) {
        arg0.amount = 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::zero();
    }

    public(friend) fun has_debt(arg0: &Debt) : bool {
        !0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::is_zero(&arg0.amount)
    }

    public(friend) fun new(arg0: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal, arg1: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal) : Debt {
        Debt{
            amount       : arg0,
            borrow_index : arg1,
        }
    }

    public(friend) fun unsafe_debt_amount(arg0: &Debt) : 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal {
        arg0.amount
    }

    public(friend) fun unsafe_decrease(arg0: &mut Debt, arg1: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal) {
        arg0.amount = 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::sub(arg0.amount, arg1);
    }

    public(friend) fun unsafe_increase(arg0: &mut Debt, arg1: 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::Decimal) {
        arg0.amount = 0xa66da896777763298f7a678e25cd99d92ff53a5a27df201f4a86225e11117eff::float::add(arg0.amount, arg1);
    }

    // decompiled from Move bytecode v6
}

