module 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::app {
    struct APP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolApp has store, key {
        id: 0x2::object::UID,
        version: u64,
        markets: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct MarketRegisteredEvent has copy, drop {
        market_id: 0x2::object::ID,
        market_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    struct TakeRevenueEvent has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
        timestamp_ms: u64,
    }

    public fun create_limiter(arg0: &AdminCap, arg1: u64, arg2: u32, arg3: u32) : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::limiter::NewLimiter {
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::limiter::create_new_limiter_change(arg1, arg2, arg3)
    }

    public fun create_market_config(arg0: &AdminCap, arg1: u64, arg2: u64) : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::MarketConfiguration {
        assert!(arg1 > 0, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::invalid_params_error());
        assert!(arg2 > 0, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::invalid_params_error());
        assert!(arg1 <= arg2, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::invalid_params_error());
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::new_market_configuration(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from_quotient(arg1, arg2))
    }

    public fun get_market_config<T0>(arg0: &ProtocolApp, arg1: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>) : &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::MarketConfiguration {
        validate_market<T0>(arg0, arg1);
        0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::market_config<T0>(arg1)
    }

    public fun get_market_id<T0>(arg0: &ProtocolApp) : &0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::market_not_found());
        0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0)
    }

    public fun get_version(arg0: &ProtocolApp) : u64 {
        arg0.version
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<APP>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = ProtocolApp{
            id      : 0x2::object::new(arg1),
            version : 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::current_version::current_version(),
            markets : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg1),
        };
        0x2::transfer::public_share_object<ProtocolApp>(v1);
    }

    public fun is_market_registered<T0>(arg0: &ProtocolApp) : bool {
        0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, 0x1::type_name::get<T0>())
    }

    public fun register_market<T0>(arg0: &AdminCap, arg1: &mut ProtocolApp, arg2: 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::MarketConfiguration, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg1.markets, v0), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::market_already_exists());
        let v1 = 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::new<T0>(arg2, arg4);
        let v2 = 0x2::object::id<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>>(&v1);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.markets, v0, v2);
        0x2::transfer::public_share_object<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>>(v1);
        let v3 = MarketRegisteredEvent{
            market_id    : v2,
            market_type  : v0,
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketRegisteredEvent>(v3);
        v2
    }

    public entry fun take_revenue<T0, T1>(arg0: &AdminCap, arg1: &ProtocolApp, arg2: &mut 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_market<T0>(arg1, arg2);
        assert!(arg3 > 0, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::invalid_params_error());
        let v0 = TakeRevenueEvent{
            market       : 0x2::object::id<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>>(arg2),
            amount       : arg3,
            coin_type    : 0x1::type_name::get<T1>(),
            sender       : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TakeRevenueEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::take_revenue<T0, T1>(arg2, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun validate_market<T0>(arg0: &ProtocolApp, arg1: &0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0), 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::market_not_found());
        let v1 = 0x2::object::id<0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::market::Market<T0>>(arg1);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0) == &v1, 0x4efe2d4ea4457a898d050a311da458f11e049e2b8c4c40427b021e0406e38898::error::invalid_market());
    }

    // decompiled from Move bytecode v6
}

