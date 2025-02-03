module 0x9bfbbad97c878b9e621542b2c8ed48ace6c18a78f3a6f2d46f5fbf62a53bc498::price_feed {
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

