module 0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::asset_revenue {
    public fun fulfill_take_revenue_wish<T0, T1>(arg0: &0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::DragonBallCollector, arg1: &0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::app::ProtocolApp, arg2: &mut 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_can_summon_shenron(arg0);
        0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::revenue_admin::take_revenue<T0, T1>(0xdf67fd7399417c3aa86959c4677cbd382b514706fd63f0534edebdffb14e6964::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

