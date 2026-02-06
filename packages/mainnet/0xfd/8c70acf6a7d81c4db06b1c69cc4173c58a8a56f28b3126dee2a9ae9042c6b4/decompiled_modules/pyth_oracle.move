module 0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::pyth_oracle {
    struct AggOracle has store {
        pair_label: 0x1::string::String,
        base_token_decimals: u64,
        quote_token_decimals: u64,
        base_token_type: 0x1::type_name::TypeName,
        quote_token_type: 0x1::type_name::TypeName,
        oracle_id: u64,
    }

    struct Oracle has store, key {
        id: 0x2::object::UID,
        markets: 0x2::table::Table<u64, AggOracle>,
        next_oracle_id: u64,
        oracle_ids: vector<u64>,
        feeders: vector<address>,
        sources: 0x2::vec_map::VecMap<u8, 0x1::string::String>,
        prices: 0x2::table::Table<0x1::type_name::TypeName, PriceFeed>,
        feed_objects: 0x2::table::Table<0x1::type_name::TypeName, FeedObjectsInfo>,
        feed_object_assets: vector<0x1::type_name::TypeName>,
    }

    struct OracleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AggOracleInfo has copy, drop {
        oracle_id: u64,
        pair_label: 0x1::string::String,
        base_token_decimals: u64,
        quote_token_decimals: u64,
        base_token_type: 0x1::type_name::TypeName,
        quote_token_type: 0x1::type_name::TypeName,
        base_price_info_id: address,
        quote_price_info_id: address,
        base_aggregator_id: address,
        quote_aggregator_id: address,
    }

    struct FeedObjectsInfo has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
        objects: 0x2::vec_map::VecMap<u8, address>,
        weights: 0x2::vec_map::VecMap<u8, u64>,
        max_staleness: u64,
        conf_threshold: u128,
        conf_liquidate_threshold: u128,
        deviation_threshold: u128,
        degrade_threshold: u64,
    }

    struct PriceFeed has copy, drop, store {
        points: 0x2::vec_map::VecMap<u8, PricePoint>,
    }

    struct PricePoint has copy, drop, store {
        value: u128,
        conf: u128,
        last_updated: u64,
    }

    public fun add_feeder(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: address) {
        if (!0x1::vector::contains<address>(&arg0.feeders, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.feeders, arg2);
        };
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_feeder_updated(arg2, true);
    }

    public fun add_market<T0, T1>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: 0x1::string::String, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0), 19);
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v1), 19);
        assert!(arg0.next_oracle_id < 18446744073709551615, 4);
        let v2 = arg0.next_oracle_id;
        arg0.next_oracle_id = v2 + 1;
        assert!(!0x2::table::contains<u64, AggOracle>(&arg0.markets, v2), 2);
        let v3 = AggOracle{
            pair_label           : arg2,
            base_token_decimals  : arg3,
            quote_token_decimals : arg4,
            base_token_type      : v0,
            quote_token_type     : v1,
            oracle_id            : v2,
        };
        0x2::table::add<u64, AggOracle>(&mut arg0.markets, v2, v3);
        0x1::vector::push_back<u64>(&mut arg0.oracle_ids, v2);
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_agg_oracle_market_added(v2, arg2, v0, v1);
        v2
    }

    public fun add_pyth_feed_object<T0>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0)) {
            let v1 = FeedObjectsInfo{
                asset_type               : v0,
                objects                  : 0x2::vec_map::empty<u8, address>(),
                weights                  : default_weights(),
                max_staleness            : 1000,
                conf_threshold           : default_conf_threshold(),
                conf_liquidate_threshold : default_conf_liquidate_threshold(),
                deviation_threshold      : default_deviation_threshold(),
                degrade_threshold        : default_degrade_threshold(),
            };
            0x2::table::add<0x1::type_name::TypeName, FeedObjectsInfo>(&mut arg0.feed_objects, v0, v1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.feed_object_assets, v0);
        };
        assert_source(&arg0.sources, 1);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedObjectsInfo>(&mut arg0.feed_objects, v0);
        let v3 = object_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
        let v4 = 1;
        if (0x2::vec_map::contains<u8, address>(&v2.objects, &v4)) {
            *0x2::vec_map::get_mut<u8, address>(&mut v2.objects, &v4) = v3;
        } else {
            0x2::vec_map::insert<u8, address>(&mut v2.objects, v4, v3);
        };
        let v5 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v5, 1);
        let v6 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v6, v3);
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_feed_objects_set(v0, v5, v6);
    }

    fun aggregate_price_wad(arg0: u128, arg1: u128) : u128 {
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_math::mul_div_down(arg0, 1000000000000000000, arg1)
    }

    public(friend) fun assert_feed_object_allowed<T0: key>(arg0: &Oracle, arg1: 0x1::type_name::TypeName, arg2: u8, arg3: &T0) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, arg1), 19);
        let v0 = &0x2::table::borrow<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, arg1).objects;
        assert!(0x2::vec_map::contains<u8, address>(v0, &arg2), 20);
        assert!(*0x2::vec_map::get<u8, address>(v0, &arg2) == object_address<T0>(arg3), 18);
    }

    fun assert_feeder(arg0: &Oracle, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        if (arg1 == 3) {
            assert!(is_feeder(arg0, 0x2::tx_context::sender(arg2)), 6);
        };
    }

    fun assert_source(arg0: &0x2::vec_map::VecMap<u8, 0x1::string::String>, arg1: u8) {
        assert!(0x2::vec_map::contains<u8, 0x1::string::String>(arg0, &arg1), 7);
    }

    public fun borrow_market(arg0: &Oracle, arg1: u64) : &AggOracle {
        if (!0x2::table::contains<u64, AggOracle>(&arg0.markets, arg1)) {
            abort 3
        };
        0x2::table::borrow<u64, AggOracle>(&arg0.markets, arg1)
    }

    fun default_conf_liquidate_threshold() : u128 {
        1000000000000000000 / 25
    }

    fun default_conf_threshold() : u128 {
        1000000000000000000 / 50
    }

    fun default_degrade_threshold() : u64 {
        2
    }

    fun default_deviation_threshold() : u128 {
        10000 / 10
    }

    fun default_weights() : 0x2::vec_map::VecMap<u8, u64> {
        let v0 = 0x2::vec_map::empty<u8, u64>();
        0x2::vec_map::insert<u8, u64>(&mut v0, 1, (0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_math::mul_div_down((10000 as u128), 80, 100) as u64));
        0x2::vec_map::insert<u8, u64>(&mut v0, 2, (0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_math::mul_div_down((10000 as u128), 0, 100) as u64));
        0x2::vec_map::insert<u8, u64>(&mut v0, 3, (0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_math::mul_div_down((10000 as u128), 20, 100) as u64));
        v0
    }

    public fun del_feeder(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.feeders, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.feeders, v1);
        };
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_feeder_updated(arg2, false);
    }

    public fun feed_object_exists<T0>(arg0: &Oracle, arg1: u8) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0)) {
            return false
        };
        0x2::vec_map::contains<u8, address>(&0x2::table::borrow<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0).objects, &arg1)
    }

    public fun get_all_feed_objects(arg0: &Oracle) : vector<FeedObjectsInfo> {
        let v0 = 0x1::vector::empty<FeedObjectsInfo>();
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.feed_object_assets)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.feed_object_assets, v2);
            if (!0x1::vector::contains<0x1::type_name::TypeName>(&v1, &v3) && 0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v3)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, v3);
                0x1::vector::push_back<FeedObjectsInfo>(&mut v0, get_feed_objects_by_type(arg0, v3));
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_feed_object_addresses(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : (address, address) {
        let v0 = get_feed_objects_by_type(arg0, arg1);
        let v1 = 1;
        let v2 = 2;
        let v3 = if (0x2::vec_map::contains<u8, address>(&v0.objects, &v2)) {
            *0x2::vec_map::get<u8, address>(&v0.objects, &v2)
        } else {
            @0x0
        };
        (*0x2::vec_map::get<u8, address>(&v0.objects, &v1), v3)
    }

    public fun get_feed_object_addresses_batch(arg0: &Oracle, arg1: vector<0x1::type_name::TypeName>) : (vector<address>, vector<address>) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1)) {
            let (v3, v4) = get_feed_object_addresses(arg0, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1, v2));
            0x1::vector::push_back<address>(&mut v0, v3);
            0x1::vector::push_back<address>(&mut v1, v4);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_feed_objects<T0>(arg0: &Oracle) : FeedObjectsInfo {
        get_feed_objects_by_type(arg0, 0x1::type_name::with_defining_ids<T0>())
    }

    fun get_feed_objects_by_type(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : FeedObjectsInfo {
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, arg1), 19);
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, arg1);
        let v1 = &v0.objects;
        let v2 = &v0.weights;
        let v3 = 0x2::vec_map::empty<u8, address>();
        let v4 = 0;
        while (v4 < 0x2::vec_map::length<u8, address>(v1)) {
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<u8, address>(v1, v4);
            0x2::vec_map::insert<u8, address>(&mut v3, *v5, *v6);
            v4 = v4 + 1;
        };
        let v7 = 0x2::vec_map::empty<u8, u64>();
        let v8 = 0;
        while (v8 < 0x2::vec_map::length<u8, u64>(v2)) {
            let (v9, v10) = 0x2::vec_map::get_entry_by_idx<u8, u64>(v2, v8);
            0x2::vec_map::insert<u8, u64>(&mut v7, *v9, *v10);
            v8 = v8 + 1;
        };
        FeedObjectsInfo{
            asset_type               : arg1,
            objects                  : v3,
            weights                  : v7,
            max_staleness            : v0.max_staleness,
            conf_threshold           : v0.conf_threshold,
            conf_liquidate_threshold : v0.conf_liquidate_threshold,
            deviation_threshold      : v0.deviation_threshold,
            degrade_threshold        : v0.degrade_threshold,
        }
    }

    public fun get_oracle_info(arg0: &Oracle, arg1: u64) : AggOracleInfo {
        assert!(0x2::table::contains<u64, AggOracle>(&arg0.markets, arg1), 3);
        let v0 = 0x2::table::borrow<u64, AggOracle>(&arg0.markets, arg1);
        let (v1, v2) = get_feed_object_addresses(arg0, v0.base_token_type);
        let (v3, v4) = get_feed_object_addresses(arg0, v0.quote_token_type);
        AggOracleInfo{
            oracle_id            : arg1,
            pair_label           : v0.pair_label,
            base_token_decimals  : v0.base_token_decimals,
            quote_token_decimals : v0.quote_token_decimals,
            base_token_type      : v0.base_token_type,
            quote_token_type     : v0.quote_token_type,
            base_price_info_id   : v1,
            quote_price_info_id  : v3,
            base_aggregator_id   : v2,
            quote_aggregator_id  : v4,
        }
    }

    public fun get_oracle_info_by_ids(arg0: &Oracle, arg1: vector<u64>) : vector<AggOracleInfo> {
        let v0 = arg1;
        if (0x1::vector::is_empty<u64>(&v0)) {
            v0 = arg0.oracle_ids;
        };
        let v1 = 0x1::vector::empty<AggOracleInfo>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            0x1::vector::push_back<AggOracleInfo>(&mut v1, get_oracle_info(arg0, *0x1::vector::borrow<u64>(&v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_price_feed(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : PriceFeed {
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceFeed>(&arg0.prices, arg1), 8);
        *0x2::table::borrow<0x1::type_name::TypeName, PriceFeed>(&arg0.prices, arg1)
    }

    public fun get_price_point(arg0: &Oracle, arg1: 0x1::type_name::TypeName, arg2: u8) : PricePoint {
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceFeed>(&arg0.prices, arg1), 8);
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, PriceFeed>(&arg0.prices, arg1);
        assert!(0x2::vec_map::contains<u8, PricePoint>(&v0.points, &arg2), 12);
        *0x2::vec_map::get<u8, PricePoint>(&v0.points, &arg2)
    }

    public fun get_source(arg0: &Oracle, arg1: u8) : 0x1::string::String {
        assert_source(&arg0.sources, arg1);
        *0x2::vec_map::get<u8, 0x1::string::String>(&arg0.sources, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleAdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg0));
        let v2 = 0x2::vec_map::empty<u8, 0x1::string::String>();
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v2, 1, 0x1::string::utf8(b"Pyth"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v2, 2, 0x1::string::utf8(b"Switchboard"));
        0x2::vec_map::insert<u8, 0x1::string::String>(&mut v2, 3, 0x1::string::utf8(b"DEX"));
        let v3 = Oracle{
            id                 : 0x2::object::new(arg0),
            markets            : 0x2::table::new<u64, AggOracle>(arg0),
            next_oracle_id     : 1,
            oracle_ids         : 0x1::vector::empty<u64>(),
            feeders            : v1,
            sources            : v2,
            prices             : 0x2::table::new<0x1::type_name::TypeName, PriceFeed>(arg0),
            feed_objects       : 0x2::table::new<0x1::type_name::TypeName, FeedObjectsInfo>(arg0),
            feed_object_assets : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::public_transfer<OracleAdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<Oracle>(v3);
    }

    public fun is_feeder(arg0: &Oracle, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.feeders, &arg1)
    }

    public fun list_oracle_ids(arg0: &Oracle) : vector<u64> {
        arg0.oracle_ids
    }

    public fun market_decimals(arg0: &Oracle, arg1: u64) : (u64, u64) {
        let v0 = borrow_market(arg0, arg1);
        (v0.base_token_decimals, v0.quote_token_decimals)
    }

    fun median_price_from_candidates(arg0: &0x2::vec_map::VecMap<u8, u128>, arg1: &0x2::vec_map::VecMap<u8, u64>) : u128 {
        let v0 = 0x2::vec_map::length<u8, u128>(arg0);
        assert!(v0 >= 1, 9);
        if (v0 == 1) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx<u8, u128>(arg0, 0);
            return *v2
        };
        if (v0 == 2) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<u8, u128>(arg0, 0);
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<u8, u128>(arg0, 1);
            let v7 = *v3;
            let v8 = *v5;
            if (*0x2::vec_map::get<u8, u64>(arg1, &v7) >= *0x2::vec_map::get<u8, u64>(arg1, &v8)) {
                return *v4
            };
            return *v6
        };
        let v9 = 0x1::vector::empty<u128>();
        let v10 = 0;
        while (v10 < v0) {
            let (_, v12) = 0x2::vec_map::get_entry_by_idx<u8, u128>(arg0, v10);
            0x1::vector::push_back<u128>(&mut v9, *v12);
            v10 = v10 + 1;
        };
        let v13 = 0x1::vector::empty<u128>();
        while (0x1::vector::length<u128>(&v9) > 0) {
            let v14 = 0;
            let v15 = 1;
            while (v15 < 0x1::vector::length<u128>(&v9)) {
                v15 = v15 + 1;
            };
            0x1::vector::push_back<u128>(&mut v13, 0x1::vector::swap_remove<u128>(&mut v9, v14));
        };
        *0x1::vector::borrow<u128>(&v13, v0 / 2)
    }

    fun object_address<T0: key>(arg0: &T0) : address {
        let v0 = 0x2::object::id<T0>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public fun price(arg0: &Oracle, arg1: u64, arg2: &0x2::clock::Clock) : u128 {
        let (v0, _) = query_price(arg0, arg1, false, arg2);
        v0
    }

    public fun price_by_type<T0>(arg0: &Oracle, arg1: &0x2::clock::Clock) : u128 {
        let (v0, _) = query_price_by_type(arg0, 0x1::type_name::with_defining_ids<T0>(), false, arg1);
        v0
    }

    public fun prices(arg0: &Oracle, arg1: vector<u64>, arg2: &0x2::clock::Clock) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            0x1::vector::push_back<u128>(&mut v0, price(arg0, *0x1::vector::borrow<u64>(&arg1, v1), arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun query_price(arg0: &Oracle, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock) : (u128, bool) {
        if (!0x2::table::contains<u64, AggOracle>(&arg0.markets, arg1)) {
            abort 3
        };
        let v0 = 0x2::table::borrow<u64, AggOracle>(&arg0.markets, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = get_price_feed(arg0, v0.base_token_type);
        let v3 = get_price_feed(arg0, v0.quote_token_type);
        let (v4, v5) = weighted_price_from_feed(&v2, 0x2::table::borrow<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0.base_token_type), arg2, v1);
        let (v6, v7) = weighted_price_from_feed(&v3, 0x2::table::borrow<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0.quote_token_type), arg2, v1);
        let v8 = v5 || v7;
        (aggregate_price_wad(v4, v6), v8)
    }

    public fun query_price_by_type(arg0: &Oracle, arg1: 0x1::type_name::TypeName, arg2: bool, arg3: &0x2::clock::Clock) : (u128, bool) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, arg1), 19);
        let v0 = get_price_feed(arg0, arg1);
        weighted_price_from_feed(&v0, 0x2::table::borrow<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, arg1), arg2, 0x2::clock::timestamp_ms(arg3))
    }

    public fun registry_address(arg0: &Oracle) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun set_conf_liquidate_threshold<T0>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: u128) {
        assert!(arg2 <= 1000000000000000000, 17);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0), 19);
        0x2::table::borrow_mut<0x1::type_name::TypeName, FeedObjectsInfo>(&mut arg0.feed_objects, v0).conf_liquidate_threshold = arg2;
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_asset_conf_liquidate_threshold_updated(v0, arg2);
    }

    public fun set_conf_threshold<T0>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: u128) {
        assert!(arg2 <= 1000000000000000000, 14);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0), 19);
        0x2::table::borrow_mut<0x1::type_name::TypeName, FeedObjectsInfo>(&mut arg0.feed_objects, v0).conf_threshold = arg2;
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_asset_conf_threshold_updated(v0, arg2);
    }

    public fun set_degrade_threshold<T0>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: u64) {
        assert!(arg2 >= 1 && arg2 <= 10, 16);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0), 19);
        0x2::table::borrow_mut<0x1::type_name::TypeName, FeedObjectsInfo>(&mut arg0.feed_objects, v0).degrade_threshold = arg2;
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_asset_degrade_threshold_updated(v0, arg2);
    }

    public fun set_deviation_threshold<T0>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: u128) {
        assert!(arg2 <= 10000, 15);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0), 19);
        0x2::table::borrow_mut<0x1::type_name::TypeName, FeedObjectsInfo>(&mut arg0.feed_objects, v0).deviation_threshold = arg2;
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_asset_deviation_threshold_updated(v0, arg2);
    }

    public fun set_max_staleness<T0>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0), 19);
        0x2::table::borrow_mut<0x1::type_name::TypeName, FeedObjectsInfo>(&mut arg0.feed_objects, v0).max_staleness = arg2;
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_asset_max_staleness_updated(v0, arg2);
    }

    public fun set_pyth_feed_object<T0>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0), 19);
        assert_source(&arg0.sources, 1);
        let v1 = object_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedObjectsInfo>(&mut arg0.feed_objects, v0);
        let v3 = 1;
        if (0x2::vec_map::contains<u8, address>(&v2.objects, &v3)) {
            *0x2::vec_map::get_mut<u8, address>(&mut v2.objects, &v3) = v1;
        } else {
            0x2::vec_map::insert<u8, address>(&mut v2.objects, v3, v1);
        };
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v4, 1);
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, v1);
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_feed_objects_set(v0, v4, v5);
    }

    public fun set_source(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: u8, arg3: 0x1::string::String) {
        if (0x2::vec_map::contains<u8, 0x1::string::String>(&arg0.sources, &arg2)) {
            *0x2::vec_map::get_mut<u8, 0x1::string::String>(&mut arg0.sources, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<u8, 0x1::string::String>(&mut arg0.sources, arg2, arg3);
        };
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_source_updated(arg2, arg3);
    }

    public fun set_switchboard_feed_object<T0>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0), 19);
        assert_source(&arg0.sources, 2);
        let v1 = object_address<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg2);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedObjectsInfo>(&mut arg0.feed_objects, v0);
        let v3 = 2;
        if (0x2::vec_map::contains<u8, address>(&v2.objects, &v3)) {
            *0x2::vec_map::get_mut<u8, address>(&mut v2.objects, &v3) = v1;
        } else {
            0x2::vec_map::insert<u8, address>(&mut v2.objects, v3, v1);
        };
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v4, 2);
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, v1);
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_feed_objects_set(v0, v4, v5);
    }

    public fun set_weights<T0>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: vector<u8>, arg3: vector<u64>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedObjectsInfo>(&arg0.feed_objects, v0), 19);
        let v1 = &arg0.sources;
        let v2 = 0x1::vector::length<u8>(&arg2);
        assert!(v2 == 0x1::vector::length<u64>(&arg3), 21);
        let v3 = 0;
        let v4 = 0;
        while (v4 < v2) {
            assert_source(v1, *0x1::vector::borrow<u8>(&arg2, v4));
            v3 = v3 + *0x1::vector::borrow<u64>(&arg3, v4);
            v4 = v4 + 1;
        };
        assert!(v3 == 10000, 11);
        let v5 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedObjectsInfo>(&mut arg0.feed_objects, v0);
        while (0x2::vec_map::length<u8, u64>(&v5.weights) > 0) {
            let (v6, _) = 0x2::vec_map::get_entry_by_idx<u8, u64>(&v5.weights, 0);
            let v8 = *v6;
            let (_, _) = 0x2::vec_map::remove<u8, u64>(&mut v5.weights, &v8);
        };
        let v11 = 0;
        while (v11 < v2) {
            let v12 = *0x1::vector::borrow<u8>(&arg2, v11);
            assert!(!0x2::vec_map::contains<u8, u64>(&v5.weights, &v12), 10);
            0x2::vec_map::insert<u8, u64>(&mut v5.weights, v12, *0x1::vector::borrow<u64>(&arg3, v11));
            v11 = v11 + 1;
        };
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_asset_weights_updated(v0, arg2, arg3);
    }

    public fun total_markets(arg0: &Oracle) : u64 {
        arg0.next_oracle_id - 1
    }

    public(friend) fun update_price<T0: key>(arg0: &mut Oracle, arg1: 0x1::type_name::TypeName, arg2: u8, arg3: u128, arg4: u128, arg5: u64, arg6: &T0, arg7: &0x2::tx_context::TxContext) {
        assert_feed_object_allowed<T0>(arg0, arg1, arg2, arg6);
        update_price_cex(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public(friend) fun update_price_cex(arg0: &mut Oracle, arg1: 0x1::type_name::TypeName, arg2: u8, arg3: u128, arg4: u128, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert_source(&arg0.sources, arg2);
        assert!(arg5 > 0, 13);
        assert_feeder(arg0, arg2, arg6);
        if (!0x2::table::contains<0x1::type_name::TypeName, PriceFeed>(&arg0.prices, arg1)) {
            let v0 = PriceFeed{points: 0x2::vec_map::empty<u8, PricePoint>()};
            0x2::table::add<0x1::type_name::TypeName, PriceFeed>(&mut arg0.prices, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceFeed>(&mut arg0.prices, arg1);
        let v2 = PricePoint{
            value        : arg3,
            conf         : arg4,
            last_updated : arg5,
        };
        if (0x2::vec_map::contains<u8, PricePoint>(&v1.points, &arg2)) {
            if (0x2::vec_map::get<u8, PricePoint>(&v1.points, &arg2).last_updated < arg5) {
                *0x2::vec_map::get_mut<u8, PricePoint>(&mut v1.points, &arg2) = v2;
            };
        } else {
            0x2::vec_map::insert<u8, PricePoint>(&mut v1.points, arg2, v2);
        };
        0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_events::emit_price_updated(0x2::tx_context::sender(arg6), arg1, arg2, arg3, arg4, arg5);
    }

    fun weighted_price_from_feed(arg0: &PriceFeed, arg1: &FeedObjectsInfo, arg2: bool, arg3: u64) : (u128, bool) {
        let v0 = &arg1.weights;
        let v1 = if (arg2) {
            arg1.conf_liquidate_threshold
        } else {
            arg1.conf_threshold
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x2::vec_map::empty<u8, u128>();
        let v5 = 0;
        while (v5 < 0x2::vec_map::length<u8, u64>(v0)) {
            let v6 = v5;
            v5 = v5 + 1;
            let (v7, v8) = 0x2::vec_map::get_entry_by_idx<u8, u64>(v0, v6);
            let v9 = *v7;
            let v10 = *v8;
            v2 = v2 + v10;
            if (v10 > 0) {
                if (!0x2::vec_map::contains<u8, PricePoint>(&arg0.points, &v9)) {
                    v3 = v3 + 1;
                    continue
                };
                let v11 = 0x2::vec_map::get<u8, PricePoint>(&arg0.points, &v9);
                if (arg3 <= v11.last_updated + arg1.max_staleness * 1000 && v11.conf <= v1) {
                    0x2::vec_map::insert<u8, u128>(&mut v4, v9, v11.value);
                    continue
                };
                v3 = v3 + 1;
            };
        };
        assert!(v2 == 10000, 11);
        let v12 = 0x2::vec_map::length<u8, u128>(&v4);
        assert!(v12 >= 1, 9);
        if (v12 == 1) {
            let (_, v14) = 0x2::vec_map::get_entry_by_idx<u8, u128>(&v4, 0);
            return (*v14, v3 >= arg1.degrade_threshold)
        };
        let v15 = median_price_from_candidates(&v4, v0);
        let v16 = 0;
        let v17 = 0;
        let v18 = 0;
        while (v18 < v12) {
            let (v19, v20) = 0x2::vec_map::get_entry_by_idx<u8, u128>(&v4, v18);
            let v21 = *v19;
            let v22 = *v20;
            let v23 = *0x2::vec_map::get<u8, u64>(v0, &v21);
            let v24 = if (v22 > v15) {
                v22 - v15
            } else {
                v15 - v22
            };
            if (v24 <= 0xfd8c70acf6a7d81c4db06b1c69cc4173c58a8a56f28b3126dee2a9ae9042c6b4::oracle_math::mul_div_down(v15, arg1.deviation_threshold, 10000)) {
                v16 = v16 + v22 * (v23 as u128);
                v17 = v17 + v23;
            };
            v18 = v18 + 1;
        };
        assert!(v17 > 0, 9);
        (v16 / (v17 as u128), v3 >= arg1.degrade_threshold)
    }

    // decompiled from Move bytecode v6
}

