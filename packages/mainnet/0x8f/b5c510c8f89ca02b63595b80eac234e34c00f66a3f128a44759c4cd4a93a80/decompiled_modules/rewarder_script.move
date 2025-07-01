module 0x8fb5c510c8f89ca02b63595b80eac234e34c00f66a3f128a44759c4cd4a93a80::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::config::GlobalConfig, arg1: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8fb5c510c8f89ca02b63595b80eac234e34c00f66a3f128a44759c4cd4a93a80::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 1);
        0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x8fb5c510c8f89ca02b63595b80eac234e34c00f66a3f128a44759c4cd4a93a80::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::config::AdminCap, arg1: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::config::GlobalConfig, arg2: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::rewarder::balance_of<T0>(arg2) >= arg3, 2);
        0x8fb5c510c8f89ca02b63595b80eac234e34c00f66a3f128a44759c4cd4a93a80::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::config::AdminCap, arg1: &0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::config::GlobalConfig, arg2: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x8fb5c510c8f89ca02b63595b80eac234e34c00f66a3f128a44759c4cd4a93a80::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

