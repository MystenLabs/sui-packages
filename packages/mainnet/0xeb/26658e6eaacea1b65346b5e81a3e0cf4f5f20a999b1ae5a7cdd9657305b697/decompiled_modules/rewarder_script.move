module 0xeb26658e6eaacea1b65346b5e81a3e0cf4f5f20a999b1ae5a7cdd9657305b697::rewarder_script {
    public entry fun deposit_reward<T0>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::RewarderGlobalVault, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xeb26658e6eaacea1b65346b5e81a3e0cf4f5f20a999b1ae5a7cdd9657305b697::utils::merge_coins<T0>(arg2, arg4);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 1);
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::deposit_reward<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg3, arg4)));
        0xeb26658e6eaacea1b65346b5e81a3e0cf4f5f20a999b1ae5a7cdd9657305b697::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun emergent_withdraw<T0>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::AdminCap, arg1: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg2: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::RewarderGlobalVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::balance_of<T0>(arg2) >= arg3, 2);
        0xeb26658e6eaacea1b65346b5e81a3e0cf4f5f20a999b1ae5a7cdd9657305b697::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, arg3), arg5), arg4);
    }

    public entry fun emergent_withdraw_all<T0>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::AdminCap, arg1: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg2: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::RewarderGlobalVault, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xeb26658e6eaacea1b65346b5e81a3e0cf4f5f20a999b1ae5a7cdd9657305b697::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::emergent_withdraw<T0>(arg0, arg1, arg2, 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::balance_of<T0>(arg2)), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

