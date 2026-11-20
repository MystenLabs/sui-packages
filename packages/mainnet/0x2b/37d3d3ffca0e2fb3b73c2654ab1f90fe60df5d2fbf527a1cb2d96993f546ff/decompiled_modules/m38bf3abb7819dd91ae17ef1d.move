module 0x2b37d3d3ffca0e2fb3b73c2654ab1f90fe60df5d2fbf527a1cb2d96993f546ff::m38bf3abb7819dd91ae17ef1d {
    public fun f5e759fddd231030e3a102656(arg0: &mut 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::UpdateTemporalNumericValueEvmInputVec, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::stork::update_multiple_temporal_numeric_values_evm(arg0, arg1, arg2, arg3);
    }

    public fun f75046ecae92756d3c7f6b1bc(arg0: vector<vector<u8>>, arg1: vector<u64>, arg2: vector<u128>, arg3: vector<bool>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: vector<u8>) : 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::UpdateTemporalNumericValueEvmInputVec {
        0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec::new(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v7
}

