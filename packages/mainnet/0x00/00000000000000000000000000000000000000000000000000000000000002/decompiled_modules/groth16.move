module 0x2::groth16 {
    struct Curve has copy, drop, store {
        id: u8,
    }

    struct PreparedVerifyingKey has copy, drop, store {
        vk_gamma_abc_g1_bytes: vector<u8>,
        alpha_g1_beta_g2_bytes: vector<u8>,
        gamma_g2_neg_pc_bytes: vector<u8>,
        delta_g2_neg_pc_bytes: vector<u8>,
    }

    struct PublicProofInputs has copy, drop, store {
        bytes: vector<u8>,
    }

    struct ProofPoints has copy, drop, store {
        bytes: vector<u8>,
    }

    public fun bls12381() : Curve {
        Curve{id: 0}
    }

    public fun bn254() : Curve {
        Curve{id: 1}
    }

    public fun prepare_verifying_key(arg0: &Curve, arg1: &vector<u8>) : PreparedVerifyingKey {
        prepare_verifying_key_internal(arg0.id, arg1)
    }

    native fun prepare_verifying_key_internal(arg0: u8, arg1: &vector<u8>) : PreparedVerifyingKey;
    public fun proof_points_from_bytes(arg0: vector<u8>) : ProofPoints {
        ProofPoints{bytes: arg0}
    }

    public fun public_proof_inputs_from_bytes(arg0: vector<u8>) : PublicProofInputs {
        assert!(0x1::vector::length<u8>(&arg0) % 32 == 0, 3);
        assert!(0x1::vector::length<u8>(&arg0) / 32 <= 8, 2);
        PublicProofInputs{bytes: arg0}
    }

    public fun pvk_from_bytes(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : PreparedVerifyingKey {
        PreparedVerifyingKey{
            vk_gamma_abc_g1_bytes  : arg0,
            alpha_g1_beta_g2_bytes : arg1,
            gamma_g2_neg_pc_bytes  : arg2,
            delta_g2_neg_pc_bytes  : arg3,
        }
    }

    public fun pvk_to_bytes(arg0: PreparedVerifyingKey) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, arg0.vk_gamma_abc_g1_bytes);
        0x1::vector::push_back<vector<u8>>(v1, arg0.alpha_g1_beta_g2_bytes);
        0x1::vector::push_back<vector<u8>>(v1, arg0.gamma_g2_neg_pc_bytes);
        0x1::vector::push_back<vector<u8>>(v1, arg0.delta_g2_neg_pc_bytes);
        v0
    }

    public fun verify_groth16_proof(arg0: &Curve, arg1: &PreparedVerifyingKey, arg2: &PublicProofInputs, arg3: &ProofPoints) : bool {
        verify_groth16_proof_internal(arg0.id, &arg1.vk_gamma_abc_g1_bytes, &arg1.alpha_g1_beta_g2_bytes, &arg1.gamma_g2_neg_pc_bytes, &arg1.delta_g2_neg_pc_bytes, &arg2.bytes, &arg3.bytes)
    }

    native fun verify_groth16_proof_internal(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>, arg5: &vector<u8>, arg6: &vector<u8>) : bool;
    // decompiled from Move bytecode v6
}

