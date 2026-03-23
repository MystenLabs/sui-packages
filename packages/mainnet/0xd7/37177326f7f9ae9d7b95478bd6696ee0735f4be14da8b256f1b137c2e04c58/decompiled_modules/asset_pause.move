module 0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg0);
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset_admin::update_asset_paused_state<T0, T1>(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::roles::SuperAdminRole, arg1: &0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::DragonBallCollector, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg4: u8) {
        0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::ensure_functional(arg1);
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::asset_admin::update_asset_paused_state<T0, T1>(0xd737177326f7f9ae9d7b95478bd6696ee0735f4be14da8b256f1b137c2e04c58::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

