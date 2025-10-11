module 0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verifier_secure {
    struct VerifiedEvent has copy, drop {
        is_verified: bool,
        circuit_hash: vector<u8>,
    }

    struct VerifyingKeyEvent has copy, drop {
        delta_bytes: vector<u8>,
        gamma_bytes: vector<u8>,
        alpha_bytes: vector<u8>,
        vk_bytes: vector<u8>,
    }

    public entry fun create_verification_key_manager(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::VerificationKeyManager>(0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::create_key_manager(arg0), 0x2::tx_context::sender(arg0));
    }

    public fun get_verification_key_components(arg0: &0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::VerificationKeyManager, arg1: vector<u8>) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::get_keys_for_circuit(arg0, &arg1)
    }

    public entry fun setup_circuit_keys(arg0: &mut 0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::VerificationKeyManager, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        assert!(0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::get_admin(arg0) == 0x2::tx_context::sender(arg6), 1008);
        0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::update_verification_key(arg0, 0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::key_type_vk(), b"main_vk", arg2, arg1, arg6);
        0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::update_verification_key(arg0, 0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::key_type_alpha(), b"main_alpha", arg3, arg1, arg6);
        0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::update_verification_key(arg0, 0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::key_type_gamma(), b"main_gamma", arg4, arg1, arg6);
        0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::update_verification_key(arg0, 0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::key_type_delta(), b"main_delta", arg5, arg1, arg6);
        let v0 = VerifyingKeyEvent{
            delta_bytes : arg5,
            gamma_bytes : arg4,
            alpha_bytes : arg3,
            vk_bytes    : arg2,
        };
        0x2::event::emit<VerifyingKeyEvent>(v0);
    }

    public fun validate_verification_key(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        v0 >= 64 && v0 <= 500
    }

    public fun verify_proof_legacy(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = 0x2::groth16::bn254();
        let v1 = 0x2::groth16::prepare_verifying_key(&v0, &arg0);
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(arg1);
        let v3 = 0x2::groth16::proof_points_from_bytes(arg2);
        let v4 = 0x2::groth16::bn254();
        let v5 = 0x2::groth16::verify_groth16_proof(&v4, &v1, &v2, &v3);
        let v6 = VerifiedEvent{
            is_verified  : v5,
            circuit_hash : 0x1::vector::empty<u8>(),
        };
        0x2::event::emit<VerifiedEvent>(v6);
        v5
    }

    public fun verify_proof_secure(arg0: &0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::VerificationKeyManager, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let (v0, _, _, _) = 0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verification_key_manager::get_keys_for_circuit(arg0, &arg1);
        let v4 = v0;
        assert!(!0x1::vector::is_empty<u8>(&v4), 1007);
        let v5 = 0x2::groth16::bn254();
        let v6 = 0x2::groth16::prepare_verifying_key(&v5, &v4);
        let v7 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        let v8 = 0x2::groth16::proof_points_from_bytes(arg3);
        let v9 = 0x2::groth16::bn254();
        let v10 = 0x2::groth16::verify_groth16_proof(&v9, &v6, &v7, &v8);
        let v11 = VerifiedEvent{
            is_verified  : v10,
            circuit_hash : arg1,
        };
        0x2::event::emit<VerifiedEvent>(v11);
        v10
    }

    // decompiled from Move bytecode v6
}

