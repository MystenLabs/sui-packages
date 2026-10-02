module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::registry {
    struct MarketRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        protocol_id: 0x2::object::ID,
        markets: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    public fun contains<T0>(arg0: &MarketRegistry<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.markets, arg1)
    }

    public(friend) fun create<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = MarketRegistry<T0>{
            id          : 0x2::object::new(arg1),
            protocol_id : arg0,
            markets     : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<MarketRegistry<T0>>(v0);
        0x2::object::id<MarketRegistry<T0>>(&v0)
    }

    public fun protocol_id<T0>(arg0: &MarketRegistry<T0>) : 0x2::object::ID {
        arg0.protocol_id
    }

    public(friend) fun register_market<T0>(arg0: &mut MarketRegistry<T0>, arg1: vector<u8>, arg2: 0x2::object::ID) {
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.markets, arg1), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::market_exists());
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.markets, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

