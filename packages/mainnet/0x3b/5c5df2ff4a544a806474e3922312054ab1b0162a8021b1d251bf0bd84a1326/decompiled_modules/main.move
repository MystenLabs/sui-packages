module 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::main {
    public fun initialize_price_adapter(arg0: &0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::admin::AdminCap, arg1: vector<vector<u8>>, arg2: u8, arg3: u64, arg4: u64, arg5: vector<address>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::price_adapter::new(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

