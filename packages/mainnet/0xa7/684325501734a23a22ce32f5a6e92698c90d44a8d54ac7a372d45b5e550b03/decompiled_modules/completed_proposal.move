module 0xa7684325501734a23a22ce32f5a6e92698c90d44a8d54ac7a372d45b5e550b03::completed_proposal {
    struct CompletedProposal has store, key {
        id: 0x2::object::UID,
        number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        pre_proposal: 0xa7684325501734a23a22ce32f5a6e92698c90d44a8d54ac7a372d45b5e550b03::pre_proposal::PreProposal,
        ended_at: u64,
        approved_vote_type: 0xa7684325501734a23a22ce32f5a6e92698c90d44a8d54ac7a372d45b5e550b03::vote_type::VoteType,
        accepted_by: address,
        total_vote_value: u64,
    }

    public(friend) fun new(arg0: u64, arg1: 0xa7684325501734a23a22ce32f5a6e92698c90d44a8d54ac7a372d45b5e550b03::pre_proposal::PreProposal, arg2: u64, arg3: 0xa7684325501734a23a22ce32f5a6e92698c90d44a8d54ac7a372d45b5e550b03::vote_type::VoteType, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : CompletedProposal {
        CompletedProposal{
            id                 : 0x2::object::new(arg6),
            number             : arg0,
            name               : 0xa7684325501734a23a22ce32f5a6e92698c90d44a8d54ac7a372d45b5e550b03::pre_proposal::name(&arg1),
            description        : 0xa7684325501734a23a22ce32f5a6e92698c90d44a8d54ac7a372d45b5e550b03::pre_proposal::description(&arg1),
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

    public fun approved_vote_type(arg0: &CompletedProposal) : &0xa7684325501734a23a22ce32f5a6e92698c90d44a8d54ac7a372d45b5e550b03::vote_type::VoteType {
        &arg0.approved_vote_type
    }

    public fun ended_at(arg0: &CompletedProposal) : u64 {
        arg0.ended_at
    }

    public fun pre_proposal(arg0: &CompletedProposal) : &0xa7684325501734a23a22ce32f5a6e92698c90d44a8d54ac7a372d45b5e550b03::pre_proposal::PreProposal {
        &arg0.pre_proposal
    }

    public fun number(arg0: &CompletedProposal) : u64 {
        arg0.number
    }

    public fun total_vote_value(arg0: &CompletedProposal) : u64 {
        arg0.total_vote_value
    }

    // decompiled from Move bytecode v6
}

