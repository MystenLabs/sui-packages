module 0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::robot {
    public entry fun add_user_rewards(arg0: &mut 0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::ACL, arg1: &mut 0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::RewardDistributor, arg2: u32, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::is_robot(arg0, 0x2::tx_context::sender(arg5)), 1);
        0x25f115d2f53e748eb5800de0c34e3f1b75605314b803e15f0b0e8cf582fc3d5e::reward_distribution::add_user_rewards_process(arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

