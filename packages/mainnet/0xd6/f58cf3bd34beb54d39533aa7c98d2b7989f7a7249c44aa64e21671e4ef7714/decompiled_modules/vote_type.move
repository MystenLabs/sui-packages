module 0xd6f58cf3bd34beb54d39533aa7c98d2b7989f7a7249c44aa64e21671e4ef7714::vote_type {
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

