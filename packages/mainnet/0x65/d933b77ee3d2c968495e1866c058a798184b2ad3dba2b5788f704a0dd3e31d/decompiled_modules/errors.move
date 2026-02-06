module 0x65d933b77ee3d2c968495e1866c058a798184b2ad3dba2b5788f704a0dd3e31d::errors {
    public fun already_appealed() : u64 {
        406
    }

    public fun already_arbitrator() : u64 {
        101
    }

    public fun already_completed() : u64 {
        6
    }

    public fun already_voted_on_ruling() : u64 {
        401
    }

    public fun appeal_not_allowed() : u64 {
        407
    }

    public fun appeal_period_not_over() : u64 {
        403
    }

    public fun appeal_period_over() : u64 {
        404
    }

    public fun arbitrator_has_active_cases() : u64 {
        104
    }

    public fun arbitrator_suspended() : u64 {
        103
    }

    public fun cannot_dispute_self() : u64 {
        208
    }

    public fun conflict_of_interest() : u64 {
        105
    }

    public fun consensus_not_reached() : u64 {
        408
    }

    public fun deliberation_not_started() : u64 {
        204
    }

    public fun dispute_already_filed() : u64 {
        202
    }

    public fun dispute_already_ruled() : u64 {
        205
    }

    public fun dispute_not_found() : u64 {
        200
    }

    public fun empty_vector() : u64 {
        8
    }

    public fun evidence_already_submitted() : u64 {
        302
    }

    public fun evidence_hash_mismatch() : u64 {
        304
    }

    public fun evidence_limit_reached() : u64 {
        303
    }

    public fun evidence_period_ended() : u64 {
        203
    }

    public fun evidence_period_not_started() : u64 {
        300
    }

    public fun fee_not_paid() : u64 {
        207
    }

    public fun insufficient_appeal_fee() : u64 {
        405
    }

    public fun insufficient_arbitrator_stake() : u64 {
        102
    }

    public fun insufficient_funds() : u64 {
        3
    }

    public fun invalid_amount() : u64 {
        2
    }

    public fun invalid_dispute_type() : u64 {
        206
    }

    public fun invalid_evidence_type() : u64 {
        301
    }

    public fun invalid_hash_length() : u64 {
        305
    }

    public fun invalid_status() : u64 {
        7
    }

    public fun invalid_timestamp() : u64 {
        4
    }

    public fun length_mismatch() : u64 {
        9
    }

    public fun not_all_arbitrators_voted() : u64 {
        400
    }

    public fun not_arbitrator() : u64 {
        100
    }

    public fun not_assigned_to_case() : u64 {
        106
    }

    public fun not_authorized() : u64 {
        1
    }

    public fun not_found() : u64 {
        5
    }

    public fun not_owner() : u64 {
        0
    }

    public fun not_party_to_dispute() : u64 {
        201
    }

    public fun reputation_too_low() : u64 {
        107
    }

    public fun ruling_not_final() : u64 {
        402
    }

    public fun voting_period_ended() : u64 {
        409
    }

    // decompiled from Move bytecode v6
}

