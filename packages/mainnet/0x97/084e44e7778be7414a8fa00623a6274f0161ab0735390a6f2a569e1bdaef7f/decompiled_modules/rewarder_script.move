module 0x97084e44e7778be7414a8fa00623a6274f0161ab0735390a6f2a569e1bdaef7f::rewarder_script {
    public fun deposit_reward<T0>(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x97084e44e7778be7414a8fa00623a6274f0161ab0735390a6f2a569e1bdaef7f::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x97084e44e7778be7414a8fa00623a6274f0161ab0735390a6f2a569e1bdaef7f::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun emergent_withdraw<T0>(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::AdminCap, arg1: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg2: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0x97084e44e7778be7414a8fa00623a6274f0161ab0735390a6f2a569e1bdaef7f::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public fun emergent_withdraw_all<T0>(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::AdminCap, arg1: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg2: &mut 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x97084e44e7778be7414a8fa00623a6274f0161ab0735390a6f2a569e1bdaef7f::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

