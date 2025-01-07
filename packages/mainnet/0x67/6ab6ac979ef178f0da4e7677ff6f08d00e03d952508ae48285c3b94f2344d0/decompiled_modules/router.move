module 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::router {
    public entry fun add_role(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::AdminCap, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg2: address, arg3: u8) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_protocol_fee<T0, T1>(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::Vault<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::claim_protocol_fee<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun collect_fee<T0, T1, T2>(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::collect_fee<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun collect_rewarder<T0, T1, T2, T3>(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::Vault<T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::collect_rewarder<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun create_vault<T0, T1, T2>(arg0: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::create_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun deposit<T0, T1, T2>(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun pause<T0>(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::pause<T0>(arg0, arg1, arg2);
    }

    public entry fun rebalance<T0, T1, T2>(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::rebalance<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun rebalance_rewarder<T0, T1, T2>(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::rewarder_swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun reinvest<T0, T1, T2>(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::reinvest<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun remove<T0, T1, T2>(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::remove<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun remove_member(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::AdminCap, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg2: address) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::AdminCap, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg2: address, arg3: u8) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_roles(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::AdminCap, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg2: address, arg3: u128) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun unpause<T0>(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::unpause<T0>(arg0, arg1, arg2);
    }

    public fun update_protocol_fee_rate<T0>(arg0: &0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::VaultsManager, arg1: &mut 0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x676ab6ac979ef178f0da4e7677ff6f08d00e03d952508ae48285c3b94f2344d0::vaults::update_protocol_fee_rate<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

