module 0xa566a1422c0529700a27e7d5e800d52d6b9ade2a57790f20ac0842a39cb02ce8::robot {
    public entry fun add_user_rewards(arg0: &mut 0xa566a1422c0529700a27e7d5e800d52d6b9ade2a57790f20ac0842a39cb02ce8::reward_distribution::ACL, arg1: &mut 0xa566a1422c0529700a27e7d5e800d52d6b9ade2a57790f20ac0842a39cb02ce8::reward_distribution::RewardDistributor, arg2: u32, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xa566a1422c0529700a27e7d5e800d52d6b9ade2a57790f20ac0842a39cb02ce8::reward_distribution::is_robot(arg0, 0x2::tx_context::sender(arg5)), 1);
        0xa566a1422c0529700a27e7d5e800d52d6b9ade2a57790f20ac0842a39cb02ce8::reward_distribution::add_user_rewards_process(arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

