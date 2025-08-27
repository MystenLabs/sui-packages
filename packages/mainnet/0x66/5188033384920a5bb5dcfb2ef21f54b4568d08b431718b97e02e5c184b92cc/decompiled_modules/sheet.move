module 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet {
    struct Entity has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct Sheet<phantom T0, phantom T1: drop> has store {
        credits: 0x2::vec_map::VecMap<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>>,
        debts: 0x2::vec_map::VecMap<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>,
        blacklist: 0x2::vec_set::VecSet<Entity>,
    }

    struct Loan<phantom T0, phantom T1, phantom T2> {
        balance: 0x2::balance::Balance<T0>,
        debt: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>,
    }

    struct Request<phantom T0, phantom T1> {
        requirement: u64,
        balance: 0x2::balance::Balance<T0>,
        checklist: 0x1::option::Option<vector<Entity>>,
        payer_debts: 0x2::vec_map::VecMap<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>,
    }

    public fun balance<T0, T1>(arg0: &Request<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun new<T0, T1: drop>(arg0: T1) : Sheet<T0, T1> {
        Sheet<T0, T1>{
            credits   : 0x2::vec_map::empty<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>>(),
            debts     : 0x2::vec_map::empty<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(),
            blacklist : 0x2::vec_set::empty<Entity>(),
        }
    }

    public fun add_creditor<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: Entity, arg2: T1) {
        if (!0x2::vec_map::contains<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(debts<T0, T1>(arg0), &arg1)) {
            0x2::vec_map::insert<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(&mut arg0.debts, arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::zero_debt<T0>());
        };
    }

    public fun add_debtor<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: Entity, arg2: T1) {
        if (!0x2::vec_map::contains<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>>(credits<T0, T1>(arg0), &arg1)) {
            0x2::vec_map::insert<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>>(&mut arg0.credits, arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::zero_credit<T0>());
        };
    }

    public fun ban<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: Entity, arg2: T1) {
        if (!0x2::vec_set::contains<Entity>(&arg0.blacklist, &arg1)) {
            0x2::vec_set::insert<Entity>(&mut arg0.blacklist, arg1);
        };
    }

    public fun blacklist<T0, T1: drop>(arg0: &Sheet<T0, T1>) : &0x2::vec_set::VecSet<Entity> {
        &arg0.blacklist
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
        if (0x1::option::is_some<vector<Entity>>(&v5) && 0x1::option::destroy_some<vector<Entity>>(v5) != 0x2::vec_map::keys<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(&v4)) {
            err_checklist_not_fulfill();
        };
        while (!0x2::vec_map::is_empty<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(&v4)) {
            let (v6, v7) = 0x2::vec_map::pop<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(&mut v4);
            let v8 = credit_against<T0, T1>(arg0, v6);
            let v9 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::settle_debt<T0>(v8, v7);
            if (0x1::option::is_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(&v9)) {
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::add_debt<T0>(debt_against<T0, T1>(arg0, v6), 0x1::option::destroy_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(v9));
                continue
            };
            0x1::option::destroy_none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(v9);
        };
        0x2::vec_map::destroy_empty<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(v4);
        v1
    }

    fun credit_against<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: Entity) : &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0> {
        if (!0x2::vec_map::contains<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>>(credits<T0, T1>(arg0), &arg1) || 0x2::vec_set::contains<Entity>(blacklist<T0, T1>(arg0), &arg1)) {
            err_invalid_entity_for_credit();
        };
        0x2::vec_map::get_mut<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>>(&mut arg0.credits, &arg1)
    }

    public fun credits<T0, T1: drop>(arg0: &Sheet<T0, T1>) : &0x2::vec_map::VecMap<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>> {
        &arg0.credits
    }

    fun debt_against<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: Entity) : &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0> {
        if (!0x2::vec_map::contains<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(debts<T0, T1>(arg0), &arg1) || 0x2::vec_set::contains<Entity>(blacklist<T0, T1>(arg0), &arg1)) {
            err_invalid_entity_for_debt();
        };
        0x2::vec_map::get_mut<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(&mut arg0.debts, &arg1)
    }

    public fun debts<T0, T1: drop>(arg0: &Sheet<T0, T1>) : &0x2::vec_map::VecMap<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>> {
        &arg0.debts
    }

    public fun entity<T0>() : Entity {
        Entity{pos0: 0x1::type_name::get<T0>()}
    }

    fun err_checklist_not_fulfill() {
        abort 504
    }

    fun err_invalid_entity_for_credit() {
        abort 502
    }

    fun err_invalid_entity_for_debt() {
        abort 501
    }

    fun err_pay_too_much() {
        abort 503
    }

    public fun lend<T0, T1: drop, T2>(arg0: &mut Sheet<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: T1) : Loan<T0, T1, T2> {
        let (v0, v1) = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::new<T0>(0x2::balance::value<T0>(&arg1));
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::add_credit<T0>(credit_against<T0, T1>(arg0, entity<T2>()), v0);
        Loan<T0, T1, T2>{
            balance : arg1,
            debt    : v1,
        }
    }

    public fun loan_value<T0, T1, T2>(arg0: &Loan<T1, T2, T0>) : u64 {
        0x2::balance::value<T1>(&arg0.balance)
    }

    public fun pay<T0, T1, T2: drop>(arg0: &mut Sheet<T0, T2>, arg1: &mut Request<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: T2) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 > shortage<T0, T1>(arg1)) {
            err_pay_too_much();
        };
        0x2::balance::join<T0>(&mut arg1.balance, arg2);
        let (v1, v2) = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::new<T0>(v0);
        let v3 = entity<T1>();
        let v4 = debt_against<T0, T2>(arg0, v3);
        let v5 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::settle_credit<T0>(v4, v1);
        if (0x1::option::is_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>>(&v5)) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::add_credit<T0>(credit_against<T0, T2>(arg0, v3), 0x1::option::destroy_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>>(v5));
        } else {
            0x1::option::destroy_none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>>(v5);
        };
        let v6 = entity<T2>();
        if (0x2::vec_map::contains<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(payer_debts<T0, T1>(arg1), &v6)) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::add_debt<T0>(0x2::vec_map::get_mut<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(&mut arg1.payer_debts, &v6), v2);
        } else {
            0x2::vec_map::insert<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(&mut arg1.payer_debts, v6, v2);
        };
    }

    public fun payer_debts<T0, T1>(arg0: &Request<T0, T1>) : &0x2::vec_map::VecMap<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>> {
        &arg0.payer_debts
    }

    public fun receive<T0, T1, T2: drop>(arg0: &mut Sheet<T0, T2>, arg1: Loan<T0, T1, T2>, arg2: T2) : 0x2::balance::Balance<T0> {
        let Loan {
            balance : v0,
            debt    : v1,
        } = arg1;
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::add_debt<T0>(debt_against<T0, T2>(arg0, entity<T1>()), v1);
        v0
    }

    public fun request<T0, T1: drop>(arg0: u64, arg1: 0x1::option::Option<vector<Entity>>, arg2: T1) : Request<T0, T1> {
        Request<T0, T1>{
            requirement : arg0,
            balance     : 0x2::balance::zero<T0>(),
            checklist   : arg1,
            payer_debts : 0x2::vec_map::empty<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(),
        }
    }

    public fun requirement<T0, T1>(arg0: &Request<T0, T1>) : u64 {
        arg0.requirement
    }

    public fun shortage<T0, T1>(arg0: &Request<T0, T1>) : u64 {
        requirement<T0, T1>(arg0) - balance<T0, T1>(arg0)
    }

    public fun total_credit<T0, T1: drop>(arg0: &Sheet<T0, T1>) : u64 {
        let v0 = 0x2::vec_map::keys<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>>(credits<T0, T1>(arg0));
        let v1 = &v0;
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<Entity>(v1)) {
            0x1::vector::push_back<u64>(&mut v2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::credit_value<T0>(0x2::vec_map::get<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Credit<T0>>(credits<T0, T1>(arg0), 0x1::vector::borrow<Entity>(v1, v3))));
            v3 = v3 + 1;
        };
        let v4 = 0;
        0x1::vector::reverse<u64>(&mut v2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v2)) {
            v4 = v4 + 0x1::vector::pop_back<u64>(&mut v2);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        v4
    }

    public fun total_debt<T0, T1: drop>(arg0: &Sheet<T0, T1>) : u64 {
        let v0 = 0x2::vec_map::keys<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(debts<T0, T1>(arg0));
        let v1 = &v0;
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<Entity>(v1)) {
            0x1::vector::push_back<u64>(&mut v2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::debt_value<T0>(0x2::vec_map::get<Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T0>>(debts<T0, T1>(arg0), 0x1::vector::borrow<Entity>(v1, v3))));
            v3 = v3 + 1;
        };
        let v4 = 0;
        0x1::vector::reverse<u64>(&mut v2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v2)) {
            v4 = v4 + 0x1::vector::pop_back<u64>(&mut v2);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        v4
    }

    public fun unban<T0, T1: drop>(arg0: &mut Sheet<T0, T1>, arg1: Entity, arg2: T1) {
        if (0x2::vec_set::contains<Entity>(&arg0.blacklist, &arg1)) {
            0x2::vec_set::remove<Entity>(&mut arg0.blacklist, &arg1);
        };
    }

    // decompiled from Move bytecode v6
}

