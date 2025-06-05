module 0xe17cfcdd6b7cb905f7efbe13357eea5a04fee08da7523b1b02dd26208dbada68::price {
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

