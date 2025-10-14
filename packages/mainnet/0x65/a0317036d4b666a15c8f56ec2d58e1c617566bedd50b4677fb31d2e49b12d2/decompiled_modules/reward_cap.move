module 0x65a0317036d4b666a15c8f56ec2d58e1c617566bedd50b4677fb31d2e49b12d2::reward_cap {
    struct RewardCap has store, key {
        id: 0x2::object::UID,
        reward_id: 0x2::object::ID,
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : RewardCap {
        RewardCap{
            id        : 0x2::object::new(arg1),
            reward_id : arg0,
        }
    }

    public fun validate(arg0: &RewardCap, arg1: 0x2::object::ID) {
        assert!(arg0.reward_id == arg1, 938607256488826100);
    }

    // decompiled from Move bytecode v6
}

