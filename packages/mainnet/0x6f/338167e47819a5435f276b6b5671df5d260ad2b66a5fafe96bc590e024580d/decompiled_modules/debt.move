module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::debt {
    struct Debt has copy, drop, store {
        amount: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
        borrow_index: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal,
    }

    public fun debt(arg0: &Debt, arg1: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        if (0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::eq(arg1, arg0.borrow_index)) {
            return arg0.amount
        };
        0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::div(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::mul(arg0.amount, arg1), arg0.borrow_index)
    }

    public(friend) fun accrue_interest(arg0: &mut Debt, arg1: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) {
        assert!(0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::le(arg0.borrow_index, arg1), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::invariant_borrow_index_incremental());
        if (0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::eq(arg0.borrow_index, arg1)) {
            return
        };
        arg0.amount = debt(arg0, arg1);
        arg0.borrow_index = arg1;
    }

    public fun borrow_index(arg0: &Debt) : &0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        &arg0.borrow_index
    }

    public(friend) fun cleared(arg0: &mut Debt) {
        arg0.amount = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::zero();
    }

    public fun has_debt(arg0: &Debt) : bool {
        !0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::is_zero(&arg0.amount)
    }

    public(friend) fun new(arg0: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, arg1: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) : Debt {
        Debt{
            amount       : arg0,
            borrow_index : arg1,
        }
    }

    public fun snapshot(arg0: &Debt) : (0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal, 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) {
        (arg0.amount, arg0.borrow_index)
    }

    public fun unsafe_debt_amount(arg0: &Debt) : 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal {
        arg0.amount
    }

    public(friend) fun unsafe_decrease(arg0: &mut Debt, arg1: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) {
        arg0.amount = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::sub(arg0.amount, arg1);
    }

    public(friend) fun unsafe_increase(arg0: &mut Debt, arg1: 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::Decimal) {
        arg0.amount = 0xaab062a74ad3b4ba68dc4cc219d3346a4e662aa02c35019348b2dbafd1088962::float::add(arg0.amount, arg1);
    }

    // decompiled from Move bytecode v6
}

