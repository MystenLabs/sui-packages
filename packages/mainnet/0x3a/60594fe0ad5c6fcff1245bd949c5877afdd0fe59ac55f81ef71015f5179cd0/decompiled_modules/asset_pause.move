module 0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::DragonBallCollector, arg1: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_functional(arg0);
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset_admin::update_asset_paused_state<T0, T1>(0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::roles::SuperAdminRole, arg1: &0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::DragonBallCollector, arg2: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg3: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg4: u8) {
        0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::ensure_functional(arg1);
        0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::asset_admin::update_asset_paused_state<T0, T1>(0x3a60594fe0ad5c6fcff1245bd949c5877afdd0fe59ac55f81ef71015f5179cd0::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

