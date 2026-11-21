module 0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::robot {
    public entry fun add_user_rewards(arg0: &mut 0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::ACL, arg1: &mut 0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::RewardDistributor, arg2: u32, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::is_robot(arg0, 0x2::tx_context::sender(arg5)), 1);
        0x8839d1744eb2e8ddaed9b22af887d1936ae2d7d6d6117c46701a4a91b70ece29::reward_distribution::add_user_rewards_process(arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

