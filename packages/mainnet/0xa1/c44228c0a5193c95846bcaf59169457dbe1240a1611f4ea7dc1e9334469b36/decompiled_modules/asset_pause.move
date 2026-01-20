module 0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::asset_pause {
    public fun wish_pause_asset<T0, T1>(arg0: &0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg1: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg2: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg0);
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset_admin::update_asset_paused_state<T0, T1>(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun wish_unpause_asset<T0, T1>(arg0: &0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::roles::SuperAdminRole, arg1: &0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::DragonBallCollector, arg2: &0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::app::ProtocolApp, arg3: &mut 0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::market::Market<T0>, arg4: u8) {
        0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::ensure_can_summon_shenron(arg1);
        0xfc0dcc82b17da1d09366263e5ad0c28cdffd2f5cee8b5366e48fabaeba50a146::asset_admin::update_asset_paused_state<T0, T1>(0xa1c44228c0a5193c95846bcaf59169457dbe1240a1611f4ea7dc1e9334469b36::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

