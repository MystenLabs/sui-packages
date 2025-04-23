module 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::event {
    struct StorkInitializationEvent has copy, drop {
        stork_sui_address: address,
        stork_evm_public_key: vector<u8>,
        single_update_fee: u64,
        stork_state_id: 0x2::object::ID,
        stork_state_version: u64,
    }

    struct FeeWithdrawalEvent has copy, drop {
        amount: u64,
    }

    struct TemporalNumericValueFeedUpdateEvent has copy, drop {
        asset_id: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId,
        value: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::TemporalNumericValue,
    }

    public(friend) fun emit_fee_withdrawal_event(arg0: u64) {
        let v0 = FeeWithdrawalEvent{amount: arg0};
        0x2::event::emit<FeeWithdrawalEvent>(v0);
    }

    public(friend) fun emit_stork_initialization_event(arg0: address, arg1: vector<u8>, arg2: u64, arg3: 0x2::object::ID, arg4: u64) {
        let v0 = StorkInitializationEvent{
            stork_sui_address    : arg0,
            stork_evm_public_key : arg1,
            single_update_fee    : arg2,
            stork_state_id       : arg3,
            stork_state_version  : arg4,
        };
        0x2::event::emit<StorkInitializationEvent>(v0);
    }

    public(friend) fun emit_temporal_numeric_value_feed_update_event(arg0: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, arg1: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::TemporalNumericValue) {
        let v0 = TemporalNumericValueFeedUpdateEvent{
            asset_id : arg0,
            value    : arg1,
        };
        0x2::event::emit<TemporalNumericValueFeedUpdateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

