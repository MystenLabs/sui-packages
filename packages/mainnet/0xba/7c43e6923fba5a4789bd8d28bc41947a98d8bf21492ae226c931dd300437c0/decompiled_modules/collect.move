module 0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::collect {
    public fun all_reward_types<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarders(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg0));
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        while (0x1::vector::is_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&v0)) {
            let v2 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&mut v0);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::reward_coin(&v2));
        };
        v1
    }

    public fun fees<T0, T1, T2>(arg0: &mut 0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg1, 0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::position_borrow<T0, T1, T2>(arg0), true);
        0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::add_free_balance_a<T0, T1, T2>(arg0, v0);
        0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::add_free_balance_b<T0, T1, T2>(arg0, v1);
    }

    public fun rewards<T0, T1, T2, T3>(arg0: &mut 0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::add_reward<T0, T1, T2, T3>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg2, arg1, 0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    public fun rewards_x<T0, T1, T2>(arg0: &mut 0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::add_reward_x<T0, T1, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg2, arg1, 0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    public fun rewards_y<T0, T1, T2>(arg0: &mut 0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::add_reward_y<T0, T1, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg2, arg1, 0xba7c43e6923fba5a4789bd8d28bc41947a98d8bf21492ae226c931dd300437c0::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    // decompiled from Move bytecode v6
}

