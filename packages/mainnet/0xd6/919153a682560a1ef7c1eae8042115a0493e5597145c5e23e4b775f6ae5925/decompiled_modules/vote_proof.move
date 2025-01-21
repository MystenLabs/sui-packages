module 0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::vote_proof {
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

