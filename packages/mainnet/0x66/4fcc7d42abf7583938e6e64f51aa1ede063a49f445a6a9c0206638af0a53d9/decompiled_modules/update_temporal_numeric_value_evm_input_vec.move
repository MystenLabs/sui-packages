module 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input_vec {
    struct UpdateTemporalNumericValueEvmInputVec has copy, drop, store {
        data: vector<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::UpdateTemporalNumericValueEvmInput>,
    }

    public fun length(arg0: &UpdateTemporalNumericValueEvmInputVec) : u64 {
        0x1::vector::length<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::UpdateTemporalNumericValueEvmInput>(&arg0.data)
    }

    public fun new(arg0: vector<vector<u8>>, arg1: vector<u64>, arg2: vector<u128>, arg3: vector<bool>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: vector<u8>) : UpdateTemporalNumericValueEvmInputVec {
        assert!(0x1::vector::length<vector<u8>>(&arg0) > 0, 1);
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<u64>(&arg1), 0);
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<u128>(&arg2), 0);
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<bool>(&arg3), 0);
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<vector<u8>>(&arg4), 0);
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<vector<u8>>(&arg5), 0);
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<vector<u8>>(&arg6), 0);
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<vector<u8>>(&arg7), 0);
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<u8>(&arg8), 0);
        let v0 = 0x1::vector::empty<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::UpdateTemporalNumericValueEvmInput>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            0x1::vector::push_back<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::UpdateTemporalNumericValueEvmInput>(&mut v0, 0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::new(*0x1::vector::borrow<vector<u8>>(&arg0, v1), *0x1::vector::borrow<u64>(&arg1, v1), *0x1::vector::borrow<u128>(&arg2, v1), *0x1::vector::borrow<bool>(&arg3, v1), *0x1::vector::borrow<vector<u8>>(&arg4, v1), *0x1::vector::borrow<vector<u8>>(&arg5, v1), *0x1::vector::borrow<vector<u8>>(&arg6, v1), *0x1::vector::borrow<vector<u8>>(&arg7, v1), *0x1::vector::borrow<u8>(&arg8, v1)));
            v1 = v1 + 1;
        };
        UpdateTemporalNumericValueEvmInputVec{data: v0}
    }

    public fun get_data(arg0: &UpdateTemporalNumericValueEvmInputVec) : vector<0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::update_temporal_numeric_value_evm_input::UpdateTemporalNumericValueEvmInput> {
        arg0.data
    }

    // decompiled from Move bytecode v6
}

