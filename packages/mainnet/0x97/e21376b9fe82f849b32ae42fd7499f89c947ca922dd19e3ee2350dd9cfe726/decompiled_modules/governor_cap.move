module 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::governor_cap {
    struct GovernorCap has store, key {
        id: 0x2::object::UID,
        voter_id: 0x2::object::ID,
        who: 0x2::object::ID,
    }

    struct EpochGovernorCap has store, key {
        id: 0x2::object::UID,
        voter_id: 0x2::object::ID,
    }

    public(friend) fun create_epoch_governor_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : EpochGovernorCap {
        EpochGovernorCap{
            id       : 0x2::object::new(arg1),
            voter_id : arg0,
        }
    }

    public(friend) fun create_governor_cap(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : GovernorCap {
        GovernorCap{
            id       : 0x2::object::new(arg2),
            voter_id : arg0,
            who      : 0x2::object::id_from_address(arg1),
        }
    }

    public fun drop_epoch_governor_cap(arg0: EpochGovernorCap) {
        let EpochGovernorCap {
            id       : v0,
            voter_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun drop_governor_cap(arg0: GovernorCap) {
        let GovernorCap {
            id       : v0,
            voter_id : _,
            who      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun epoch_governor_voter_id(arg0: &EpochGovernorCap) : 0x2::object::ID {
        arg0.voter_id
    }

    public fun governor_voter_id(arg0: &GovernorCap) : 0x2::object::ID {
        arg0.voter_id
    }

    public fun validate_epoch_governor_voter_id(arg0: &EpochGovernorCap, arg1: 0x2::object::ID) {
        assert!(arg0.voter_id == arg1, 1);
    }

    public fun validate_governor_voter_id(arg0: &GovernorCap, arg1: 0x2::object::ID) {
        assert!(arg0.voter_id == arg1, 1);
    }

    public fun who(arg0: &GovernorCap) : 0x2::object::ID {
        arg0.who
    }

    // decompiled from Move bytecode v6
}

