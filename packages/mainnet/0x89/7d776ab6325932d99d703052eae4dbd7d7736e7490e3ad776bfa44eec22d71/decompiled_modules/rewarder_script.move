module 0x897d776ab6325932d99d703052eae4dbd7d7736e7490e3ad776bfa44eec22d71::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x897d776ab6325932d99d703052eae4dbd7d7736e7490e3ad776bfa44eec22d71::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x897d776ab6325932d99d703052eae4dbd7d7736e7490e3ad776bfa44eec22d71::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0x897d776ab6325932d99d703052eae4dbd7d7736e7490e3ad776bfa44eec22d71::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::AdminCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x897d776ab6325932d99d703052eae4dbd7d7736e7490e3ad776bfa44eec22d71::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

