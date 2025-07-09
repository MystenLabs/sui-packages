module 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed {
    struct TemporalNumericValueFeed has store, key {
        id: 0x2::object::UID,
        asset_id: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId,
        latest_value: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::TemporalNumericValue,
    }

    public(friend) fun new(arg0: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, arg1: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::TemporalNumericValue, arg2: &mut 0x2::tx_context::TxContext) : TemporalNumericValueFeed {
        TemporalNumericValueFeed{
            id           : 0x2::object::new(arg2),
            asset_id     : arg0,
            latest_value : arg1,
        }
    }

    public fun get_asset_id(arg0: &TemporalNumericValueFeed) : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId {
        arg0.asset_id
    }

    public fun get_latest_canonical_temporal_numeric_value_unchecked(arg0: &TemporalNumericValueFeed) : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::TemporalNumericValue {
        arg0.latest_value
    }

    public(friend) fun set_latest_value(arg0: &mut TemporalNumericValueFeed, arg1: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::TemporalNumericValue) {
        arg0.latest_value = arg1;
    }

    // decompiled from Move bytecode v6
}

