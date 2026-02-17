module 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed {
    struct Feed has copy, drop {
        feed_id: u32,
        price: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>,
        best_bid_price: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>,
        best_ask_price: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>,
        publisher_count: 0x1::option::Option<u16>,
        exponent: 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>,
        confidence: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>,
        funding_rate: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>,
        funding_timestamp: 0x1::option::Option<0x1::option::Option<u64>>,
        funding_rate_interval: 0x1::option::Option<0x1::option::Option<u64>>,
        market_session: 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>,
        ema_price: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>,
        ema_confidence: 0x1::option::Option<0x1::option::Option<u64>>,
        feed_update_timestamp: 0x1::option::Option<0x1::option::Option<u64>>,
    }

    public fun best_ask_price(arg0: &Feed) : 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>> {
        arg0.best_ask_price
    }

    public fun best_bid_price(arg0: &Feed) : 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>> {
        arg0.best_bid_price
    }

    public fun confidence(arg0: &Feed) : 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>> {
        arg0.confidence
    }

    public fun ema_confidence(arg0: &Feed) : 0x1::option::Option<0x1::option::Option<u64>> {
        arg0.ema_confidence
    }

    public fun ema_price(arg0: &Feed) : 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>> {
        arg0.ema_price
    }

    public fun exponent(arg0: &Feed) : 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16> {
        arg0.exponent
    }

    public fun feed_id(arg0: &Feed) : u32 {
        arg0.feed_id
    }

    public fun feed_update_timestamp(arg0: &Feed) : 0x1::option::Option<0x1::option::Option<u64>> {
        arg0.feed_update_timestamp
    }

    public fun funding_rate(arg0: &Feed) : 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>> {
        arg0.funding_rate
    }

    public fun funding_rate_interval(arg0: &Feed) : 0x1::option::Option<0x1::option::Option<u64>> {
        arg0.funding_rate_interval
    }

    public fun funding_timestamp(arg0: &Feed) : 0x1::option::Option<0x1::option::Option<u64>> {
        arg0.funding_timestamp
    }

    public fun market_session(arg0: &Feed) : 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession> {
        arg0.market_session
    }

    public(friend) fun new(arg0: u32, arg1: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>, arg2: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>, arg3: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>, arg4: 0x1::option::Option<u16>, arg5: 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>, arg6: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>, arg7: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>, arg8: 0x1::option::Option<0x1::option::Option<u64>>, arg9: 0x1::option::Option<0x1::option::Option<u64>>, arg10: 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>, arg11: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>, arg12: 0x1::option::Option<0x1::option::Option<u64>>, arg13: 0x1::option::Option<0x1::option::Option<u64>>) : Feed {
        Feed{
            feed_id               : arg0,
            price                 : arg1,
            best_bid_price        : arg2,
            best_ask_price        : arg3,
            publisher_count       : arg4,
            exponent              : arg5,
            confidence            : arg6,
            funding_rate          : arg7,
            funding_timestamp     : arg8,
            funding_rate_interval : arg9,
            market_session        : arg10,
            ema_price             : arg11,
            ema_confidence        : arg12,
            feed_update_timestamp : arg13,
        }
    }

    public(friend) fun parse_from_cursor(arg0: &mut 0x2::bcs::BCS) : Feed {
        let v0 = new(0x2::bcs::peel_u32(arg0), 0x1::option::none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(), 0x1::option::none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(), 0x1::option::none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(), 0x1::option::none<u16>(), 0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(), 0x1::option::none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(), 0x1::option::none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(), 0x1::option::none<0x1::option::Option<u64>>(), 0x1::option::none<0x1::option::Option<u64>>(), 0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(), 0x1::option::none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(), 0x1::option::none<0x1::option::Option<u64>>(), 0x1::option::none<0x1::option::Option<u64>>());
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_u8(arg0)) {
            let v2 = 0x2::bcs::peel_u8(arg0);
            if (v2 == 0) {
                let v3 = 0x2::bcs::peel_u64(arg0);
                if (v3 != 0) {
                    let v4 = &mut v0;
                    set_price(v4, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::from_u64(v3))));
                } else {
                    let v5 = &mut v0;
                    set_price(v5, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()));
                };
            } else if (v2 == 1) {
                let v6 = 0x2::bcs::peel_u64(arg0);
                if (v6 != 0) {
                    let v7 = &mut v0;
                    set_best_bid_price(v7, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::from_u64(v6))));
                } else {
                    let v8 = &mut v0;
                    set_best_bid_price(v8, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()));
                };
            } else if (v2 == 2) {
                let v9 = 0x2::bcs::peel_u64(arg0);
                if (v9 != 0) {
                    let v10 = &mut v0;
                    set_best_ask_price(v10, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::from_u64(v9))));
                } else {
                    let v11 = &mut v0;
                    set_best_ask_price(v11, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()));
                };
            } else if (v2 == 3) {
                let v12 = &mut v0;
                set_publisher_count(v12, 0x1::option::some<u16>(0x2::bcs::peel_u16(arg0)));
            } else if (v2 == 4) {
                let v13 = &mut v0;
                set_exponent(v13, 0x1::option::some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::from_u16(0x2::bcs::peel_u16(arg0))));
            } else if (v2 == 5) {
                let v14 = 0x2::bcs::peel_u64(arg0);
                if (v14 != 0) {
                    let v15 = &mut v0;
                    set_confidence(v15, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::from_u64(v14))));
                } else {
                    let v16 = &mut v0;
                    set_confidence(v16, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()));
                };
            } else if (v2 == 6) {
                if (0x2::bcs::peel_bool(arg0)) {
                    let v17 = &mut v0;
                    set_funding_rate(v17, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::from_u64(0x2::bcs::peel_u64(arg0)))));
                } else {
                    let v18 = &mut v0;
                    set_funding_rate(v18, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()));
                };
            } else if (v2 == 7) {
                if (0x2::bcs::peel_bool(arg0)) {
                    let v19 = &mut v0;
                    set_funding_timestamp(v19, 0x1::option::some<0x1::option::Option<u64>>(0x1::option::some<u64>(0x2::bcs::peel_u64(arg0))));
                } else {
                    let v20 = &mut v0;
                    set_funding_timestamp(v20, 0x1::option::some<0x1::option::Option<u64>>(0x1::option::none<u64>()));
                };
            } else if (v2 == 8) {
                if (0x2::bcs::peel_bool(arg0)) {
                    let v21 = &mut v0;
                    set_funding_rate_interval(v21, 0x1::option::some<0x1::option::Option<u64>>(0x1::option::some<u64>(0x2::bcs::peel_u64(arg0))));
                } else {
                    let v22 = &mut v0;
                    set_funding_rate_interval(v22, 0x1::option::some<0x1::option::Option<u64>>(0x1::option::none<u64>()));
                };
            } else if (v2 == 9) {
                let v23 = &mut v0;
                set_market_session(v23, 0x1::option::some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::from_u16(0x2::bcs::peel_u16(arg0))));
            } else if (v2 == 10) {
                let v24 = 0x2::bcs::peel_u64(arg0);
                if (v24 != 0) {
                    let v25 = &mut v0;
                    set_ema_price(v25, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::from_u64(v24))));
                } else {
                    let v26 = &mut v0;
                    set_ema_price(v26, 0x1::option::some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>()));
                };
            } else if (v2 == 11) {
                let v27 = 0x2::bcs::peel_u64(arg0);
                if (v27 != 0) {
                    let v28 = &mut v0;
                    set_ema_confidence(v28, 0x1::option::some<0x1::option::Option<u64>>(0x1::option::some<u64>(v27)));
                } else {
                    let v29 = &mut v0;
                    set_ema_confidence(v29, 0x1::option::some<0x1::option::Option<u64>>(0x1::option::none<u64>()));
                };
            } else {
                assert!(v2 == 12, 13906835716236640257);
                if (0x2::bcs::peel_bool(arg0)) {
                    let v30 = &mut v0;
                    set_feed_update_timestamp(v30, 0x1::option::some<0x1::option::Option<u64>>(0x1::option::some<u64>(0x2::bcs::peel_u64(arg0))));
                } else {
                    let v31 = &mut v0;
                    set_feed_update_timestamp(v31, 0x1::option::some<0x1::option::Option<u64>>(0x1::option::none<u64>()));
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun price(arg0: &Feed) : 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>> {
        arg0.price
    }

    public fun publisher_count(arg0: &Feed) : 0x1::option::Option<u16> {
        arg0.publisher_count
    }

    public(friend) fun set_best_ask_price(arg0: &mut Feed, arg1: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) {
        arg0.best_ask_price = arg1;
    }

    public(friend) fun set_best_bid_price(arg0: &mut Feed, arg1: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) {
        arg0.best_bid_price = arg1;
    }

    public(friend) fun set_confidence(arg0: &mut Feed, arg1: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) {
        arg0.confidence = arg1;
    }

    public(friend) fun set_ema_confidence(arg0: &mut Feed, arg1: 0x1::option::Option<0x1::option::Option<u64>>) {
        arg0.ema_confidence = arg1;
    }

    public(friend) fun set_ema_price(arg0: &mut Feed, arg1: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) {
        arg0.ema_price = arg1;
    }

    public(friend) fun set_exponent(arg0: &mut Feed, arg1: 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>) {
        arg0.exponent = arg1;
    }

    public(friend) fun set_feed_id(arg0: &mut Feed, arg1: u32) {
        arg0.feed_id = arg1;
    }

    public(friend) fun set_feed_update_timestamp(arg0: &mut Feed, arg1: 0x1::option::Option<0x1::option::Option<u64>>) {
        arg0.feed_update_timestamp = arg1;
    }

    public(friend) fun set_funding_rate(arg0: &mut Feed, arg1: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) {
        arg0.funding_rate = arg1;
    }

    public(friend) fun set_funding_rate_interval(arg0: &mut Feed, arg1: 0x1::option::Option<0x1::option::Option<u64>>) {
        arg0.funding_rate_interval = arg1;
    }

    public(friend) fun set_funding_timestamp(arg0: &mut Feed, arg1: 0x1::option::Option<0x1::option::Option<u64>>) {
        arg0.funding_timestamp = arg1;
    }

    public(friend) fun set_market_session(arg0: &mut Feed, arg1: 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>) {
        arg0.market_session = arg1;
    }

    public(friend) fun set_price(arg0: &mut Feed, arg1: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) {
        arg0.price = arg1;
    }

    public(friend) fun set_publisher_count(arg0: &mut Feed, arg1: 0x1::option::Option<u16>) {
        arg0.publisher_count = arg1;
    }

    // decompiled from Move bytecode v6
}

