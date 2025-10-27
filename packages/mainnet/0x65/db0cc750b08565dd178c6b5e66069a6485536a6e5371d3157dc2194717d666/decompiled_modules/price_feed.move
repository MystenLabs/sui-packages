module 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::price_feed {
    struct PriceFeed has store, key {
        id: 0x2::object::UID,
        from: 0x2::object::ID,
        price: u256,
        timestamp: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u256, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PriceFeed {
        assert!(!0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::is_neg(arg1), 0);
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
        assert!(!0xc15ee4dcdc9f93d19c9c0c28dfca2c91a650747b5cebcdba67b5191bee9290b0::ifixed::is_neg(arg1), 0);
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

