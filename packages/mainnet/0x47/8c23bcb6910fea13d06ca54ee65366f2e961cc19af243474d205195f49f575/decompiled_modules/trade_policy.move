module 0x478c23bcb6910fea13d06ca54ee65366f2e961cc19af243474d205195f49f575::trade_policy {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    struct TradePolicy has key {
        id: 0x2::object::UID,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct Request<phantom T0> {
        dca: address,
        owner: address,
        rule: 0x1::option::Option<0x1::type_name::TypeName>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        output: 0x2::coin::Coin<T0>,
    }

    public fun dca<T0>(arg0: &Request<T0>) : address {
        arg0.dca
    }

    public fun owner<T0>(arg0: &Request<T0>) : address {
        arg0.owner
    }

    public fun add<T0: drop, T1>(arg0: &mut Request<T1>, arg1: T0, arg2: 0x2::coin::Coin<T1>) {
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.rule), 1);
        arg0.rule = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>());
        0x2::coin::join<T1>(&mut arg0.output, arg2);
    }

    public fun approve<T0: drop>(arg0: &Admin, arg1: &mut TradePolicy) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.whitelist, 0x1::type_name::get<T0>());
    }

    public fun confirm<T0, T1>(arg0: &mut 0x478c23bcb6910fea13d06ca54ee65366f2e961cc19af243474d205195f49f575::dca::DCA<T0, T1>, arg1: &0x2::clock::Clock, arg2: Request<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let Request {
            dca       : v0,
            owner     : _,
            rule      : v2,
            whitelist : v3,
            output    : v4,
        } = arg2;
        let v5 = v3;
        let v6 = v2;
        assert!(0x2::object::id_address<0x478c23bcb6910fea13d06ca54ee65366f2e961cc19af243474d205195f49f575::dca::DCA<T0, T1>>(arg0) == v0, 0);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&v6), 2);
        let v7 = 0x1::option::destroy_some<0x1::type_name::TypeName>(v6);
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v5, &v7), 3);
        0x478c23bcb6910fea13d06ca54ee65366f2e961cc19af243474d205195f49f575::dca::resolve<T0, T1>(arg0, arg1, v4, arg3);
    }

    public fun disapprove<T0: drop>(arg0: &Admin, arg1: &mut TradePolicy) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.whitelist, &v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TradePolicy{
            id        : 0x2::object::new(arg0),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<TradePolicy>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun output<T0>(arg0: &Request<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.output)
    }

    public fun request<T0, T1>(arg0: &TradePolicy, arg1: &mut 0x478c23bcb6910fea13d06ca54ee65366f2e961cc19af243474d205195f49f575::dca::DCA<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (Request<T1>, 0x2::coin::Coin<T0>) {
        let v0 = Request<T1>{
            dca       : 0x2::object::id_address<0x478c23bcb6910fea13d06ca54ee65366f2e961cc19af243474d205195f49f575::dca::DCA<T0, T1>>(arg1),
            owner     : 0x478c23bcb6910fea13d06ca54ee65366f2e961cc19af243474d205195f49f575::dca::owner<T0, T1>(arg1),
            rule      : 0x1::option::none<0x1::type_name::TypeName>(),
            whitelist : arg0.whitelist,
            output    : 0x2::coin::zero<T1>(arg2),
        };
        (v0, 0x478c23bcb6910fea13d06ca54ee65366f2e961cc19af243474d205195f49f575::dca::take<T0, T1>(arg1, arg2))
    }

    public fun rule<T0>(arg0: &Request<T0>) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.rule
    }

    public fun whitelist(arg0: &TradePolicy) : vector<0x1::type_name::TypeName> {
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.whitelist)
    }

    // decompiled from Move bytecode v6
}

