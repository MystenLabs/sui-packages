module 0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::asset_pause {
    public fun wish_pause_asset<T0, T1>(arg0: &0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::DragonBallCollector, arg1: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_can_summon_shenron(arg0);
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::asset_admin::update_asset_paused_state<T0, T1>(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun wish_unpause_asset<T0, T1>(arg0: &0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::roles::SuperAdminRole, arg1: &0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::DragonBallCollector, arg2: &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg3: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::market::Market<T0>, arg4: u8) {
        0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::ensure_can_summon_shenron(arg1);
        0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::asset_admin::update_asset_paused_state<T0, T1>(0x64e9f7d213e46c3ea6c7e6ccb364da2435f54760d98eaad029f7acc262dfb379::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

