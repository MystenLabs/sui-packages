module 0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::breaker {
    public entry fun deposit_reward<T0>(arg0: &mut 0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::ACL, arg1: &mut 0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::RewardDistributor, arg2: u32, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::is_breaker(arg0, 0x2::tx_context::sender(arg4)), 1);
        0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::deposit_reward_process<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun pause_claim(arg0: &mut 0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::ACL, arg1: &mut 0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::PauseClaimConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::is_breaker(arg0, 0x2::tx_context::sender(arg3)), 1);
        0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::pause_claim(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

