module 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::types {
    struct CourtConfig has copy, drop, store {
        min_arbitrator_stake: u64,
        dispute_fee: u64,
        appeal_fee: u64,
        evidence_period: u64,
        deliberation_period: u64,
        appeal_period: u64,
        min_arbitrators: u8,
    }

    struct Evidence has copy, drop, store {
        submitter: address,
        evidence_type: u8,
        content_hash: vector<u8>,
        content_location: vector<u8>,
        timestamp: u64,
        seal_encrypted: bool,
    }

    struct ArbitratorVote has copy, drop, store {
        arbitrator: address,
        decision: u8,
        award_amount: u64,
        reasoning_hash: vector<u8>,
        voted_at: u64,
    }

    struct Ruling has copy, drop, store {
        decision: u8,
        award_amount: u64,
        votes: vector<ArbitratorVote>,
        reasoning_hash: vector<u8>,
        timestamp: u64,
    }

    struct Specialization has copy, drop, store {
        dispute_type: u8,
        cases_handled: u64,
        accuracy_score: u64,
    }

    public fun config_appeal_fee(arg0: &CourtConfig) : u64 {
        arg0.appeal_fee
    }

    public fun config_appeal_period(arg0: &CourtConfig) : u64 {
        arg0.appeal_period
    }

    public fun config_deliberation_period(arg0: &CourtConfig) : u64 {
        arg0.deliberation_period
    }

    public fun config_dispute_fee(arg0: &CourtConfig) : u64 {
        arg0.dispute_fee
    }

    public fun config_evidence_period(arg0: &CourtConfig) : u64 {
        arg0.evidence_period
    }

    public fun config_min_arbitrators(arg0: &CourtConfig) : u8 {
        arg0.min_arbitrators
    }

    public fun config_min_stake(arg0: &CourtConfig) : u64 {
        arg0.min_arbitrator_stake
    }

    public fun decision_claimant_wins() : u8 {
        0
    }

    public fun decision_dismissed() : u8 {
        3
    }

    public fun decision_respondent_wins() : u8 {
        1
    }

    public fun decision_split() : u8 {
        2
    }

    public fun default_court_config() : CourtConfig {
        CourtConfig{
            min_arbitrator_stake : 100000000000,
            dispute_fee          : 1000000000,
            appeal_fee           : 5000000000,
            evidence_period      : 259200000,
            deliberation_period  : 172800000,
            appeal_period        : 86400000,
            min_arbitrators      : 3,
        }
    }

    public fun dispute_status_appealed() : u8 {
        4
    }

    public fun dispute_status_deliberation() : u8 {
        2
    }

    public fun dispute_status_evidence() : u8 {
        1
    }

    public fun dispute_status_filed() : u8 {
        0
    }

    public fun dispute_status_final() : u8 {
        5
    }

    public fun dispute_status_ruled() : u8 {
        3
    }

    public fun dispute_type_contract() : u8 {
        4
    }

    public fun dispute_type_damage() : u8 {
        3
    }

    public fun dispute_type_data() : u8 {
        2
    }

    public fun dispute_type_payment() : u8 {
        1
    }

    public fun dispute_type_service() : u8 {
        0
    }

    public fun evidence_content_hash(arg0: &Evidence) : &vector<u8> {
        &arg0.content_hash
    }

    public fun evidence_is_encrypted(arg0: &Evidence) : bool {
        arg0.seal_encrypted
    }

    public fun evidence_submitter(arg0: &Evidence) : address {
        arg0.submitter
    }

    public fun evidence_type(arg0: &Evidence) : u8 {
        arg0.evidence_type
    }

    public fun evidence_type_attestation() : u8 {
        2
    }

    public fun evidence_type_computation() : u8 {
        3
    }

    public fun evidence_type_document() : u8 {
        0
    }

    public fun evidence_type_transaction() : u8 {
        1
    }

    public fun evidence_type_witness() : u8 {
        4
    }

    public fun is_dispute_appealed(arg0: u8) : bool {
        arg0 == 4
    }

    public fun is_dispute_filed(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_dispute_final(arg0: u8) : bool {
        arg0 == 5
    }

    public fun is_dispute_in_deliberation(arg0: u8) : bool {
        arg0 == 2
    }

    public fun is_dispute_in_evidence(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_dispute_ruled(arg0: u8) : bool {
        arg0 == 3
    }

    public fun max_arbitrators() : u8 {
        7
    }

    public fun max_evidence_items() : u64 {
        10
    }

    public fun min_reputation() : u64 {
        50
    }

    public fun new_arbitrator_vote(arg0: address, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: u64) : ArbitratorVote {
        ArbitratorVote{
            arbitrator     : arg0,
            decision       : arg1,
            award_amount   : arg2,
            reasoning_hash : arg3,
            voted_at       : arg4,
        }
    }

    public fun new_court_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8) : CourtConfig {
        CourtConfig{
            min_arbitrator_stake : arg0,
            dispute_fee          : arg1,
            appeal_fee           : arg2,
            evidence_period      : arg3,
            deliberation_period  : arg4,
            appeal_period        : arg5,
            min_arbitrators      : arg6,
        }
    }

    public fun new_evidence(arg0: address, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: bool) : Evidence {
        Evidence{
            submitter        : arg0,
            evidence_type    : arg1,
            content_hash     : arg2,
            content_location : arg3,
            timestamp        : arg4,
            seal_encrypted   : arg5,
        }
    }

    public fun new_ruling(arg0: u8, arg1: u64, arg2: vector<ArbitratorVote>, arg3: vector<u8>, arg4: u64) : Ruling {
        Ruling{
            decision       : arg0,
            award_amount   : arg1,
            votes          : arg2,
            reasoning_hash : arg3,
            timestamp      : arg4,
        }
    }

    public fun new_specialization(arg0: u8, arg1: u64, arg2: u64) : Specialization {
        Specialization{
            dispute_type   : arg0,
            cases_handled  : arg1,
            accuracy_score : arg2,
        }
    }

    public fun required_consensus() : u8 {
        67
    }

    public fun ruling_award_amount(arg0: &Ruling) : u64 {
        arg0.award_amount
    }

    public fun ruling_decision(arg0: &Ruling) : u8 {
        arg0.decision
    }

    public fun ruling_votes(arg0: &Ruling) : &vector<ArbitratorVote> {
        &arg0.votes
    }

    public fun starting_reputation() : u64 {
        100
    }

    public fun vote_award_amount(arg0: &ArbitratorVote) : u64 {
        arg0.award_amount
    }

    public fun vote_decision(arg0: &ArbitratorVote) : u8 {
        arg0.decision
    }

    // decompiled from Move bytecode v6
}

