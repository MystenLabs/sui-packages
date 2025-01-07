module 0x9d5c964fda4247e0e191c5856bcdb7c96d19800c82d2a4a6e52740a64bc44625::lending_market_registry {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        lending_markets: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct LENDING_MARKET_2 {
        dummy_field: bool,
    }

    public fun create_lending_market<T0>(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : (0x9d5c964fda4247e0e191c5856bcdb7c96d19800c82d2a4a6e52740a64bc44625::lending_market::LendingMarketOwnerCap<T0>, 0x9d5c964fda4247e0e191c5856bcdb7c96d19800c82d2a4a6e52740a64bc44625::lending_market::LendingMarket<T0>) {
        assert!(arg0.version == 1, 1);
        let (v0, v1) = 0x9d5c964fda4247e0e191c5856bcdb7c96d19800c82d2a4a6e52740a64bc44625::lending_market::create_lending_market<T0>(arg1);
        let v2 = v1;
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.lending_markets, 0x1::type_name::get<T0>(), 0x2::object::id<0x9d5c964fda4247e0e191c5856bcdb7c96d19800c82d2a4a6e52740a64bc44625::lending_market::LendingMarket<T0>>(&v2));
        (v0, v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id              : 0x2::object::new(arg0),
            version         : 1,
            lending_markets : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    // decompiled from Move bytecode v6
}

