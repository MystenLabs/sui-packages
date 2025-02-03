module 0x823da9e6dc8ee3ae0510b5f38908d95659210d54ad9f152b2e22665e0e56d626::vote_type {
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

