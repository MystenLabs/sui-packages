module 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::reward_authorized_cap {
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

