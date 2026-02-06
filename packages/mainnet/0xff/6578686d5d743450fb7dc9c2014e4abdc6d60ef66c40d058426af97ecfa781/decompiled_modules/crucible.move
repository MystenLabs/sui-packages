module 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::crucible {
    struct ModelRegistry has key {
        id: 0x2::object::UID,
        models: 0x2::table::Table<vector<u8>, ModelRecord>,
        total_models: u64,
    }

    struct ModelRecord has store {
        model_hash: vector<u8>,
        architecture_hash: vector<u8>,
        registered_by: address,
        verified_providers: vector<address>,
        active: bool,
        registered_at: u64,
    }

    struct ComputationCommitment has store, key {
        id: 0x2::object::UID,
        provider: address,
        model_id: vector<u8>,
        input_hash: vector<u8>,
        inference_config: 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::InferenceConfig,
        committed_at: u64,
        fulfilled: bool,
    }

    struct ComputationClaim has store, key {
        id: 0x2::object::UID,
        model_id: vector<u8>,
        input_hash: vector<u8>,
        output_hash: vector<u8>,
        inference_config: 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::InferenceConfig,
        tee_attestation: 0x1::option::Option<0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::TeeAttestation>,
        zk_proof: 0x1::option::Option<0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::ZkProof>,
        provider: address,
        commitment_id: 0x1::option::Option<0x2::object::ID>,
        timestamp: u64,
        gas_used: u64,
        status: u8,
        challenge_deadline: u64,
    }

    struct VerificationBounty has store, key {
        id: 0x2::object::UID,
        claim_id: 0x2::object::ID,
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        challenger: address,
        challenge_type: u8,
        evidence: 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::ChallengeEvidence,
        challenged_at: u64,
        resolved: bool,
    }

    struct ProviderTeeRegistration has store, key {
        id: 0x2::object::UID,
        provider: address,
        attestation: 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::TeeAttestation,
        verified_models: vector<vector<u8>>,
        reputation: u64,
        total_claims: u64,
        successful_verifications: u64,
    }

    struct CrucibleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun challenge_claim(arg0: &mut ComputationClaim, arg1: u8, arg2: 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::ChallengeEvidence, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VerificationBounty {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::is_claim_in_challenge_period(arg0.status), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::invalid_status());
        assert!(v0 < arg0.challenge_deadline, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::challenge_period_over());
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::min_challenge_stake(), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::insufficient_bounty_stake());
        arg0.status = 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::claim_status_challenged();
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = VerificationBounty{
            id             : 0x2::object::new(arg5),
            claim_id       : 0x2::object::id<ComputationClaim>(arg0),
            stake          : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            challenger     : v2,
            challenge_type : arg1,
            evidence       : arg2,
            challenged_at  : v0,
            resolved       : false,
        };
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_claim_challenged(0x2::object::id<ComputationClaim>(arg0), 0x2::object::id<VerificationBounty>(&v3), v2, arg1, v1, v0);
        v3
    }

    public fun claim_output_hash(arg0: &ComputationClaim) : vector<u8> {
        arg0.output_hash
    }

    public fun claim_provider(arg0: &ComputationClaim) : address {
        arg0.provider
    }

    public fun claim_status(arg0: &ComputationClaim) : u8 {
        arg0.status
    }

    public fun deactivate_model(arg0: &mut ModelRegistry, arg1: &CrucibleAdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, ModelRecord>(&arg0.models, arg2), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::model_not_found());
        0x2::table::borrow_mut<vector<u8>, ModelRecord>(&mut arg0.models, arg2).active = false;
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_model_deactivated(arg2, 0x2::tx_context::sender(arg5), arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public fun finalize_claim(arg0: &mut ComputationClaim, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::is_claim_in_challenge_period(arg0.status), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::invalid_status());
        assert!(v0 >= arg0.challenge_deadline, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::challenge_period_not_over());
        arg0.status = 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::claim_status_verified();
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_claim_verified(0x2::object::id<ComputationClaim>(arg0), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::verification_method_optimistic(), v0);
    }

    public fun fulfill_commitment(arg0: &mut ComputationCommitment, arg1: &mut ComputationClaim, arg2: &0x2::clock::Clock) {
        assert!(!arg0.fulfilled, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::already_completed());
        assert!(arg1.provider == arg0.provider, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::not_authorized());
        assert!(arg1.model_id == arg0.model_id, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::invalid_model_hash());
        assert!(arg1.input_hash == arg0.input_hash, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::invalid_input_hash());
        arg0.fulfilled = true;
        arg1.commitment_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<ComputationCommitment>(arg0));
        arg1.status = 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::claim_status_verified();
        arg1.challenge_deadline = 0;
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_claim_verified(0x2::object::id<ComputationClaim>(arg1), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::verification_method_reproducibility(), 0x2::clock::timestamp_ms(arg2));
    }

    public fun get_model_hash(arg0: &ModelRegistry, arg1: vector<u8>) : vector<u8> {
        0x2::table::borrow<vector<u8>, ModelRecord>(&arg0.models, arg1).model_hash
    }

    public fun hash_input(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::keccak256(arg0)
    }

    public fun hash_output(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::keccak256(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ModelRegistry{
            id           : 0x2::object::new(arg0),
            models       : 0x2::table::new<vector<u8>, ModelRecord>(arg0),
            total_models : 0,
        };
        0x2::transfer::share_object<ModelRegistry>(v0);
        let v1 = CrucibleAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CrucibleAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_claim_verified(arg0: &ComputationClaim) : bool {
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::is_claim_verified(arg0.status)
    }

    public fun is_provider_verified(arg0: &ModelRegistry, arg1: vector<u8>, arg2: address) : bool {
        if (!0x2::table::contains<vector<u8>, ModelRecord>(&arg0.models, arg1)) {
            return false
        };
        0x1::vector::contains<address>(&0x2::table::borrow<vector<u8>, ModelRecord>(&arg0.models, arg1).verified_providers, &arg2)
    }

    public fun make_commitment(arg0: &ModelRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::InferenceConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : ComputationCommitment {
        assert!(0x2::table::contains<vector<u8>, ModelRecord>(&arg0.models, arg1), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::model_not_found());
        assert!(0x2::table::borrow<vector<u8>, ModelRecord>(&arg0.models, arg1).active, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::model_deactivated());
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = ComputationCommitment{
            id               : 0x2::object::new(arg5),
            provider         : v1,
            model_id         : arg1,
            input_hash       : arg2,
            inference_config : arg3,
            committed_at     : v0,
            fulfilled        : false,
        };
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_computation_committed(0x2::object::id<ComputationCommitment>(&v2), v1, arg1, arg2, v0);
        v2
    }

    public fun model_exists(arg0: &ModelRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, ModelRecord>(&arg0.models, arg1)
    }

    public fun register_model(arg0: &mut ModelRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<vector<u8>, ModelRecord>(&arg0.models, arg1), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::model_already_registered());
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::invalid_model_hash());
        assert!(0x1::vector::length<u8>(&arg3) == 32, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::invalid_architecture_hash());
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = ModelRecord{
            model_hash         : arg2,
            architecture_hash  : arg3,
            registered_by      : v1,
            verified_providers : 0x1::vector::empty<address>(),
            active             : true,
            registered_at      : v0,
        };
        0x2::table::add<vector<u8>, ModelRecord>(&mut arg0.models, arg1, v2);
        arg0.total_models = arg0.total_models + 1;
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_model_registered(arg1, arg2, arg3, v1, v0);
    }

    public fun resolve_challenge(arg0: &CrucibleAdminCap, arg1: &mut ComputationClaim, arg2: VerificationBounty, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg2.claim_id == 0x2::object::id<ComputationClaim>(arg1), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::not_found());
        assert!(!arg2.resolved, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::already_completed());
        assert!(0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::is_claim_challenged(arg1.status), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::invalid_status());
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let VerificationBounty {
            id             : v1,
            claim_id       : _,
            stake          : v3,
            challenger     : _,
            challenge_type : _,
            evidence       : _,
            challenged_at  : _,
            resolved       : _,
        } = arg2;
        let v9 = v3;
        0x2::object::delete(v1);
        if (arg3) {
            arg1.status = 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::claim_status_failed();
            0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_claim_verification_failed(0x2::object::id<ComputationClaim>(arg1), b"Challenge succeeded", v0);
            0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_challenge_resolved(0x2::object::id<VerificationBounty>(&arg2), 0x2::object::id<ComputationClaim>(arg1), true, 0x2::balance::value<0x2::sui::SUI>(&v9), v0);
            0x2::coin::from_balance<0x2::sui::SUI>(v9, arg5)
        } else {
            arg1.status = 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::claim_status_verified();
            0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_claim_verified(0x2::object::id<ComputationClaim>(arg1), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::verification_method_optimistic(), v0);
            0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_challenge_resolved(0x2::object::id<VerificationBounty>(&arg2), 0x2::object::id<ComputationClaim>(arg1), false, 0x2::balance::value<0x2::sui::SUI>(&v9), v0);
            0x2::coin::from_balance<0x2::sui::SUI>(v9, arg5)
        }
    }

    public fun submit_claim_with_tee(arg0: &ModelRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::InferenceConfig, arg5: 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::TeeAttestation, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : ComputationClaim {
        assert!(0x2::table::contains<vector<u8>, ModelRecord>(&arg0.models, arg1), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::model_not_found());
        assert!(0x2::table::borrow<vector<u8>, ModelRecord>(&arg0.models, arg1).active, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::model_deactivated());
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::tx_context::sender(arg8);
        assert!(!0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::is_tee_attestation_expired(&arg5, v0), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::tee_attestation_expired());
        let v2 = v0 + 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::default_challenge_period();
        let v3 = ComputationClaim{
            id                 : 0x2::object::new(arg8),
            model_id           : arg1,
            input_hash         : arg2,
            output_hash        : arg3,
            inference_config   : arg4,
            tee_attestation    : 0x1::option::some<0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::TeeAttestation>(arg5),
            zk_proof           : 0x1::option::none<0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::ZkProof>(),
            provider           : v1,
            commitment_id      : 0x1::option::none<0x2::object::ID>(),
            timestamp          : v0,
            gas_used           : arg6,
            status             : 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::claim_status_challenge_period(),
            challenge_deadline : v2,
        };
        let v4 = 0x2::object::id<ComputationClaim>(&v3);
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_computation_claimed(v4, 0x1::option::none<0x2::object::ID>(), v1, arg1, arg2, arg3, arg6, v0);
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_claim_challenge_period_started(v4, v2, v0);
        v3
    }

    public fun submit_claim_with_zk(arg0: &ModelRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::InferenceConfig, arg5: 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::ZkProof, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : ComputationClaim {
        assert!(0x2::table::contains<vector<u8>, ModelRecord>(&arg0.models, arg1), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::model_not_found());
        assert!(0x2::table::borrow<vector<u8>, ModelRecord>(&arg0.models, arg1).active, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::model_deactivated());
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = ComputationClaim{
            id                 : 0x2::object::new(arg8),
            model_id           : arg1,
            input_hash         : arg2,
            output_hash        : arg3,
            inference_config   : arg4,
            tee_attestation    : 0x1::option::none<0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::TeeAttestation>(),
            zk_proof           : 0x1::option::some<0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::ZkProof>(arg5),
            provider           : v1,
            commitment_id      : 0x1::option::none<0x2::object::ID>(),
            timestamp          : v0,
            gas_used           : arg6,
            status             : 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::claim_status_verified(),
            challenge_deadline : 0,
        };
        let v3 = 0x2::object::id<ComputationClaim>(&v2);
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_computation_claimed(v3, 0x1::option::none<0x2::object::ID>(), v1, arg1, arg2, arg3, arg6, v0);
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_claim_verified(v3, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::types::verification_method_zk(), v0);
        v2
    }

    public fun total_models(arg0: &ModelRegistry) : u64 {
        arg0.total_models
    }

    public fun verify_provider_for_model(arg0: &mut ModelRegistry, arg1: &CrucibleAdminCap, arg2: vector<u8>, arg3: address, arg4: u8, arg5: &0x2::clock::Clock) {
        assert!(0x2::table::contains<vector<u8>, ModelRecord>(&arg0.models, arg2), 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::model_not_found());
        let v0 = 0x2::table::borrow_mut<vector<u8>, ModelRecord>(&mut arg0.models, arg2);
        assert!(v0.active, 0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::errors::model_deactivated());
        if (!0x1::vector::contains<address>(&v0.verified_providers, &arg3)) {
            0x1::vector::push_back<address>(&mut v0.verified_providers, arg3);
        };
        0xff6578686d5d743450fb7dc9c2014e4abdc6d60ef66c40d058426af97ecfa781::events::emit_provider_verified(arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    // decompiled from Move bytecode v6
}

