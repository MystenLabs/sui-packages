module 0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::breaker {
    public entry fun deposit_reward<T0>(arg0: &mut 0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::ACL, arg1: &mut 0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::RewardDistributor, arg2: u32, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::is_breaker(arg0, 0x2::tx_context::sender(arg4)), 1);
        0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::deposit_reward_process<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun pause_claim(arg0: &mut 0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::ACL, arg1: &mut 0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::PauseClaimConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::is_breaker(arg0, 0x2::tx_context::sender(arg3)), 1);
        0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::pause_claim(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

