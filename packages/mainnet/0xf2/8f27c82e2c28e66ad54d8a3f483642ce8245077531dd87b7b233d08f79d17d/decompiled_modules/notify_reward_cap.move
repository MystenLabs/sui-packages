module 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::notify_reward_cap {
    struct NOTIFY_REWARD_CAP has drop {
        dummy_field: bool,
    }

    struct NotifyRewardCap has store, key {
        id: 0x2::object::UID,
        voter_id: 0x2::object::ID,
        who: 0x2::object::ID,
    }

    public fun create(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : NotifyRewardCap {
        NotifyRewardCap{
            id       : 0x2::object::new(arg3),
            voter_id : arg1,
            who      : arg2,
        }
    }

    public(friend) fun create_internal(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : NotifyRewardCap {
        NotifyRewardCap{
            id       : 0x2::object::new(arg1),
            voter_id : arg0,
            who      : 0x2::object::id_from_address(0x2::tx_context::sender(arg1)),
        }
    }

    public fun grant(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 9223372191473598463);
        let v0 = NotifyRewardCap{
            id       : 0x2::object::new(arg3),
            voter_id : arg1,
            who      : 0x2::object::id_from_address(arg2),
        };
        0x2::transfer::transfer<NotifyRewardCap>(v0, arg2);
    }

    fun init(arg0: NOTIFY_REWARD_CAP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<NOTIFY_REWARD_CAP>(arg0, arg1);
    }

    public fun validate_notify_reward_voter_id(arg0: &NotifyRewardCap, arg1: 0x2::object::ID) {
        assert!(arg0.voter_id == arg1, 9223372135639023617);
    }

    public fun who(arg0: &NotifyRewardCap) : 0x2::object::ID {
        arg0.who
    }

    // decompiled from Move bytecode v6
}

