module 0x79dfd759786a4355fcd574dc1c6b29231995c44cf8b18c208e94b9598eb9704e::price_feed {
    struct PriceFeedCreated has copy, drop {
        feed_id: 0x2::object::ID,
        price_cap_id: 0x2::object::ID,
        max_age_secs: u64,
        max_conf_bps: u64,
        timestamp_ms: u64,
        admin: address,
    }

    struct CoinFeedRegistered has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        feed_id: vector<u8>,
        decimals: u8,
        replaced: bool,
        timestamp_ms: u64,
        admin: address,
    }

    struct CoinFeedRemoved has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
        admin: address,
    }

    struct PriceLimitsUpdated has copy, drop {
        max_age_secs: u64,
        max_conf_bps: u64,
        timestamp_ms: u64,
        admin: address,
    }

    struct PriceFeed has key {
        id: 0x2::object::UID,
        version: u64,
        price_cap: 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::PriceCap,
        coins: 0x2::table::Table<0x1::type_name::TypeName, CoinFeed>,
        coins_by_feed: 0x2::table::Table<vector<u8>, vector<0x1::type_name::TypeName>>,
        max_age_secs: u64,
        max_conf_bps: u64,
    }

    struct CoinFeed has copy, drop, store {
        feed_id: vector<u8>,
        decimals: u8,
    }

    fun assert_version(arg0: &PriceFeed) {
        assert!(arg0.version <= 1, 5000);
    }

    public fun create_price_feed(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceFeed{
            id            : 0x2::object::new(arg3),
            version       : 1,
            price_cap     : 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::create_price_cap(arg0, arg1, arg2, arg3),
            coins         : 0x2::table::new<0x1::type_name::TypeName, CoinFeed>(arg3),
            coins_by_feed : 0x2::table::new<vector<u8>, vector<0x1::type_name::TypeName>>(arg3),
            max_age_secs  : 60,
            max_conf_bps  : 50,
        };
        let v1 = PriceFeedCreated{
            feed_id      : 0x2::object::id<PriceFeed>(&v0),
            price_cap_id : 0x2::object::id<0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::PriceCap>(&v0.price_cap),
            max_age_secs : v0.max_age_secs,
            max_conf_bps : v0.max_conf_bps,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            admin        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PriceFeedCreated>(v1);
        0x2::transfer::share_object<PriceFeed>(v0);
    }

    public fun price_from_feed(arg0: &PriceFeed, arg1: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::Config, arg2: &mut 0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::RebalancePotato, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) {
        assert_version(arg0);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1);
        assert!(0x2::table::contains<vector<u8>, vector<0x1::type_name::TypeName>>(&arg0.coins_by_feed, v2), 5004);
        let v3 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v4 = *0x2::table::borrow<vector<u8>, vector<0x1::type_name::TypeName>>(&arg0.coins_by_feed, v2);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::type_name::TypeName>(&v4)) {
            let v6 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v4);
            if (0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::price_needed(arg2, v6)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v3, v6);
            };
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v4);
        assert!(!0x1::vector::is_empty<0x1::type_name::TypeName>(&v3), 5005);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg3);
        let v8 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v7);
        let v10 = if (v8 > v9) {
            v8 - v9
        } else {
            0
        };
        assert!(v10 <= arg0.max_age_secs, 5006);
        let v11 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v7);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v11), 5007);
        let v12 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v11);
        assert!(v12 > 0, 5007);
        assert!((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v7) as u128) * (10000 as u128) <= (arg0.max_conf_bps as u128) * (v12 as u128), 5008);
        let v13 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v7);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v3);
        let v14 = 0;
        while (v14 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            let v15 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3);
            0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::set_price(arg2, &arg0.price_cap, arg1, v15, scale(v12, &v13, 0x2::table::borrow<0x1::type_name::TypeName, CoinFeed>(&arg0.coins, v15).decimals));
            v14 = v14 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v3);
    }

    public fun register_coin<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut PriceFeed, arg2: &0x2::coin_registry::Currency<T0>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 5002);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::table::contains<0x1::type_name::TypeName, CoinFeed>(&arg1.coins, v0);
        if (v1) {
            unregister(arg1, v0);
        };
        let v2 = 0x2::coin_registry::decimals<T0>(arg2);
        let v3 = CoinFeed{
            feed_id  : arg3,
            decimals : v2,
        };
        0x2::table::add<0x1::type_name::TypeName, CoinFeed>(&mut arg1.coins, v0, v3);
        if (!0x2::table::contains<vector<u8>, vector<0x1::type_name::TypeName>>(&arg1.coins_by_feed, arg3)) {
            0x2::table::add<vector<u8>, vector<0x1::type_name::TypeName>>(&mut arg1.coins_by_feed, arg3, 0x1::vector::empty<0x1::type_name::TypeName>());
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(0x2::table::borrow_mut<vector<u8>, vector<0x1::type_name::TypeName>>(&mut arg1.coins_by_feed, arg3), v0);
        let v4 = CoinFeedRegistered{
            coin_type    : v0,
            feed_id      : arg3,
            decimals     : v2,
            replaced     : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
            admin        : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CoinFeedRegistered>(v4);
    }

    public fun remove_coin<T0>(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut PriceFeed, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinFeed>(&arg1.coins, v0), 5001);
        unregister(arg1, v0);
        let v1 = CoinFeedRemoved{
            coin_type    : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            admin        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CoinFeedRemoved>(v1);
    }

    fun scale(arg0: u64, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg2: u8) : u128 {
        let (v0, v1) = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg1)) {
            (18, (arg2 as u64) + 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg1))
        } else {
            (18 + 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg1), (arg2 as u64))
        };
        let v2 = if (v0 >= v1) {
            assert!(v0 - v1 <= 38, 5009);
            (arg0 as u256) * 0x1::u256::pow(10, ((v0 - v1) as u8))
        } else {
            assert!(v1 - v0 <= 20, 5009);
            (arg0 as u256) / 0x1::u256::pow(10, ((v1 - v0) as u8))
        };
        assert!(v2 > 0 && v2 <= 340282366920938463463374607431768211455, 5009);
        (v2 as u128)
    }

    public fun set_limits(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut PriceFeed, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(arg2 > 0 && arg2 <= 300, 5003);
        assert!(arg3 > 0 && arg3 <= 200, 5003);
        arg1.max_age_secs = arg2;
        arg1.max_conf_bps = arg3;
        let v0 = PriceLimitsUpdated{
            max_age_secs : arg2,
            max_conf_bps : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
            admin        : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PriceLimitsUpdated>(v0);
    }

    fun unregister(arg0: &mut PriceFeed, arg1: 0x1::type_name::TypeName) {
        let CoinFeed {
            feed_id  : v0,
            decimals : _,
        } = 0x2::table::remove<0x1::type_name::TypeName, CoinFeed>(&mut arg0.coins, arg1);
        let v2 = 0x2::table::borrow_mut<vector<u8>, vector<0x1::type_name::TypeName>>(&mut arg0.coins_by_feed, v0);
        let (_, v4) = 0x1::vector::index_of<0x1::type_name::TypeName>(v2, &arg1);
        0x1::vector::remove<0x1::type_name::TypeName>(v2, v4);
        if (0x1::vector::is_empty<0x1::type_name::TypeName>(v2)) {
            0x2::table::remove<vector<u8>, vector<0x1::type_name::TypeName>>(&mut arg0.coins_by_feed, v0);
        };
    }

    public fun update_version(arg0: &0x10808e70b5813e17fd494759427bc9a30f94c0fec0e5dc7e8fce393c1279688e::diversify_core::AdminCap, arg1: &mut PriceFeed) {
        assert_version(arg1);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v7
}

