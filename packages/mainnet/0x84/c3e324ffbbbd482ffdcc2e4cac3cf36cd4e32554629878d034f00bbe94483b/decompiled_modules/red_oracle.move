module 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle {
    struct RED_ORACLE has drop {
        dummy_field: bool,
    }

    struct UpdatePriceRequest<phantom T0> {
        primary_price_feeds: vector<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>,
        secondary_price_feeds: vector<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>,
    }

    struct PriceFeedUpdatedEvent has copy, drop {
        primary_price_feeds: vector<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>,
        secondary_price_feeds: vector<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>,
    }

    struct RedOracleCap has key {
        id: 0x2::object::UID,
    }

    struct RedOracle has store, key {
        id: 0x2::object::UID,
        coin_policies: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>,
        prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>,
        decimals: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>,
    }

    public fun add_primary_provider<T0, T1: drop>(arg0: &RedOracleCap, arg1: &mut RedOracle, arg2: &mut 0x2::tx_context::TxContext) {
        ensure_coin_policy_created<T0>(arg1, arg2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>(&mut arg1.coin_policies, &v0);
        let v2 = 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::primary_providers(v1);
        assert!(0x2::vec_set::size<0x1::type_name::TypeName>(&v2) == 0, 4);
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::add_primary_provider<T1>(v1);
    }

    public fun add_secondary_provider<T0, T1: drop>(arg0: &RedOracleCap, arg1: &mut RedOracle, arg2: &mut 0x2::tx_context::TxContext) {
        ensure_coin_policy_created<T0>(arg1, arg2);
        let v0 = 0x1::type_name::get<T0>();
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::add_secondary_provider<T1>(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>(&mut arg1.coin_policies, &v0));
    }

    public fun remove_primary_provider<T0, T1: drop>(arg0: &RedOracleCap, arg1: &mut RedOracle, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::remove_primary_provider<T1>(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>(&mut arg1.coin_policies, &v0));
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&arg1.prices, &v1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&mut arg1.prices, &v1);
        };
    }

    public fun remove_secondary_provider<T0, T1: drop>(arg0: &RedOracleCap, arg1: &mut RedOracle, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::remove_secondary_provider<T1>(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>(&mut arg1.coin_policies, &v0));
    }

    fun add_or_replace_coin_price_feed<T0>(arg0: &mut RedOracle, arg1: &0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&arg0.prices, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&mut arg0.prices, &v0);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&mut arg0.prices, v0, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::to_owned(arg1));
    }

    fun assert_ensure_coin_policy_exists<T0>(arg0: &RedOracle) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>(&arg0.coin_policies, &v0), 5);
    }

    public fun decimals(arg0: &RedOracle, arg1: 0x1::type_name::TypeName) : u8 {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u8>(&arg0.decimals, &arg1), 6);
        *0x2::vec_map::get<0x1::type_name::TypeName, u8>(&arg0.decimals, &arg1)
    }

    fun ensure_coin_policy_created<T0>(arg0: &mut RedOracle, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>(&arg0.coin_policies, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>(&mut arg0.coin_policies, v0, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::new(arg1));
        };
    }

    public fun finalize_update_request<T0>(arg0: &mut RedOracle, arg1: UpdatePriceRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>(&arg0.coin_policies, &v0);
        let v2 = 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::primary_providers(v1);
        assert!(0x1::vector::length<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(primary_price_feeds<T0>(&arg1)) == 0x2::vec_set::size<0x1::type_name::TypeName>(&v2), 0);
        let v3 = 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::secondary_providers(v1);
        assert!(0x1::vector::length<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(secondary_price_feeds<T0>(&arg1)) == 0x2::vec_set::size<0x1::type_name::TypeName>(&v3), 1);
        let UpdatePriceRequest {
            primary_price_feeds   : v4,
            secondary_price_feeds : v5,
        } = arg1;
        let v6 = v5;
        let v7 = v4;
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&v6)) {
            0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::assert_acceptable_diff(0x1::vector::borrow<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&v7, v8), 0x1::vector::borrow<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&v6, v8));
            v8 = v8 + 1;
        };
        add_or_replace_coin_price_feed<T0>(arg0, 0x1::vector::borrow<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&v7, 0));
        let v9 = PriceFeedUpdatedEvent{
            primary_price_feeds   : v7,
            secondary_price_feeds : v6,
        };
        0x2::event::emit<PriceFeedUpdatedEvent>(v9);
    }

    public fun get_price<T0>(arg0: &RedOracle, arg1: &0x2::clock::Clock) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        get_price_by_type_name(arg0, arg1, 0x1::type_name::get<T0>())
    }

    public fun get_price_by_type_name(arg0: &RedOracle, arg1: &0x2::clock::Clock, arg2: 0x1::type_name::TypeName) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&arg0.prices, &arg2);
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::assert_price_feed_stale(v0, arg1);
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::value(v0)
    }

    public fun get_price_feed<T0>(arg0: &RedOracle) : 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&arg0.prices, &v0), 5);
        *0x2::vec_map::get<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&arg0.prices, &v0)
    }

    fun init(arg0: RED_ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RedOracle{
            id            : 0x2::object::new(arg1),
            coin_policies : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>(),
            prices        : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(),
            decimals      : 0x2::vec_map::empty<0x1::type_name::TypeName, u8>(),
        };
        0x2::transfer::share_object<RedOracle>(v0);
        let v1 = RedOracleCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<RedOracleCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun new_price_calculator(arg0: &RedOracle, arg1: &0x2::clock::Clock) : 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::PriceCalculator {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::CoinInfo>();
        let v1 = 0;
        let v2 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&arg0.prices);
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v3 = 0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            let v4 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&arg0.prices, v3);
            0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::assert_price_feed_stale(v4, arg1);
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::CoinInfo>(&mut v0, *v3, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info::new(0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::value(v4), decimals(arg0, *v3)));
            v1 = v1 + 1;
        };
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::new(v0)
    }

    public fun new_update_request<T0>() : UpdatePriceRequest<T0> {
        UpdatePriceRequest<T0>{
            primary_price_feeds   : 0x1::vector::empty<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(),
            secondary_price_feeds : 0x1::vector::empty<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(),
        }
    }

    public fun primary_price_feeds<T0>(arg0: &UpdatePriceRequest<T0>) : &vector<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed> {
        &arg0.primary_price_feeds
    }

    public fun secondary_price_feeds<T0>(arg0: &UpdatePriceRequest<T0>) : &vector<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed> {
        &arg0.secondary_price_feeds
    }

    public fun set_coin_decimals<T0>(arg0: &RedOracleCap, arg1: &mut RedOracle, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_map::insert<0x1::type_name::TypeName, u8>(&mut arg1.decimals, 0x1::type_name::get<T0>(), arg2);
    }

    public fun update_price_feed_as_primary<T0, T1: drop>(arg0: &mut RedOracle, arg1: &mut UpdatePriceRequest<T0>, arg2: 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed, arg3: &0x2::clock::Clock) {
        assert_ensure_coin_policy_exists<T0>(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::is_primary_provider<T1>(0x2::vec_map::get<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>(&arg0.coin_policies, &v0)), 2);
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::validate_basic(&arg2, arg3);
        0x1::vector::push_back<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&mut arg1.primary_price_feeds, arg2);
    }

    public fun update_price_feed_as_secondary<T0, T1: drop>(arg0: &mut RedOracle, arg1: &mut UpdatePriceRequest<T0>, arg2: 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed, arg3: &0x2::clock::Clock) {
        assert_ensure_coin_policy_exists<T0>(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::is_secondary_provider<T1>(0x2::vec_map::get<0x1::type_name::TypeName, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::oracle_price_policy::OraclePricePolicy>(&arg0.coin_policies, &v0)), 3);
        0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::validate_basic(&arg2, arg3);
        0x1::vector::push_back<0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed::PriceFeed>(&mut arg1.secondary_price_feeds, arg2);
    }

    // decompiled from Move bytecode v6
}

