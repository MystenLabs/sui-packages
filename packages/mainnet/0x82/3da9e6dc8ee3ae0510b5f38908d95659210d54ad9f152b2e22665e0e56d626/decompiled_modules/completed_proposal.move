module 0x823da9e6dc8ee3ae0510b5f38908d95659210d54ad9f152b2e22665e0e56d626::completed_proposal {
    struct CompletedProposal has store, key {
        id: 0x2::object::UID,
        number: u64,
        pre_proposal: 0x823da9e6dc8ee3ae0510b5f38908d95659210d54ad9f152b2e22665e0e56d626::pre_proposal::PreProposal,
        ended_at: u64,
        approved_vote_type: 0x823da9e6dc8ee3ae0510b5f38908d95659210d54ad9f152b2e22665e0e56d626::vote_type::VoteType,
        accepted_by: address,
        total_vote_value: u64,
    }

    public(friend) fun new(arg0: u64, arg1: 0x823da9e6dc8ee3ae0510b5f38908d95659210d54ad9f152b2e22665e0e56d626::pre_proposal::PreProposal, arg2: u64, arg3: 0x823da9e6dc8ee3ae0510b5f38908d95659210d54ad9f152b2e22665e0e56d626::vote_type::VoteType, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : CompletedProposal {
        CompletedProposal{
            id                 : 0x2::object::new(arg6),
            number             : arg0,
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

    public fun approved_vote_type(arg0: &CompletedProposal) : &0x823da9e6dc8ee3ae0510b5f38908d95659210d54ad9f152b2e22665e0e56d626::vote_type::VoteType {
        &arg0.approved_vote_type
    }

    public fun ended_at(arg0: &CompletedProposal) : u64 {
        arg0.ended_at
    }

    public fun pre_proposal(arg0: &CompletedProposal) : &0x823da9e6dc8ee3ae0510b5f38908d95659210d54ad9f152b2e22665e0e56d626::pre_proposal::PreProposal {
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

