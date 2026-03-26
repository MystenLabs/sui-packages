module 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle {
    struct AssetPrice has copy, drop, store {
        price: u256,
        updated_at_ms: u64,
        source_updated_at_ms: u64,
        max_staleness_ms: u64,
        pyth_feed_id: vector<u8>,
        oracle_source: u8,
        switchboard_aggregator: address,
    }

    struct Oracle has key {
        id: 0x2::object::UID,
        asset_prices: 0x2::table::Table<0x1::string::String, AssetPrice>,
    }

    struct OracleAdminCap has key {
        id: 0x2::object::UID,
        oracle_id: address,
    }

    struct PriceUpdated has copy, drop {
        asset_id: 0x1::string::String,
        price: u256,
        oracle_source: u8,
        updated_at_ms: u64,
        source_updated_at_ms: u64,
        source_age_ms: u64,
    }

    struct MaxStalenessUpdated has copy, drop {
        asset_id: 0x1::string::String,
        max_staleness_ms: u64,
    }

    struct PythFeedUpdated has copy, drop {
        asset_id: 0x1::string::String,
        pyth_feed_id: vector<u8>,
    }

    struct OracleSourceUpdated has copy, drop {
        asset_id: 0x1::string::String,
        oracle_source: u8,
    }

    struct SwitchboardAggregatorUpdated has copy, drop {
        asset_id: 0x1::string::String,
        switchboard_aggregator: address,
    }

    struct OracleCreated has copy, drop {
        oracle_id: address,
        creator: address,
    }

    struct AssetRegistered has copy, drop {
        asset_id: 0x1::string::String,
        initial_price: u256,
        max_staleness_ms: u64,
        oracle_source: u8,
    }

    fun assert_cap(arg0: &Oracle, arg1: &OracleAdminCap) {
        assert!(0x2::object::id_address<Oracle>(arg0) == arg1.oracle_id, 10001);
    }

    fun assert_valid_oracle_source(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 10008);
    }

    fun borrow_asset_price(arg0: &Oracle, arg1: 0x1::string::String) : &AssetPrice {
        assert!(0x2::table::contains<0x1::string::String, AssetPrice>(&arg0.asset_prices, arg1), 10006);
        0x2::table::borrow<0x1::string::String, AssetPrice>(&arg0.asset_prices, arg1)
    }

    fun borrow_asset_price_mut(arg0: &mut Oracle, arg1: 0x1::string::String) : &mut AssetPrice {
        assert!(0x2::table::contains<0x1::string::String, AssetPrice>(&arg0.asset_prices, arg1), 10006);
        0x2::table::borrow_mut<0x1::string::String, AssetPrice>(&mut arg0.asset_prices, arg1)
    }

    fun compute_age_ms(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun create_oracle(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u256, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_oracle_internal(arg0, arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4), arg5);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = OracleCreated{
            oracle_id : 0x2::object::id_address<Oracle>(&v2),
            creator   : v3,
        };
        0x2::event::emit<OracleCreated>(v4);
        0x2::transfer::transfer<OracleAdminCap>(v1, v3);
        0x2::transfer::share_object<Oracle>(v2);
    }

    fun create_oracle_internal(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u256, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Oracle, OracleAdminCap) {
        assert!(arg2 > 0, 10002);
        assert!(arg3 > 0, 10003);
        let v0 = Oracle{
            id           : 0x2::object::new(arg5),
            asset_prices : 0x2::table::new<0x1::string::String, AssetPrice>(arg5),
        };
        let v1 = AssetPrice{
            price                  : arg2,
            updated_at_ms          : arg4,
            source_updated_at_ms   : arg4,
            max_staleness_ms       : arg3,
            pyth_feed_id           : arg1,
            oracle_source          : 0,
            switchboard_aggregator : @0x0,
        };
        0x2::table::add<0x1::string::String, AssetPrice>(&mut v0.asset_prices, arg0, v1);
        let v2 = OracleAdminCap{
            id        : 0x2::object::new(arg5),
            oracle_id : 0x2::object::id_address<Oracle>(&v0),
        };
        (v0, v2)
    }

    public fun get_current_price(arg0: &Oracle, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) : u256 {
        let v0 = borrow_asset_price(arg0, arg1);
        assert!(v0.price > 0, 10002);
        assert!(compute_age_ms(0x2::clock::timestamp_ms(arg2), v0.source_updated_at_ms) <= v0.max_staleness_ms, 10004);
        v0.price
    }

    fun millis_to_seconds_ceil(arg0: u64) : u64 {
        if (arg0 <= 1000) {
            1
        } else if (arg0 > 18446744073709551615 - 1000 - 1) {
            arg0 / 1000 + 1
        } else {
            (arg0 + 1000 - 1) / 1000
        }
    }

    public fun oracle_source(arg0: &Oracle, arg1: 0x1::string::String) : u8 {
        borrow_asset_price(arg0, arg1).oracle_source
    }

    fun pow10_u256(arg0: u64) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun pyth_feed_id(arg0: &Oracle, arg1: 0x1::string::String) : vector<u8> {
        borrow_asset_price(arg0, arg1).pyth_feed_id
    }

    public fun register_asset(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u256, arg5: u64, arg6: &0x2::clock::Clock) {
        assert_cap(arg0, arg1);
        assert!(arg4 > 0, 10002);
        assert!(arg5 > 0, 10003);
        assert!(!0x2::table::contains<0x1::string::String, AssetPrice>(&arg0.asset_prices, arg2), 10005);
        let v0 = AssetPrice{
            price                  : arg4,
            updated_at_ms          : 0x2::clock::timestamp_ms(arg6),
            source_updated_at_ms   : 0x2::clock::timestamp_ms(arg6),
            max_staleness_ms       : arg5,
            pyth_feed_id           : arg3,
            oracle_source          : 0,
            switchboard_aggregator : @0x0,
        };
        0x2::table::add<0x1::string::String, AssetPrice>(&mut arg0.asset_prices, arg2, v0);
        let v1 = AssetRegistered{
            asset_id         : arg2,
            initial_price    : arg4,
            max_staleness_ms : arg5,
            oracle_source    : 0,
        };
        0x2::event::emit<AssetRegistered>(v1);
    }

    fun scale_to_oracle_1e18(arg0: u128, arg1: u8) : u256 {
        if (arg1 == 18) {
            (arg0 as u256)
        } else if (arg1 < 18) {
            (arg0 as u256) * pow10_u256(((18 - arg1) as u64))
        } else {
            (arg0 as u256) / pow10_u256(((arg1 - 18) as u64))
        }
    }

    fun seconds_to_millis_saturating(arg0: u64) : u64 {
        if (arg0 > 18446744073709551615 / 1000) {
            18446744073709551615
        } else {
            arg0 * 1000
        }
    }

    public fun set_max_staleness_ms(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: 0x1::string::String, arg3: u64) {
        assert_cap(arg0, arg1);
        assert!(arg3 > 0, 10003);
        borrow_asset_price_mut(arg0, arg2).max_staleness_ms = arg3;
        let v0 = MaxStalenessUpdated{
            asset_id         : arg2,
            max_staleness_ms : arg3,
        };
        0x2::event::emit<MaxStalenessUpdated>(v0);
    }

    public fun set_oracle_source(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: 0x1::string::String, arg3: u8) {
        assert_cap(arg0, arg1);
        assert_valid_oracle_source(arg3);
        let v0 = borrow_asset_price_mut(arg0, arg2);
        if (arg3 == 0) {
            assert!(0x1::vector::length<u8>(&v0.pyth_feed_id) > 0, 10007);
        } else {
            assert!(v0.switchboard_aggregator != @0x0, 10009);
        };
        v0.oracle_source = arg3;
        let v1 = OracleSourceUpdated{
            asset_id      : arg2,
            oracle_source : arg3,
        };
        0x2::event::emit<OracleSourceUpdated>(v1);
    }

    public fun set_pyth_feed_id(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: 0x1::string::String, arg3: vector<u8>) {
        assert_cap(arg0, arg1);
        let v0 = borrow_asset_price_mut(arg0, arg2);
        v0.pyth_feed_id = arg3;
        let v1 = PythFeedUpdated{
            asset_id     : arg2,
            pyth_feed_id : v0.pyth_feed_id,
        };
        0x2::event::emit<PythFeedUpdated>(v1);
    }

    public fun set_switchboard_aggregator(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: 0x1::string::String, arg3: address) {
        assert_cap(arg0, arg1);
        borrow_asset_price_mut(arg0, arg2).switchboard_aggregator = arg3;
        let v0 = SwitchboardAggregatorUpdated{
            asset_id               : arg2,
            switchboard_aggregator : arg3,
        };
        0x2::event::emit<SwitchboardAggregatorUpdated>(v0);
    }

    public fun source_updated_at_ms(arg0: &Oracle, arg1: 0x1::string::String) : u64 {
        borrow_asset_price(arg0, arg1).source_updated_at_ms
    }

    public fun switchboard_aggregator(arg0: &Oracle, arg1: 0x1::string::String) : address {
        borrow_asset_price(arg0, arg1).switchboard_aggregator
    }

    public fun update_price(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: 0x1::string::String, arg3: u256, arg4: &0x2::clock::Clock) {
        assert_cap(arg0, arg1);
        assert!(arg3 > 0, 10002);
        let v0 = borrow_asset_price_mut(arg0, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        v0.price = arg3;
        v0.updated_at_ms = v1;
        v0.source_updated_at_ms = v1;
        let v2 = PriceUpdated{
            asset_id             : arg2,
            price                : arg3,
            oracle_source        : v0.oracle_source,
            updated_at_ms        : v0.updated_at_ms,
            source_updated_at_ms : v1,
            source_age_ms        : 0,
        };
        0x2::event::emit<PriceUpdated>(v2);
    }

    public fun update_price_from_pyth(arg0: &mut Oracle, arg1: 0x1::string::String, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        let v0 = borrow_asset_price_mut(arg0, arg1);
        assert!(v0.oracle_source == 0, 10008);
        let v1 = v0.pyth_feed_id;
        assert!(0x1::vector::length<u8>(&v1) > 0, 10007);
        let (v2, v3) = 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::pyth_oracle::get_verified_price_1e18_with_publish_time(arg2, v1, arg3, millis_to_seconds_ceil(v0.max_staleness_ms));
        assert!(v2 > 0, 10002);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let v5 = seconds_to_millis_saturating(v3);
        let v6 = compute_age_ms(v4, v5);
        assert!(v6 <= v0.max_staleness_ms, 10004);
        v0.price = v2;
        v0.updated_at_ms = v4;
        v0.source_updated_at_ms = v5;
        let v7 = PriceUpdated{
            asset_id             : arg1,
            price                : v2,
            oracle_source        : 0,
            updated_at_ms        : v4,
            source_updated_at_ms : v5,
            source_age_ms        : v6,
        };
        0x2::event::emit<PriceUpdated>(v7);
    }

    public fun update_price_from_switchboard(arg0: &mut Oracle, arg1: 0x1::string::String, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg3: &0x2::clock::Clock) {
        let v0 = borrow_asset_price_mut(arg0, arg1);
        assert!(v0.oracle_source == 1, 10008);
        assert!(v0.switchboard_aggregator != @0x0, 10009);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg2);
        assert!(v0.switchboard_aggregator == 0x2::object::id_to_address(&v1), 10010);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg2);
        let v4 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::max_timestamp_ms(v3);
        let v5 = compute_age_ms(v2, v4);
        assert!(v5 <= v0.max_staleness_ms, 10004);
        let v6 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v3);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v6), 10011);
        let v7 = scale_to_oracle_1e18(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(v6), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::dec(v6));
        assert!(v7 > 0, 10002);
        v0.price = v7;
        v0.updated_at_ms = v2;
        v0.source_updated_at_ms = v4;
        let v8 = PriceUpdated{
            asset_id             : arg1,
            price                : v7,
            oracle_source        : 1,
            updated_at_ms        : v2,
            source_updated_at_ms : v4,
            source_age_ms        : v5,
        };
        0x2::event::emit<PriceUpdated>(v8);
    }

    // decompiled from Move bytecode v6
}

