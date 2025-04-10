module 0xe14acefdc888d3e20fc624693b28c4f47ec7d5c7a1c70632cb29b8389e9bd9e6::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::GlobalConfig, arg1: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe14acefdc888d3e20fc624693b28c4f47ec7d5c7a1c70632cb29b8389e9bd9e6::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 1);
        0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0xe14acefdc888d3e20fc624693b28c4f47ec7d5c7a1c70632cb29b8389e9bd9e6::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::AdminCap, arg1: &0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::GlobalConfig, arg2: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::rewarder::balance_of<T0>(arg2) >= arg3, 2);
        0xe14acefdc888d3e20fc624693b28c4f47ec7d5c7a1c70632cb29b8389e9bd9e6::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::AdminCap, arg1: &0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::GlobalConfig, arg2: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xe14acefdc888d3e20fc624693b28c4f47ec7d5c7a1c70632cb29b8389e9bd9e6::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

