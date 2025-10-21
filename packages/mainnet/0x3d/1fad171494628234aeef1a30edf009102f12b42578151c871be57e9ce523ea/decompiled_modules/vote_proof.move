module 0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::vote_proof {
    struct VoteProof has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
    }

    public(friend) fun create_vote_proof_and_transfer(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = VoteProof{
            id     : 0x2::object::new(arg1),
            nft_id : arg0,
        };
        0x2::transfer::transfer<VoteProof>(v0, 0x2::tx_context::sender(arg1));
        0x2::object::uid_to_inner(&v0.id)
    }

    public fun nft_id(arg0: &VoteProof) : 0x2::object::ID {
        arg0.nft_id
    }

    // decompiled from Move bytecode v6
}

