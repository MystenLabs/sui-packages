module 0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::voting_key {
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

