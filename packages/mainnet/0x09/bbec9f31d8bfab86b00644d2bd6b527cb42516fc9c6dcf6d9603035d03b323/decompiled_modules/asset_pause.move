module 0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::DragonBallCollector, arg1: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg2: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_functional(arg0);
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::asset_admin::update_asset_paused_state<T0, T1>(0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::roles::SuperAdminRole, arg1: &0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::DragonBallCollector, arg2: &0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::app::ProtocolApp, arg3: &mut 0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::market::Market<T0>, arg4: u8) {
        0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::ensure_functional(arg1);
        0x8d24a2d7c171db6f5021149197e4bccfc6070fea586a862acdefd45de2568b62::asset_admin::update_asset_paused_state<T0, T1>(0x9bbec9f31d8bfab86b00644d2bd6b527cb42516fc9c6dcf6d9603035d03b323::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

