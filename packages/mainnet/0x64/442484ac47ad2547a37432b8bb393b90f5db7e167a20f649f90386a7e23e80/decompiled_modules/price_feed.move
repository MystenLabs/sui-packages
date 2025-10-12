module 0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::price_feed {
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

