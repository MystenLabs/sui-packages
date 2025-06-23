module 0xee2b616f5f00d0df943312bea4c4f8d1a5dbc9ccc89014bbe357d3d19ddb4927::reward_distributor_cap {
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

