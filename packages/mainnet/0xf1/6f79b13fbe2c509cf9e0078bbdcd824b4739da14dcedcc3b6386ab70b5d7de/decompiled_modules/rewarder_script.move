module 0xf16f79b13fbe2c509cf9e0078bbdcd824b4739da14dcedcc3b6386ab70b5d7de::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg1: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf16f79b13fbe2c509cf9e0078bbdcd824b4739da14dcedcc3b6386ab70b5d7de::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 1);
        0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0xf16f79b13fbe2c509cf9e0078bbdcd824b4739da14dcedcc3b6386ab70b5d7de::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::AdminCap, arg1: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg2: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::balance_of<T0>(arg2) >= arg3, 2);
        0xf16f79b13fbe2c509cf9e0078bbdcd824b4739da14dcedcc3b6386ab70b5d7de::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::AdminCap, arg1: &0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::config::GlobalConfig, arg2: &mut 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xf16f79b13fbe2c509cf9e0078bbdcd824b4739da14dcedcc3b6386ab70b5d7de::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0xea1866e78947ffd4e583d75c52687911420d49ff762b3e5d82152f57bd0f6878::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

