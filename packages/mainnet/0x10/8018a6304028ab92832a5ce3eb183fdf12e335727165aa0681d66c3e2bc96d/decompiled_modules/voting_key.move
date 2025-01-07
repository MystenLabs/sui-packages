module 0x108018a6304028ab92832a5ce3eb183fdf12e335727165aa0681d66c3e2bc96d::voting_key {
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

