module 0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::DragonBallCollector, arg1: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp, arg2: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_functional(arg0);
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::asset_admin::update_asset_paused_state<T0, T1>(0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::roles::SuperAdminRole, arg1: &0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::DragonBallCollector, arg2: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp, arg3: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::market::Market<T0>, arg4: u8) {
        0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::ensure_functional(arg1);
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::asset_admin::update_asset_paused_state<T0, T1>(0x678dd75f93edffe8f3db77ecd7bb51c5ff7fcd2ceddf97736a3167859a5457a3::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

