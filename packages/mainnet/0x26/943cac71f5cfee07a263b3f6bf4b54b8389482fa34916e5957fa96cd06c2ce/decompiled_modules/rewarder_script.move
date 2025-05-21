module 0x26943cac71f5cfee07a263b3f6bf4b54b8389482fa34916e5957fa96cd06c2ce::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg1: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x26943cac71f5cfee07a263b3f6bf4b54b8389482fa34916e5957fa96cd06c2ce::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 0);
        0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x26943cac71f5cfee07a263b3f6bf4b54b8389482fa34916e5957fa96cd06c2ce::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::AdminCap, arg1: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg2: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::rewarder::balance_of<T0>(arg2) >= arg3, 0);
        0x26943cac71f5cfee07a263b3f6bf4b54b8389482fa34916e5957fa96cd06c2ce::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::AdminCap, arg1: &0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::config::GlobalConfig, arg2: &mut 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x26943cac71f5cfee07a263b3f6bf4b54b8389482fa34916e5957fa96cd06c2ce::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x272968a6c4e9f404ca6f07547cf4b49435afa906c27ce49b4c8f6fa881b8e80d::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

