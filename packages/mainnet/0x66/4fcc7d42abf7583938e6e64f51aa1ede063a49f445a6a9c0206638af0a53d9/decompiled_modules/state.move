module 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state {
    struct StorkState has key {
        id: 0x2::object::UID,
        stork_sui_address: address,
        stork_evm_public_key: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::EvmPubkey,
        single_update_fee_in_mist: u64,
        version: u64,
    }

    public(friend) fun new(arg0: address, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : StorkState {
        assert!(arg3 == 2, 0);
        let v0 = 0x2::object::new(arg4);
        0x2::dynamic_object_field::add<vector<u8>, 0x2::object_table::ObjectTable<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>>(&mut v0, b"temporal_numeric_value_feed_registry", 0x2::object_table::new<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>(arg4));
        0x2::dynamic_object_field::add<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v0, b"treasury", 0x2::coin::zero<0x2::sui::SUI>(arg4));
        StorkState{
            id                        : v0,
            stork_sui_address         : arg0,
            stork_evm_public_key      : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::from_bytes(arg1),
            single_update_fee_in_mist : arg2,
            version                   : arg3,
        }
    }

    public(friend) fun borrow_tnv_feeds_registry(arg0: &StorkState) : &0x2::object_table::ObjectTable<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed> {
        assert!(arg0.version == 2, 0);
        0x2::dynamic_object_field::borrow<vector<u8>, 0x2::object_table::ObjectTable<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>>(&arg0.id, b"temporal_numeric_value_feed_registry")
    }

    public(friend) fun borrow_tnv_feeds_registry_mut(arg0: &mut StorkState) : &mut 0x2::object_table::ObjectTable<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed> {
        assert!(arg0.version == 2, 0);
        0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::object_table::ObjectTable<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>>(&mut arg0.id, b"temporal_numeric_value_feed_registry")
    }

    public fun deposit_fee(arg0: &mut StorkState, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.version == 2, 0);
        0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, b"treasury"), arg1);
    }

    public fun get_single_update_fee_in_mist(arg0: &StorkState) : u64 {
        assert!(arg0.version == 2, 0);
        arg0.single_update_fee_in_mist
    }

    public fun get_stork_evm_public_key(arg0: &StorkState) : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::EvmPubkey {
        assert!(arg0.version == 2, 0);
        arg0.stork_evm_public_key
    }

    public fun get_stork_sui_address(arg0: &StorkState) : address {
        assert!(arg0.version == 2, 0);
        arg0.stork_sui_address
    }

    public fun get_total_fees_in_mist(arg0: &StorkState, arg1: u64) : u64 {
        assert!(arg0.version == 2, 0);
        get_single_update_fee_in_mist(arg0) * arg1
    }

    public fun get_version(arg0: &StorkState) : u64 {
        assert!(arg0.version == 2, 0);
        arg0.version
    }

    entry fun migrate(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::admin::AdminCap, arg1: &mut StorkState, arg2: u64, arg3: address) {
        assert!(arg1.version == 2 - 1, 0);
        arg1.stork_sui_address = arg3;
        arg1.version = arg2;
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::event::emit_stork_initialization_event(arg3, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::get_bytes(&arg1.stork_evm_public_key), arg1.single_update_fee_in_mist, 0x2::object::id<StorkState>(arg1), arg1.version);
    }

    public(friend) fun share(arg0: StorkState) {
        0x2::transfer::share_object<StorkState>(arg0);
    }

    public fun update_single_update_fee_in_mist(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::admin::AdminCap, arg1: &mut StorkState, arg2: u64) {
        assert!(arg1.version == 2, 0);
        arg1.single_update_fee_in_mist = arg2;
    }

    public fun update_stork_evm_public_key(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::admin::AdminCap, arg1: &mut StorkState, arg2: vector<u8>) {
        assert!(arg1.version == 2, 0);
        arg1.stork_evm_public_key = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::evm_pubkey::from_bytes(arg2);
    }

    public fun update_stork_sui_address(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::admin::AdminCap, arg1: &mut StorkState, arg2: address) {
        assert!(arg1.version == 2, 0);
        arg1.stork_sui_address = arg2;
    }

    public fun withdraw_fees(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::admin::AdminCap, arg1: &mut StorkState, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.version == 2, 0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, b"treasury");
        assert!(0x2::coin::value<0x2::sui::SUI>(v0) > 0, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(v0);
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::event::emit_fee_withdrawal_event(v1);
        0x2::coin::split<0x2::sui::SUI>(v0, v1, arg2)
    }

    // decompiled from Move bytecode v6
}

