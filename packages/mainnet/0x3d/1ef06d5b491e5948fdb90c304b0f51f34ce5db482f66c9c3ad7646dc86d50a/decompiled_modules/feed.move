module 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed {
    struct Feed has copy, drop {
        feed_id: u32,
        price: u64,
        exponent: u16,
        feed_update_timestamp: u64,
        publisher_count: u16,
        market_session: u16,
        confidence: 0x1::option::Option<u64>,
        best_bid_price: 0x1::option::Option<u64>,
        best_ask_price: 0x1::option::Option<u64>,
        ema_price: 0x1::option::Option<u64>,
        ema_confidence: 0x1::option::Option<u64>,
        funding_rate: 0x1::option::Option<u64>,
        funding_timestamp: 0x1::option::Option<u64>,
        funding_rate_interval: 0x1::option::Option<u64>,
    }

    public fun best_ask_price_bits(arg0: &Feed) : 0x1::option::Option<u64> {
        arg0.best_ask_price
    }

    public fun best_bid_price_bits(arg0: &Feed) : 0x1::option::Option<u64> {
        arg0.best_bid_price
    }

    public fun confidence_bits(arg0: &Feed) : 0x1::option::Option<u64> {
        arg0.confidence
    }

    public fun ema_confidence(arg0: &Feed) : 0x1::option::Option<u64> {
        arg0.ema_confidence
    }

    public fun ema_price_bits(arg0: &Feed) : 0x1::option::Option<u64> {
        arg0.ema_price
    }

    public fun exponent_sign_magnitude(arg0: &Feed) : (bool, u16) {
        let v0 = arg0.exponent;
        if (v0 >= 32768) {
            (true, (v0 ^ 65535) + 1)
        } else {
            (false, v0)
        }
    }

    public fun feed_id(arg0: &Feed) : u32 {
        arg0.feed_id
    }

    public fun funding_rate_bits(arg0: &Feed) : 0x1::option::Option<u64> {
        arg0.funding_rate
    }

    public fun funding_rate_interval(arg0: &Feed) : 0x1::option::Option<u64> {
        arg0.funding_rate_interval
    }

    public fun funding_timestamp(arg0: &Feed) : 0x1::option::Option<u64> {
        arg0.funding_timestamp
    }

    public fun market_session(arg0: &Feed) : u16 {
        arg0.market_session
    }

    public(friend) fun parse_from_cursor(arg0: &mut 0x2::bcs::BCS) : Feed {
        let v0 = Feed{
            feed_id               : 0x2::bcs::peel_u32(arg0),
            price                 : 0x2::bcs::peel_u64(arg0),
            exponent              : 0x2::bcs::peel_u16(arg0),
            feed_update_timestamp : 0x2::bcs::peel_u64(arg0),
            publisher_count       : 0x2::bcs::peel_u16(arg0),
            market_session        : 0x2::bcs::peel_u16(arg0),
            confidence            : 0x1::option::none<u64>(),
            best_bid_price        : 0x1::option::none<u64>(),
            best_ask_price        : 0x1::option::none<u64>(),
            ema_price             : 0x1::option::none<u64>(),
            ema_confidence        : 0x1::option::none<u64>(),
            funding_rate          : 0x1::option::none<u64>(),
            funding_timestamp     : 0x1::option::none<u64>(),
            funding_rate_interval : 0x1::option::none<u64>(),
        };
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_u8(arg0)) {
            let v2 = 0x2::bcs::peel_u8(arg0);
            if (v2 == 0) {
                v0.confidence = 0x1::option::some<u64>(0x2::bcs::peel_u64(arg0));
            } else if (v2 == 1) {
                v0.best_bid_price = 0x1::option::some<u64>(0x2::bcs::peel_u64(arg0));
            } else if (v2 == 2) {
                v0.best_ask_price = 0x1::option::some<u64>(0x2::bcs::peel_u64(arg0));
            } else if (v2 == 3) {
                v0.ema_price = 0x1::option::some<u64>(0x2::bcs::peel_u64(arg0));
            } else if (v2 == 4) {
                v0.ema_confidence = 0x1::option::some<u64>(0x2::bcs::peel_u64(arg0));
            } else if (v2 == 5) {
                v0.funding_rate = 0x1::option::some<u64>(0x2::bcs::peel_u64(arg0));
            } else if (v2 == 6) {
                v0.funding_timestamp = 0x1::option::some<u64>(0x2::bcs::peel_u64(arg0));
            } else {
                assert!(v2 == 7, 13906834552300503041);
                v0.funding_rate_interval = 0x1::option::some<u64>(0x2::bcs::peel_u64(arg0));
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_sign_magnitude(arg0: &Feed) : (bool, u64) {
        let v0 = arg0.price;
        if (v0 >= 9223372036854775808) {
            (true, (v0 ^ 18446744073709551615) + 1)
        } else {
            (false, v0)
        }
    }

    public fun publisher_count(arg0: &Feed) : u16 {
        arg0.publisher_count
    }

    public fun timestamp(arg0: &Feed) : u64 {
        arg0.feed_update_timestamp
    }

    public fun timestamp_ms(arg0: &Feed) : u64 {
        arg0.feed_update_timestamp / 1000
    }

    // decompiled from Move bytecode v7
}

