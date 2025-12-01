module 0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::asset_pause {
    public fun wish_pause_asset<T0, T1>(arg0: &0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg1: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg2: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_can_summon_shenron(arg0);
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset_admin::update_asset_paused_state<T0, T1>(0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun wish_unpause_asset<T0, T1>(arg0: &0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::roles::SuperAdminRole, arg1: &0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::DragonBallCollector, arg2: &0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::app::ProtocolApp, arg3: &mut 0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::market::Market<T0>, arg4: u8) {
        0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::ensure_can_summon_shenron(arg1);
        0x3587b2b71baeabbfbb2f81a446197748b2b35235d59ba098eddfa8f6471cbe4c::asset_admin::update_asset_paused_state<T0, T1>(0xd8c524de1b9a563790a99fa54b68872f45b9de7de1eb3e0ef293d4a498bffae3::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

