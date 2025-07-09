module 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::stork {
    fun create_or_update_temporal_numeric_value_feed(arg0: &mut 0x2::object_table::ObjectTable<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>, arg1: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, arg2: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::UpdateTemporalNumericValueEvmInput, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::object_table::contains<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>(arg0, arg1)) {
            0x2::object_table::add<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>(arg0, arg1, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::new(arg1, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_temporal_numeric_value(&arg2), arg3));
        } else {
            0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::set_latest_value(0x2::object_table::borrow_mut<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>(arg0, arg1), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_temporal_numeric_value(&arg2));
        };
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::event::emit_temporal_numeric_value_feed_update_event(arg1, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_temporal_numeric_value(&arg2));
    }

    public fun get_temporal_numeric_value_unchecked(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: vector<u8>) : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::TemporalNumericValue {
        let v0 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::from_bytes(arg1);
        let v1 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::borrow_tnv_feeds_registry(arg0);
        assert!(0x2::object_table::contains<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>(v1, v0), 2);
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::get_latest_canonical_temporal_numeric_value_unchecked(0x2::object_table::borrow<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>(v1, v0))
    }

    entry fun init_stork(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::admin::AdminCap, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::new(arg1, arg2, arg3, arg4, arg5);
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::share(v0);
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::event::emit_stork_initialization_event(arg1, arg2, arg3, 0x2::object::id<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState>(&v0), arg4);
    }

    public fun update_multiple_temporal_numeric_values_evm(arg0: &mut 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::UpdateTemporalNumericValueEvmInputVec, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::get_stork_evm_public_key(arg0);
        let v1 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::borrow_tnv_feeds_registry_mut(arg0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::length(&arg1)) {
            let v4 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::get_data(&arg1);
            let v5 = *0x1::vector::borrow<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::UpdateTemporalNumericValueEvmInput>(&v4, v3);
            let v6 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_id(&v5);
            if (0x2::object_table::contains<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>(v1, v6)) {
                let v7 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::get_latest_canonical_temporal_numeric_value_unchecked(0x2::object_table::borrow_mut<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>(v1, v6));
                let v8 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_temporal_numeric_value(&v5);
                if (0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v7) >= 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v8)) {
                    v3 = v3 + 1;
                    continue
                };
            };
            let v9 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_id(&v5);
            let v10 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_temporal_numeric_value(&v5);
            let v11 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_temporal_numeric_value(&v5);
            assert!(0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::verify::verify_stork_evm_signature(&v0, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::get_bytes(&v9), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v10), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_quantized_value(&v11), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_publisher_merkle_root(&v5), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_value_compute_alg_hash(&v5), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_r(&v5), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_s(&v5), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_v(&v5)), 0);
            create_or_update_temporal_numeric_value_feed(v1, v6, v5, arg3);
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::get_total_fees_in_mist(arg0, v2), 1);
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::deposit_fee(arg0, arg2);
    }

    public fun update_single_temporal_numeric_value_evm(arg0: &mut 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::UpdateTemporalNumericValueEvmInput, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_id(&arg1);
        let v1 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::get_stork_evm_public_key(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::get_single_update_fee_in_mist(arg0), 1);
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::deposit_fee(arg0, arg2);
        let v2 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::borrow_tnv_feeds_registry_mut(arg0);
        if (0x2::object_table::contains<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>(v2, v0)) {
            let v3 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::get_latest_canonical_temporal_numeric_value_unchecked(0x2::object_table::borrow_mut<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::EncodedAssetId, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value_feed::TemporalNumericValueFeed>(v2, v0));
            let v4 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_temporal_numeric_value(&arg1);
            if (0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v3) >= 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v4)) {
                return
            };
        };
        let v5 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_id(&arg1);
        let v6 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_temporal_numeric_value(&arg1);
        let v7 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_temporal_numeric_value(&arg1);
        assert!(0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::verify::verify_stork_evm_signature(&v1, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::get_bytes(&v5), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v6), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_quantized_value(&v7), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_publisher_merkle_root(&arg1), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_value_compute_alg_hash(&arg1), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_r(&arg1), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_s(&arg1), 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_v(&arg1)), 0);
        create_or_update_temporal_numeric_value_feed(v2, v0, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

