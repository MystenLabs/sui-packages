module 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet {
    struct Credit<phantom T0> has store {
        pos0: u64,
    }

    struct Debt<phantom T0> has store {
        pos0: u64,
    }

    struct Creditor has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct Debtor has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct Sheet<phantom T0, phantom T1> has store {
        credits: 0x2::vec_map::VecMap<Debtor, Credit<T1>>,
        debts: 0x2::vec_map::VecMap<Creditor, Debt<T1>>,
    }

    struct Loan<phantom T0, phantom T1, phantom T2> {
        balance: 0x2::balance::Balance<T2>,
        credit: 0x1::option::Option<Credit<T2>>,
        debt: 0x1::option::Option<Debt<T2>>,
    }

    struct Repayment<phantom T0, phantom T1, phantom T2> {
        balance: 0x2::balance::Balance<T2>,
        credit: 0x1::option::Option<Credit<T2>>,
        debt: 0x1::option::Option<Debt<T2>>,
    }

    struct Collector<phantom T0, phantom T1, phantom T2> {
        requirement: u64,
        repayment: 0x1::option::Option<Repayment<T0, T1, T2>>,
    }

    fun add_credit<T0>(arg0: &mut Credit<T0>, arg1: Credit<T0>) : u64 {
        let Credit { pos0: v0 } = arg1;
        let v1 = arg0.pos0 + v0;
        arg0.pos0 = v1;
        v1
    }

    public fun add_creditor<T0: drop, T1, T2>(arg0: &mut Sheet<T0, T1>, arg1: T0) {
        let v0 = Debt<T1>{pos0: 0};
        0x2::vec_map::insert<Creditor, Debt<T1>>(&mut arg0.debts, creditor<T2>(), v0);
    }

    fun add_debt<T0>(arg0: &mut Debt<T0>, arg1: Debt<T0>) : u64 {
        let Debt { pos0: v0 } = arg1;
        let v1 = arg0.pos0 + v0;
        arg0.pos0 = v1;
        v1
    }

    public fun add_debtor<T0: drop, T1, T2>(arg0: &mut Sheet<T0, T1>, arg1: T0) {
        let v0 = Credit<T1>{pos0: 0};
        0x2::vec_map::insert<Debtor, Credit<T1>>(&mut arg0.credits, debtor<T2>(), v0);
    }

    public fun collect<T0: drop, T1, T2>(arg0: &mut Sheet<T0, T2>, arg1: Collector<T0, T1, T2>, arg2: T0) : 0x2::balance::Balance<T2> {
        let v0 = &mut arg1;
        record_collect<T0, T1, T2>(arg0, v0);
        let Collector {
            requirement : v1,
            repayment   : v2,
        } = arg1;
        let v3 = v2;
        if (0x1::option::is_none<Repayment<T0, T1, T2>>(&v3)) {
            err_no_repayment();
        };
        let Repayment {
            balance : v4,
            credit  : v5,
            debt    : v6,
        } = 0x1::option::destroy_some<Repayment<T0, T1, T2>>(v3);
        let v7 = v4;
        0x1::option::destroy_none<Credit<T2>>(v5);
        0x1::option::destroy_none<Debt<T2>>(v6);
        if (v1 != 0x2::balance::value<T2>(&v7)) {
            err_not_enough_repayment();
        };
        v7
    }

    public fun credit_value<T0>(arg0: &Credit<T0>) : u64 {
        arg0.pos0
    }

    public fun creditor<T0>() : Creditor {
        Creditor{pos0: 0x1::type_name::get<T0>()}
    }

    public fun credits<T0, T1>(arg0: &Sheet<T0, T1>) : &0x2::vec_map::VecMap<Debtor, Credit<T1>> {
        &arg0.credits
    }

    public fun debt_value<T0>(arg0: &Debt<T0>) : u64 {
        arg0.pos0
    }

    public fun debtor<T0>() : Debtor {
        Debtor{pos0: 0x1::type_name::get<T0>()}
    }

    public fun debts<T0, T1>(arg0: &Sheet<T0, T1>) : &0x2::vec_map::VecMap<Creditor, Debt<T1>> {
        &arg0.debts
    }

    fun destroy_credit<T0>(arg0: Credit<T0>) {
        let Credit { pos0: v0 } = arg0;
        if (v0 > 0) {
            err_destroy_not_empty_sheet();
        };
    }

    fun destroy_debt<T0>(arg0: Debt<T0>) {
        let Debt { pos0: v0 } = arg0;
        if (v0 > 0) {
            err_destroy_not_empty_sheet();
        };
    }

    public fun dun<T0: drop, T1, T2>(arg0: u64, arg1: T0) : Collector<T0, T1, T2> {
        Collector<T0, T1, T2>{
            requirement : arg0,
            repayment   : 0x1::option::none<Repayment<T0, T1, T2>>(),
        }
    }

    fun err_already_repaid() {
        abort 3
    }

    fun err_creditor_not_found() {
        abort 5
    }

    fun err_debtor_not_found() {
        abort 6
    }

    fun err_destroy_not_empty_sheet() {
        abort 2
    }

    fun err_no_repayment() {
        abort 4
    }

    fun err_not_enough_repayment() {
        abort 0
    }

    fun err_repay_too_much() {
        abort 1
    }

    public fun loan<T0: drop, T1, T2>(arg0: &mut Sheet<T0, T2>, arg1: 0x2::balance::Balance<T2>, arg2: T0) : Loan<T0, T1, T2> {
        let v0 = 0x2::balance::value<T2>(&arg1);
        let v1 = Credit<T2>{pos0: v0};
        let v2 = Debt<T2>{pos0: v0};
        let v3 = Loan<T0, T1, T2>{
            balance : arg1,
            credit  : 0x1::option::some<Credit<T2>>(v1),
            debt    : 0x1::option::some<Debt<T2>>(v2),
        };
        let v4 = &mut v3;
        record_loan<T0, T1, T2>(arg0, v4);
        v3
    }

    public fun loan_balance<T0, T1, T2>(arg0: &Loan<T0, T1, T2>) : &0x2::balance::Balance<T2> {
        &arg0.balance
    }

    public fun new<T0: drop, T1>(arg0: T0) : Sheet<T0, T1> {
        Sheet<T0, T1>{
            credits : 0x2::vec_map::empty<Debtor, Credit<T1>>(),
            debts   : 0x2::vec_map::empty<Creditor, Debt<T1>>(),
        }
    }

    public fun receive<T0, T1: drop, T2>(arg0: &mut Sheet<T1, T2>, arg1: Loan<T0, T1, T2>, arg2: T1) : 0x2::balance::Balance<T2> {
        let v0 = &mut arg1;
        record_receive<T0, T1, T2>(arg0, v0);
        let Loan {
            balance : v1,
            credit  : v2,
            debt    : v3,
        } = arg1;
        0x1::option::destroy_none<Credit<T2>>(v2);
        0x1::option::destroy_none<Debt<T2>>(v3);
        v1
    }

    fun record_collect<T0, T1, T2>(arg0: &mut Sheet<T0, T2>, arg1: &mut Collector<T0, T1, T2>) : u64 {
        let v0 = debtor<T1>();
        if (!0x2::vec_map::contains<Debtor, Credit<T2>>(&arg0.credits, &v0)) {
            err_debtor_not_found();
        };
        let v1 = 0x2::vec_map::get_mut<Debtor, Credit<T2>>(&mut arg0.credits, &v0);
        sub_credit<T2>(v1, 0x1::option::extract<Credit<T2>>(&mut 0x1::option::borrow_mut<Repayment<T0, T1, T2>>(&mut arg1.repayment).credit))
    }

    fun record_loan<T0, T1, T2>(arg0: &mut Sheet<T0, T2>, arg1: &mut Loan<T0, T1, T2>) : u64 {
        let v0 = debtor<T1>();
        if (!0x2::vec_map::contains<Debtor, Credit<T2>>(&arg0.credits, &v0)) {
            err_debtor_not_found();
        };
        let v1 = 0x2::vec_map::get_mut<Debtor, Credit<T2>>(&mut arg0.credits, &v0);
        add_credit<T2>(v1, 0x1::option::extract<Credit<T2>>(&mut arg1.credit))
    }

    fun record_receive<T0, T1, T2>(arg0: &mut Sheet<T1, T2>, arg1: &mut Loan<T0, T1, T2>) : u64 {
        let v0 = creditor<T0>();
        if (!0x2::vec_map::contains<Creditor, Debt<T2>>(&arg0.debts, &v0)) {
            err_creditor_not_found();
        };
        let v1 = 0x2::vec_map::get_mut<Creditor, Debt<T2>>(&mut arg0.debts, &v0);
        add_debt<T2>(v1, 0x1::option::extract<Debt<T2>>(&mut arg1.debt))
    }

    fun record_repay<T0, T1, T2>(arg0: &mut Sheet<T1, T2>, arg1: &mut Collector<T0, T1, T2>) : u64 {
        let v0 = creditor<T0>();
        if (!0x2::vec_map::contains<Creditor, Debt<T2>>(&arg0.debts, &v0)) {
            err_creditor_not_found();
        };
        let v1 = 0x2::vec_map::get_mut<Creditor, Debt<T2>>(&mut arg0.debts, &v0);
        sub_debt<T2>(v1, 0x1::option::extract<Debt<T2>>(&mut 0x1::option::borrow_mut<Repayment<T0, T1, T2>>(&mut arg1.repayment).debt))
    }

    public fun remove_creditor<T0: drop, T1, T2>(arg0: &mut Sheet<T0, T1>, arg1: T0) {
        let v0 = creditor<T2>();
        if (!0x2::vec_map::contains<Creditor, Debt<T1>>(&arg0.debts, &v0)) {
            err_creditor_not_found();
        };
        let (_, v2) = 0x2::vec_map::remove<Creditor, Debt<T1>>(&mut arg0.debts, &v0);
        destroy_debt<T1>(v2);
    }

    public fun remove_debtor<T0: drop, T1, T2>(arg0: &mut Sheet<T0, T1>, arg1: T0) {
        let v0 = debtor<T2>();
        if (!0x2::vec_map::contains<Debtor, Credit<T1>>(&arg0.credits, &v0)) {
            err_debtor_not_found();
        };
        let (_, v2) = 0x2::vec_map::remove<Debtor, Credit<T1>>(&mut arg0.credits, &v0);
        destroy_credit<T1>(v2);
    }

    public fun repay<T0, T1: drop, T2>(arg0: &mut Sheet<T1, T2>, arg1: &mut Collector<T0, T1, T2>, arg2: 0x2::balance::Balance<T2>, arg3: T1) {
        if (0x1::option::is_some<Repayment<T0, T1, T2>>(&arg1.repayment)) {
            err_already_repaid();
        };
        let v0 = 0x2::balance::value<T2>(&arg2);
        let v1 = Credit<T2>{pos0: v0};
        let v2 = Debt<T2>{pos0: v0};
        let v3 = Repayment<T0, T1, T2>{
            balance : arg2,
            credit  : 0x1::option::some<Credit<T2>>(v1),
            debt    : 0x1::option::some<Debt<T2>>(v2),
        };
        0x1::option::fill<Repayment<T0, T1, T2>>(&mut arg1.repayment, v3);
        record_repay<T0, T1, T2>(arg0, arg1);
    }

    public fun repayment<T0, T1, T2>(arg0: &Collector<T0, T1, T2>) : &0x1::option::Option<Repayment<T0, T1, T2>> {
        &arg0.repayment
    }

    public fun repayment_balance<T0, T1, T2>(arg0: &Repayment<T0, T1, T2>) : &0x2::balance::Balance<T2> {
        &arg0.balance
    }

    public fun requirement<T0, T1, T2>(arg0: &Collector<T0, T1, T2>) : u64 {
        arg0.requirement
    }

    fun sub_credit<T0>(arg0: &mut Credit<T0>, arg1: Credit<T0>) : u64 {
        let Credit { pos0: v0 } = arg1;
        if (arg0.pos0 < v0) {
            err_repay_too_much();
        };
        let v1 = arg0.pos0 - v0;
        arg0.pos0 = v1;
        v1
    }

    fun sub_debt<T0>(arg0: &mut Debt<T0>, arg1: Debt<T0>) : u64 {
        let Debt { pos0: v0 } = arg1;
        if (arg0.pos0 < v0) {
            err_repay_too_much();
        };
        let v1 = arg0.pos0 - v0;
        arg0.pos0 = v1;
        v1
    }

    // decompiled from Move bytecode v6
}

