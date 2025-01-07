module 0x53db5bfbd09013d86341e3020023161d11b6fc17af49326224732798d22374df::completed_proposal {
    struct CompletedProposal has store, key {
        id: 0x2::object::UID,
        number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        pre_proposal: 0x53db5bfbd09013d86341e3020023161d11b6fc17af49326224732798d22374df::pre_proposal::PreProposal,
        ended_at: u64,
        approved_vote_type: 0x53db5bfbd09013d86341e3020023161d11b6fc17af49326224732798d22374df::vote_type::VoteType,
        accepted_by: address,
        total_vote_value: u64,
    }

    public(friend) fun new(arg0: u64, arg1: 0x53db5bfbd09013d86341e3020023161d11b6fc17af49326224732798d22374df::pre_proposal::PreProposal, arg2: u64, arg3: 0x53db5bfbd09013d86341e3020023161d11b6fc17af49326224732798d22374df::vote_type::VoteType, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : CompletedProposal {
        CompletedProposal{
            id                 : 0x2::object::new(arg6),
            number             : arg0,
            name               : 0x53db5bfbd09013d86341e3020023161d11b6fc17af49326224732798d22374df::pre_proposal::name(&arg1),
            description        : 0x53db5bfbd09013d86341e3020023161d11b6fc17af49326224732798d22374df::pre_proposal::description(&arg1),
            pre_proposal       : arg1,
            ended_at           : arg2,
            approved_vote_type : arg3,
            accepted_by        : arg4,
            total_vote_value   : arg5,
        }
    }

    public fun accepted_by(arg0: &CompletedProposal) : address {
        arg0.accepted_by
    }

    public fun approved_vote_type(arg0: &CompletedProposal) : &0x53db5bfbd09013d86341e3020023161d11b6fc17af49326224732798d22374df::vote_type::VoteType {
        &arg0.approved_vote_type
    }

    public fun ended_at(arg0: &CompletedProposal) : u64 {
        arg0.ended_at
    }

    public fun pre_proposal(arg0: &CompletedProposal) : &0x53db5bfbd09013d86341e3020023161d11b6fc17af49326224732798d22374df::pre_proposal::PreProposal {
        &arg0.pre_proposal
    }

    public fun number(arg0: &CompletedProposal) : u64 {
        arg0.number
    }

    public fun total_vote_value(arg0: &CompletedProposal) : u64 {
        arg0.total_vote_value
    }

    public fun vec_vote_types(arg0: &CompletedProposal) : vector<0x53db5bfbd09013d86341e3020023161d11b6fc17af49326224732798d22374df::vote_type::VoteTypeClone> {
        0x53db5bfbd09013d86341e3020023161d11b6fc17af49326224732798d22374df::pre_proposal::vec_vote_types(pre_proposal(arg0))
    }

    // decompiled from Move bytecode v6
}

