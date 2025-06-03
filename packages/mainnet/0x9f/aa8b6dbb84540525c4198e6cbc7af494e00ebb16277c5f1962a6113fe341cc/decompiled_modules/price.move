module 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price {
    struct Price has copy, drop, store {
        value: u256,
        timestamp_ms: u64,
    }

    public(friend) fun get_timestamp_ms(arg0: Price) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun get_value(arg0: Price) : u256 {
        arg0.value
    }

    public(friend) fun new(arg0: u256, arg1: u64) : Price {
        Price{
            value        : arg0,
            timestamp_ms : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

