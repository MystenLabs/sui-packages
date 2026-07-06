module 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::stork_feed {
    struct StorkFeedInfo has store {
        feed_id: vector<u8>,
        ema_feed_id: vector<u8>,
        last_updated_nano: u64,
        ema_last_updated_nano: u64,
    }

    fun assert_price_newer(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0 >= arg1, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::stork_price_too_old());
        assert!(arg0 <= 0x2::clock::timestamp_ms(arg2) * 1000000, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::future_stork_price());
    }

    public(friend) fun destroy(arg0: StorkFeedInfo) {
        let StorkFeedInfo {
            feed_id               : _,
            ema_feed_id           : _,
            last_updated_nano     : _,
            ema_last_updated_nano : _,
        } = arg0;
    }

    fun extract_stork_price(arg0: vector<u8>, arg1: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::stork::get_temporal_numeric_value_unchecked(arg1, arg0);
        let v1 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v0);
        assert_price_newer(v1, arg2, arg3);
        let v2 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_quantized_value(&v0);
        (to_normalized_u64(0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::get_magnitude_if_positive(&v2)), v1)
    }

    public(friend) fun new(arg0: vector<u8>, arg1: vector<u8>) : StorkFeedInfo {
        StorkFeedInfo{
            feed_id               : arg0,
            ema_feed_id           : arg1,
            last_updated_nano     : 0,
            ema_last_updated_nano : 0,
        }
    }

    public(friend) fun refresh_stork_price(arg0: &mut StorkFeedInfo, arg1: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg2: &0x2::clock::Clock) : (0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeedComponent, 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::PriceFeedComponent) {
        let (v0, v1) = extract_stork_price(arg0.feed_id, arg1, arg0.last_updated_nano, arg2);
        arg0.last_updated_nano = v1;
        let (v2, v3) = extract_stork_price(arg0.ema_feed_id, arg1, arg0.ema_last_updated_nano, arg2);
        arg0.ema_last_updated_nano = v3;
        (0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::new_component(v0, v1 / 1000000000), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::new_component(v2, v3 / 1000000000))
    }

    public(friend) fun to_normalized_u64(arg0: u128) : u64 {
        0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::price_feed::safe_cast_to_u64(arg0 / 1000000000)
    }

    public(friend) fun update_feed_ids(arg0: &mut StorkFeedInfo, arg1: vector<u8>, arg2: vector<u8>) {
        arg0.feed_id = arg1;
        arg0.ema_feed_id = arg2;
    }

    // decompiled from Move bytecode v7
}

