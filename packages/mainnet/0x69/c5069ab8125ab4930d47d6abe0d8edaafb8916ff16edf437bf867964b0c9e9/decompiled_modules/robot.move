module 0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::robot {
    public entry fun add_user_rewards(arg0: &mut 0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::ACL, arg1: &mut 0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::RewardDistributor, arg2: u32, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::is_robot(arg0, 0x2::tx_context::sender(arg5)), 1);
        0x69c5069ab8125ab4930d47d6abe0d8edaafb8916ff16edf437bf867964b0c9e9::reward_distribution::add_user_rewards_process(arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

