module 0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::rewarder_script {
    public fun deposit_reward<T0>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun emergent_withdraw<T0>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::AdminCap, arg1: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public fun emergent_withdraw_all<T0>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::AdminCap, arg1: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

