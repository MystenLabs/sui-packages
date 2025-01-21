module 0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::voting_key {
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

