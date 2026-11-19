module 0xa57bbbbe3815d1f4d0c4a3ec4f28b887cfc30f3845c3a857aab6e542cbb4638e::robot {
    public entry fun add_user_rewards(arg0: &mut 0xa57bbbbe3815d1f4d0c4a3ec4f28b887cfc30f3845c3a857aab6e542cbb4638e::reward_distribution::ACL, arg1: &mut 0xa57bbbbe3815d1f4d0c4a3ec4f28b887cfc30f3845c3a857aab6e542cbb4638e::reward_distribution::RewardDistributor, arg2: u32, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xa57bbbbe3815d1f4d0c4a3ec4f28b887cfc30f3845c3a857aab6e542cbb4638e::reward_distribution::is_robot(arg0, 0x2::tx_context::sender(arg5)), 1);
        0xa57bbbbe3815d1f4d0c4a3ec4f28b887cfc30f3845c3a857aab6e542cbb4638e::reward_distribution::add_user_rewards_process(arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

