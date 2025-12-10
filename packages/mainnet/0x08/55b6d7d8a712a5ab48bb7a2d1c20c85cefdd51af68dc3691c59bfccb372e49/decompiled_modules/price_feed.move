module 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed {
    struct PriceFeed has store, key {
        id: 0x2::object::UID,
        from: 0x2::object::ID,
        price: u256,
        confidence: u64,
        confidence_delta: u256,
        timestamp: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : PriceFeed {
        assert!(!0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::is_neg(arg1), 0);
        assert!(arg2 <= arg1, 1);
        let v0 = if (arg2 == 0) {
            0
        } else {
            ((1000000000000000000 - arg2 * 1000000000000000000 / arg1) as u64)
        };
        PriceFeed{
            id               : 0x2::object::new(arg4),
            from             : arg0,
            price            : arg1,
            confidence       : v0,
            confidence_delta : arg2,
            timestamp        : arg3,
        }
    }

    public(friend) fun as_parts(arg0: &PriceFeed) : (u256, u64, u256, u64) {
        (arg0.price, arg0.confidence, arg0.confidence_delta, arg0.timestamp)
    }

    public fun confidence(arg0: &PriceFeed) : u64 {
        arg0.confidence
    }

    public fun confidence_delta(arg0: &PriceFeed) : u256 {
        arg0.confidence_delta
    }

    public fun confidence_not_reported_by_source() : u256 {
        0
    }

    public(friend) fun destroy(arg0: PriceFeed) {
        let PriceFeed {
            id               : v0,
            from             : _,
            price            : _,
            confidence       : _,
            confidence_delta : _,
            timestamp        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun from(arg0: &PriceFeed) : 0x2::object::ID {
        arg0.from
    }

    public fun price(arg0: &PriceFeed) : u256 {
        arg0.price
    }

    public fun price_and_timestamp(arg0: &PriceFeed) : (u256, u64) {
        (arg0.price, arg0.timestamp)
    }

    public fun price_with_bounds(arg0: &PriceFeed) : (u256, u256, u256) {
        (arg0.price, arg0.price - arg0.confidence_delta, arg0.price + arg0.confidence_delta)
    }

    public(friend) fun set_price(arg0: &mut PriceFeed, arg1: u256, arg2: u256, arg3: u64) {
        if (arg3 < arg0.timestamp) {
            return
        };
        assert!(!0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::is_neg(arg1), 0);
        assert!(arg2 <= arg1, 1);
        arg0.price = arg1;
        let v0 = if (arg2 == 0) {
            0
        } else {
            ((1000000000000000000 - arg2 * 1000000000000000000 / arg1) as u64)
        };
        arg0.confidence = v0;
        arg0.confidence_delta = arg2;
        arg0.timestamp = arg3;
    }

    public fun timestamp(arg0: &PriceFeed) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

