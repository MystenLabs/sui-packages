module 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::price_feed {
    struct PriceFeed has copy, drop, store {
        value: u64,
        last_updated: u64,
    }

    public fun decimals() : u8 {
        9
    }

    public fun last_updated(arg0: &PriceFeed) : u64 {
        arg0.last_updated
    }

    public fun new(arg0: u64, arg1: u64) : PriceFeed {
        PriceFeed{
            value        : arg0,
            last_updated : arg1,
        }
    }

    public fun value(arg0: &PriceFeed) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

