module 0x4813578acf0385ebed1851f27e1afb413d41761b208de518a0be1a58d545438::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::GlobalConfig, arg1: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4813578acf0385ebed1851f27e1afb413d41761b208de518a0be1a58d545438::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 1);
        0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x4813578acf0385ebed1851f27e1afb413d41761b208de518a0be1a58d545438::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::AdminCap, arg1: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::GlobalConfig, arg2: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::rewarder::balance_of<T0>(arg2) >= arg3, 2);
        0x4813578acf0385ebed1851f27e1afb413d41761b208de518a0be1a58d545438::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::AdminCap, arg1: &0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::config::GlobalConfig, arg2: &mut 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x4813578acf0385ebed1851f27e1afb413d41761b208de518a0be1a58d545438::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x3a74a12271278416c937ef74a953b0807c6b21302774f05836a26054c7346290::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

