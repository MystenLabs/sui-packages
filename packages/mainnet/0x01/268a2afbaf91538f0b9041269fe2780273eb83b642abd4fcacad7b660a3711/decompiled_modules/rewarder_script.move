module 0x1268a2afbaf91538f0b9041269fe2780273eb83b642abd4fcacad7b660a3711::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::config::GlobalConfig, arg1: &mut 0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1268a2afbaf91538f0b9041269fe2780273eb83b642abd4fcacad7b660a3711::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 1);
        0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0x1268a2afbaf91538f0b9041269fe2780273eb83b642abd4fcacad7b660a3711::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::config::AdminCap, arg1: &0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::config::GlobalConfig, arg2: &mut 0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::rewarder::balance_of<T0>(arg2) >= arg3, 2);
        0x1268a2afbaf91538f0b9041269fe2780273eb83b642abd4fcacad7b660a3711::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::config::AdminCap, arg1: &0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::config::GlobalConfig, arg2: &mut 0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x1268a2afbaf91538f0b9041269fe2780273eb83b642abd4fcacad7b660a3711::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0xa9b94307de472ebe7c1a24ea862eb013d954c9c003a0484e045861d05b31435::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

