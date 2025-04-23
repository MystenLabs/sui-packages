module 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value {
    struct TemporalNumericValue has copy, drop, store {
        timestamp_ns: u64,
        quantized_value: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::I128,
    }

    public fun get_quantized_value(arg0: &TemporalNumericValue) : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::I128 {
        arg0.quantized_value
    }

    public fun get_timestamp_ns(arg0: &TemporalNumericValue) : u64 {
        arg0.timestamp_ns
    }

    public fun new(arg0: u64, arg1: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::I128) : TemporalNumericValue {
        TemporalNumericValue{
            timestamp_ns    : arg0,
            quantized_value : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

