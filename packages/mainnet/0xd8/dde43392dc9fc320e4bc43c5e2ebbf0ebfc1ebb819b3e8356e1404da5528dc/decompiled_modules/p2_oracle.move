module 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::p2_oracle {
    struct AssetPrice has copy, drop, store {
        price: u256,
        updated_at_ms: u64,
        max_staleness_ms: u64,
        pyth_feed_id: vector<u8>,
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
        updated_at_ms: u64,
    }

    struct MaxStalenessUpdated has copy, drop {
        asset_id: 0x1::string::String,
        max_staleness_ms: u64,
    }

    struct PythFeedUpdated has copy, drop {
        asset_id: 0x1::string::String,
        pyth_feed_id: vector<u8>,
    }

    fun assert_cap(arg0: &Oracle, arg1: &OracleAdminCap) {
        assert!(0x2::object::id_address<Oracle>(arg0) == arg1.oracle_id, 10001);
    }

    fun borrow_asset_price(arg0: &Oracle, arg1: 0x1::string::String) : &AssetPrice {
        assert!(0x2::table::contains<0x1::string::String, AssetPrice>(&arg0.asset_prices, arg1), 10006);
        0x2::table::borrow<0x1::string::String, AssetPrice>(&arg0.asset_prices, arg1)
    }

    fun borrow_asset_price_mut(arg0: &mut Oracle, arg1: 0x1::string::String) : &mut AssetPrice {
        assert!(0x2::table::contains<0x1::string::String, AssetPrice>(&arg0.asset_prices, arg1), 10006);
        0x2::table::borrow_mut<0x1::string::String, AssetPrice>(&mut arg0.asset_prices, arg1)
    }

    public fun create_oracle(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u256, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_oracle_internal(arg0, arg1, arg2, arg3, 0x2::clock::timestamp_ms(arg4), arg5);
        0x2::transfer::transfer<OracleAdminCap>(v1, 0x2::tx_context::sender(arg5));
        0x2::transfer::share_object<Oracle>(v0);
    }

    fun create_oracle_internal(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u256, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Oracle, OracleAdminCap) {
        assert!(arg2 > 0, 10002);
        assert!(arg3 > 0, 10003);
        let v0 = Oracle{
            id           : 0x2::object::new(arg5),
            asset_prices : 0x2::table::new<0x1::string::String, AssetPrice>(arg5),
        };
        let v1 = AssetPrice{
            price            : arg2,
            updated_at_ms    : arg4,
            max_staleness_ms : arg3,
            pyth_feed_id     : arg1,
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
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (v1 > v0.updated_at_ms) {
            v1 - v0.updated_at_ms
        } else {
            0
        };
        assert!(v2 <= v0.max_staleness_ms, 10004);
        v0.price
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
            price            : arg4,
            updated_at_ms    : 0x2::clock::timestamp_ms(arg6),
            max_staleness_ms : arg5,
            pyth_feed_id     : arg3,
        };
        0x2::table::add<0x1::string::String, AssetPrice>(&mut arg0.asset_prices, arg2, v0);
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

    public fun update_price(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: 0x1::string::String, arg3: u256, arg4: &0x2::clock::Clock) {
        assert_cap(arg0, arg1);
        assert!(arg3 > 0, 10002);
        let v0 = borrow_asset_price_mut(arg0, arg2);
        v0.price = arg3;
        v0.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v1 = PriceUpdated{
            asset_id      : arg2,
            price         : arg3,
            updated_at_ms : v0.updated_at_ms,
        };
        0x2::event::emit<PriceUpdated>(v1);
    }

    public fun update_price_from_pyth(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: 0x1::string::String, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_cap(arg0, arg1);
        let v0 = pyth_feed_id(arg0, arg2);
        assert!(0x1::vector::length<u8>(&v0) > 0, 10007);
        update_price(arg0, arg1, arg2, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::pyth_oracle::get_verified_price_1e18(arg3, v0, arg5, arg4), arg5);
    }

    // decompiled from Move bytecode v6
}

