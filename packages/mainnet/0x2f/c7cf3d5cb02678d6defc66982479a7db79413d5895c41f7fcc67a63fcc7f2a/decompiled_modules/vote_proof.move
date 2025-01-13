module 0x2fc7cf3d5cb02678d6defc66982479a7db79413d5895c41f7fcc67a63fcc7f2a::vote_proof {
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

