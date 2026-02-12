module 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::asset_pause {
    public fun wish_pause_asset<T0, T1>(arg0: &0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::DragonBallCollector, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_can_summon_shenron(arg0);
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_watcher_allowed(arg0, 0x2::tx_context::sender(arg4));
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::asset_admin::update_asset_paused_state<T0, T1>(0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::lending_admin_cap(arg0), arg1, arg2, arg3, true);
    }

    public fun wish_unpause_asset<T0, T1>(arg0: &0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::roles::SuperAdminRole, arg1: &0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::DragonBallCollector, arg2: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg3: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg4: u8) {
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_can_summon_shenron(arg1);
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::asset_admin::update_asset_paused_state<T0, T1>(0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::lending_admin_cap(arg1), arg2, arg3, arg4, false);
    }

    // decompiled from Move bytecode v6
}

