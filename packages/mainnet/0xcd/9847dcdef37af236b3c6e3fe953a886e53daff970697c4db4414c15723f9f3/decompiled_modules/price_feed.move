module 0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::price_feed {
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

    public(friend) fun update(arg0: &mut PriceFeed, arg1: u64, arg2: u64) {
        arg0.value = arg1;
        arg0.last_updated = arg2;
    }

    public fun value(arg0: &PriceFeed) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

