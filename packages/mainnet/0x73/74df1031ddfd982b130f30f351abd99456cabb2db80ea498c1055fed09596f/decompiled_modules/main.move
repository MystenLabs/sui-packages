module 0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::main {
    public fun initialize_price_adapter(arg0: &0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::admin::AdminCap, arg1: vector<vector<u8>>, arg2: u8, arg3: u64, arg4: u64, arg5: vector<address>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::price_adapter::new(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

