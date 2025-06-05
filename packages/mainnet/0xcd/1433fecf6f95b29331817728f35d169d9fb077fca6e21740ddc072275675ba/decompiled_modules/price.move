module 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price {
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

