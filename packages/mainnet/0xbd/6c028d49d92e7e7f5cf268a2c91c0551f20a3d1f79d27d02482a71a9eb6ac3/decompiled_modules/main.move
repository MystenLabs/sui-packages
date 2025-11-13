module 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::main {
    public fun initialize_price_adapter(arg0: &0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::admin::AdminCap, arg1: vector<vector<u8>>, arg2: u8, arg3: u64, arg4: u64, arg5: vector<address>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::price_adapter::new(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

