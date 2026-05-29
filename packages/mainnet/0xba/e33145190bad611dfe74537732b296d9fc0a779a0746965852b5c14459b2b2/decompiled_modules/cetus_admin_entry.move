module 0xbae33145190bad611dfe74537732b296d9fc0a779a0746965852b5c14459b2b2::cetus_admin_entry {
    public fun register_cetus_leg_auth<T0>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<0x2::sui::SUI, T0>, arg2: &0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::register_protocol_leg_auth<0x2::sui::SUI, T0, 0xbae33145190bad611dfe74537732b296d9fc0a779a0746965852b5c14459b2b2::cetus_entry::CetusLegAuth>(arg1, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_CETUS(), arg2);
    }

    // decompiled from Move bytecode v7
}

