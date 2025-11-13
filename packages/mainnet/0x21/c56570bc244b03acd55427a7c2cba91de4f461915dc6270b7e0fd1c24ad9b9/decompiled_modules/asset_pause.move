module 0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::asset_pause {
    public fun wish_pause_asset<T0, T1>(arg0: &0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::DragonBallCollector, arg1: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::ensure_can_summon_shenron(arg0);
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset_admin::update_asset_paused_state<T0, T1>(0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun wish_unpause_asset<T0, T1>(arg0: &0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::roles::SuperAdminRole, arg1: &0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::DragonBallCollector, arg2: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg3: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg4: u8) {
        0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::ensure_can_summon_shenron(arg1);
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::asset_admin::update_asset_paused_state<T0, T1>(0x21c56570bc244b03acd55427a7c2cba91de4f461915dc6270b7e0fd1c24ad9b9::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

