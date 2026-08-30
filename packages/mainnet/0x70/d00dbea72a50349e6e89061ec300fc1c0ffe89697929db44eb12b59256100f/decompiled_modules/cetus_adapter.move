module 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::cetus_adapter {
    public fun close_position<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg4: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg5: &0x2::clock::Clock) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::module_cetus::burn_position<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::TraderAccount, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::module_cetus::collect_reward_account<T0, T1, T2>(arg2, arg1, arg3, arg4, arg0, arg5, arg6);
    }

    public fun collect_reward_v<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T2>, arg5: &0x2::clock::Clock) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::module_cetus::collect_reward_vault<T0, T1, T2>(arg1, arg0, arg2, arg3, arg4, arg5);
    }

    public fun fees_rewards<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : vector<u8> {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::module_cetus::claimed_fees_rewards<T0, T1>(arg0, arg1)
    }

    public fun open_position<T0, T1>(arg0: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::account::TraderAccount, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T0>, arg4: &mut 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::vault::Vault<T1>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::module_cetus::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_params::to_open_params(arg5), arg6, arg7);
    }

    // decompiled from Move bytecode v7
}

