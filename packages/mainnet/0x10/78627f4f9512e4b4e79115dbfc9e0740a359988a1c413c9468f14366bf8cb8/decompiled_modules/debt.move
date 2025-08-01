module 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::debt {
    struct Debt has store {
        debt_assets_list: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        open_debt: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    public fun destroy_empty(arg0: Debt) {
        assert!(is_empty(&arg0), 2);
        destroy(arg0);
    }

    public fun is_empty(arg0: &Debt) : bool {
        0x2::vec_set::is_empty<0x1::type_name::TypeName>(&arg0.debt_assets_list)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Debt {
        Debt{
            debt_assets_list : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            open_debt        : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
        }
    }

    public fun remove<T0>(arg0: &mut Debt) : u64 {
        let v0 = value<T0>(arg0);
        decrease<T0>(arg0, v0);
        v0
    }

    public fun calc_debt(arg0: &Debt, arg1: &mut 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::trusted_prices::TrustedPriceData) : u64 {
        let v0 = *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.debt_assets_list);
        let v1 = 0;
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v0)) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v0);
            let v3 = 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::trusted_prices::pull_raw_price(arg1, v2);
            v1 = v1 + 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::price::calc_value(&v3, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.open_debt, v2));
        };
        v1
    }

    public fun clone(arg0: &Debt, arg1: &mut 0x2::tx_context::TxContext) : Debt {
        let v0 = Debt{
            debt_assets_list : arg0.debt_assets_list,
            open_debt        : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
        };
        let v1 = *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.debt_assets_list);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v1)) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut v0.open_debt, v2, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.open_debt, v2));
        };
        v0
    }

    public fun debt_assets_list(arg0: &Debt) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.debt_assets_list
    }

    public fun decrease<T0>(arg0: &mut Debt, arg1: u64) {
        assert!(maybe_decrease<T0>(arg0, arg1), 0);
    }

    public fun destroy(arg0: Debt) {
        let Debt {
            debt_assets_list : v0,
            open_debt        : v1,
        } = arg0;
        let v2 = v1;
        let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v0);
        while (!0x1::vector::is_empty<0x1::type_name::TypeName>(&v3)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut v2, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3));
        };
        0x2::table::destroy_empty<0x1::type_name::TypeName, u64>(v2);
    }

    public fun has_debt(arg0: &Debt) : bool {
        !0x2::vec_set::is_empty<0x1::type_name::TypeName>(&arg0.debt_assets_list)
    }

    public fun increase<T0>(arg0: &mut Debt, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.open_debt, v0)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.open_debt, v0, arg1);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.debt_assets_list, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.open_debt, v0);
            *v1 = *v1 + arg1;
        };
    }

    fun maybe_decrease<T0>(arg0: &mut Debt, arg1: u64) : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.open_debt, v0)) {
            return false
        };
        let v1 = 0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.open_debt, v0);
        assert!(v1 >= arg1, 1);
        let v2 = v1 - arg1;
        if (v2 != 0) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.open_debt, v0, v2);
        } else {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.debt_assets_list, &v0);
        };
        true
    }

    public fun value<T0>(arg0: &Debt) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.open_debt, v0)) {
            return 0
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.open_debt, v0)
    }

    // decompiled from Move bytecode v6
}

