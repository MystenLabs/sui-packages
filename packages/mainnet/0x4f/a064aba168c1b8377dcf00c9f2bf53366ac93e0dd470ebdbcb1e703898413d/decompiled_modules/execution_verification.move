module 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution_verification {
    public(friend) fun validate_verdict(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::ToolRegistry, arg1: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::NetworkAuth, arg2: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, arg3: 0x2::object::ID, arg4: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::ToolVerifierMode, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::VerificationVerdict) {
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::contains_tool_id(arg0, arg3), 13906834350437040129);
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::stamps(arg2);
        let v1 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::verdict_witness_id(arg7);
        if (arg4 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::verifier_mode_none()) {
            assert!(0x2::vec_map::length<0x2::object::ID, vector<u8>>(v0) == 2, 13906834371912400905);
            assert!(0x1::option::is_none<0x2::object::ID>(&v1), 13906834376207106053);
            return
        };
        let v2 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::verifier_support(arg0, arg3);
        assert!(0x1::option::is_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::ToolVerifierSupport>(&v2), 13906834397681811459);
        let v3 = 0x1::option::destroy_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::ToolVerifierSupport>(v2);
        assert!(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::support_matches_mode(&v3, arg4), 13906834406271746051);
        assert!(0x2::vec_map::length<0x2::object::ID, vector<u8>>(v0) == 3, 13906834410567106569);
        if (arg4 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::verifier_mode_registered_key()) {
            let v4 = 0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::registered_key_witness(arg1);
            assert!(v1 == 0x1::option::some<0x2::object::ID>(v4), 13906834432041680901);
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u8>>(v0, 2);
            assert!(*v5 == v4, 13906834440631615493);
            let v7 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::registered_key_stamp_data(arg5, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::verdict_output_hash(arg7), arg6);
            assert!(*v6 == 0x1::bcs::to_bytes<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::RegisteredKeyStampData>(&v7), 13906834483581419527);
            return
        };
        assert!(arg4 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::verifier_mode_external(), 13906834505055993859);
        let v8 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::support_method(&v3);
        assert!(0x1::option::is_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::VerifierMethodId>(&v8), 13906834513645928451);
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::has_external_verifier(arg0, arg3), 13906834517940895747);
        assert!(0x1::option::destroy_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::VerifierMethodId>(v8) == 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::external_verifier_method(arg0, arg3), 13906834530825797635);
        let v9 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::external_verifier_witness(arg0, arg3);
        assert!(v1 == 0x1::option::some<0x2::object::ID>(v9), 13906834543710830597);
        let (v10, v11) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u8>>(v0, 2);
        assert!(*v10 == v9, 13906834556595732485);
        let v12 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::external_stamp_data(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::verdict_output_hash(arg7));
        assert!(*v11 == 0x1::bcs::to_bytes<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::ExternalVerifierStampData>(&v12), 13906834569480765447);
    }

    // decompiled from Move bytecode v7
}

