module 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::yield_registry {
    struct YieldRegistry has key {
        id: 0x2::object::UID,
        total_markets: u64,
        market_id: 0x1::option::Option<0x2::object::ID>,
        backing_type: 0x1::option::Option<0x1::type_name::TypeName>,
        maturity_ms: u64,
        initial_rate: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun backing_type(arg0: &YieldRegistry) : 0x1::type_name::TypeName {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.backing_type), 2);
        *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.backing_type)
    }

    public fun has_market(arg0: &YieldRegistry) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.market_id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldRegistry{
            id            : 0x2::object::new(arg0),
            total_markets : 0,
            market_id     : 0x1::option::none<0x2::object::ID>(),
            backing_type  : 0x1::option::none<0x1::type_name::TypeName>(),
            maturity_ms   : 0,
            initial_rate  : 0,
        };
        0x2::transfer::share_object<YieldRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun initial_rate(arg0: &YieldRegistry) : u64 {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.market_id), 2);
        arg0.initial_rate
    }

    public fun market_id(arg0: &YieldRegistry) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.market_id), 2);
        *0x1::option::borrow<0x2::object::ID>(&arg0.market_id)
    }

    public fun maturity_ms(arg0: &YieldRegistry) : u64 {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.market_id), 2);
        arg0.maturity_ms
    }

    public(friend) fun register_market<T0>(arg0: &mut YieldRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : 0x1::type_name::TypeName {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.market_id), 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        arg0.total_markets = 1;
        arg0.market_id = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.backing_type = 0x1::option::some<0x1::type_name::TypeName>(v0);
        arg0.maturity_ms = arg2;
        arg0.initial_rate = arg3;
        v0
    }

    public fun total_markets(arg0: &YieldRegistry) : u64 {
        arg0.total_markets
    }

    // decompiled from Move bytecode v7
}

