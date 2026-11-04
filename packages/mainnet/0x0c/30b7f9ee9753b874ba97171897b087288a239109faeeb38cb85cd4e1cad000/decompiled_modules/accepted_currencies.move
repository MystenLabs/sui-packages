module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::accepted_currencies {
    struct AcceptCurrencyAbility has drop {
        dummy_field: bool,
    }

    struct AcceptedCurrencies<phantom T0> has key {
        id: 0x2::object::UID,
        accepted_currencies: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct AcceptedCurrenciesCreated<phantom T0> has copy, drop {
        id: 0x2::object::ID,
    }

    struct CurrencyAccepted<phantom T0> has copy, drop {
        currencies_id: 0x2::object::ID,
        currency: 0x1::type_name::TypeName,
    }

    struct CurrencyRevoked<phantom T0> has copy, drop {
        currencies_id: 0x2::object::ID,
        currency: 0x1::type_name::TypeName,
    }

    struct AcceptedCurrenciesDeleted<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        currencies: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun delete<T0>(arg0: AcceptedCurrencies<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, AcceptCurrencyAbility>(arg1), 0);
        let AcceptedCurrencies {
            id                  : v0,
            accepted_currencies : v1,
        } = arg0;
        let v2 = v0;
        let v3 = AcceptedCurrenciesDeleted<T0>{
            id         : 0x2::object::uid_to_inner(&v2),
            currencies : v1,
        };
        0x2::event::emit<AcceptedCurrenciesDeleted<T0>>(v3);
        0x2::object::delete(v2);
        v1
    }

    public fun new<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &mut 0x2::tx_context::TxContext) : AcceptedCurrencies<T0> {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, AcceptCurrencyAbility>(arg0), 0);
        let v0 = 0x2::object::new(arg1);
        let v1 = AcceptedCurrenciesCreated<T0>{id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<AcceptedCurrenciesCreated<T0>>(v1);
        AcceptedCurrencies<T0>{
            id                  : v0,
            accepted_currencies : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun contains<T0, T1>(arg0: &AcceptedCurrencies<T0>) : bool {
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.accepted_currencies, &v0)
    }

    public fun accept_currency<T0, T1>(arg0: &mut AcceptedCurrencies<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, AcceptCurrencyAbility>(arg1), 0);
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.accepted_currencies, v0);
        let v1 = CurrencyAccepted<T0>{
            currencies_id : 0x2::object::id<AcceptedCurrencies<T0>>(arg0),
            currency      : v0,
        };
        0x2::event::emit<CurrencyAccepted<T0>>(v1);
    }

    public fun revoke_currency<T0, T1>(arg0: &mut AcceptedCurrencies<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, AcceptCurrencyAbility>(arg1), 0);
        let v0 = 0x1::type_name::get<T1>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.accepted_currencies, &v0);
        let v1 = CurrencyRevoked<T0>{
            currencies_id : 0x2::object::id<AcceptedCurrencies<T0>>(arg0),
            currency      : v0,
        };
        0x2::event::emit<CurrencyRevoked<T0>>(v1);
    }

    public fun share<T0>(arg0: AcceptedCurrencies<T0>) {
        0x2::transfer::share_object<AcceptedCurrencies<T0>>(arg0);
    }

    // decompiled from Move bytecode v7
}

