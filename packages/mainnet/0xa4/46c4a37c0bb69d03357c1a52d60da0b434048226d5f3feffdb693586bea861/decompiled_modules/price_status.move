module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_status {
    struct PriceStatus has copy, drop, store {
        status: u64,
    }

    public fun from_u64(arg0: u64) : PriceStatus {
        assert!(arg0 <= 1, 0);
        PriceStatus{status: arg0}
    }

    public fun get_status(arg0: &PriceStatus) : u64 {
        arg0.status
    }

    public fun new_trading() : PriceStatus {
        PriceStatus{status: 1}
    }

    public fun new_unknown() : PriceStatus {
        PriceStatus{status: 0}
    }

    // decompiled from Move bytecode v6
}

