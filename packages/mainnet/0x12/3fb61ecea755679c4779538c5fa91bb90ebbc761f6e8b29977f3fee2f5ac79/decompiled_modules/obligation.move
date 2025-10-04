module 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::obligation {
    struct ObligationOwnerCap has store, key {
        id: 0x2::object::UID,
        obligation_id: 0x2::object::ID,
        market_type: 0x1::type_name::TypeName,
        market_id: 0x2::object::ID,
    }

    struct Obligation<phantom T0> has store, key {
        id: 0x2::object::UID,
        lending_market_id: 0x2::object::ID,
        debts: 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt>,
        ctokens: 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken_table::CTokenTable,
    }

    struct ObligationDebts has drop {
        dummy_field: bool,
    }

    public fun id(arg0: &ObligationOwnerCap) : 0x2::object::ID {
        arg0.obligation_id
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : (Obligation<T0>, ObligationOwnerCap) {
        let v0 = ObligationDebts{dummy_field: false};
        let v1 = Obligation<T0>{
            id                : 0x2::object::new(arg1),
            lending_market_id : arg0,
            debts             : 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::new<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt>(v0, true, arg1),
            ctokens           : 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken_table::new(arg1),
        };
        let v2 = ObligationOwnerCap{
            id            : 0x2::object::new(arg1),
            obligation_id : 0x2::object::id<Obligation<T0>>(&v1),
            market_type   : 0x1::type_name::get<T0>(),
            market_id     : arg0,
        };
        (v1, v2)
    }

    public fun debt<T0>(arg0: &Obligation<T0>, arg1: 0x1::type_name::TypeName) : &0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt {
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::borrow<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt>(&arg0.debts, arg1)
    }

    public(friend) fun accrue_interest<T0>(arg0: &mut Obligation<T0>, arg1: 0x1::type_name::TypeName, arg2: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) : &mut 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt {
        let v0 = ObligationDebts{dummy_field: false};
        let v1 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::borrow_mut<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt>(v0, &mut arg0.debts, arg1);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::accrue_interest(v1, arg2);
        v1
    }

    public fun has_debt<T0>(arg0: &Obligation<T0>, arg1: 0x1::type_name::TypeName) : bool {
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::contains<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt>(&arg0.debts, arg1)
    }

    public fun ctoken_amount_by_coin<T0>(arg0: &Obligation<T0>, arg1: 0x1::type_name::TypeName) : u64 {
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken_table::ctoken_value_by_coin_type(&arg0.ctokens, arg1)
    }

    public fun debt_types<T0>(arg0: &Obligation<T0>) : vector<0x1::type_name::TypeName> {
        0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::keys<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt>(&arg0.debts)
    }

    public fun debts<T0>(arg0: &Obligation<T0>) : &0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::WitTable<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt> {
        &arg0.debts
    }

    public(friend) fun deposit_ctoken<T0, T1>(arg0: &mut Obligation<T0>, arg1: 0x2::balance::Balance<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken::CToken<T0, T1>>) {
        assert!(!0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::contains<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt>(&arg0.debts, 0x1::type_name::get<T1>()), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::obligation_deposit_borrowed_asset());
        if (!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken_table::is_supporting_collateral<T0, T1>(&arg0.ctokens)) {
            0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken_table::support_collateral_token<T0, T1>(&mut arg0.ctokens);
        };
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken_table::join_ctoken<T0, T1>(&mut arg0.ctokens, arg1);
    }

    public fun deposit_types<T0>(arg0: &Obligation<T0>) : vector<0x1::type_name::TypeName> {
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken_table::supported_coin_types(&arg0.ctokens)
    }

    public(friend) fun enforce_post_borrow_repay_invariant<T0, T1>(arg0: &Obligation<T0>, arg1: u64) {
        let v0 = 0x1::type_name::get<T1>();
        if (!has_debt<T0>(arg0, v0)) {
            return
        };
        assert!(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::ge_u64(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::unsafe_debt_amount(debt<T0>(arg0, v0)), arg1), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::obligation_borrow_below_min());
    }

    public fun market_id<T0>(arg0: &Obligation<T0>) : 0x2::object::ID {
        arg0.lending_market_id
    }

    public(friend) fun repay_debt<T0, T1>(arg0: &mut Obligation<T0>, arg1: u64, arg2: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) : u64 {
        accrue_interest<T0>(arg0, 0x1::type_name::get<T1>(), arg2);
        unsafe_repay_debt_only<T0, T1>(arg0, arg1)
    }

    public(friend) fun try_borrow_asset<T0, T1>(arg0: &mut Obligation<T0>, arg1: u64, arg2: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal) : 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal {
        let v0 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(arg1);
        if (!0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::contains<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt>(&arg0.debts, 0x1::type_name::get<T1>())) {
            assert!(!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken_table::is_supporting_collateral<T0, T1>(&arg0.ctokens), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::obligation_borrow_collateral_asset());
            let v1 = ObligationDebts{dummy_field: false};
            0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::add<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt>(v1, &mut arg0.debts, 0x1::type_name::get<T1>(), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::new(v0, arg2));
            return v0
        };
        let v2 = accrue_interest<T0>(arg0, 0x1::type_name::get<T1>(), arg2);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::unsafe_increase(v2, v0);
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::unsafe_debt_amount(v2)
    }

    public(friend) fun unsafe_repay_debt_only<T0, T1>(arg0: &mut Obligation<T0>, arg1: u64) : u64 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = ObligationDebts{dummy_field: false};
        let v2 = 0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::borrow_mut<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt>(v1, &mut arg0.debts, v0);
        let v3 = 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::ceil(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::unsafe_debt_amount(v2));
        let v4 = if (v3 < arg1) {
            0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::cleared(v2);
            arg1 - v3
        } else {
            0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::unsafe_decrease(v2, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(arg1));
            0
        };
        if (!0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::has_debt(v2)) {
            let v5 = ObligationDebts{dummy_field: false};
            0xd8fa2075231ed2e55fad0b987a7c4af574688cbb0f7778c020748cad3a1b4f40::wit_table::remove<ObligationDebts, 0x1::type_name::TypeName, 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::debt::Debt>(v5, &mut arg0.debts, v0);
        };
        v4
    }

    public(friend) fun withdraw_ctokens<T0, T1>(arg0: &mut Obligation<T0>, arg1: u64) : 0x2::balance::Balance<0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken::CToken<T0, T1>> {
        assert!(0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken_table::is_supporting_collateral<T0, T1>(&arg0.ctokens), 0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::error::obligation_withdraw_no_deposit());
        0xecedce7f426db20709fbd4ed992fcf35561fc7560b00426516e43f35ec3237e6::ctoken_table::split_ctoken<T0, T1>(&mut arg0.ctokens, arg1)
    }

    // decompiled from Move bytecode v6
}

