module 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events {
    struct ModelRegistered has copy, drop {
        model_id: vector<u8>,
        model_hash: vector<u8>,
        architecture_hash: vector<u8>,
        registered_by: address,
        registered_at: u64,
    }

    struct ProviderVerified has copy, drop {
        model_id: vector<u8>,
        provider: address,
        tee_type: u8,
        verified_at: u64,
    }

    struct ModelDeactivated has copy, drop {
        model_id: vector<u8>,
        deactivated_by: address,
        reason: vector<u8>,
        deactivated_at: u64,
    }

    struct ComputationCommitted has copy, drop {
        commitment_id: 0x2::object::ID,
        provider: address,
        model_id: vector<u8>,
        input_hash: vector<u8>,
        committed_at: u64,
    }

    struct ComputationClaimed has copy, drop {
        claim_id: 0x2::object::ID,
        commitment_id: 0x1::option::Option<0x2::object::ID>,
        provider: address,
        model_id: vector<u8>,
        input_hash: vector<u8>,
        output_hash: vector<u8>,
        gas_used: u64,
        claimed_at: u64,
    }

    struct ClaimChallengePeriodStarted has copy, drop {
        claim_id: 0x2::object::ID,
        challenge_deadline: u64,
        started_at: u64,
    }

    struct ClaimVerified has copy, drop {
        claim_id: 0x2::object::ID,
        verification_method: u8,
        verified_at: u64,
    }

    struct ClaimVerificationFailed has copy, drop {
        claim_id: 0x2::object::ID,
        reason: vector<u8>,
        failed_at: u64,
    }

    struct ClaimChallenged has copy, drop {
        claim_id: 0x2::object::ID,
        bounty_id: 0x2::object::ID,
        challenger: address,
        challenge_type: u8,
        stake: u64,
        challenged_at: u64,
    }

    struct ChallengeResolved has copy, drop {
        bounty_id: 0x2::object::ID,
        claim_id: 0x2::object::ID,
        challenger_won: bool,
        payout: u64,
        resolved_at: u64,
    }

    struct BountyClaimed has copy, drop {
        bounty_id: 0x2::object::ID,
        claim_id: 0x2::object::ID,
        provider: address,
        amount: u64,
        claimed_at: u64,
    }

    struct TeeAttestationSubmitted has copy, drop {
        provider: address,
        tee_type: u8,
        tee_public_key: vector<u8>,
        expires_at: u64,
        submitted_at: u64,
    }

    struct TeeAttestationVerified has copy, drop {
        provider: address,
        tee_type: u8,
        verified_by: address,
        verified_at: u64,
    }

    public fun emit_bounty_claimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = BountyClaimed{
            bounty_id  : arg0,
            claim_id   : arg1,
            provider   : arg2,
            amount     : arg3,
            claimed_at : arg4,
        };
        0x2::event::emit<BountyClaimed>(v0);
    }

    public fun emit_challenge_resolved(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64) {
        let v0 = ChallengeResolved{
            bounty_id      : arg0,
            claim_id       : arg1,
            challenger_won : arg2,
            payout         : arg3,
            resolved_at    : arg4,
        };
        0x2::event::emit<ChallengeResolved>(v0);
    }

    public fun emit_claim_challenge_period_started(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = ClaimChallengePeriodStarted{
            claim_id           : arg0,
            challenge_deadline : arg1,
            started_at         : arg2,
        };
        0x2::event::emit<ClaimChallengePeriodStarted>(v0);
    }

    public fun emit_claim_challenged(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: u64, arg5: u64) {
        let v0 = ClaimChallenged{
            claim_id       : arg0,
            bounty_id      : arg1,
            challenger     : arg2,
            challenge_type : arg3,
            stake          : arg4,
            challenged_at  : arg5,
        };
        0x2::event::emit<ClaimChallenged>(v0);
    }

    public fun emit_claim_verification_failed(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = ClaimVerificationFailed{
            claim_id  : arg0,
            reason    : arg1,
            failed_at : arg2,
        };
        0x2::event::emit<ClaimVerificationFailed>(v0);
    }

    public fun emit_claim_verified(arg0: 0x2::object::ID, arg1: u8, arg2: u64) {
        let v0 = ClaimVerified{
            claim_id            : arg0,
            verification_method : arg1,
            verified_at         : arg2,
        };
        0x2::event::emit<ClaimVerified>(v0);
    }

    public fun emit_computation_claimed(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64) {
        let v0 = ComputationClaimed{
            claim_id      : arg0,
            commitment_id : arg1,
            provider      : arg2,
            model_id      : arg3,
            input_hash    : arg4,
            output_hash   : arg5,
            gas_used      : arg6,
            claimed_at    : arg7,
        };
        0x2::event::emit<ComputationClaimed>(v0);
    }

    public fun emit_computation_committed(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        let v0 = ComputationCommitted{
            commitment_id : arg0,
            provider      : arg1,
            model_id      : arg2,
            input_hash    : arg3,
            committed_at  : arg4,
        };
        0x2::event::emit<ComputationCommitted>(v0);
    }

    public fun emit_model_deactivated(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: u64) {
        let v0 = ModelDeactivated{
            model_id       : arg0,
            deactivated_by : arg1,
            reason         : arg2,
            deactivated_at : arg3,
        };
        0x2::event::emit<ModelDeactivated>(v0);
    }

    public fun emit_model_registered(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: u64) {
        let v0 = ModelRegistered{
            model_id          : arg0,
            model_hash        : arg1,
            architecture_hash : arg2,
            registered_by     : arg3,
            registered_at     : arg4,
        };
        0x2::event::emit<ModelRegistered>(v0);
    }

    public fun emit_provider_verified(arg0: vector<u8>, arg1: address, arg2: u8, arg3: u64) {
        let v0 = ProviderVerified{
            model_id    : arg0,
            provider    : arg1,
            tee_type    : arg2,
            verified_at : arg3,
        };
        0x2::event::emit<ProviderVerified>(v0);
    }

    public fun emit_tee_attestation_submitted(arg0: address, arg1: u8, arg2: vector<u8>, arg3: u64, arg4: u64) {
        let v0 = TeeAttestationSubmitted{
            provider       : arg0,
            tee_type       : arg1,
            tee_public_key : arg2,
            expires_at     : arg3,
            submitted_at   : arg4,
        };
        0x2::event::emit<TeeAttestationSubmitted>(v0);
    }

    public fun emit_tee_attestation_verified(arg0: address, arg1: u8, arg2: address, arg3: u64) {
        let v0 = TeeAttestationVerified{
            provider    : arg0,
            tee_type    : arg1,
            verified_by : arg2,
            verified_at : arg3,
        };
        0x2::event::emit<TeeAttestationVerified>(v0);
    }

    // decompiled from Move bytecode v6
}

