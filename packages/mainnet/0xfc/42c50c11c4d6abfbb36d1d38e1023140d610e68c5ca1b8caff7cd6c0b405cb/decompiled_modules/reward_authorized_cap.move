module 0xfc42c50c11c4d6abfbb36d1d38e1023140d610e68c5ca1b8caff7cd6c0b405cb::reward_authorized_cap {
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

