module 0xb1751bdfcc38e7d1b6b6f42ecc231a637c0ede7109ff2e4f1fa6946af8d36184::feed_info_object {
    struct FeedInfoObjectKey has copy, drop, store {
        pos0: vector<u8>,
    }

    struct FeedMetadata has copy, drop, store {
        price: u256,
        confidence_delta: u256,
        timestamp_ms: u64,
    }

    struct FeedInfoObject has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        current_feed_id: u32,
        next_feed_id: u32,
        expiry_timestamp_ms: u64,
        roll_start_days: u64,
        cutoff_days: u64,
        cached_current_feed: FeedMetadata,
        cached_next_feed: FeedMetadata,
    }

    public(friend) fun as_parts(arg0: &FeedMetadata) : (u256, u256, u64) {
        (arg0.price, arg0.confidence_delta, arg0.timestamp_ms)
    }

    public(friend) fun cached_current_feed(arg0: &FeedInfoObject) : FeedMetadata {
        arg0.cached_current_feed
    }

    public(friend) fun cached_next_feed(arg0: &FeedInfoObject) : FeedMetadata {
        arg0.cached_next_feed
    }

    public fun current_feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.current_feed_id
    }

    public fun cutoff_days(arg0: &FeedInfoObject) : u64 {
        arg0.cutoff_days
    }

    public fun expiry_timestamp_ms(arg0: &FeedInfoObject) : u64 {
        arg0.expiry_timestamp_ms
    }

    public(friend) fun is_fresh(arg0: &FeedMetadata) : bool {
        arg0.timestamp_ms != 0
    }

    public(friend) fun maybe_cache_front_month_feed(arg0: &mut FeedInfoObject, arg1: u256, arg2: u256, arg3: u64) {
        if (arg3 < arg0.cached_current_feed.timestamp_ms) {
            return
        };
        let v0 = FeedMetadata{
            price            : arg1,
            confidence_delta : arg2,
            timestamp_ms     : arg3,
        };
        arg0.cached_current_feed = v0;
    }

    public(friend) fun maybe_cache_next_month_feed(arg0: &mut FeedInfoObject, arg1: u256, arg2: u256, arg3: u64) {
        if (arg3 < arg0.cached_next_feed.timestamp_ms) {
            return
        };
        let v0 = FeedMetadata{
            price            : arg1,
            confidence_delta : arg2,
            timestamp_ms     : arg3,
        };
        arg0.cached_next_feed = v0;
    }

    public fun new<T0>(arg0: &mut 0xb1751bdfcc38e7d1b6b6f42ecc231a637c0ede7109ff2e4f1fa6946af8d36184::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: 0x1::string::String, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u64) : FeedInfoObject {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_package_version(arg2);
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        assert!(arg7 > arg8, 1);
        let v0 = 0xb1751bdfcc38e7d1b6b6f42ecc231a637c0ede7109ff2e4f1fa6946af8d36184::pyth_lazer_rolling::borrow_mut_id<T0>(arg0, arg1);
        let v1 = FeedInfoObjectKey{pos0: 0x1::string::into_bytes(arg3)};
        assert!(!0x2::derived_object::exists<FeedInfoObjectKey>(v0, v1), 0);
        let v2 = FeedMetadata{
            price            : 0,
            confidence_delta : 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source(),
            timestamp_ms     : 0,
        };
        let v3 = FeedMetadata{
            price            : 0,
            confidence_delta : 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source(),
            timestamp_ms     : 0,
        };
        FeedInfoObject{
            id                  : 0x2::derived_object::claim<FeedInfoObjectKey>(v0, v1),
            symbol              : arg3,
            current_feed_id     : arg4,
            next_feed_id        : arg5,
            expiry_timestamp_ms : arg6,
            roll_start_days     : arg7,
            cutoff_days         : arg8,
            cached_current_feed : v2,
            cached_next_feed    : v3,
        }
    }

    public fun next_feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.next_feed_id
    }

    public(friend) fun price(arg0: &FeedMetadata) : u256 {
        arg0.price
    }

    public fun roll_start_days(arg0: &FeedInfoObject) : u64 {
        arg0.roll_start_days
    }

    public fun symbol(arg0: &FeedInfoObject) : 0x1::string::String {
        arg0.symbol
    }

    public fun update<T0>(arg0: &mut 0xb1751bdfcc38e7d1b6b6f42ecc231a637c0ede7109ff2e4f1fa6946af8d36184::pyth_lazer_rolling::OracleAggregatorPythLazerRollingIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &mut FeedInfoObject, arg4: u32, arg5: u32, arg6: u64, arg7: u64, arg8: u64) {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_package_version(arg2);
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        assert!(arg7 > arg8, 1);
        arg3.current_feed_id = arg4;
        arg3.next_feed_id = arg5;
        arg3.expiry_timestamp_ms = arg6;
        arg3.roll_start_days = arg7;
        arg3.cutoff_days = arg8;
        let v0 = FeedMetadata{
            price            : 0,
            confidence_delta : 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source(),
            timestamp_ms     : 0,
        };
        arg3.cached_current_feed = v0;
        let v1 = FeedMetadata{
            price            : 0,
            confidence_delta : 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source(),
            timestamp_ms     : 0,
        };
        arg3.cached_next_feed = v1;
    }

    // decompiled from Move bytecode v6
}

