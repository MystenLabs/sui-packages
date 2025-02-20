module 0xde76b5100c777b0ef6154eb7485f2270ec390b2f7cd3786469e5772a9eb90b5a::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg1: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xde76b5100c777b0ef6154eb7485f2270ec390b2f7cd3786469e5772a9eb90b5a::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 1);
        0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0xde76b5100c777b0ef6154eb7485f2270ec390b2f7cd3786469e5772a9eb90b5a::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::AdminCap, arg1: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::balance_of<T0>(arg2) >= arg3, 2);
        0xde76b5100c777b0ef6154eb7485f2270ec390b2f7cd3786469e5772a9eb90b5a::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::AdminCap, arg1: &0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::config::GlobalConfig, arg2: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xde76b5100c777b0ef6154eb7485f2270ec390b2f7cd3786469e5772a9eb90b5a::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

