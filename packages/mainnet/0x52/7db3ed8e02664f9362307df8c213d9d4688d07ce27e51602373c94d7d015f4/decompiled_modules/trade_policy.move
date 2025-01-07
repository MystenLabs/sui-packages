module 0x527db3ed8e02664f9362307df8c213d9d4688d07ce27e51602373c94d7d015f4::trade_policy {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    struct TradePolicy has key {
        id: 0x2::object::UID,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct Request<phantom T0> {
        dca_address: address,
        rule: 0x1::option::Option<0x1::type_name::TypeName>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        output: 0x2::coin::Coin<T0>,
    }

    public fun add<T0: drop, T1>(arg0: &mut Request<T1>, arg1: T0, arg2: 0x2::coin::Coin<T1>) {
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.rule), 1);
        arg0.rule = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>());
        0x2::coin::join<T1>(&mut arg0.output, arg2);
    }

    public fun approve<T0: drop>(arg0: &Admin, arg1: &mut TradePolicy) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.whitelist, 0x1::type_name::get<T0>());
    }

    public fun confirm<T0, T1>(arg0: &mut 0x527db3ed8e02664f9362307df8c213d9d4688d07ce27e51602373c94d7d015f4::dca::DCA<T0, T1>, arg1: &0x2::clock::Clock, arg2: Request<T1>) {
        let Request {
            dca_address : v0,
            rule        : v1,
            whitelist   : v2,
            output      : v3,
        } = arg2;
        let v4 = v2;
        let v5 = v1;
        assert!(0x2::object::id_address<0x527db3ed8e02664f9362307df8c213d9d4688d07ce27e51602373c94d7d015f4::dca::DCA<T0, T1>>(arg0) == v0, 0);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&v5), 2);
        let v6 = 0x1::option::destroy_some<0x1::type_name::TypeName>(v5);
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v4, &v6), 3);
        0x527db3ed8e02664f9362307df8c213d9d4688d07ce27e51602373c94d7d015f4::dca::resolve<T0, T1>(arg0, arg1, v3);
    }

    public fun dca_address<T0>(arg0: &Request<T0>) : address {
        arg0.dca_address
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

    public fun request<T0, T1>(arg0: &TradePolicy, arg1: &mut 0x527db3ed8e02664f9362307df8c213d9d4688d07ce27e51602373c94d7d015f4::dca::DCA<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (Request<T1>, 0x2::coin::Coin<T0>) {
        let v0 = Request<T1>{
            dca_address : 0x2::object::id_address<0x527db3ed8e02664f9362307df8c213d9d4688d07ce27e51602373c94d7d015f4::dca::DCA<T0, T1>>(arg1),
            rule        : 0x1::option::none<0x1::type_name::TypeName>(),
            whitelist   : arg0.whitelist,
            output      : 0x2::coin::zero<T1>(arg2),
        };
        (v0, 0x527db3ed8e02664f9362307df8c213d9d4688d07ce27e51602373c94d7d015f4::dca::take<T0, T1>(arg1, arg2))
    }

    public fun rule<T0>(arg0: &Request<T0>) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.rule
    }

    public fun whitelist(arg0: &TradePolicy) : vector<0x1::type_name::TypeName> {
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.whitelist)
    }

    // decompiled from Move bytecode v6
}

