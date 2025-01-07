module 0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::collect {
    public fun fees<T0, T1, T2>(arg0: &mut 0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg1, 0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::position_borrow<T0, T1, T2>(arg0), true);
        0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::add_free_balance_a<T0, T1, T2>(arg0, v0);
        0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::add_free_balance_b<T0, T1, T2>(arg0, v1);
    }

    public fun rewards<T0, T1, T2, T3>(arg0: &mut 0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::add_reward<T0, T1, T2, T3>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg2, arg1, 0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    public fun rewards_x<T0, T1, T2>(arg0: &mut 0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::add_reward_x<T0, T1, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg2, arg1, 0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    public fun rewards_y<T0, T1, T2>(arg0: &mut 0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::add_reward_y<T0, T1, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg2, arg1, 0x4c4f5d4ea09af3d863bb7f5c8898b2b3e36b458946b660ae29d89a4f3e1ad8c9::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    // decompiled from Move bytecode v6
}

