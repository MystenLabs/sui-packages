module 0x64334189f9f4281aaf5c764e4ca340a0788fd6ef904e99c278037a453d54c4::conditional {
    public fun any_newer(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::UpdateTemporalNumericValueEvmInputVec) : bool {
        count_newer(arg0, arg1) > 0
    }

    public fun count_newer(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::UpdateTemporalNumericValueEvmInputVec) : u64 {
        let v0 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::get_data(arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::length(arg1)) {
            let v3 = 0x1::vector::borrow<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::UpdateTemporalNumericValueEvmInput>(&v0, v2);
            let v4 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_id(v3);
            let v5 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::stork::get_temporal_numeric_value_unchecked(arg0, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::get_bytes(&v4));
            let v6 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_temporal_numeric_value(v3);
            if (0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v6) > 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v5)) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun update_if_newer(arg0: &mut 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::UpdateTemporalNumericValueEvmInputVec, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = count_newer(arg0, &arg1);
        if (v0 == 0) {
            return false
        };
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::stork::update_multiple_temporal_numeric_values_evm(arg0, arg1, 0x2::coin::split<0x2::sui::SUI>(arg2, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::get_total_fees_in_mist(arg0, v0), arg4), arg4);
        true
    }

    // decompiled from Move bytecode v7
}

