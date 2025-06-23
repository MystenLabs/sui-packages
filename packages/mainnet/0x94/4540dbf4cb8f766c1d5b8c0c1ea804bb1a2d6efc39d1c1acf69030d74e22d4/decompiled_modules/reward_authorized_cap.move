module 0x944540dbf4cb8f766c1d5b8c0c1ea804bb1a2d6efc39d1c1acf69030d74e22d4::reward_authorized_cap {
    struct RewardAuthorizedCap has store, key {
        id: 0x2::object::UID,
        authorized: 0x2::object::ID,
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : RewardAuthorizedCap {
        RewardAuthorizedCap{
            id         : 0x2::object::new(arg1),
            authorized : arg0,
        }
    }

    public fun validate(arg0: &RewardAuthorizedCap, arg1: 0x2::object::ID) {
        assert!(arg0.authorized == arg1, 9223372109869219839);
    }

    // decompiled from Move bytecode v6
}

