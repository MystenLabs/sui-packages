module 0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::early_voting {
    struct ProposalPointer has store {
        proposal_id: 0x2::object::ID,
        end_time: u64,
    }

    struct EarlyVoting has store {
        pos0: vector<ProposalPointer>,
    }

    public fun add_proposal(arg0: &0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::governance::NSGovernanceCap, arg1: &mut 0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::governance::NSGovernance, arg2: 0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::proposal::Proposal) {
        if (!0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::governance::has_app<EarlyVoting>(arg1)) {
            let v0 = EarlyVoting{pos0: 0x1::vector::empty<ProposalPointer>()};
            0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::governance::add_app<EarlyVoting>(arg1, v0);
        };
        let v1 = 0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::governance::app_mut<EarlyVoting>(arg1);
        if (0x1::vector::length<ProposalPointer>(&v1.pos0) > 0) {
            assert!(0x1::vector::borrow<ProposalPointer>(&v1.pos0, 0x1::vector::length<ProposalPointer>(&v1.pos0) - 1).end_time < 0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::proposal::start_time_ms(&arg2), 9223372277372944385);
        };
        let v2 = ProposalPointer{
            proposal_id : 0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::proposal::id(&arg2),
            end_time    : 0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::proposal::end_time_ms(&arg2),
        };
        0x1::vector::push_back<ProposalPointer>(&mut v1.pos0, v2);
        0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::proposal::set_serial_no(&mut arg2, 0x1::vector::length<ProposalPointer>(&v1.pos0));
        0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::proposal::set_threshold(&mut arg2, 0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::governance::quorum_threshold(arg1));
        0x1ad77d75e2002f18711ba54dd195190dd9b55a1945a575263ee70609e01ece3::proposal::share(arg2);
    }

    // decompiled from Move bytecode v6
}

