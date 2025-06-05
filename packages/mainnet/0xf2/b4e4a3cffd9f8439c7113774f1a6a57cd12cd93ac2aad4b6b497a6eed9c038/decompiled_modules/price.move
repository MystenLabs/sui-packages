module 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::price {
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

