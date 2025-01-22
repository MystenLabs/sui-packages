module 0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::main {
    public fun initialize_price_adapter(arg0: &0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::admin::AdminCap, arg1: vector<vector<u8>>, arg2: u8, arg3: u64, arg4: u64, arg5: vector<address>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::price_adapter::new(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

