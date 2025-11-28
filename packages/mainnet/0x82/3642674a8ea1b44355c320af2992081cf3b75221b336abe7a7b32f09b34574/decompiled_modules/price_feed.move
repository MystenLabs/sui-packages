module 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::price_feed {
    struct PriceFeed has store, key {
        id: 0x2::object::UID,
        from: 0x2::object::ID,
        price: u256,
        confidence: u64,
        confidence_delta: u256,
        timestamp: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : PriceFeed {
        assert!(!0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::is_neg(arg1), 0);
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
        assert!(!0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::is_neg(arg1), 0);
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

