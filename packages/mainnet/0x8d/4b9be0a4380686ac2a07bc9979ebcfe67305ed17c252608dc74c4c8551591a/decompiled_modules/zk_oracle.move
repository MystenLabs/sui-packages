module 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::zk_oracle {
    struct ZkRiskOracle has key {
        id: 0x2::object::UID,
        vk_gamma_abc_g1_bytes: vector<u8>,
        alpha_g1_beta_g2_bytes: vector<u8>,
        gamma_g2_neg_pc_bytes: vector<u8>,
        delta_g2_neg_pc_bytes: vector<u8>,
        circuit_hash: vector<u8>,
        latest_score: u64,
        latest_proof_hash: vector<u8>,
        verification_count: u64,
        last_updated_ms: u64,
    }

    struct ProofVerified has copy, drop {
        oracle_id: address,
        composite_score: u64,
        proof_hash: vector<u8>,
        circuit_hash: vector<u8>,
        timestamp_ms: u64,
    }

    public fun create_oracle(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ZkRiskOracle{
            id                     : 0x2::object::new(arg6),
            vk_gamma_abc_g1_bytes  : arg1,
            alpha_g1_beta_g2_bytes : arg2,
            gamma_g2_neg_pc_bytes  : arg3,
            delta_g2_neg_pc_bytes  : arg4,
            circuit_hash           : arg5,
            latest_score           : 0,
            latest_proof_hash      : 0x1::vector::empty<u8>(),
            verification_count     : 0,
            last_updated_ms        : 0,
        };
        0x2::transfer::share_object<ZkRiskOracle>(v0);
    }

    public fun get_circuit_hash(arg0: &ZkRiskOracle) : vector<u8> {
        arg0.circuit_hash
    }

    public fun get_latest_score(arg0: &ZkRiskOracle) : u64 {
        arg0.latest_score
    }

    public fun get_verification_count(arg0: &ZkRiskOracle) : u64 {
        arg0.verification_count
    }

    public fun submit_proof(arg0: &mut ZkRiskOracle, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(arg1 <= 500, 1);
        let v0 = 0x2::groth16::bn254();
        let v1 = 0x2::groth16::pvk_from_bytes(arg0.vk_gamma_abc_g1_bytes, arg0.alpha_g1_beta_g2_bytes, arg0.gamma_g2_neg_pc_bytes, arg0.delta_g2_neg_pc_bytes);
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        let v3 = 0x2::groth16::proof_points_from_bytes(arg3);
        assert!(0x2::groth16::verify_groth16_proof(&v0, &v1, &v2, &v3), 0);
        let v4 = 0x2::hash::blake2b256(&arg3);
        arg0.latest_score = arg1;
        arg0.latest_proof_hash = v4;
        arg0.verification_count = arg0.verification_count + 1;
        arg0.last_updated_ms = 0x2::clock::timestamp_ms(arg4);
        let v5 = ProofVerified{
            oracle_id       : 0x2::object::uid_to_address(&arg0.id),
            composite_score : arg1,
            proof_hash      : v4,
            circuit_hash    : arg0.circuit_hash,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ProofVerified>(v5);
    }

    // decompiled from Move bytecode v7
}

