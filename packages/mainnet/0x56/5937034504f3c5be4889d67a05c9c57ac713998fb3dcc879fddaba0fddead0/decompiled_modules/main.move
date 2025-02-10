module 0x565937034504f3c5be4889d67a05c9c57ac713998fb3dcc879fddaba0fddead0::main {
    public fun initialize_price_adapter(arg0: &0x565937034504f3c5be4889d67a05c9c57ac713998fb3dcc879fddaba0fddead0::admin::AdminCap, arg1: vector<vector<u8>>, arg2: u8, arg3: u64, arg4: u64, arg5: vector<address>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x565937034504f3c5be4889d67a05c9c57ac713998fb3dcc879fddaba0fddead0::price_adapter::new(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

