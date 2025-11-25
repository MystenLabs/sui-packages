module 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::app {
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

    public(friend) fun add_market<T0>(arg0: &mut ProtocolApp, arg1: 0x2::object::ID) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_already_exists());
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.markets, v0, arg1);
    }

    public fun drain_pool<T0, T1>(arg0: &AdminCap, arg1: &ProtocolApp, arg2: &mut 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        validate_market<T0>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::drain_liquidity<T0, T1>(arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun get_market_config<T0>(arg0: &ProtocolApp, arg1: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>) : &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::MarketConfiguration {
        validate_market<T0>(arg0, arg1);
        0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::market_config<T0>(arg1)
    }

    public fun get_market_id<T0>(arg0: &ProtocolApp) : &0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_not_found());
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
            version : 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::current_version::current_version(),
            markets : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg1),
        };
        0x2::transfer::public_share_object<ProtocolApp>(v1);
    }

    public fun is_market_registered<T0>(arg0: &ProtocolApp) : bool {
        0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, 0x1::type_name::get<T0>())
    }

    public fun validate_market<T0>(arg0: &ProtocolApp, arg1: &0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0), 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::market_not_found());
        let v1 = 0x2::object::id<0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::market::Market<T0>>(arg1);
        assert!(0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.markets, v0) == &v1, 0x6f338167e47819a5435f276b6b5671df5d260ad2b66a5fafe96bc590e024580d::error::invalid_market());
    }

    // decompiled from Move bytecode v6
}

