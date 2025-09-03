module 0x49a7dda98c6dfd2115cee9c00727cf493c01804e55c89b325b08397e414898eb::reward_distributor_cap {
    struct RewardDistributorCap has store, key {
        id: 0x2::object::UID,
        reward_distributor: 0x2::object::ID,
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : RewardDistributorCap {
        RewardDistributorCap{
            id                 : 0x2::object::new(arg1),
            reward_distributor : arg0,
        }
    }

    public fun validate(arg0: &RewardDistributorCap, arg1: 0x2::object::ID) {
        assert!(arg0.reward_distributor == arg1, 9223372105574252543);
    }

    // decompiled from Move bytecode v6
}

