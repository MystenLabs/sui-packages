module 0x65d50c0086e5760b2aa9ad7f2a541a75f6eb8a29ee048aed3c42fc248f90eade::voting_escrow_cap {
    struct VotingEscrowCap has store, key {
        id: 0x2::object::UID,
        voting_escrow_id: 0x2::object::ID,
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : VotingEscrowCap {
        VotingEscrowCap{
            id               : 0x2::object::new(arg1),
            voting_escrow_id : arg0,
        }
    }

    public fun validate(arg0: &VotingEscrowCap, arg1: 0x2::object::ID) {
        assert!(arg0.voting_escrow_id == arg1, 145221715012404670);
    }

    // decompiled from Move bytecode v6
}

