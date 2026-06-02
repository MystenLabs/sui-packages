module 0x865ee810427b8a90b31ebf0a4dd750db9295046c2e6f83b0e955ccb61c9e960e::navi_admin_entry {
    public fun init_navi_account_cap<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        let v0 = 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::navi_account_cap_key();
        assert!(!0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::has_protocol_cap<T0, T1, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::NaviAccountCapKey>(arg1, v0), 1);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::store_protocol_cap<T0, T1, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::NaviAccountCapKey, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(arg1, v0, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2), arg2);
    }

    public fun register_navi_leg_auth<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::register_protocol_leg_auth<T0, T1, 0x865ee810427b8a90b31ebf0a4dd750db9295046c2e6f83b0e955ccb61c9e960e::navi_entry::NaviLegAuth>(arg1, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_NAVI(), arg2);
    }

    // decompiled from Move bytecode v7
}

