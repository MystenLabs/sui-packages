module 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::early_voting {
    struct ProposalPointer has store {
        proposal_id: 0x2::object::ID,
        end_time: u64,
    }

    struct EarlyVoting has store {
        pos0: vector<ProposalPointer>,
    }

    struct EventAddProposal has copy, drop {
        proposal_id: 0x2::object::ID,
        serial_no: u64,
        start_time: u64,
        end_time: u64,
        version: u8,
        reward: u64,
    }

    fun add_early_voting_proposal(arg0: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::governance::NSGovernance, arg1: ProposalPointer, arg2: u64) {
        if (!0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::governance::has_app<EarlyVoting>(arg0)) {
            let v0 = EarlyVoting{pos0: 0x1::vector::empty<ProposalPointer>()};
            0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::governance::add_app<EarlyVoting>(arg0, v0);
        };
        let v1 = 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::governance::app_mut<EarlyVoting>(arg0);
        if (0x1::vector::length<ProposalPointer>(&v1.pos0) > 0) {
            assert!(0x1::vector::borrow<ProposalPointer>(&v1.pos0, 0x1::vector::length<ProposalPointer>(&v1.pos0) - 1).end_time < arg2, 1000);
        };
        0x1::vector::push_back<ProposalPointer>(&mut v1.pos0, arg1);
    }

    public fun add_proposal_v2(arg0: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::governance::NSGovernanceCap, arg1: &mut 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::governance::NSGovernance, arg2: 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::ProposalV2) {
        let v0 = ProposalPointer{
            proposal_id : 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::id(&arg2),
            end_time    : 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::end_time_ms(&arg2),
        };
        add_early_voting_proposal(arg1, v0, 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::start_time_ms(&arg2));
        0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::set_serial_no(&mut arg2, 0x1::vector::length<ProposalPointer>(&0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::governance::app_mut<EarlyVoting>(arg1).pos0) + 3);
        0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::set_threshold(&mut arg2, 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::governance::quorum_threshold(arg1));
        let v1 = EventAddProposal{
            proposal_id : 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::id(&arg2),
            serial_no   : 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::serial_no(&arg2),
            start_time  : 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::start_time_ms(&arg2),
            end_time    : 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::end_time_ms(&arg2),
            version     : 2,
            reward      : 0x2::balance::value<0x5145494a5f5100e645e4b0aa950fa6b68f614e8c59e17bc5ded3495123a79178::ns::NS>(0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::reward(&arg2)),
        };
        0x2::event::emit<EventAddProposal>(v1);
        0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::proposal_v2::share(arg2);
    }

    public(friend) fun get_proposal_ids(arg0: &0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::governance::NSGovernance, arg1: u64, arg2: u64) : vector<address> {
        if (!0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::governance::has_app<EarlyVoting>(arg0)) {
            return vector[]
        };
        let v0 = 0xdcdcc90460c2b262f24a387a4fda6ceb0365c88349a4c87d3e270afdb74ff94f::governance::app<EarlyVoting>(arg0);
        let v1 = 0x1::vector::length<ProposalPointer>(&v0.pos0);
        if (arg1 >= v1) {
            return vector[]
        };
        let v2 = vector[];
        let v3 = v1 - arg1;
        while (v3 > 0 && 0x1::vector::length<address>(&v2) < arg2) {
            v3 = v3 - 1;
            0x1::vector::push_back<address>(&mut v2, 0x2::object::id_to_address(&0x1::vector::borrow<ProposalPointer>(&v0.pos0, v3).proposal_id));
        };
        v2
    }

    // decompiled from Move bytecode v6
}

