module 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle {
    struct UpdatePriceRequest {
        primary_price_feeds: vector<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>,
        secondary_price_feeds: vector<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>,
    }

    struct PriceFeedUpdatedEvent has copy, drop {
        primary_price_feeds: vector<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>,
        secondary_price_feeds: vector<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>,
    }

    struct XOracleCap has key {
        id: 0x2::object::UID,
    }

    struct XOracle has store, key {
        id: 0x2::object::UID,
        coin_policies: 0x2::table::Table<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>,
        prices: 0x2::table::Table<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>,
    }

    public fun add_primary_provider<T0, T1: drop>(arg0: &XOracleCap, arg1: &mut XOracle, arg2: &mut 0x2::tx_context::TxContext) {
        ensure_coin_policy_created<T0>(arg1, arg2);
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>(&mut arg1.coin_policies, 0x1::type_name::get<T0>());
        let v1 = 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::primary_providers(v0);
        assert!(0x2::vec_set::size<0x1::type_name::TypeName>(&v1) == 0, 4);
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::add_primary_provider<T1>(v0);
    }

    public fun add_secondary_provider<T0, T1: drop>(arg0: &XOracleCap, arg1: &mut XOracle, arg2: &mut 0x2::tx_context::TxContext) {
        ensure_coin_policy_created<T0>(arg1, arg2);
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::add_secondary_provider<T1>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>(&mut arg1.coin_policies, 0x1::type_name::get<T0>()));
    }

    public fun remove_primary_provider<T0, T1: drop>(arg0: &XOracleCap, arg1: &mut XOracle, arg2: &mut 0x2::tx_context::TxContext) {
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::remove_primary_provider<T1>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>(&mut arg1.coin_policies, 0x1::type_name::get<T0>()));
    }

    public fun remove_secondary_provider<T0, T1: drop>(arg0: &XOracleCap, arg1: &mut XOracle, arg2: &mut 0x2::tx_context::TxContext) {
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::remove_secondary_provider<T1>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>(&mut arg1.coin_policies, 0x1::type_name::get<T0>()));
    }

    fun add_or_replace_coin_price_feed<T0>(arg0: &mut XOracle, arg1: &0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&arg0.prices, v0)) {
            0x2::table::add<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&mut arg0.prices, v0, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::to_owned(arg1));
        } else {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&mut arg0.prices, v0) = 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::to_owned(arg1);
        };
    }

    fun assert_ensure_coin_policy_exists<T0>(arg0: &XOracle) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>(&arg0.coin_policies, 0x1::type_name::get<T0>()), 6);
    }

    fun ensure_coin_policy_created<T0>(arg0: &mut XOracle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>(&arg0.coin_policies, v0)) {
            0x2::table::add<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>(&mut arg0.coin_policies, v0, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::new(arg1));
        };
    }

    public fun finalize_update_request<T0>(arg0: &mut XOracle, arg1: UpdatePriceRequest, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>(&arg0.coin_policies, 0x1::type_name::get<T0>());
        let v1 = 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::primary_providers(v0);
        assert!(0x2::vec_set::size<0x1::type_name::TypeName>(&v1) > 0, 5);
        assert!(0x1::vector::length<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(primary_price_feeds(&arg1)) == 0x2::vec_set::size<0x1::type_name::TypeName>(&v1), 0);
        let v2 = 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::secondary_providers(v0);
        assert!(0x1::vector::length<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(secondary_price_feeds(&arg1)) == 0x2::vec_set::size<0x1::type_name::TypeName>(&v2), 1);
        let UpdatePriceRequest {
            primary_price_feeds   : v3,
            secondary_price_feeds : v4,
        } = arg1;
        let v5 = v4;
        let v6 = v3;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&v5)) {
            0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::assert_acceptable_diff(0x1::vector::borrow<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&v6, v7), 0x1::vector::borrow<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&v5, v7));
            v7 = v7 + 1;
        };
        add_or_replace_coin_price_feed<T0>(arg0, 0x1::vector::borrow<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&v6, 0));
        let v8 = PriceFeedUpdatedEvent{
            primary_price_feeds   : v6,
            secondary_price_feeds : v5,
        };
        0x2::event::emit<PriceFeedUpdatedEvent>(v8);
    }

    public fun get_price<T0>(arg0: &XOracle, arg1: &0x2::clock::Clock) : 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::Price {
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&arg0.prices, 0x1::type_name::get<T0>());
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::assert_price_feed_stale(v0, arg1);
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::value(v0)
    }

    public fun get_price_feed<T0>(arg0: &XOracle) : &0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&arg0.prices, v0), 6);
        0x2::table::borrow<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&arg0.prices, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = XOracle{
            id            : 0x2::object::new(arg0),
            coin_policies : 0x2::table::new<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>(arg0),
            prices        : 0x2::table::new<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(arg0),
        };
        0x2::transfer::share_object<XOracle>(v0);
        let v1 = XOracleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<XOracleCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun new_update_request() : UpdatePriceRequest {
        UpdatePriceRequest{
            primary_price_feeds   : 0x1::vector::empty<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(),
            secondary_price_feeds : 0x1::vector::empty<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(),
        }
    }

    public fun primary_price_feeds(arg0: &UpdatePriceRequest) : &vector<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed> {
        &arg0.primary_price_feeds
    }

    public fun secondary_price_feeds(arg0: &UpdatePriceRequest) : &vector<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed> {
        &arg0.secondary_price_feeds
    }

    public fun update_price_feed_as_primary<T0, T1: drop>(arg0: &mut XOracle, arg1: &mut UpdatePriceRequest, arg2: 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed, arg3: &0x2::clock::Clock) {
        assert_ensure_coin_policy_exists<T0>(arg0);
        assert!(0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::is_primary_provider<T1>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>(&mut arg0.coin_policies, 0x1::type_name::get<T0>())), 2);
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::validate_basic(&arg2, arg3);
        assert!(0x1::vector::length<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&arg1.primary_price_feeds) == 0, 4);
        0x1::vector::push_back<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&mut arg1.primary_price_feeds, arg2);
    }

    public fun update_price_feed_as_secondary<T0, T1: drop>(arg0: &mut XOracle, arg1: &mut UpdatePriceRequest, arg2: 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed, arg3: &0x2::clock::Clock) {
        assert_ensure_coin_policy_exists<T0>(arg0);
        assert!(0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::is_secondary_provider<T1>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::oracle_price_policy::OraclePricePolicy>(&mut arg0.coin_policies, 0x1::type_name::get<T0>())), 3);
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::validate_basic(&arg2, arg3);
        0x1::vector::push_back<0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed>(&mut arg1.secondary_price_feeds, arg2);
    }

    // decompiled from Move bytecode v6
}

