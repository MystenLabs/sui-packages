module 0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg1: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ProtocolApp, arg2: &mut 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_functional(arg0);
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::asset_admin::update_asset_paused_state<T0, T1>(0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::roles::SuperAdminRole, arg1: &0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::DragonBallCollector, arg2: &0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::app::ProtocolApp, arg3: &mut 0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::market::Market<T0>, arg4: u8) {
        0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::ensure_functional(arg1);
        0x16a08a310237e82b2e8c29ab2a5ff1fbc3cf659bf8dc7b79211bbbac2a4c28e5::asset_admin::update_asset_paused_state<T0, T1>(0x8284f4c573932fe58e5b58cb492425bbaa6af4a4489f19d76cff8b5268d27f9e::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

