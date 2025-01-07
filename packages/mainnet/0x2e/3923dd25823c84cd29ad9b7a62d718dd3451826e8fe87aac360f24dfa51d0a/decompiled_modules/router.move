module 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::router {
    public entry fun add_role(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::AdminCap, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg2: address, arg3: u8) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::add_role(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_protocol_fee<T0, T1>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::claim_protocol_fee<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun collect_fee<T0, T1, T2>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::collect_fee<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun collect_rewarder<T0, T1, T2, T3>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::collect_rewarder<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun create_vault<T0, T1, T2>(arg0: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::create_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun deposit<T0, T1, T2>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun pause<T0>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::pause<T0>(arg0, arg1, arg2);
    }

    public entry fun rebalance<T0, T1, T2>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::rebalance<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun rebalance_rewarder<T0, T1, T2>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::rewarder_swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun reinvest<T0, T1, T2>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::reinvest<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun remove<T0, T1, T2>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::remove<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg9));
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::utils::send_coin<T1>(v1, 0x2::tx_context::sender(arg9));
    }

    public entry fun remove_member(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::AdminCap, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg2: address) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::remove_member(arg0, arg1, arg2);
    }

    public entry fun remove_role(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::AdminCap, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg2: address, arg3: u8) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::remove_role(arg0, arg1, arg2, arg3);
    }

    public entry fun set_roles(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::AdminCap, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg2: address, arg3: u128) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::set_roles(arg0, arg1, arg2, arg3);
    }

    public entry fun unpause<T0>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::unpause<T0>(arg0, arg1, arg2);
    }

    public fun update_protocol_fee_rate<T0>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::VaultsManager, arg1: &mut 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::update_protocol_fee_rate<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

