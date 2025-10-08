module 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow_cap {
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

