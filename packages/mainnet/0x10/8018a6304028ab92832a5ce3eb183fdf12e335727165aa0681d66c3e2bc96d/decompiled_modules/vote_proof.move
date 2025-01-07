module 0x108018a6304028ab92832a5ce3eb183fdf12e335727165aa0681d66c3e2bc96d::vote_proof {
    struct VoteProof has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
    }

    public(friend) fun create_vote_proof_and_transfer(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VoteProof{
            id     : 0x2::object::new(arg1),
            nft_id : arg0,
        };
        0x2::transfer::transfer<VoteProof>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

