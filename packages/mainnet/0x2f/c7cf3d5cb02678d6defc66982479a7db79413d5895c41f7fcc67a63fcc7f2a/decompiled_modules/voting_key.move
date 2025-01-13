module 0x2fc7cf3d5cb02678d6defc66982479a7db79413d5895c41f7fcc67a63fcc7f2a::voting_key {
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

