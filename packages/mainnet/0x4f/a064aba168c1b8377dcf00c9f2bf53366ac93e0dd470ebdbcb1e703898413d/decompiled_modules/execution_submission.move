module 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution_submission {
    fun assert_active_walk_submission(arg0: &0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg1: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg2: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, arg3: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg4: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::LeaderTarget) {
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::created_from(arg2) == 0x2::object::id<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>(arg0), 13906837163641667601);
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::stamps(arg2);
        assert!(0x2::vec_map::length<0x2::object::ID, vector<u8>>(v0) >= 2, 13906837172230684675);
        let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u8>>(v0, 1);
        assert!(*v1 == 0x2::object::id<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry>(arg1), 13906837180820619267);
        let v3 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::leader_stamp_data(0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>>(arg3), arg4);
        assert!(*v2 == 0x1::bcs::to_bytes<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::LeaderStampData>(&v3), 13906837198001537043);
    }

    fun assert_base_stamps(arg0: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, arg1: &0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg2: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg3: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg4: 0x2::object::ID, arg5: 0x1::option::Option<0x2::object::ID>) {
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::stamps(arg0);
        let v1 = if (0x1::option::is_some<0x2::object::ID>(&arg5)) {
            3
        } else {
            2
        };
        assert!(0x2::vec_map::length<0x2::object::ID, vector<u8>>(v0) == v1, 13906837060561666053);
        let (v2, _) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u8>>(v0, 0);
        assert!(*v2 == 0x2::object::id<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>(arg1), 13906837069151469571);
        let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, vector<u8>>(v0, 1);
        assert!(*v4 == 0x2::object::id<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry>(arg2), 13906837077741404163);
        let v6 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::leader_stamp_data(0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>>(arg3), 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::leader_target_offchain(arg4, arg5));
        assert!(*v5 == 0x1::bcs::to_bytes<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::LeaderStampData>(&v6), 13906837116395978753);
    }

    public(friend) fun authenticate_walk_submission(arg0: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_network_matches_leader_cap(arg0, arg2);
        let (v0, v1, v2) = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::active_walk_submission_context(arg0, arg3);
        if (0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::secondary_leader_is_allowed(arg0, arg3, arg2, arg4)) {
            if (0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::walk_is_active(arg0, arg3)) {
                let v3 = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::walk_request_authority_primary_cap_id(arg0, arg3);
                0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::mark_walk_request_authority_secondary_window(arg0, arg3);
                0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::record_leader_submission_takeover(arg1, arg0, arg3, v0, 0x2::object::id_to_address(&v3), 0x2::tx_context::sender(arg5));
            };
            return
        };
        assert!(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::walk_is_active(arg0, arg3), 13906836815749447699);
        assert!(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::walk_request_authority_is_primary_window(arg0, arg3), 13906836828634349587);
        assert!(0x2::clock::timestamp_ms(arg4) < v2 + v1, 13906836837224415253);
        assert!(0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>>(arg2) == 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::walk_request_authority_primary_cap_id(arg0, arg3), 13906836850109186067);
    }

    fun authorization_context_for_vertex(arg0: &0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorizationContext {
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::agent_vertex_authorization_context(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::execution_agent_id(arg0), 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::execution_skill_id(arg0), 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::interface_version(arg0), 0x2::object::id<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>(arg0), 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_into_string(arg1), 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::task_id(arg0))
    }

    public fun commit_off_chain_tool_result_for_walk<T0>(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimePermit<T0>, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::ToolRegistry, arg4: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::NetworkAuth, arg5: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, arg6: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorizationStamp, arg7: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::VerificationVerdict, arg8: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg9: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg10: u64, arg11: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg12: &mut 0x2::tx_context::TxContext) {
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_is_for(arg2, arg1);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_network_matches_leader_cap(arg2, arg8);
        assert!(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::is_vertex_offchain_tool(arg1, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&arg11)), 13906834590955864075);
        let (v0, _, _) = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::active_walk_submission_context(arg2, arg10);
        assert!(v0 == arg11, 13906834603840503815);
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::created_from(&arg5) == 0x2::object::id<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>(arg2), 13906834608136126481);
        let v3 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&arg11);
        let v4 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_tool_id(arg1, v3);
        let v5 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_tool_fqn(arg1, v3);
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::contains_tool(arg3, v5) && 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::tool_id(arg3, v5) == v4, 13906834646791225367);
        0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::assert_registered_vertex(arg3, arg1, v3);
        let v6 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_verifier_mode(arg1, v3);
        assert_base_stamps(&arg5, arg2, arg9, arg8, v4, verifier_witness_for_mode(arg3, arg4, v4, v6));
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution_verification::validate_verdict(arg3, arg4, &arg5, v4, v6, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::worksheet_input_commitment(&arg5, &arg6), 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::tool_invocation_nonce(0x2::object::id<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>(arg2), arg10, 0x1::ascii::into_bytes(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_into_string(v3)), 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::runtime_vertex_iteration_or_zero(&arg11)), &arg7);
        let v7 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::verdict_decision(&arg7);
        let (v8, _, v10) = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::consume_verdict(arg7);
        let v11 = v10;
        let v12 = v8;
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::consume_workflow_worksheet(arg2, arg5);
        let (v13, v14) = if (0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::decision_is_accept(&v11)) {
            let v15 = if (0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::conforms_raw_output(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_meta_schema(arg1, v3), &v12)) {
                v12
            } else {
                0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::canonical_schema_mismatch_failure()
            };
            0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::tagged_output_to_dag_types(v15)
        } else {
            let v16 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::decision_reason(v11);
            let v17 = if (0x1::option::is_some<vector<u8>>(&v16)) {
                0x1::option::destroy_some<vector<u8>>(v16)
            } else {
                b"Tool verification failed"
            };
            (0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::output_variant_from_string(0x1::ascii::string(b"_err_eval")), err_eval_ports(v17))
        };
        let v18 = v14;
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::assert_output_objects_allowed(arg9, &v18);
        let v19 = if (!0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::decision_is_accept(&v7) || 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::output_variant_into_string(v13) == 0x1::ascii::string(b"_err_eval")) {
            0x1::option::some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::FailureEvidenceKind>(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::failure_evidence_kind_tool_evidence())
        } else {
            0x1::option::none<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::FailureEvidenceKind>()
        };
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::commit_off_chain_tool_eval_for_walk_state(arg1, arg2, arg8, arg10, arg11, v13, v18, v19, arg12);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution_events::emit_tool_verification_resolved(0x2::object::id<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG>(arg1), 0x2::object::id<0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution>(arg2), arg10, arg11, 0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>>(arg8), v4, v6, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::verdict_witness_id(&arg7), v7);
    }

    public fun consume_on_chain_tool_result_for_walk<T0>(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimePermit<T0>, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::ToolRegistry, arg4: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::OnchainToolResult, arg5: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg6: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg7: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::priority_fee_vault::PriorityFeeVault, arg8: u64, arg9: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg10: 0x2::object::ID, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::assert_current_leader_cap(arg6, arg5);
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::assert_transaction_budget(arg6, arg11);
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::assert_transaction_budget(arg6, arg12);
        authenticate_walk_submission(arg2, arg1, arg5, arg8, arg13, arg14);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::submit_committed_tool_result_gas_charge_for_walk_state(arg2, arg8, 0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>>(arg5), 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::consume_onchain_tool_result_for_walk_state(arg1, arg2, arg3, arg6, 0x1::option::some<0x2::object::ID>(0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>>(arg5)), arg8, arg9, arg4, arg10, arg11, arg14), arg11, arg12);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::settle_committed_tool_eval_for_walk_state(arg1, arg2, arg3, arg6, arg7, arg8, arg13, arg14);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::clear_payment_insufficient_settlement_if_resolved(arg2, arg6);
    }

    public fun create_on_chain_tool_result_for_walk<T0>(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimePermit<T0>, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::ToolRegistry, arg4: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, arg5: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorizationStamp, arg6: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg7: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg8: u64, arg9: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg10: &mut 0x2::tx_context::TxContext) : (0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::UIDRequirements, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::onchain_tool_result::OnchainToolResult) {
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_is_for(arg2, arg1);
        let v0 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&arg9);
        assert!(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::is_vertex_onchain_tool(arg1, v0), 13906836046949646345);
        let (v1, _, _) = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::active_walk_submission_context(arg2, arg8);
        assert!(v1 == arg9, 13906836055539449863);
        let v4 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_tool_fqn(arg1, v0);
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::contains_tool(arg3, v4) && 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::tool_id(arg3, v4) == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_tool_id(arg1, v0), 13906836077015334935);
        let v5 = 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::on_chain_tool_witness_id(arg3, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_tool_fqn(arg1, v0));
        assert_active_walk_submission(arg2, arg7, &arg4, arg6, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::leader_target_onchain(v5));
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::create_onchain_tool_result_for_walk_state(arg2, arg8, arg4, arg5, 0x2::object::id<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>>(arg6), v5, arg10)
    }

    fun err_eval_ports(arg0: vector<u8>) : 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData> {
        let v0 = 0x2::vec_map::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>();
        0x2::vec_map::insert<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&mut v0, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::output_port_from_string(0x1::ascii::string(b"reason")), 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::one(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::inline_data_value(arg0)));
        v0
    }

    public fun prepare_tool_result_submission_worksheet<T0>(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimePermit<T0>, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::agent_registry::AgentRegistry, arg3: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::ToolRegistry, arg4: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::NetworkAuth, arg5: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader::LeaderRegistry, arg6: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg7: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorizationStamp) {
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_is_for(arg6, arg1);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_network_matches_leader_cap(arg6, arg7);
        authenticate_walk_submission(arg6, arg1, arg7, arg8, arg9, arg10);
        let (v0, _, _) = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::active_walk_submission_context(arg6, arg8);
        let v3 = v0;
        let v4 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&v3);
        0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::agent_registry::skill_requirements_for_skill(arg2, 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::execution_agent_id(arg6), 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::execution_skill_id(arg6));
        let v5 = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::new_workflow_worksheet(arg6);
        let v6 = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::effective_input_payload_sha256(arg1, arg6, v3);
        assert!(0x1::vector::length<u8>(&v6) == 32, 13906835299624812545);
        let v7 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::agent_vertex_authorization_stamp(authorization_context_for_vertex(arg6, v4), v6);
        let v8 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_tool_id(arg1, v4);
        let v9 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_tool_fqn(arg1, v4);
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::contains_tool(arg3, v9) && 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::tool_id(arg3, v9) == v8, 13906835346870894615);
        let v10 = if (0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::is_vertex_onchain_tool(arg1, v4)) {
            0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::leader_target_onchain(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::on_chain_tool_witness_id(arg3, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_tool_fqn(arg1, v4)))
        } else {
            0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::leader_target_offchain(v8, verifier_witness_for_mode(arg3, arg4, v8, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::dag_vertex_verifier_mode(arg1, v4)))
        };
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::stamp_workflow_worksheet(arg6, &mut v5, 0x1::bcs::to_bytes<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorizationStamp>(&v7));
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::stamp_leader_submission_worksheet<T0>(arg0, arg5, arg7, v10, &mut v5);
        (v5, v7)
    }

    public fun release_vertex_authorization_for_onchain_walk<T0>(arg0: &0xf868841f7dcd45f79d1eaf0a57206a1aaa5a8ed0f225103797b33218f02490f5::runtime_authority::RuntimePermit<T0>, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG, arg2: &mut 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::DAGExecution, arg3: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, arg4: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorizationStamp, arg5: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::leader_cap::OverNetwork>, arg6: u64) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::ProvenValue<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorization> {
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_is_for(arg2, arg1);
        0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::assert_execution_network_matches_leader_cap(arg2, arg5);
        let (v0, _, _) = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::active_walk_submission_context(arg2, arg6);
        let v3 = v0;
        assert!(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::is_vertex_onchain_tool(arg1, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&v3)), 13906835750596902921);
        assert!(0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::has_vertex_authorization_grant(arg2, v3), 13906835763482066957);
        let v4 = 0x4fa064aba168c1b8377dcf00c9f2bf53366ac93e0dd470ebdbcb1e703898413d::execution::release_vertex_authorization_grant_unchecked(arg2, v3);
        let v5 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::grant_value<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorization>(&v4);
        assert!(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::agent_vertex_authorization_dag_id(&v5) == 0x2::object::id<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag::DAG>(arg1), 13906835789252001807);
        assert!(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::agent_vertex_authorization_vertex(&v5) == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_into_string(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&v3)), 13906835810726313991);
        assert!(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::authorization_matches_worksheet(&v5, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::grant_by<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorization>(&v4), arg3, arg4), 13906835849381675025);
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::grant_into_proven_value<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization::AgentVertexAuthorization>(v4)
    }

    fun verifier_witness_for_mode(arg0: &0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::ToolRegistry, arg1: &0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::NetworkAuth, arg2: 0x2::object::ID, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::ToolVerifierMode) : 0x1::option::Option<0x2::object::ID> {
        if (arg3 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::verifier_mode_none()) {
            return 0x1::option::none<0x2::object::ID>()
        };
        assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::supports_verifier_mode(arg0, arg2, arg3), 13906836914534088729);
        if (arg3 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::verifier_mode_registered_key()) {
            0x1::option::some<0x2::object::ID>(0xf01174d560a525a8b0635b5713ba334e26d7cd6f221701e785c28e46febf6fd4::network_auth::registered_key_witness(arg1))
        } else {
            assert!(arg3 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::verifier_mode_external(), 13906836931713957913);
            assert!(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::has_external_verifier(arg0, arg2), 13906836936008925209);
            0x1::option::some<0x2::object::ID>(0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::tool_registry::external_verifier_witness(arg0, arg2))
        }
    }

    // decompiled from Move bytecode v7
}

