module 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price {
    struct Price has copy, drop, store {
        value: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal,
        timestamp_ms: u64,
    }

    public(friend) fun get_price(arg0: Price) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        arg0.value
    }

    public(friend) fun get_timestamp_ms(arg0: Price) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun new(arg0: 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, arg1: u64) : Price {
        Price{
            value        : arg0,
            timestamp_ms : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

