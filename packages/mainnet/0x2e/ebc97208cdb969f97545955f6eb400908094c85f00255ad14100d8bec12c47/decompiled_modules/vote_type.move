module 0x2eebc97208cdb969f97545955f6eb400908094c85f00255ad14100d8bec12c47::vote_type {
    struct VoteType has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        proposal_id: 0x2::object::ID,
        total_vote_value: u64,
    }

    struct VoteTypeClone has copy, drop {
        id: 0x2::object::ID,
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

    public(friend) fun new_from_vote_type(arg0: &VoteType) : VoteTypeClone {
        VoteTypeClone{
            id               : 0x2::object::id<VoteType>(arg0),
            name             : arg0.name,
            proposal_id      : arg0.proposal_id,
            total_vote_value : arg0.total_vote_value,
        }
    }

    public fun proposal_id(arg0: &VoteType) : 0x2::object::ID {
        arg0.proposal_id
    }

    public fun total_vote_value(arg0: &VoteType) : u64 {
        arg0.total_vote_value
    }

    // decompiled from Move bytecode v6
}

