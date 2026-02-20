module 0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::asset_pause {
    public fun pause_asset<T0, T1>(arg0: &0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg1: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg2: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_functional(arg0);
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::asset_admin::update_asset_paused_state<T0, T1>(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun unpause_asset<T0, T1>(arg0: &0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::roles::SuperAdminRole, arg1: &0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::DragonBallCollector, arg2: &0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::app::ProtocolApp, arg3: &mut 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market::Market<T0>, arg4: u8) {
        0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::ensure_functional(arg1);
        0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::asset_admin::update_asset_paused_state<T0, T1>(0xa16fb9c1261e86b5f64e02d08856facb625272d996bc809f4aaa70f7d8137e65::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

