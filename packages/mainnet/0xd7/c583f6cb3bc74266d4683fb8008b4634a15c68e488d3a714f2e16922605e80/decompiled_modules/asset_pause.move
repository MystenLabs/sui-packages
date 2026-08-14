module 0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg1: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp, arg2: &mut 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg0);
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::asset_admin::update_asset_paused_state<T0, T1>(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::roles::SuperAdminRole, arg1: &0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::DragonBallCollector, arg2: &0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::app::ProtocolApp, arg3: &mut 0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::market::Market<T0>, arg4: u8) {
        0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::ensure_functional(arg1);
        0xce265981a720274f6032324a42be65b2d9c280c8882243adb11d4222837444c0::asset_admin::update_asset_paused_state<T0, T1>(0xd7c583f6cb3bc74266d4683fb8008b4634a15c68e488d3a714f2e16922605e80::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

