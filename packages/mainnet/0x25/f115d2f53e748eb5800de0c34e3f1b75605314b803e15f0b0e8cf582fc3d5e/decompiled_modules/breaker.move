module 0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::breaker {
    public entry fun deposit_reward<T0>(arg0: &mut 0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::ACL, arg1: &mut 0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::RewardDistributor, arg2: u32, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::is_breaker(arg0, 0x2::tx_context::sender(arg4)), 1);
        0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::deposit_reward_process<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun pause_claim(arg0: &mut 0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::ACL, arg1: &mut 0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::PauseClaimConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::is_breaker(arg0, 0x2::tx_context::sender(arg3)), 1);
        0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::pause_claim(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

