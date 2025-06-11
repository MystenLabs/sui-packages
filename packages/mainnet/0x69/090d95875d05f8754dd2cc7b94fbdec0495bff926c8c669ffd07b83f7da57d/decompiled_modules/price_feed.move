module 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed {
    struct PriceFeed has copy, drop, store {
        value: 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::Price,
        last_updated: u64,
        confidence: u128,
    }

    public fun acceptable_conf_tolerance_bps() : u128 {
        200
    }

    public fun acceptable_diff_bps() : u128 {
        100
    }

    public fun assert_acceptable_diff(arg0: &PriceFeed, arg1: &PriceFeed) {
        assert!(is_acceptable_diff(arg0, arg1), 4);
    }

    public fun assert_price_feed_confidence_tolerance(arg0: &PriceFeed) {
        assert!(arg0.confidence * 10000 / 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::base(&arg0.value) <= acceptable_conf_tolerance_bps(), 3);
    }

    public fun assert_price_feed_stale(arg0: &PriceFeed, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(arg0.last_updated <= v0, 1);
        assert!(v0 - arg0.last_updated < staleness_threshold(), 2);
    }

    public fun confidence(arg0: &PriceFeed) : u128 {
        arg0.confidence
    }

    public fun is_acceptable_diff(arg0: &PriceFeed, arg1: &PriceFeed) : bool {
        let v0 = if (0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::base(&arg0.value) > 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::base(&arg1.value)) {
            0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::base(&arg0.value) - 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::base(&arg1.value)
        } else {
            0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::base(&arg1.value) - 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::base(&arg0.value)
        };
        v0 <= 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::base(&arg0.value) * acceptable_diff_bps() / 10000
    }

    public fun last_updated(arg0: &PriceFeed) : u64 {
        arg0.last_updated
    }

    public fun new(arg0: 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::Price, arg1: u64, arg2: u128) : PriceFeed {
        PriceFeed{
            value        : arg0,
            last_updated : arg1,
            confidence   : arg2,
        }
    }

    public fun staleness_threshold() : u64 {
        14400
    }

    public(friend) fun to_owned(arg0: &PriceFeed) : PriceFeed {
        PriceFeed{
            value        : arg0.value,
            last_updated : arg0.last_updated,
            confidence   : arg0.confidence,
        }
    }

    public fun validate_basic(arg0: &PriceFeed, arg1: &0x2::clock::Clock) {
        assert!(!0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::is_zero(&arg0.value), 0);
        assert_price_feed_confidence_tolerance(arg0);
        assert_price_feed_stale(arg0, arg1);
    }

    public fun value(arg0: &PriceFeed) : 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::Price {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

