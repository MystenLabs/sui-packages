module 0x565f0f84b23e5d167ddf5efed362787d3ad2a9a5cdf86e76cfdca285a2debdf4::events {
    struct VoteCastEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
    }

    struct VoteRemovedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
    }

    struct ProposalDeletedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
    }

    struct ProposalExecutedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
    }

    struct VoterAddedEvent has copy, drop {
        quorum_upgrade_id: 0x2::object::ID,
        voter: address,
    }

    struct VoterRemovedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
    }

    struct QuorumReachedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
    }

    struct VoterReplacedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        old_voter: address,
        new_voter: address,
    }

    struct ThresholdUpdatedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        new_required_votes: u64,
    }

    struct QuorumRelinquishedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
    }

    public(friend) fun emit_proposal_deleted_event(arg0: 0x2::object::ID) {
        let v0 = ProposalDeletedEvent{proposal_id: arg0};
        0x2::event::emit<ProposalDeletedEvent>(v0);
    }

    public(friend) fun emit_proposal_executed_event(arg0: 0x2::object::ID) {
        let v0 = ProposalExecutedEvent{proposal_id: arg0};
        0x2::event::emit<ProposalExecutedEvent>(v0);
    }

    public(friend) fun emit_quorum_reached_event(arg0: 0x2::object::ID) {
        let v0 = QuorumReachedEvent{proposal_id: arg0};
        0x2::event::emit<QuorumReachedEvent>(v0);
    }

    public(friend) fun emit_quorum_relinquished_event(arg0: 0x2::object::ID) {
        let v0 = QuorumRelinquishedEvent{proposal_id: arg0};
        0x2::event::emit<QuorumRelinquishedEvent>(v0);
    }

    public(friend) fun emit_threshold_updated_event(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ThresholdUpdatedEvent{
            proposal_id        : arg0,
            new_required_votes : arg1,
        };
        0x2::event::emit<ThresholdUpdatedEvent>(v0);
    }

    public(friend) fun emit_vote_cast_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VoteCastEvent{
            proposal_id : arg0,
            voter       : arg1,
        };
        0x2::event::emit<VoteCastEvent>(v0);
    }

    public(friend) fun emit_vote_removed_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VoteRemovedEvent{
            proposal_id : arg0,
            voter       : arg1,
        };
        0x2::event::emit<VoteRemovedEvent>(v0);
    }

    public(friend) fun emit_voter_added_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VoterAddedEvent{
            quorum_upgrade_id : arg0,
            voter             : arg1,
        };
        0x2::event::emit<VoterAddedEvent>(v0);
    }

    public(friend) fun emit_voter_removed_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = VoterRemovedEvent{
            proposal_id : arg0,
            voter       : arg1,
        };
        0x2::event::emit<VoterRemovedEvent>(v0);
    }

    public(friend) fun emit_voter_replaced_event(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = VoterReplacedEvent{
            proposal_id : arg0,
            old_voter   : arg1,
            new_voter   : arg2,
        };
        0x2::event::emit<VoterReplacedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

