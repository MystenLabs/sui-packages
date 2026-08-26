module 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::registered_key_verifier {
    fun assert_binding(arg0: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::NetworkAuth, arg1: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::KeyBinding, arg2: 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::IdentityKey) {
        assert!(0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::key_binding_identity(arg1) == arg2, 13906834668264751107);
        let v0 = 0x2::object::id<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::KeyBinding>(arg1);
        assert!(0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::binding_address(arg0, arg2) == 0x2::object::id_to_address(&v0), 13906834681149652995);
    }

    public fun configure_tool(arg0: &mut 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::ToolRegistry, arg1: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::Tool, arg2: &mut 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_authority::OverTool>, arg3: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::NetworkAuth, arg4: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::KeyBinding) {
        assert_binding(arg3, arg4, 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::identity_key_tool(0x2::object::id<0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::Tool>(arg1)));
        assert!(0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::active_key_is_usable(arg4), 13906834328962465797);
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::configure_registered_key_support(arg0, arg1, arg2);
    }

    public fun verify(arg0: &mut 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, arg1: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::tagged_output::TaggedOutput, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::RegisteredKeyAuxiliary, arg3: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg4: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg5: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::NetworkAuth, arg6: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::KeyBinding, arg7: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::KeyBinding, arg8: 0x2::object::ID) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::VerificationVerdict {
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::stamps(arg0);
        assert!(0x2::vec_map::length<0x2::object::ID, vector<u8>>(v0) == 2, 13906834406271614977);
        let (v1, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u8>>(v0, 0);
        let (v3, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u8>>(v0, 1);
        assert!(*v1 == 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::created_from(arg0), 13906834427746451457);
        assert!(*v3 == 0x2::object::id<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry>(arg3), 13906834432041418753);
        let (v5, v6) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u8>>(v0, 1);
        assert!(*v5 == 0x2::object::id<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry>(arg3), 13906834440631353345);
        let v7 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::leader_stamp_data(0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>>(arg4), 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::leader_target_offchain(arg8, 0x1::option::some<0x2::object::ID>(0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::registered_key_witness(arg5))));
        assert!(*v6 == 0x1::bcs::to_bytes<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::LeaderStampData>(&v7), 13906834492170960897);
        assert_binding(arg5, arg6, 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::identity_key_leader(0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>>(arg4)));
        assert_binding(arg5, arg7, 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::identity_key_tool(arg8));
        let v8 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::auxiliary_input_hash(&arg2);
        let v9 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::auxiliary_nonce(&arg2);
        let v10 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::auxiliary_leader_signature(&arg2);
        let v11 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::registered_key_tool_signature_message(v10, v9, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::output_sha256(&arg1));
        let v12 = if (0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::verify_active_key_signature(arg6, &v10, &v8)) {
            let v13 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::auxiliary_tool_signature(&arg2);
            0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::verify_active_key_signature(arg7, &v13, &v11)
        } else {
            false
        };
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::new_registered_key_verdict(arg0, arg1, v8, v9, 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::registered_key_witness_uid(arg5), v12)
    }

    // decompiled from Move bytecode v7
}

