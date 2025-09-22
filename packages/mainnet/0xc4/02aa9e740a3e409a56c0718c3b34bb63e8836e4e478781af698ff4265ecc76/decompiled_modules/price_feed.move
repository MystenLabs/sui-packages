module 0xc402aa9e740a3e409a56c0718c3b34bb63e8836e4e478781af698ff4265ecc76::price_feed {
    struct PriceFeed has store, key {
        id: 0x2::object::UID,
        from: 0x2::object::ID,
        price: u256,
        timestamp: u64,
    }

    public fun new(arg0: 0x2::object::ID, arg1: u256, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PriceFeed {
        assert!(!0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::is_neg(arg1), 0);
        PriceFeed{
            id        : 0x2::object::new(arg3),
            from      : arg0,
            price     : arg1,
            timestamp : arg2,
        }
    }

    public(friend) fun destroy(arg0: PriceFeed) {
        let PriceFeed {
            id        : v0,
            from      : _,
            price     : _,
            timestamp : _,
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

    public(friend) fun set_price(arg0: &mut PriceFeed, arg1: u256, arg2: u64) {
        assert!(!0x59d346d409154e137b47dd6f05c7882f5ccd4ef8a7800239d622ac74083b271::ifixed::is_neg(arg1), 0);
        if (arg2 < arg0.timestamp) {
            return
        };
        arg0.price = arg1;
        arg0.timestamp = arg2;
    }

    public fun timestamp(arg0: &PriceFeed) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

