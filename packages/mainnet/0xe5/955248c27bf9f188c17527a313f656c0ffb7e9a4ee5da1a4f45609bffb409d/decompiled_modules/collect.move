module 0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::collect {
    public fun fees<T0, T1, T2>(arg0: &mut 0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg1, 0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::position_borrow<T0, T1, T2>(arg0), true);
        0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::add_free_balance_a<T0, T1, T2>(arg0, v0);
        0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::add_free_balance_b<T0, T1, T2>(arg0, v1);
    }

    public fun rewards<T0, T1, T2, T3>(arg0: &mut 0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::add_reward<T0, T1, T2, T3>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg2, arg1, 0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    public fun rewards_x<T0, T1, T2>(arg0: &mut 0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::add_reward_x<T0, T1, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg2, arg1, 0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    public fun rewards_y<T0, T1, T2>(arg0: &mut 0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::add_reward_y<T0, T1, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg2, arg1, 0xe5955248c27bf9f188c17527a313f656c0ffb7e9a4ee5da1a4f45609bffb409d::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    // decompiled from Move bytecode v6
}

