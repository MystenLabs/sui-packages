module 0x63c7def4e55061f4c98e2bc8e4e80bfaf59da3562f6db99f109d38262c3d2b4::price_feed {
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

