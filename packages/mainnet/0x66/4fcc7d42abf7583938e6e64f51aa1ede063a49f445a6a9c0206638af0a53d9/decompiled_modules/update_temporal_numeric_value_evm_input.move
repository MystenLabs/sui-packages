module 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input {
    struct UpdateTemporalNumericValueEvmInput has copy, drop, store {
        id: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId,
        temporal_numeric_value: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::TemporalNumericValue,
        publisher_merkle_root: vector<u8>,
        value_compute_alg_hash: vector<u8>,
        r: vector<u8>,
        s: vector<u8>,
        v: u8,
    }

    public fun new(arg0: vector<u8>, arg1: u64, arg2: u128, arg3: bool, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u8) : UpdateTemporalNumericValueEvmInput {
        UpdateTemporalNumericValueEvmInput{
            id                     : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::from_bytes(arg0),
            temporal_numeric_value : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::new(arg1, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::i128::new(arg2, arg3)),
            publisher_merkle_root  : arg4,
            value_compute_alg_hash : arg5,
            r                      : arg6,
            s                      : arg7,
            v                      : arg8,
        }
    }

    public fun get_id(arg0: &UpdateTemporalNumericValueEvmInput) : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId {
        arg0.id
    }

    public fun get_publisher_merkle_root(arg0: &UpdateTemporalNumericValueEvmInput) : vector<u8> {
        arg0.publisher_merkle_root
    }

    public fun get_r(arg0: &UpdateTemporalNumericValueEvmInput) : vector<u8> {
        arg0.r
    }

    public fun get_s(arg0: &UpdateTemporalNumericValueEvmInput) : vector<u8> {
        arg0.s
    }

    public fun get_temporal_numeric_value(arg0: &UpdateTemporalNumericValueEvmInput) : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::TemporalNumericValue {
        arg0.temporal_numeric_value
    }

    public fun get_v(arg0: &UpdateTemporalNumericValueEvmInput) : u8 {
        arg0.v
    }

    public fun get_value_compute_alg_hash(arg0: &UpdateTemporalNumericValueEvmInput) : vector<u8> {
        arg0.value_compute_alg_hash
    }

    // decompiled from Move bytecode v6
}

