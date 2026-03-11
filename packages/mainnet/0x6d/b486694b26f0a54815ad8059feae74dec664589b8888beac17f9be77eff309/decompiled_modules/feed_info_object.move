module 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::feed_info_object {
    struct FeedInfoObjectKey has copy, drop, store {
        pos0: u32,
    }

    struct FeedMetadata has copy, drop, store {
        price: u256,
        confidence_delta: u256,
        timestamp_ms: u64,
    }

    struct FeedInfoObject has store, key {
        id: 0x2::object::UID,
        feed_id: u32,
        cached_feed: FeedMetadata,
    }

    public(friend) fun as_parts(arg0: &FeedMetadata) : (u256, u256, u64) {
        (arg0.price, arg0.confidence_delta, arg0.timestamp_ms)
    }

    public(friend) fun cached_feed(arg0: &FeedInfoObject) : FeedMetadata {
        arg0.cached_feed
    }

    public fun feed_id(arg0: &FeedInfoObject) : u32 {
        arg0.feed_id
    }

    public(friend) fun is_fresh(arg0: &FeedMetadata) : bool {
        arg0.timestamp_ms != 0
    }

    public(friend) fun maybe_cache_quote(arg0: &mut FeedInfoObject, arg1: u256, arg2: u256, arg3: u64) {
        if (arg3 < arg0.cached_feed.timestamp_ms) {
            return
        };
        let v0 = FeedMetadata{
            price            : arg1,
            confidence_delta : arg2,
            timestamp_ms     : arg3,
        };
        arg0.cached_feed = v0;
    }

    public fun new<T0>(arg0: &mut 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::pyth_lazer::OracleAggregatorPythLazerIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: u32) : FeedInfoObject {
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_package_version(arg2);
        0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::assert_authority_cap_is_valid<T0>(arg2, arg1);
        let v0 = 0x6db486694b26f0a54815ad8059feae74dec664589b8888beac17f9be77eff309::pyth_lazer::borrow_mut_id<T0>(arg0, arg1);
        let v1 = FeedInfoObjectKey{pos0: arg3};
        assert!(!0x2::derived_object::exists<FeedInfoObjectKey>(v0, v1), 0);
        let v2 = FeedMetadata{
            price            : 0,
            confidence_delta : 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed::confidence_not_reported_by_source(),
            timestamp_ms     : 0,
        };
        FeedInfoObject{
            id          : 0x2::derived_object::claim<FeedInfoObjectKey>(v0, v1),
            feed_id     : arg3,
            cached_feed : v2,
        }
    }

    public(friend) fun price(arg0: &FeedMetadata) : u256 {
        arg0.price
    }

    public(friend) fun timestamp_ms(arg0: &FeedMetadata) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v6
}

