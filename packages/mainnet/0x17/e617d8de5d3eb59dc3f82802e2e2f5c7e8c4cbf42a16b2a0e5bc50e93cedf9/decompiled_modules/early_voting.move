module 0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::early_voting {
    struct ProposalPointer has store {
        proposal_id: 0x2::object::ID,
        end_time: u64,
    }

    struct EarlyVoting has store {
        pos0: vector<ProposalPointer>,
    }

    public fun add_proposal(arg0: &0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::governance::NSGovernanceCap, arg1: &mut 0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::governance::NSGovernance, arg2: 0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::proposal::Proposal) {
        if (!0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::governance::has_app<EarlyVoting>(arg1)) {
            let v0 = EarlyVoting{pos0: 0x1::vector::empty<ProposalPointer>()};
            0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::governance::add_app<EarlyVoting>(arg1, v0);
        };
        let v1 = 0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::governance::app_mut<EarlyVoting>(arg1);
        if (0x1::vector::length<ProposalPointer>(&v1.pos0) > 0) {
            assert!(0x1::vector::borrow<ProposalPointer>(&v1.pos0, 0x1::vector::length<ProposalPointer>(&v1.pos0) - 1).end_time < 0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::proposal::start_time_ms(&arg2), 9223372277372944385);
        };
        let v2 = ProposalPointer{
            proposal_id : 0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::proposal::id(&arg2),
            end_time    : 0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::proposal::end_time_ms(&arg2),
        };
        0x1::vector::push_back<ProposalPointer>(&mut v1.pos0, v2);
        0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::proposal::set_serial_no(&mut arg2, 0x1::vector::length<ProposalPointer>(&v1.pos0));
        0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::proposal::set_threshold(&mut arg2, 0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::governance::quorum_threshold(arg1));
        0x17e617d8de5d3eb59dc3f82802e2e2f5c7e8c4cbf42a16b2a0e5bc50e93cedf9::proposal::share(arg2);
    }

    // decompiled from Move bytecode v6
}

