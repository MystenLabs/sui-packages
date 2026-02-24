module 0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg1: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg0);
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset_admin::update_asset_paused_state<T0, T1>(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::roles::SuperAdminRole, arg1: &0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::DragonBallCollector, arg2: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg3: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::market::Market<T0>, arg4: u8) {
        0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::ensure_functional(arg1);
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::asset_admin::update_asset_paused_state<T0, T1>(0x96d1da449ac7a1366f3bb491a88392f11a3924a7c9a10ce358294c9016e7d1ad::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

