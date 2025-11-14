module 0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::asset_pause {
    public fun wish_pause_asset<T0, T1>(arg0: &0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::DragonBallCollector, arg1: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::ProtocolApp, arg2: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::ensure_can_summon_shenron(arg0);
        0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset_admin::update_asset_paused_state<T0, T1>(0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun wish_unpause_asset<T0, T1>(arg0: &0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::roles::SuperAdminRole, arg1: &0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::DragonBallCollector, arg2: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::app::ProtocolApp, arg3: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg4: u8) {
        0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::ensure_can_summon_shenron(arg1);
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::asset_admin::update_asset_paused_state<T0, T1>(0xe87de8d551cce2a1ab87bd3ebac51ae98aae134e516cc59d911de5c29c26ffa::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

