module 0xc14bf5c5b1657199254820558b6d803ef1a8eca4115a00a47828649d198174af::completed_proposal {
    struct CompletedProposal has store, key {
        id: 0x2::object::UID,
        number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        pre_proposal: 0xc14bf5c5b1657199254820558b6d803ef1a8eca4115a00a47828649d198174af::pre_proposal::PreProposal,
        started_at: u64,
        ended_at: u64,
        approved_vote_type: 0xc14bf5c5b1657199254820558b6d803ef1a8eca4115a00a47828649d198174af::vote_type::VoteType,
        accepted_by: address,
        total_vote_value: u64,
    }

    public(friend) fun new(arg0: u64, arg1: 0xc14bf5c5b1657199254820558b6d803ef1a8eca4115a00a47828649d198174af::pre_proposal::PreProposal, arg2: u64, arg3: u64, arg4: 0xc14bf5c5b1657199254820558b6d803ef1a8eca4115a00a47828649d198174af::vote_type::VoteType, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : CompletedProposal {
        CompletedProposal{
            id                 : 0x2::object::new(arg7),
            number             : arg0,
            name               : 0xc14bf5c5b1657199254820558b6d803ef1a8eca4115a00a47828649d198174af::pre_proposal::name(&arg1),
            description        : 0xc14bf5c5b1657199254820558b6d803ef1a8eca4115a00a47828649d198174af::pre_proposal::description(&arg1),
            pre_proposal       : arg1,
            started_at         : arg2,
            ended_at           : arg3,
            approved_vote_type : arg4,
            accepted_by        : arg5,
            total_vote_value   : arg6,
        }
    }

    public fun accepted_by(arg0: &CompletedProposal) : address {
        arg0.accepted_by
    }

    public fun approved_vote_type(arg0: &CompletedProposal) : &0xc14bf5c5b1657199254820558b6d803ef1a8eca4115a00a47828649d198174af::vote_type::VoteType {
        &arg0.approved_vote_type
    }

    public fun ended_at(arg0: &CompletedProposal) : u64 {
        arg0.ended_at
    }

    public fun pre_proposal(arg0: &CompletedProposal) : &0xc14bf5c5b1657199254820558b6d803ef1a8eca4115a00a47828649d198174af::pre_proposal::PreProposal {
        &arg0.pre_proposal
    }

    public fun number(arg0: &CompletedProposal) : u64 {
        arg0.number
    }

    public fun total_vote_value(arg0: &CompletedProposal) : u64 {
        arg0.total_vote_value
    }

    public fun vec_vote_types(arg0: &CompletedProposal) : vector<0xc14bf5c5b1657199254820558b6d803ef1a8eca4115a00a47828649d198174af::vote_type::VoteTypeClone> {
        0xc14bf5c5b1657199254820558b6d803ef1a8eca4115a00a47828649d198174af::pre_proposal::vec_vote_types(pre_proposal(arg0))
    }

    // decompiled from Move bytecode v6
}

