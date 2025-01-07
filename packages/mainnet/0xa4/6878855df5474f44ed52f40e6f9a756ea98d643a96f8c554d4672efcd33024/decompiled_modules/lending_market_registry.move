module 0xa46878855df5474f44ed52f40e6f9a756ea98d643a96f8c554d4672efcd33024::lending_market_registry {
    struct Registry has key {
        id: 0x2::object::UID,
        lending_markets: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct LENDING_MARKET_2 {
        dummy_field: bool,
    }

    public fun create_lending_market<T0>(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : (0xa46878855df5474f44ed52f40e6f9a756ea98d643a96f8c554d4672efcd33024::lending_market::LendingMarketOwnerCap<T0>, 0xa46878855df5474f44ed52f40e6f9a756ea98d643a96f8c554d4672efcd33024::lending_market::LendingMarket<T0>) {
        let (v0, v1) = 0xa46878855df5474f44ed52f40e6f9a756ea98d643a96f8c554d4672efcd33024::lending_market::create_lending_market<T0>(arg1);
        let v2 = v1;
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.lending_markets, 0x1::type_name::get<T0>(), 0x2::object::id<0xa46878855df5474f44ed52f40e6f9a756ea98d643a96f8c554d4672efcd33024::lending_market::LendingMarket<T0>>(&v2));
        (v0, v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id              : 0x2::object::new(arg0),
            lending_markets : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    // decompiled from Move bytecode v6
}

