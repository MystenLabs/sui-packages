module 0x42601747e2672daf6257e284da1b586307e6a036683249c3af68f249e0afac1e::vote_type {
    struct VoteType has copy, drop, store {
        name: 0x1::string::String,
        total_vote_value: u64,
    }

    public(friend) fun from_string(arg0: 0x1::string::String) : VoteType {
        VoteType{
            name             : arg0,
            total_vote_value : 0,
        }
    }

    public(friend) fun increment_total_vote_value(arg0: &mut VoteType) {
        arg0.total_vote_value = arg0.total_vote_value + 1;
    }

    public(friend) fun name(arg0: &VoteType) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: u64) : VoteType {
        VoteType{
            name             : arg0,
            total_vote_value : arg1,
        }
    }

    public(friend) fun total_vote_value(arg0: &VoteType) : u64 {
        arg0.total_vote_value
    }

    // decompiled from Move bytecode v6
}

