module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price_status {
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

