module 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::price_status {
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

    // decompiled from Move bytecode v7
}

