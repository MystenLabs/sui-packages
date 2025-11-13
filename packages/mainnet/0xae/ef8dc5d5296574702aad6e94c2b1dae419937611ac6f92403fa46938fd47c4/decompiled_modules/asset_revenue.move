module 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::asset_revenue {
    public fun fulfill_take_revenue_wish<T0, T1>(arg0: &0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::DragonBallCollector, arg1: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::app::ProtocolApp, arg2: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_can_summon_shenron(arg0);
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg5));
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::revenue_admin::take_revenue<T0, T1>(0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::lending_admin_cap(arg0), arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

