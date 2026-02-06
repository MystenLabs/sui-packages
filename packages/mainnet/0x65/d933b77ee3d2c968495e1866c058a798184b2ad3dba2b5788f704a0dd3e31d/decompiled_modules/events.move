module 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::events {
    struct CourtCreated has copy, drop {
        court_id: 0x2::object::ID,
        creator: address,
        dispute_fee: u64,
        min_arbitrator_stake: u64,
        created_at: u64,
    }

    struct CourtParametersUpdated has copy, drop {
        court_id: 0x2::object::ID,
        updated_by: address,
        updated_at: u64,
    }

    struct ArbitratorJoined has copy, drop {
        court_id: 0x2::object::ID,
        arbitrator: address,
        stake: u64,
        joined_at: u64,
    }

    struct ArbitratorStakeUpdated has copy, drop {
        court_id: 0x2::object::ID,
        arbitrator: address,
        old_stake: u64,
        new_stake: u64,
        updated_at: u64,
    }

    struct ArbitratorAssigned has copy, drop {
        court_id: 0x2::object::ID,
        dispute_id: 0x2::object::ID,
        arbitrator: address,
        assigned_at: u64,
    }

    struct ArbitratorReputationUpdated has copy, drop {
        court_id: 0x2::object::ID,
        arbitrator: address,
        old_reputation: u64,
        new_reputation: u64,
        updated_at: u64,
    }

    struct ArbitratorSlashed has copy, drop {
        court_id: 0x2::object::ID,
        arbitrator: address,
        amount: u64,
        reason: vector<u8>,
        slashed_at: u64,
    }

    struct ArbitratorLeft has copy, drop {
        court_id: 0x2::object::ID,
        arbitrator: address,
        stake_returned: u64,
        left_at: u64,
    }

    struct DisputeFiled has copy, drop {
        court_id: 0x2::object::ID,
        dispute_id: 0x2::object::ID,
        claimant: address,
        respondent: address,
        dispute_type: u8,
        claim_amount: u64,
        filed_at: u64,
    }

    struct DisputeEvidencePhaseStarted has copy, drop {
        court_id: 0x2::object::ID,
        dispute_id: 0x2::object::ID,
        evidence_deadline: u64,
        started_at: u64,
    }

    struct EvidenceSubmitted has copy, drop {
        court_id: 0x2::object::ID,
        dispute_id: 0x2::object::ID,
        submitter: address,
        evidence_type: u8,
        content_hash: vector<u8>,
        submitted_at: u64,
    }

    struct DisputeDeliberationStarted has copy, drop {
        court_id: 0x2::object::ID,
        dispute_id: 0x2::object::ID,
        deliberation_deadline: u64,
        arbitrators_assigned: u64,
        started_at: u64,
    }

    struct ArbitratorVoted has copy, drop {
        court_id: 0x2::object::ID,
        dispute_id: 0x2::object::ID,
        arbitrator: address,
        decision: u8,
        award_amount: u64,
        voted_at: u64,
    }

    struct RulingIssued has copy, drop {
        court_id: 0x2::object::ID,
        dispute_id: 0x2::object::ID,
        decision: u8,
        award_amount: u64,
        votes_for_claimant: u64,
        votes_for_respondent: u64,
        issued_at: u64,
    }

    struct DisputeAppealed has copy, drop {
        court_id: 0x2::object::ID,
        dispute_id: 0x2::object::ID,
        appealed_by: address,
        appeal_fee: u64,
        appealed_at: u64,
    }

    struct DisputeFinalized has copy, drop {
        court_id: 0x2::object::ID,
        dispute_id: 0x2::object::ID,
        final_decision: u8,
        final_award: u64,
        finalized_at: u64,
    }

    struct AwardPaid has copy, drop {
        court_id: 0x2::object::ID,
        dispute_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        paid_at: u64,
    }

    public fun emit_arbitrator_assigned(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = ArbitratorAssigned{
            court_id    : arg0,
            dispute_id  : arg1,
            arbitrator  : arg2,
            assigned_at : arg3,
        };
        0x2::event::emit<ArbitratorAssigned>(v0);
    }

    public fun emit_arbitrator_joined(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = ArbitratorJoined{
            court_id   : arg0,
            arbitrator : arg1,
            stake      : arg2,
            joined_at  : arg3,
        };
        0x2::event::emit<ArbitratorJoined>(v0);
    }

    public fun emit_arbitrator_left(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = ArbitratorLeft{
            court_id       : arg0,
            arbitrator     : arg1,
            stake_returned : arg2,
            left_at        : arg3,
        };
        0x2::event::emit<ArbitratorLeft>(v0);
    }

    public fun emit_arbitrator_reputation_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ArbitratorReputationUpdated{
            court_id       : arg0,
            arbitrator     : arg1,
            old_reputation : arg2,
            new_reputation : arg3,
            updated_at     : arg4,
        };
        0x2::event::emit<ArbitratorReputationUpdated>(v0);
    }

    public fun emit_arbitrator_slashed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: vector<u8>, arg4: u64) {
        let v0 = ArbitratorSlashed{
            court_id   : arg0,
            arbitrator : arg1,
            amount     : arg2,
            reason     : arg3,
            slashed_at : arg4,
        };
        0x2::event::emit<ArbitratorSlashed>(v0);
    }

    public fun emit_arbitrator_stake_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ArbitratorStakeUpdated{
            court_id   : arg0,
            arbitrator : arg1,
            old_stake  : arg2,
            new_stake  : arg3,
            updated_at : arg4,
        };
        0x2::event::emit<ArbitratorStakeUpdated>(v0);
    }

    public fun emit_arbitrator_voted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: u64, arg5: u64) {
        let v0 = ArbitratorVoted{
            court_id     : arg0,
            dispute_id   : arg1,
            arbitrator   : arg2,
            decision     : arg3,
            award_amount : arg4,
            voted_at     : arg5,
        };
        0x2::event::emit<ArbitratorVoted>(v0);
    }

    public fun emit_award_paid(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = AwardPaid{
            court_id   : arg0,
            dispute_id : arg1,
            recipient  : arg2,
            amount     : arg3,
            paid_at    : arg4,
        };
        0x2::event::emit<AwardPaid>(v0);
    }

    public fun emit_court_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = CourtCreated{
            court_id             : arg0,
            creator              : arg1,
            dispute_fee          : arg2,
            min_arbitrator_stake : arg3,
            created_at           : arg4,
        };
        0x2::event::emit<CourtCreated>(v0);
    }

    public fun emit_court_parameters_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = CourtParametersUpdated{
            court_id   : arg0,
            updated_by : arg1,
            updated_at : arg2,
        };
        0x2::event::emit<CourtParametersUpdated>(v0);
    }

    public fun emit_dispute_appealed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = DisputeAppealed{
            court_id    : arg0,
            dispute_id  : arg1,
            appealed_by : arg2,
            appeal_fee  : arg3,
            appealed_at : arg4,
        };
        0x2::event::emit<DisputeAppealed>(v0);
    }

    public fun emit_dispute_deliberation_started(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = DisputeDeliberationStarted{
            court_id              : arg0,
            dispute_id            : arg1,
            deliberation_deadline : arg2,
            arbitrators_assigned  : arg3,
            started_at            : arg4,
        };
        0x2::event::emit<DisputeDeliberationStarted>(v0);
    }

    public fun emit_dispute_evidence_phase_started(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = DisputeEvidencePhaseStarted{
            court_id          : arg0,
            dispute_id        : arg1,
            evidence_deadline : arg2,
            started_at        : arg3,
        };
        0x2::event::emit<DisputeEvidencePhaseStarted>(v0);
    }

    public fun emit_dispute_filed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u8, arg5: u64, arg6: u64) {
        let v0 = DisputeFiled{
            court_id     : arg0,
            dispute_id   : arg1,
            claimant     : arg2,
            respondent   : arg3,
            dispute_type : arg4,
            claim_amount : arg5,
            filed_at     : arg6,
        };
        0x2::event::emit<DisputeFiled>(v0);
    }

    public fun emit_dispute_finalized(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = DisputeFinalized{
            court_id       : arg0,
            dispute_id     : arg1,
            final_decision : arg2,
            final_award    : arg3,
            finalized_at   : arg4,
        };
        0x2::event::emit<DisputeFinalized>(v0);
    }

    public fun emit_evidence_submitted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: vector<u8>, arg5: u64) {
        let v0 = EvidenceSubmitted{
            court_id      : arg0,
            dispute_id    : arg1,
            submitter     : arg2,
            evidence_type : arg3,
            content_hash  : arg4,
            submitted_at  : arg5,
        };
        0x2::event::emit<EvidenceSubmitted>(v0);
    }

    public fun emit_ruling_issued(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = RulingIssued{
            court_id             : arg0,
            dispute_id           : arg1,
            decision             : arg2,
            award_amount         : arg3,
            votes_for_claimant   : arg4,
            votes_for_respondent : arg5,
            issued_at            : arg6,
        };
        0x2::event::emit<RulingIssued>(v0);
    }

    // decompiled from Move bytecode v6
}

