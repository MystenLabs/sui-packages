module 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::x_oracle {
    struct X_ORACLE has drop {
        dummy_field: bool,
    }

    struct XOracle has key {
        id: 0x2::object::UID,
        primary_price_update_policy: 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::PriceUpdatePolicy,
        secondary_price_update_policy: 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::PriceUpdatePolicy,
        prices: 0x2::table::Table<0x1::type_name::TypeName, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>,
        ema_prices: 0x2::table::Table<0x1::type_name::TypeName, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>,
    }

    struct XOraclePolicyCap has store, key {
        id: 0x2::object::UID,
        primary_price_update_policy_cap: 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::PriceUpdatePolicyCap,
        secondary_price_update_policy_cap: 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::PriceUpdatePolicyCap,
    }

    struct XOraclePriceUpdateRequest<phantom T0> {
        primary_price_update_request: 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::PriceUpdateRequest<T0>,
        secondary_price_update_request: 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::PriceUpdateRequest<T0>,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (XOracle, XOraclePolicyCap) {
        let (v0, v1) = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::new(arg0);
        let (v2, v3) = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::new(arg0);
        let v4 = XOracle{
            id                            : 0x2::object::new(arg0),
            primary_price_update_policy   : v0,
            secondary_price_update_policy : v2,
            prices                        : 0x2::table::new<0x1::type_name::TypeName, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>(arg0),
            ema_prices                    : 0x2::table::new<0x1::type_name::TypeName, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>(arg0),
        };
        let v5 = XOraclePolicyCap{
            id                                : 0x2::object::new(arg0),
            primary_price_update_policy_cap   : v1,
            secondary_price_update_policy_cap : v3,
        };
        (v4, v5)
    }

    public fun add_primary_price_update_rule<T0: drop>(arg0: &mut XOracle, arg1: &XOraclePolicyCap) {
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::add_rule<T0>(&mut arg0.primary_price_update_policy, &arg1.primary_price_update_policy_cap);
    }

    public fun add_secondary_price_update_rule<T0: drop>(arg0: &mut XOracle, arg1: &XOraclePolicyCap) {
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::add_rule<T0>(&mut arg0.secondary_price_update_policy, &arg1.secondary_price_update_policy_cap);
    }

    public fun confirm_price_update_request<T0>(arg0: &mut XOracle, arg1: XOraclePriceUpdateRequest<T0>, arg2: &0x2::clock::Clock) {
        let XOraclePriceUpdateRequest {
            primary_price_update_request   : v0,
            secondary_price_update_request : v1,
        } = arg1;
        let v2 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>(&arg0.prices, v2)) {
            0x2::table::add<0x1::type_name::TypeName, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>(&mut arg0.prices, v2, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::new(0, 0));
        };
        let v3 = determine_price(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::confirm_request<T0>(v0, &arg0.primary_price_update_policy), 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::confirm_request<T0>(v1, &arg0.secondary_price_update_policy));
        *0x2::table::borrow_mut<0x1::type_name::TypeName, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>(&mut arg0.prices, 0x1::type_name::get<T0>()) = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::new(0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::value(&v3), 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    fun determine_price(arg0: vector<0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>, arg1: vector<0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>) : 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed {
        let v0 = 0x1::vector::pop_back<0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>(&mut arg0);
        let v1 = 0x1::vector::length<0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>(&arg1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            if (price_feed_match(v0, 0x1::vector::pop_back<0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed>(&mut arg1))) {
                v2 = v2 + 1;
            };
            v3 = v3 + 1;
        };
        assert!(v2 >= (v1 + 1) / 2, 720);
        v0
    }

    fun init(arg0: X_ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg1);
        0x2::transfer::share_object<XOracle>(v0);
        0x2::transfer::transfer<XOraclePolicyCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<X_ORACLE>(arg0, arg1);
    }

    fun price_feed_match(arg0: 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed, arg1: 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed) : bool {
        let v0 = 1000;
        let v1 = 1 * v0 / 100;
        let v2 = 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::value(&arg0) * v0 / 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::value(&arg1);
        v2 <= v0 + v1 && v2 >= v0 - v1
    }

    public fun price_update_request<T0>(arg0: &XOracle) : XOraclePriceUpdateRequest<T0> {
        XOraclePriceUpdateRequest<T0>{
            primary_price_update_request   : 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::new_request<T0>(&arg0.primary_price_update_policy),
            secondary_price_update_request : 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::new_request<T0>(&arg0.secondary_price_update_policy),
        }
    }

    public fun prices(arg0: &XOracle) : &0x2::table::Table<0x1::type_name::TypeName, 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed> {
        &arg0.prices
    }

    public fun remove_primary_price_update_rule<T0: drop>(arg0: &mut XOracle, arg1: &XOraclePolicyCap) {
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::remove_rule<T0>(&mut arg0.primary_price_update_policy, &arg1.primary_price_update_policy_cap);
    }

    public fun remove_secondary_price_update_rule<T0: drop>(arg0: &mut XOracle, arg1: &XOraclePolicyCap) {
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::remove_rule<T0>(&mut arg0.secondary_price_update_policy, &arg1.secondary_price_update_policy_cap);
    }

    public fun set_primary_price<T0, T1: drop>(arg0: T1, arg1: &mut XOraclePriceUpdateRequest<T0>, arg2: 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed) {
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::add_price_feed<T0, T1>(arg0, &mut arg1.primary_price_update_request, arg2);
    }

    public fun set_secondary_price<T0, T1: drop>(arg0: T1, arg1: &mut XOraclePriceUpdateRequest<T0>, arg2: 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed::PriceFeed) {
        0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_update_policy::add_price_feed<T0, T1>(arg0, &mut arg1.secondary_price_update_request, arg2);
    }

    // decompiled from Move bytecode v6
}

