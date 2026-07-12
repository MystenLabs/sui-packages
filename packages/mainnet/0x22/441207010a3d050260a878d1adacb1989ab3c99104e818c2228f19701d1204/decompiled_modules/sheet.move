module 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::sheet {
    struct Entity has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct Sheet<phantom T0, phantom T1: drop> has store {
        credits: 0x2::vec_map::VecMap<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>,
        debts: 0x2::vec_map::VecMap<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>,
        blacklist: 0x2::vec_set::VecSet<Entity>,
    }

    struct Loan<phantom T0, phantom T1, phantom T2> {
        balance: 0x2::balance::Balance<T0>,
        debt: 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>,
    }

    struct Request<phantom T0, phantom T1> {
        requirement: u64,
        balance: 0x2::balance::Balance<T0>,
        checklist: 0x1::option::Option<vector<Entity>>,
        payer_debts: 0x2::vec_map::VecMap<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>,
    }

    public fun balance<T0, T1>(arg0: &Request<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun credit_value<T0, T1: drop>(arg0: &Sheet<T0, T1>, arg1: Entity) : u64 {
        if (!0x2::vec_map::contains<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(&arg0.credits, &arg1)) {
            return 0
        };
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::credit_value<T0>(0x2::vec_map::get<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(&arg0.credits, &arg1))
    }

    public fun debt_value<T0, T1: drop>(arg0: &Sheet<T0, T1>, arg1: Entity) : u64 {
        if (!0x2::vec_map::contains<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&arg0.debts, &arg1)) {
            return 0
        };
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::debt_value<T0>(0x2::vec_map::get<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&arg0.debts, &arg1))
    }

    public fun new<T0, T1: drop>(arg0: T1) : Sheet<T0, T1> {
        Sheet<T0, T1>{
            credits   : 0x2::vec_map::empty<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(),
            debts     : 0x2::vec_map::empty<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(),
            blacklist : 0x2::vec_set::empty<Entity>(),
        }
    }

    public fun add_creditor<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: Entity, arg2: T1) {
        if (!0x2::vec_map::contains<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&arg0.debts, &arg1)) {
            0x2::vec_map::insert<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&mut arg0.debts, arg1, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::zero_debt<T0>());
        };
    }

    public fun add_debtor<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: Entity, arg2: T1) {
        if (!0x2::vec_map::contains<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(&arg0.credits, &arg1)) {
            0x2::vec_map::insert<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(&mut arg0.credits, arg1, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::zero_credit<T0>());
        };
    }

    public fun ban<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: Entity, arg2: T1) {
        if (!0x2::vec_set::contains<Entity>(&arg0.blacklist, &arg1)) {
            0x2::vec_set::insert<Entity>(&mut arg0.blacklist, arg1);
        };
    }

    public fun collect<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: Request<T0, T1>, arg2: T1) : 0x2::balance::Balance<T0> {
        let Request {
            requirement : _,
            balance     : v1,
            checklist   : v2,
            payer_debts : v3,
        } = arg1;
        let v4 = v3;
        let v5 = v2;
        if (0x1::option::is_some<vector<Entity>>(&v5)) {
            assert!(0x1::option::destroy_some<vector<Entity>>(v5) == 0x2::vec_map::keys<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&v4), 4);
        } else {
            0x1::option::destroy_none<vector<Entity>>(v5);
        };
        while (!0x2::vec_map::is_empty<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&v4)) {
            let (v6, v7) = 0x2::vec_map::pop<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&mut v4);
            let v8 = v6;
            let v9 = if (0x2::vec_map::contains<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(&arg0.credits, &v8)) {
                let v10 = credit_against<T0, T1>(arg0, &v8);
                0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::settle_debt<T0>(v10, v7)
            } else {
                0x1::option::some<0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(v7)
            };
            let v11 = v9;
            if (0x1::option::is_some<0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&v11)) {
                0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::add_debt<T0>(debt_against<T0, T1>(arg0, &v8), 0x1::option::destroy_some<0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(v11));
                continue
            };
            0x1::option::destroy_none<0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(v11);
        };
        0x2::vec_map::destroy_empty<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(v4);
        v1
    }

    fun credit_against<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: &Entity) : &mut 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0> {
        assert!(0x2::vec_map::contains<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(&arg0.credits, arg1), 1);
        assert!(!0x2::vec_set::contains<Entity>(&arg0.blacklist, arg1), 1);
        0x2::vec_map::get_mut<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(&mut arg0.credits, arg1)
    }

    fun debt_against<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: &Entity) : &mut 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0> {
        assert!(0x2::vec_map::contains<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&arg0.debts, arg1), 2);
        assert!(!0x2::vec_set::contains<Entity>(&arg0.blacklist, arg1), 2);
        0x2::vec_map::get_mut<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&mut arg0.debts, arg1)
    }

    public fun entity<T0>() : Entity {
        Entity{pos0: 0x1::type_name::with_defining_ids<T0>()}
    }

    public fun lend<T0, T1: drop, T2>(arg0: &mut Sheet<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: T1) : Loan<T0, T1, T2> {
        let (v0, v1) = 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::new<T0>(0x2::balance::value<T0>(&arg1));
        let v2 = entity<T2>();
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::add_credit<T0>(credit_against<T0, T1>(arg0, &v2), v0);
        Loan<T0, T1, T2>{
            balance : arg1,
            debt    : v1,
        }
    }

    public fun loan_value<T0, T1, T2>(arg0: &Loan<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun pay<T0, T1, T2: drop>(arg0: &mut Sheet<T0, T2>, arg1: &mut Request<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: T2) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 <= shortage<T0, T1>(arg1), 3);
        0x2::balance::join<T0>(&mut arg1.balance, arg2);
        let (v1, v2) = 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::new<T0>(v0);
        let v3 = entity<T1>();
        let v4 = if (0x2::vec_map::contains<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&arg0.debts, &v3)) {
            let v5 = debt_against<T0, T2>(arg0, &v3);
            0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::settle_credit<T0>(v5, v1)
        } else {
            0x1::option::some<0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(v1)
        };
        let v6 = v4;
        if (0x1::option::is_some<0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(&v6)) {
            0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::add_credit<T0>(credit_against<T0, T2>(arg0, &v3), 0x1::option::destroy_some<0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(v6));
        } else {
            0x1::option::destroy_none<0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(v6);
        };
        let v7 = entity<T2>();
        if (0x2::vec_map::contains<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&arg1.payer_debts, &v7)) {
            0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::add_debt<T0>(0x2::vec_map::get_mut<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&mut arg1.payer_debts, &v7), v2);
        } else {
            0x2::vec_map::insert<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&mut arg1.payer_debts, v7, v2);
        };
    }

    public fun receive<T0, T1, T2: drop>(arg0: &mut Sheet<T0, T2>, arg1: Loan<T0, T1, T2>, arg2: T2) : 0x2::balance::Balance<T0> {
        let Loan {
            balance : v0,
            debt    : v1,
        } = arg1;
        let v2 = entity<T1>();
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::add_debt<T0>(debt_against<T0, T2>(arg0, &v2), v1);
        v0
    }

    public fun request<T0, T1: drop>(arg0: u64, arg1: 0x1::option::Option<vector<Entity>>, arg2: T1) : Request<T0, T1> {
        Request<T0, T1>{
            requirement : arg0,
            balance     : 0x2::balance::zero<T0>(),
            checklist   : arg1,
            payer_debts : 0x2::vec_map::empty<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(),
        }
    }

    public fun requirement<T0, T1>(arg0: &Request<T0, T1>) : u64 {
        arg0.requirement
    }

    public fun shortage<T0, T1>(arg0: &Request<T0, T1>) : u64 {
        arg0.requirement - 0x2::balance::value<T0>(&arg0.balance)
    }

    public fun total_credit<T0, T1: drop>(arg0: &Sheet<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(&arg0.credits);
        0x1::vector::reverse<Entity>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Entity>(&v1)) {
            let v3 = 0x1::vector::pop_back<Entity>(&mut v1);
            v0 = v0 + 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::credit_value<T0>(0x2::vec_map::get<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Credit<T0>>(&arg0.credits, &v3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<Entity>(v1);
        v0
    }

    public fun total_debt<T0, T1: drop>(arg0: &Sheet<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&arg0.debts);
        0x1::vector::reverse<Entity>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Entity>(&v1)) {
            let v3 = 0x1::vector::pop_back<Entity>(&mut v1);
            v0 = v0 + 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::debt_value<T0>(0x2::vec_map::get<Entity, 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::liability::Debt<T0>>(&arg0.debts, &v3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<Entity>(v1);
        v0
    }

    public fun unban<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: Entity, arg2: T1) {
        if (0x2::vec_set::contains<Entity>(&arg0.blacklist, &arg1)) {
            0x2::vec_set::remove<Entity>(&mut arg0.blacklist, &arg1);
        };
    }

    // decompiled from Move bytecode v7
}

