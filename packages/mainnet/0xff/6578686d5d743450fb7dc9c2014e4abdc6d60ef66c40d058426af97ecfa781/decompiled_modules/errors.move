module 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors {
    public fun already_completed() : u64 {
        6
    }

    public fun bounty_already_claimed() : u64 {
        401
    }

    public fun bounty_not_found() : u64 {
        400
    }

    public fun challenge_already_submitted() : u64 {
        405
    }

    public fun challenge_period_not_over() : u64 {
        402
    }

    public fun challenge_period_over() : u64 {
        403
    }

    public fun claim_already_submitted() : u64 {
        201
    }

    public fun claim_already_verified() : u64 {
        202
    }

    public fun claim_disputed() : u64 {
        207
    }

    public fun claim_expired() : u64 {
        203
    }

    public fun claim_not_found() : u64 {
        200
    }

    public fun commitment_not_revealed() : u64 {
        208
    }

    public fun computation_mismatch() : u64 {
        305
    }

    public fun empty_vector() : u64 {
        8
    }

    public fun insufficient_bounty_stake() : u64 {
        406
    }

    public fun insufficient_funds() : u64 {
        3
    }

    public fun invalid_amount() : u64 {
        2
    }

    public fun invalid_architecture_hash() : u64 {
        106
    }

    public fun invalid_challenge_evidence() : u64 {
        404
    }

    public fun invalid_computation_proof() : u64 {
        206
    }

    public fun invalid_input_hash() : u64 {
        204
    }

    public fun invalid_model_hash() : u64 {
        102
    }

    public fun invalid_output_hash() : u64 {
        205
    }

    public fun invalid_random_seed() : u64 {
        304
    }

    public fun invalid_status() : u64 {
        7
    }

    public fun invalid_tee_attestation() : u64 {
        103
    }

    public fun invalid_timestamp() : u64 {
        4
    }

    public fun invalid_verifier() : u64 {
        302
    }

    public fun length_mismatch() : u64 {
        9
    }

    public fun model_already_registered() : u64 {
        100
    }

    public fun model_deactivated() : u64 {
        105
    }

    public fun model_not_found() : u64 {
        101
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

    public fun provider_not_verified() : u64 {
        104
    }

    public fun reproducibility_failed() : u64 {
        303
    }

    public fun tee_attestation_expired() : u64 {
        301
    }

    public fun verification_failed() : u64 {
        300
    }

    // decompiled from Move bytecode v6
}

