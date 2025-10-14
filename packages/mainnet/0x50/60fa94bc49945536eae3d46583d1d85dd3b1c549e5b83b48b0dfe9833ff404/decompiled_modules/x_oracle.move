module 0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::x_oracle {
    struct X_ORACLE has drop {
        dummy_field: bool,
    }

    struct XOracleOwnerCap has store, key {
        id: 0x2::object::UID,
        x_oracle: 0x2::object::ID,
    }

    struct XOracle has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<0x1::type_name::TypeName, 0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::price_feed::PriceFeed>,
        pyth_price_feeds: 0x2::table::Table<0x1::type_name::TypeName, 0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::pyth_adaptor::PythFeedData>,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (XOracle, XOracleOwnerCap) {
        let v0 = XOracle{
            id               : 0x2::object::new(arg0),
            prices           : 0x2::table::new<0x1::type_name::TypeName, 0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::price_feed::PriceFeed>(arg0),
            pyth_price_feeds : 0x2::table::new<0x1::type_name::TypeName, 0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::pyth_adaptor::PythFeedData>(arg0),
        };
        let v1 = XOracleOwnerCap{
            id       : 0x2::object::new(arg0),
            x_oracle : 0x2::object::id<XOracle>(&v0),
        };
        (v0, v1)
    }

    public fun refresh_pyth_price<T0>(arg0: &mut XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::pyth_adaptor::refresh_pyth_price<T0>(&arg0.pyth_price_feeds, &mut arg0.prices, arg1, arg2);
    }

    public fun register_pyth_feed<T0>(arg0: &XOracleOwnerCap, arg1: &mut XOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64) {
        0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::pyth_adaptor::register_pyth_feed<T0>(&mut arg1.pyth_price_feeds, arg2, arg3);
    }

    fun init(arg0: X_ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg1);
        0x2::transfer::transfer<XOracleOwnerCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<XOracle>(v0);
        0x2::package::claim_and_keep<X_ORACLE>(arg0, arg1);
    }

    public fun prices(arg0: &XOracle) : &0x2::table::Table<0x1::type_name::TypeName, 0x5060fa94bc49945536eae3d46583d1d85dd3b1c549e5b83b48b0dfe9833ff404::price_feed::PriceFeed> {
        &arg0.prices
    }

    // decompiled from Move bytecode v6
}

