module 0x53dbd4f80dfd9e5aced21c9e3070535ade5cfb639d92fc042e22ef820aa40aaf::gate {
    public fun update_if_newer(arg0: &mut 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::UpdateTemporalNumericValueEvmInputVec, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::get_data(&arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::UpdateTemporalNumericValueEvmInput>(&v0)) {
            let v2 = 0x1::vector::borrow<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::UpdateTemporalNumericValueEvmInput>(&v0, v1);
            let v3 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_id(v2);
            let v4 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::stork::get_temporal_numeric_value_unchecked(arg0, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::encoded_asset_id::get_bytes(&v3));
            let v5 = 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::get_temporal_numeric_value(v2);
            if (0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v5) > 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::temporal_numeric_value::get_timestamp_ns(&v4)) {
                0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::stork::update_multiple_temporal_numeric_values_evm(arg0, arg1, arg2, arg3);
                return 0x2::coin::zero<0x2::sui::SUI>(arg3)
            };
            v1 = v1 + 1;
        };
        arg2
    }

    // decompiled from Move bytecode v7
}

