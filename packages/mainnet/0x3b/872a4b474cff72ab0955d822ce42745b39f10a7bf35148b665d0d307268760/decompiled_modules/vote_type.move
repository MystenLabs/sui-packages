module 0x3b872a4b474cff72ab0955d822ce42745b39f10a7bf35148b665d0d307268760::vote_type {
    struct VoteType has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        proposal_id: 0x2::object::ID,
        total_vote_value: u64,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : VoteType {
        VoteType{
            id               : 0x2::object::new(arg3),
            name             : arg0,
            proposal_id      : arg1,
            total_vote_value : arg2,
        }
    }

    public fun add_vote_value(arg0: &mut VoteType, arg1: u64) {
        arg0.total_vote_value = arg0.total_vote_value + arg1;
    }

    public(friend) fun destruct(arg0: VoteType) {
        let VoteType {
            id               : v0,
            name             : _,
            proposal_id      : _,
            total_vote_value : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun name(arg0: &VoteType) : 0x1::string::String {
        arg0.name
    }

    public fun proposal_id(arg0: &VoteType) : 0x2::object::ID {
        arg0.proposal_id
    }

    public fun total_vote_value(arg0: &VoteType) : u64 {
        arg0.total_vote_value
    }

    // decompiled from Move bytecode v6
}

