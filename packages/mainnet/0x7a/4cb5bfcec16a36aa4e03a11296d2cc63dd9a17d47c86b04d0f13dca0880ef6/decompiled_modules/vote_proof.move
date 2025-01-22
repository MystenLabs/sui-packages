module 0x7a4cb5bfcec16a36aa4e03a11296d2cc63dd9a17d47c86b04d0f13dca0880ef6::vote_proof {
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

