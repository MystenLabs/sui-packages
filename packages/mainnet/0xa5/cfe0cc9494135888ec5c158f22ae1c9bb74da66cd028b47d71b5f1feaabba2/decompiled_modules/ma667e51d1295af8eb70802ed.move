module 0xa5cfe0cc9494135888ec5c158f22ae1c9bb74da66cd028b47d71b5f1feaabba2::ma667e51d1295af8eb70802ed {
    public fun f88388512ee4976bff2b575d6(arg0: vector<vector<u8>>, arg1: vector<u64>, arg2: vector<u128>, arg3: vector<bool>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: vector<u8>) : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::UpdateTemporalNumericValueEvmInputVec {
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::new(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun fd46808c19bac18041ab6027c(arg0: &mut 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::UpdateTemporalNumericValueEvmInputVec, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::stork::update_multiple_temporal_numeric_values_evm(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

