module 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_feed {
    struct PriceFeed has copy, drop, store {
        value: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal,
        last_updated: u64,
        confidence: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal,
    }

    public fun acceptable_conf_tolerance_bps() : u64 {
        200
    }

    public fun acceptable_diff_bps() : u64 {
        100
    }

    public fun assert_acceptable_diff(arg0: &PriceFeed, arg1: &PriceFeed) {
        assert!(is_acceptable_diff(arg0, arg1), 4);
    }

    public fun assert_price_feed_confidence_tolerance(arg0: &PriceFeed) {
        assert!(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::le(arg0.confidence, arg0.value), 5);
        assert!(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::ceil(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(arg0.confidence, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(10000)), arg0.value)) <= acceptable_conf_tolerance_bps(), 3);
    }

    public fun assert_price_feed_stale(arg0: &PriceFeed, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(arg0.last_updated <= v0, 1);
        assert!(v0 - arg0.last_updated < staleness_threshold(), 2);
    }

    public fun confidence(arg0: &PriceFeed) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        arg0.confidence
    }

    public fun is_acceptable_diff(arg0: &PriceFeed, arg1: &PriceFeed) : bool {
        let v0 = if (0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::gt(arg0.value, arg1.value)) {
            0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::sub(arg0.value, arg1.value)
        } else {
            0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::sub(arg1.value, arg0.value)
        };
        0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::le(v0, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(arg0.value, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(acceptable_diff_bps())), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(10000)))
    }

    public fun last_updated(arg0: &PriceFeed) : u64 {
        arg0.last_updated
    }

    public fun new(arg0: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal, arg1: u64, arg2: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal) : PriceFeed {
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
        assert!(!0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::is_zero(&arg0.value), 0);
        assert_price_feed_confidence_tolerance(arg0);
        assert_price_feed_stale(arg0, arg1);
    }

    public fun value(arg0: &PriceFeed) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

