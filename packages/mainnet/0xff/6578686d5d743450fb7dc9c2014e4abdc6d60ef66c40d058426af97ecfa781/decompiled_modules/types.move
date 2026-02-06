module 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types {
    struct InferenceConfig has copy, drop, store {
        temperature: u64,
        top_p: u64,
        max_tokens: u64,
        random_seed: u64,
        deterministic: bool,
    }

    struct TeeAttestation has copy, drop, store {
        tee_type: u8,
        attestation: vector<u8>,
        tee_public_key: vector<u8>,
        attested_at: u64,
        expires_at: u64,
    }

    struct ZkProof has copy, drop, store {
        proof_type: u8,
        proof: vector<u8>,
        public_inputs: vector<u8>,
        vk_hash: vector<u8>,
    }

    struct ChallengeEvidence has copy, drop, store {
        challenge_type: u8,
        evidence: vector<u8>,
        challenger_attestation: 0x1::option::Option<TeeAttestation>,
        notes: vector<u8>,
    }

    public fun challenge_type_fake_tee() : u8 {
        2
    }

    public fun challenge_type_no_computation() : u8 {
        3
    }

    public fun challenge_type_wrong_model() : u8 {
        0
    }

    public fun challenge_type_wrong_output() : u8 {
        1
    }

    public fun claim_status_challenge_period() : u8 {
        1
    }

    public fun claim_status_challenged() : u8 {
        3
    }

    public fun claim_status_failed() : u8 {
        4
    }

    public fun claim_status_pending() : u8 {
        0
    }

    public fun claim_status_verified() : u8 {
        2
    }

    public fun config_is_deterministic(arg0: &InferenceConfig) : bool {
        arg0.deterministic
    }

    public fun config_max_tokens(arg0: &InferenceConfig) : u64 {
        arg0.max_tokens
    }

    public fun config_random_seed(arg0: &InferenceConfig) : u64 {
        arg0.random_seed
    }

    public fun config_temperature(arg0: &InferenceConfig) : u64 {
        arg0.temperature
    }

    public fun default_challenge_period() : u64 {
        86400000
    }

    public fun default_inference_config() : InferenceConfig {
        InferenceConfig{
            temperature   : 700,
            top_p         : 950,
            max_tokens    : 2048,
            random_seed   : 0,
            deterministic : false,
        }
    }

    public fun deterministic_inference_config(arg0: u64, arg1: u64, arg2: u64) : InferenceConfig {
        InferenceConfig{
            temperature   : arg0,
            top_p         : 1000,
            max_tokens    : arg1,
            random_seed   : arg2,
            deterministic : true,
        }
    }

    public fun evidence_bytes(arg0: &ChallengeEvidence) : &vector<u8> {
        &arg0.evidence
    }

    public fun evidence_challenge_type(arg0: &ChallengeEvidence) : u8 {
        arg0.challenge_type
    }

    public fun is_claim_challenged(arg0: u8) : bool {
        arg0 == 3
    }

    public fun is_claim_failed(arg0: u8) : bool {
        arg0 == 4
    }

    public fun is_claim_in_challenge_period(arg0: u8) : bool {
        arg0 == 1
    }

    public fun is_claim_pending(arg0: u8) : bool {
        arg0 == 0
    }

    public fun is_claim_verified(arg0: u8) : bool {
        arg0 == 2
    }

    public fun is_tee_attestation_expired(arg0: &TeeAttestation, arg1: u64) : bool {
        arg1 >= arg0.expires_at
    }

    public fun min_challenge_stake() : u64 {
        1000000000
    }

    public fun new_challenge_evidence(arg0: u8, arg1: vector<u8>, arg2: 0x1::option::Option<TeeAttestation>, arg3: vector<u8>) : ChallengeEvidence {
        ChallengeEvidence{
            challenge_type         : arg0,
            evidence               : arg1,
            challenger_attestation : arg2,
            notes                  : arg3,
        }
    }

    public fun new_inference_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : InferenceConfig {
        InferenceConfig{
            temperature   : arg0,
            top_p         : arg1,
            max_tokens    : arg2,
            random_seed   : arg3,
            deterministic : arg4,
        }
    }

    public fun new_tee_attestation(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64) : TeeAttestation {
        TeeAttestation{
            tee_type       : arg0,
            attestation    : arg1,
            tee_public_key : arg2,
            attested_at    : arg3,
            expires_at     : arg4,
        }
    }

    public fun new_zk_proof(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : ZkProof {
        ZkProof{
            proof_type    : arg0,
            proof         : arg1,
            public_inputs : arg2,
            vk_hash       : arg3,
        }
    }

    public fun tee_expires_at(arg0: &TeeAttestation) : u64 {
        arg0.expires_at
    }

    public fun tee_public_key(arg0: &TeeAttestation) : &vector<u8> {
        &arg0.tee_public_key
    }

    public fun tee_type_nitro() : u8 {
        0
    }

    public fun tee_type_sev() : u8 {
        2
    }

    public fun tee_type_sgx() : u8 {
        1
    }

    public fun verification_method_optimistic() : u8 {
        3
    }

    public fun verification_method_reproducibility() : u8 {
        2
    }

    public fun verification_method_tee() : u8 {
        0
    }

    public fun verification_method_zk() : u8 {
        1
    }

    public fun zk_proof_bytes(arg0: &ZkProof) : &vector<u8> {
        &arg0.proof
    }

    public fun zk_public_inputs(arg0: &ZkProof) : &vector<u8> {
        &arg0.public_inputs
    }

    public fun zk_type_groth16() : u8 {
        0
    }

    public fun zk_type_plonk() : u8 {
        1
    }

    public fun zk_type_stark() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

