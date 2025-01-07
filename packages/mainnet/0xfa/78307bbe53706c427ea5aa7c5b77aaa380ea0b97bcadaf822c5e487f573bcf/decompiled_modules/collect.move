module 0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::collect {
    public fun all_reward_types<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarders(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg0));
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        while (0x1::vector::is_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&v0)) {
            let v2 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&mut v0);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::reward_coin(&v2));
        };
        v1
    }

    public fun fees<T0, T1, T2>(arg0: &mut 0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::version::assert_current_version(arg3);
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg1, 0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::position_borrow<T0, T1, T2>(arg0), true);
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::add_free_balance_a<T0, T1, T2>(arg0, v0);
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::add_free_balance_b<T0, T1, T2>(arg0, v1);
    }

    public fun rewards<T0, T1, T2, T3>(arg0: &mut 0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::version::assert_current_version(arg5);
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::add_reward<T0, T1, T2, T3>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg2, arg1, 0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    public fun rewards_x<T0, T1, T2>(arg0: &mut 0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::version::assert_current_version(arg5);
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::add_reward_x<T0, T1, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg2, arg1, 0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    public fun rewards_y<T0, T1, T2>(arg0: &mut 0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::version::assert_current_version(arg5);
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::add_reward_y<T0, T1, T2>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg2, arg1, 0xfa78307bbe53706c427ea5aa7c5b77aaa380ea0b97bcadaf822c5e487f573bcf::vault::position_borrow<T0, T1, T2>(arg0), arg3, true, arg4));
    }

    // decompiled from Move bytecode v6
}

