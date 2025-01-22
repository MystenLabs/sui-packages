module 0x7a4cb5bfcec16a36aa4e03a11296d2cc63dd9a17d47c86b04d0f13dca0880ef6::voting_key {
    struct VotingKey has copy, drop, store {
        nft_id: 0x2::object::ID,
        voter_addr: address,
    }

    public(friend) fun create_voting_key(arg0: 0x2::object::ID, arg1: address) : VotingKey {
        VotingKey{
            nft_id     : arg0,
            voter_addr : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

