module 0xe69b497088a27b95c788a77b8916066e922b5942bdde2d83f9df413d4b2c0f12::price_status {
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

