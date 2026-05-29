module 0x9a052872cec69f116b2a7eff5ed818ed2499cb77f96fddd5c2c2fa08e1d4a058::alphalend_admin_entry {
    public fun init_alphalend_position_cap<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        let v0 = 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::alphalend_position_cap_key();
        assert!(!0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::has_protocol_cap<T0, T1, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::AlphaLendPositionCapKey>(arg1, v0), 1);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_validation::validate_alphalend_protocol<T0, T1>(arg1, 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol>(arg2));
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::store_protocol_cap<T0, T1, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::AlphaLendPositionCapKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg1, v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg2, arg3), arg3);
    }

    public fun register_alphalend_leg_auth<T0, T1>(arg0: &0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::LLVGlobal, arg1: &mut 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::LLVPool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_admin::assert_version(arg0);
        0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_pool::register_protocol_leg_auth<T0, T1, 0x9a052872cec69f116b2a7eff5ed818ed2499cb77f96fddd5c2c2fa08e1d4a058::alphalend_entry::AlphaLendLegAuth>(arg1, 0x5da13a1e55b05f6da745dcc293f46970de58429cc2badb373bf1cfcd66b4cb76::llv_allocation_plan::PROTOCOL_ALPHALEND(), arg2);
    }

    // decompiled from Move bytecode v7
}

