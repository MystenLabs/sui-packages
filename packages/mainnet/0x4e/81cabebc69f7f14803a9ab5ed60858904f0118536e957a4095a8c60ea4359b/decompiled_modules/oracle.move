module 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle {
    struct OracleRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        feeds: 0x2::table::Table<0x1::type_name::TypeName, FeedConfig>,
    }

    struct FeedConfig has store {
        pyth_feed_id: vector<u8>,
        max_age_secs: u64,
        max_conf_bps: u64,
        min_price_1e18: u128,
        max_price_1e18: u128,
    }

    struct PriceResult has copy, drop {
        mid_1e18: u128,
        low_1e18: u128,
        high_1e18: u128,
        publish_time_s: u64,
    }

    fun assert_version(arg0: &OracleRegistry) {
        assert!(arg0.version == 1, 6);
    }

    public fun create_registry(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleRegistry{
            id      : 0x2::object::new(arg1),
            version : 1,
            feeds   : 0x2::table::new<0x1::type_name::TypeName, FeedConfig>(arg1),
        };
        0x2::transfer::share_object<OracleRegistry>(v0);
    }

    public(friend) fun feed_max_age_secs<T0>(arg0: &OracleRegistry) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg0.feeds, v0), 0);
        0x2::table::borrow<0x1::type_name::TypeName, FeedConfig>(&arg0.feeds, v0).max_age_secs
    }

    public fun get_price<T0>(arg0: &OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : PriceResult {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg0.feeds, v0), 0);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, FeedConfig>(&arg0.feeds, v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, v1.max_age_secs);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v3);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v4) == v1.pyth_feed_id, 1);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5), 2);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5);
        assert!(v6 > 0, 2);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v2);
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        assert!((v7 as u128) * 10000 <= (v6 as u128) * (v1.max_conf_bps as u128), 3);
        let v9 = scale_to_1e18(v6, v8);
        let v10 = scale_to_1e18(v7, v8);
        assert!(v9 >= v1.min_price_1e18 && v9 <= v1.max_price_1e18, 4);
        let v11 = if (v10 >= v9) {
            0
        } else {
            v9 - v10
        };
        PriceResult{
            mid_1e18       : v9,
            low_1e18       : v11,
            high_1e18      : v9 + v10,
            publish_time_s : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2),
        }
    }

    public(friend) fun high_1e18(arg0: &PriceResult) : u128 {
        arg0.high_1e18
    }

    public(friend) fun low_1e18(arg0: &PriceResult) : u128 {
        arg0.low_1e18
    }

    public(friend) fun mid_1e18(arg0: &PriceResult) : u128 {
        arg0.mid_1e18
    }

    public fun migrate(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::AdminCap, arg1: &mut OracleRegistry) {
        assert!(arg1.version < 1, 9);
        arg1.version = 1;
    }

    fun pow10_u256(arg0: u8) : u256 {
        pow10_u256_from_u64((arg0 as u256))
    }

    fun pow10_u256_from_u64(arg0: u256) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun publish_time_s(arg0: &PriceResult) : u64 {
        arg0.publish_time_s
    }

    fun scale_to_1e18(arg0: u64, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u128 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg1);
        let v1 = if (v0) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&arg1)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg1)
        };
        let v2 = if (!v0) {
            (arg0 as u256) * pow10_u256_from_u64(18 + (v1 as u256))
        } else if ((v1 as u256) <= 18) {
            (arg0 as u256) * pow10_u256_from_u64(18 - (v1 as u256))
        } else {
            (arg0 as u256) / pow10_u256_from_u64((v1 as u256) - 18)
        };
        assert!(v2 <= 340282366920938463463374607431768211455, 10);
        (v2 as u128)
    }

    public fun set_feed<T0>(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::RiskAdminCap, arg1: &mut OracleRegistry, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u128, arg6: u128) {
        assert_version(arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 7);
        assert!(arg4 <= 10000, 8);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg1.feeds, v0), 5);
        let v1 = FeedConfig{
            pyth_feed_id   : arg2,
            max_age_secs   : arg3,
            max_conf_bps   : arg4,
            min_price_1e18 : arg5,
            max_price_1e18 : arg6,
        };
        0x2::table::add<0x1::type_name::TypeName, FeedConfig>(&mut arg1.feeds, v0, v1);
    }

    public fun update_feed<T0>(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::RiskAdminCap, arg1: &mut OracleRegistry, arg2: u64, arg3: u64, arg4: u128, arg5: u128) {
        assert_version(arg1);
        assert!(arg3 <= 10000, 8);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg1.feeds, v0), 0);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedConfig>(&mut arg1.feeds, v0);
        v1.max_age_secs = arg2;
        v1.max_conf_bps = arg3;
        v1.min_price_1e18 = arg4;
        v1.max_price_1e18 = arg5;
    }

    public fun value_usd(arg0: u128, arg1: u64, arg2: u8) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::div_u256(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_u128(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_scaled((arg0 as u256)), (arg1 as u128)), pow10_u256(arg2))
    }

    public fun value_usd_ceil(arg0: u128, arg1: u64, arg2: u8) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        let v0 = (arg0 as u256) * (arg1 as u256);
        let v1 = pow10_u256(arg2);
        let v2 = if (v0 == 0) {
            0
        } else {
            (v0 + v1 - 1) / v1
        };
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_scaled(v2)
    }

    // decompiled from Move bytecode v7
}

