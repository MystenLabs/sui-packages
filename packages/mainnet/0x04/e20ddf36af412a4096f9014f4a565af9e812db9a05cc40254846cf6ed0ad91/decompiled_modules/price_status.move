module 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_status {
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

