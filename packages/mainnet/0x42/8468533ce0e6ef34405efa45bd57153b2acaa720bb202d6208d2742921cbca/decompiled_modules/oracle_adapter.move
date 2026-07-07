module 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::oracle_adapter {
    struct SlippageValidated has copy, drop {
        price_a: u128,
        price_b: u128,
        deviation_scaled: u128,
        threshold: u128,
    }

    public fun get_validated_price<T0>(arg0: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg3: &0x2::clock::Clock, arg4: u64) : 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::NormalizedPrice {
        0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::oracle::get_validated_price<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun is_price_stale(arg0: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::NormalizedPrice, arg1: u64, arg2: u64) : bool {
        0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::oracle::is_price_stale(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

