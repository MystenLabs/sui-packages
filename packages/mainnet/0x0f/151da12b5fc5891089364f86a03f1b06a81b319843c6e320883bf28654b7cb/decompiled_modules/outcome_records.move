module 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::outcome_records {
    struct HandOutcomeRecord has key {
        id: 0x2::object::UID,
        schema_version: u16,
        tunnel_id: 0x2::object::ID,
        execution_id: vector<u8>,
        protocol_id: vector<u8>,
        protocol_version: u16,
        event_contract_version: u16,
        participant_set_digest: vector<u8>,
        origin_tag: u8,
        actor_seat: u16,
        authority_role: vector<u8>,
        previous_nonce: u64,
        previous_state_commitment: vector<u8>,
        resulting_nonce: u64,
        resulting_state_commitment: vector<u8>,
        receipt_digest: vector<u8>,
        outcome_schema_version: u16,
        outcome: vector<u8>,
    }

    struct ActionOutcomeRecord has key {
        id: 0x2::object::UID,
        schema_version: u16,
        tunnel_id: 0x2::object::ID,
        execution_id: vector<u8>,
        protocol_id: vector<u8>,
        protocol_version: u16,
        event_contract_version: u16,
        participant_set_digest: vector<u8>,
        origin_tag: u8,
        actor_seat: u16,
        authority_role: vector<u8>,
        previous_nonce: u64,
        previous_state_commitment: vector<u8>,
        resulting_nonce: u64,
        resulting_state_commitment: vector<u8>,
        receipt_digest: vector<u8>,
        outcome_schema_version: u16,
        outcome: vector<u8>,
    }

    struct HandRecordKey has copy, drop, store {
        receipt_digest: vector<u8>,
    }

    struct ActionRecordKey has copy, drop, store {
        receipt_digest: vector<u8>,
    }

    struct HandOutcomeRecordPublished has copy, drop {
        tunnel_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        receipt_digest: vector<u8>,
        event_contract_version: u16,
    }

    struct ActionOutcomeRecordPublished has copy, drop {
        tunnel_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        receipt_digest: vector<u8>,
        event_contract_version: u16,
    }

    public fun action_record_actor_seat(arg0: &ActionOutcomeRecord) : u16 {
        arg0.actor_seat
    }

    public fun action_record_authority_role(arg0: &ActionOutcomeRecord) : vector<u8> {
        arg0.authority_role
    }

    public fun action_record_event_contract_version(arg0: &ActionOutcomeRecord) : u16 {
        arg0.event_contract_version
    }

    public fun action_record_execution_id(arg0: &ActionOutcomeRecord) : vector<u8> {
        arg0.execution_id
    }

    public fun action_record_origin_tag(arg0: &ActionOutcomeRecord) : u8 {
        arg0.origin_tag
    }

    public fun action_record_outcome(arg0: &ActionOutcomeRecord) : vector<u8> {
        arg0.outcome
    }

    public fun action_record_outcome_schema_version(arg0: &ActionOutcomeRecord) : u16 {
        arg0.outcome_schema_version
    }

    public fun action_record_participant_set_digest(arg0: &ActionOutcomeRecord) : vector<u8> {
        arg0.participant_set_digest
    }

    public fun action_record_previous_nonce(arg0: &ActionOutcomeRecord) : u64 {
        arg0.previous_nonce
    }

    public fun action_record_previous_state_commitment(arg0: &ActionOutcomeRecord) : vector<u8> {
        arg0.previous_state_commitment
    }

    public fun action_record_protocol_id(arg0: &ActionOutcomeRecord) : vector<u8> {
        arg0.protocol_id
    }

    public fun action_record_protocol_version(arg0: &ActionOutcomeRecord) : u16 {
        arg0.protocol_version
    }

    public fun action_record_receipt_digest(arg0: &ActionOutcomeRecord) : vector<u8> {
        arg0.receipt_digest
    }

    public fun action_record_resulting_nonce(arg0: &ActionOutcomeRecord) : u64 {
        arg0.resulting_nonce
    }

    public fun action_record_resulting_state_commitment(arg0: &ActionOutcomeRecord) : vector<u8> {
        arg0.resulting_state_commitment
    }

    public fun action_record_schema_version(arg0: &ActionOutcomeRecord) : u16 {
        arg0.schema_version
    }

    public fun action_record_tunnel_id(arg0: &ActionOutcomeRecord) : 0x2::object::ID {
        arg0.tunnel_id
    }

    public fun apply_non_outcome_receipt<T0>(arg0: &mut 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>, arg1: u8, arg2: u16, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: u16, arg9: vector<u8>, arg10: 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::TimeEvidence, arg11: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>, arg12: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::ArtifactCommitmentWire>, arg13: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::AuthorizationProof>) {
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::status<T0>(arg0) == 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::live_status(), 13906835776366968845);
        assert!(arg1 == 1 || arg1 == 2, 13906835789252001807);
        assert_canonical_origin_fields(arg1, arg2, &arg3);
        validate_receipt_shape(arg4, &arg5, arg6, &arg7, arg8, &arg9);
        assert!(!0x1::vector::is_empty<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(&arg11), 13906835836498214951);
        assert_authorization_policy<T0>(arg0, arg1, &arg11);
        validate_principal_proof_shape(&arg11, &arg13);
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::assert_outcome_record_predecessor<T0>(arg0, arg4, &arg5);
        verify_origin_declared<T0>(arg0, arg1, arg2, &arg3, &arg11);
        let v0 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::execution_id<T0>(arg0);
        let v1 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::protocol_id<T0>(arg0);
        let v2 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::encode_candidate_transition(1, &v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::protocol_version<T0>(arg0), &v1, arg4, &arg5, arg6, &arg7, arg1, arg2, &arg3, &arg11, &arg12);
        let v3 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::execution_id<T0>(arg0);
        verify_time_evidence<T0>(arg0, &arg10, &v3, arg4, &arg5);
        let v4 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::encode_authorization_payload(&v2, arg8, &arg9, &arg10);
        verify_proofs<T0>(arg0, &v4, &arg13);
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::advance_outcome_record_state<T0>(arg0, arg6, arg7);
    }

    fun assert_authorization_policy<T0>(arg0: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>, arg1: u8, arg2: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>) {
        if (arg1 == 2) {
            return
        };
        let v0 = if (arg1 == 1) {
            0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::hand_authorization<T0>(arg0)
        } else {
            0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::action_authorization<T0>(arg0)
        };
        if (0x1::vector::is_empty<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(v0)) {
            return
        };
        assert!(principal_vectors_equal(v0, arg2), 13906836579527688233);
    }

    fun assert_canonical_origin_fields(arg0: u8, arg1: u16, arg2: &vector<u8>) {
        if (arg0 == 1) {
            assert!(arg1 == 0, 13906836463563702315);
        } else {
            assert!(0x1::vector::is_empty<u8>(arg2), 13906836472153636907);
        };
    }

    fun bound_key<T0>(arg0: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>, arg1: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal) : (u8, vector<u8>) {
        if (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_tag(arg1) == 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::seat_principal_tag()) {
            let v2 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_seat(arg1);
            (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::find_seat_signature_type<T0>(arg0, v2), 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::find_seat_public_key<T0>(arg0, v2))
        } else {
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_tag(arg1) == 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::role_principal_tag(), 13906838031227289651);
            let v3 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_role(arg1);
            (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::find_role_signature_type<T0>(arg0, &v3), 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::find_role_public_key<T0>(arg0, &v3))
        }
    }

    fun build_receipt_digest<T0>(arg0: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>, arg1: u8, arg2: u16, arg3: u16, arg4: u8, arg5: u16, arg6: vector<u8>, arg7: u64, arg8: vector<u8>, arg9: u64, arg10: vector<u8>, arg11: u16, arg12: vector<u8>, arg13: 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::TimeEvidence, arg14: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>, arg15: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::ArtifactCommitmentWire>, arg16: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::AuthorizationProof>, arg17: u16, arg18: &vector<u8>) : vector<u8> {
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::status<T0>(arg0) == 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::live_status(), 13906836132849254413);
        assert!(arg4 == 0 || arg4 == 1, 13906836145734287375);
        assert!(arg4 == arg1, 13906836154324353041);
        assert_canonical_origin_fields(arg4, arg5, &arg6);
        assert!(arg3 == 1, 13906836162914418707);
        validate_receipt_shape(arg7, &arg8, arg9, &arg10, arg11, &arg12);
        assert!(!0x1::vector::is_empty<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(&arg14), 13906836201570435111);
        assert_authorization_policy<T0>(arg0, arg4, &arg14);
        validate_principal_proof_shape(&arg14, &arg16);
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::assert_outcome_record_predecessor<T0>(arg0, arg7, &arg8);
        validate_outcome(arg17, arg18);
        verify_outcome_authenticated(&arg15, arg2, arg17, arg18);
        verify_origin_declared<T0>(arg0, arg4, arg5, &arg6, &arg14);
        let v0 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::execution_id<T0>(arg0);
        let v1 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::protocol_id<T0>(arg0);
        let v2 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::encode_candidate_transition(1, &v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::protocol_version<T0>(arg0), &v1, arg7, &arg8, arg9, &arg10, arg4, arg5, &arg6, &arg14, &arg15);
        let v3 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::execution_id<T0>(arg0);
        verify_time_evidence<T0>(arg0, &arg13, &v3, arg7, &arg8);
        let v4 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::encode_authorization_payload(&v2, arg11, &arg12, &arg13);
        verify_proofs<T0>(arg0, &v4, &arg16);
        let v5 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::encode_transition_receipt(&v4, &arg16);
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::digest_transition_receipt(&v5)
    }

    public fun digest_action_outcome_record(arg0: &ActionOutcomeRecord) : vector<u8> {
        let v0 = encode_action_outcome_record_payload(arg0);
        digest_action_outcome_record_payload(&v0)
    }

    public fun digest_action_outcome_record_payload(arg0: &vector<u8>) : vector<u8> {
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_framed(b"arena_tunnel::action_outcome_record", arg0)
    }

    public fun digest_hand_outcome_record(arg0: &HandOutcomeRecord) : vector<u8> {
        let v0 = encode_hand_outcome_record_payload(arg0);
        digest_hand_outcome_record_payload(&v0)
    }

    public fun digest_hand_outcome_record_payload(arg0: &vector<u8>) : vector<u8> {
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_framed(b"arena_tunnel::hand_outcome_record", arg0)
    }

    public fun encode_action_outcome_record_payload(arg0: &ActionOutcomeRecord) : vector<u8> {
        encode_record_payload(arg0.schema_version, 0x2::object::id_to_bytes(&arg0.tunnel_id), arg0.execution_id, arg0.protocol_id, arg0.protocol_version, arg0.event_contract_version, arg0.participant_set_digest, arg0.origin_tag, arg0.actor_seat, arg0.authority_role, arg0.previous_nonce, arg0.previous_state_commitment, arg0.resulting_nonce, arg0.resulting_state_commitment, arg0.receipt_digest, arg0.outcome_schema_version, arg0.outcome)
    }

    public fun encode_hand_outcome_record_payload(arg0: &HandOutcomeRecord) : vector<u8> {
        encode_record_payload(arg0.schema_version, 0x2::object::id_to_bytes(&arg0.tunnel_id), arg0.execution_id, arg0.protocol_id, arg0.protocol_version, arg0.event_contract_version, arg0.participant_set_digest, arg0.origin_tag, arg0.actor_seat, arg0.authority_role, arg0.previous_nonce, arg0.previous_state_commitment, arg0.resulting_nonce, arg0.resulting_state_commitment, arg0.receipt_digest, arg0.outcome_schema_version, arg0.outcome)
    }

    public fun encode_record_payload(arg0: u16, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u16, arg5: u16, arg6: vector<u8>, arg7: u8, arg8: u16, arg9: vector<u8>, arg10: u64, arg11: vector<u8>, arg12: u64, arg13: vector<u8>, arg14: vector<u8>, arg15: u16, arg16: vector<u8>) : vector<u8> {
        let v0 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg4));
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg5));
        0x1::vector::append<u8>(&mut v0, arg6);
        0x1::vector::push_back<u8>(&mut v0, arg7);
        if (arg7 == 0) {
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg8));
        } else {
            0x1::vector::append<u8>(&mut v0, arg9);
        };
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg10));
        0x1::vector::append<u8>(&mut v0, arg11);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg12));
        0x1::vector::append<u8>(&mut v0, arg13);
        0x1::vector::append<u8>(&mut v0, arg14);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg15));
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<u8>(&arg16) as u16)));
        0x1::vector::append<u8>(&mut v0, arg16);
        v0
    }

    public fun hand_record_actor_seat(arg0: &HandOutcomeRecord) : u16 {
        arg0.actor_seat
    }

    public fun hand_record_authority_role(arg0: &HandOutcomeRecord) : vector<u8> {
        arg0.authority_role
    }

    public fun hand_record_event_contract_version(arg0: &HandOutcomeRecord) : u16 {
        arg0.event_contract_version
    }

    public fun hand_record_execution_id(arg0: &HandOutcomeRecord) : vector<u8> {
        arg0.execution_id
    }

    public fun hand_record_origin_tag(arg0: &HandOutcomeRecord) : u8 {
        arg0.origin_tag
    }

    public fun hand_record_outcome(arg0: &HandOutcomeRecord) : vector<u8> {
        arg0.outcome
    }

    public fun hand_record_outcome_schema_version(arg0: &HandOutcomeRecord) : u16 {
        arg0.outcome_schema_version
    }

    public fun hand_record_participant_set_digest(arg0: &HandOutcomeRecord) : vector<u8> {
        arg0.participant_set_digest
    }

    public fun hand_record_previous_nonce(arg0: &HandOutcomeRecord) : u64 {
        arg0.previous_nonce
    }

    public fun hand_record_previous_state_commitment(arg0: &HandOutcomeRecord) : vector<u8> {
        arg0.previous_state_commitment
    }

    public fun hand_record_protocol_id(arg0: &HandOutcomeRecord) : vector<u8> {
        arg0.protocol_id
    }

    public fun hand_record_protocol_version(arg0: &HandOutcomeRecord) : u16 {
        arg0.protocol_version
    }

    public fun hand_record_receipt_digest(arg0: &HandOutcomeRecord) : vector<u8> {
        arg0.receipt_digest
    }

    public fun hand_record_resulting_nonce(arg0: &HandOutcomeRecord) : u64 {
        arg0.resulting_nonce
    }

    public fun hand_record_resulting_state_commitment(arg0: &HandOutcomeRecord) : vector<u8> {
        arg0.resulting_state_commitment
    }

    public fun hand_record_schema_version(arg0: &HandOutcomeRecord) : u16 {
        arg0.schema_version
    }

    public fun hand_record_tunnel_id(arg0: &HandOutcomeRecord) : 0x2::object::ID {
        arg0.tunnel_id
    }

    fun principal_vectors_equal(arg0: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>, arg1: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>) : bool {
        if (0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0) != 0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0)) {
            if (!0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_equal(0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0, v0), 0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg1, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun publish_action_outcome<T0>(arg0: &mut 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>, arg1: u16, arg2: u8, arg3: u16, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: vector<u8>, arg9: u16, arg10: vector<u8>, arg11: 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::TimeEvidence, arg12: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>, arg13: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::ArtifactCommitmentWire>, arg14: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::AuthorizationProof>, arg15: u16, arg16: vector<u8>, arg17: &mut 0x2::tx_context::TxContext) {
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::advance_outcome_record_state<T0>(arg0, arg7, arg8);
        let v0 = ActionOutcomeRecord{
            id                         : 0x2::object::new(arg17),
            schema_version             : 1,
            tunnel_id                  : 0x2::object::id<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>>(arg0),
            execution_id               : 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::execution_id<T0>(arg0),
            protocol_id                : 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::protocol_id<T0>(arg0),
            protocol_version           : 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::protocol_version<T0>(arg0),
            event_contract_version     : arg1,
            participant_set_digest     : 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::participant_set_digest<T0>(arg0),
            origin_tag                 : arg2,
            actor_seat                 : arg3,
            authority_role             : arg4,
            previous_nonce             : arg5,
            previous_state_commitment  : arg6,
            resulting_nonce            : arg7,
            resulting_state_commitment : arg8,
            receipt_digest             : build_receipt_digest<T0>(arg0, 0, 21, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &arg16),
            outcome_schema_version     : arg15,
            outcome                    : arg16,
        };
        let v1 = 0x2::object::id<ActionOutcomeRecord>(&v0);
        let v2 = ActionRecordKey{receipt_digest: v0.receipt_digest};
        assert!(!0x2::dynamic_field::exists<ActionRecordKey>(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::record_index_uid<T0>(arg0), v2), 13906835626046914631);
        0x2::dynamic_field::add<ActionRecordKey, 0x2::object::ID>(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::record_index_uid<T0>(arg0), v2, v1);
        let v3 = ActionOutcomeRecordPublished{
            tunnel_id              : 0x2::object::id<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>>(arg0),
            record_id              : v1,
            receipt_digest         : v0.receipt_digest,
            event_contract_version : arg1,
        };
        0x2::event::emit<ActionOutcomeRecordPublished>(v3);
        0x2::transfer::freeze_object<ActionOutcomeRecord>(v0);
    }

    public fun publish_hand_outcome<T0>(arg0: &mut 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>, arg1: u16, arg2: u8, arg3: u16, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: vector<u8>, arg9: u16, arg10: vector<u8>, arg11: 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::TimeEvidence, arg12: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>, arg13: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::ArtifactCommitmentWire>, arg14: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::AuthorizationProof>, arg15: u16, arg16: vector<u8>, arg17: &mut 0x2::tx_context::TxContext) {
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::advance_outcome_record_state<T0>(arg0, arg7, arg8);
        let v0 = HandOutcomeRecord{
            id                         : 0x2::object::new(arg17),
            schema_version             : 1,
            tunnel_id                  : 0x2::object::id<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>>(arg0),
            execution_id               : 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::execution_id<T0>(arg0),
            protocol_id                : 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::protocol_id<T0>(arg0),
            protocol_version           : 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::protocol_version<T0>(arg0),
            event_contract_version     : arg1,
            participant_set_digest     : 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::participant_set_digest<T0>(arg0),
            origin_tag                 : arg2,
            actor_seat                 : arg3,
            authority_role             : arg4,
            previous_nonce             : arg5,
            previous_state_commitment  : arg6,
            resulting_nonce            : arg7,
            resulting_state_commitment : arg8,
            receipt_digest             : build_receipt_digest<T0>(arg0, 1, 22, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &arg16),
            outcome_schema_version     : arg15,
            outcome                    : arg16,
        };
        let v1 = 0x2::object::id<HandOutcomeRecord>(&v0);
        let v2 = HandRecordKey{receipt_digest: v0.receipt_digest};
        assert!(!0x2::dynamic_field::exists<HandRecordKey>(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::record_index_uid<T0>(arg0), v2), 13906835286744498247);
        0x2::dynamic_field::add<HandRecordKey, 0x2::object::ID>(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::record_index_uid<T0>(arg0), v2, v1);
        let v3 = HandOutcomeRecordPublished{
            tunnel_id              : 0x2::object::id<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>>(arg0),
            record_id              : v1,
            receipt_digest         : v0.receipt_digest,
            event_contract_version : arg1,
        };
        0x2::event::emit<HandOutcomeRecordPublished>(v3);
        0x2::transfer::freeze_object<HandOutcomeRecord>(v0);
    }

    fun validate_outcome(arg0: u16, arg1: &vector<u8>) {
        assert!(arg0 == 0 == 0x1::vector::is_empty<u8>(arg1), 13906836841522266177);
        assert!(0x1::vector::length<u8>(arg1) <= 4096, 13906836850112331843);
    }

    fun validate_principal_proof_shape(arg0: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>, arg1: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::AuthorizationProof>) {
        assert!(0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0) == 0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::AuthorizationProof>(arg1), 13906836682607165485);
        let v0 = 1;
        while (v0 < 0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0)) {
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_is_less(0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0, v0 - 1), 0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0, v0)), 13906836704082133039);
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::AuthorizationProof>(arg1)) {
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_equal(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::proof_principal(0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::AuthorizationProof>(arg1, v0)), 0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0, v0)), 13906836751326904369);
            v0 = v0 + 1;
        };
    }

    fun validate_receipt_shape(arg0: u64, arg1: &vector<u8>, arg2: u64, arg3: &vector<u8>, arg4: u16, arg5: &vector<u8>) {
        assert!(arg4 != 0, 13906836626771017749);
        assert!(!0x1::vector::is_empty<u8>(arg5), 13906836631066116119);
        assert!(0x1::vector::length<u8>(arg5) <= 65535, 13906836635361214489);
        assert!(arg0 != 18446744073709551615, 13906836639656312859);
        assert!(arg2 == arg0 + 1, 13906836643951411229);
        assert!(0x1::vector::length<u8>(arg1) == 32, 13906836648246509599);
        assert!(0x1::vector::length<u8>(arg3) == 32, 13906836652541476895);
    }

    fun verify_origin_declared<T0>(arg0: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>, arg1: u8, arg2: u16, arg3: &vector<u8>, arg4: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>) {
        if (arg1 == 2) {
            0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::find_seat_public_key<T0>(arg0, arg2);
            return
        };
        let v0 = if (arg1 == 0) {
            0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::seat_principal(arg2)
        } else {
            assert!(0x1::vector::length<u8>(arg3) == 32, 13906837069153435681);
            0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::role_principal(*arg3)
        };
        let v1 = v0;
        if (arg1 == 0) {
            0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::find_seat_public_key<T0>(arg0, arg2);
        } else {
            0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::find_role_public_key<T0>(arg0, arg3);
        };
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg4)) {
            if (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_equal(0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg4, v3), &v1)) {
                v2 = true;
            };
            v3 = v3 + 1;
        };
        assert!(v2, 13906837137873174565);
    }

    fun verify_outcome_authenticated(arg0: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::ArtifactCommitmentWire>, arg1: u16, arg2: u16, arg3: &vector<u8>) {
        assert!(!0x1::vector::is_empty<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::ArtifactCommitmentWire>(arg0), 13906836901652070469);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::ArtifactCommitmentWire>(arg0)) {
            let v2 = 0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::ArtifactCommitmentWire>(arg0, v1);
            let v3 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::artifact_digest(v2);
            assert!(0x1::vector::length<u8>(&v3) == 32, 13906836931714613283);
            let v4 = if (!v0) {
                if (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::artifact_kind(v2) == arg1) {
                    if (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::artifact_schema(v2) == arg2) {
                        if (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::artifact_byte_length(v2) == 0x1::vector::length<u8>(arg3)) {
                            0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::artifact_digest(v2) == 0x2::hash::blake2b256(arg3)
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 13906836974666514501);
    }

    fun verify_proofs<T0>(arg0: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>, arg1: &vector<u8>, arg2: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::AuthorizationProof>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::AuthorizationProof>(arg2)) {
            let v1 = 0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::AuthorizationProof>(arg2, v0);
            let v2 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::proof_principal(v1);
            let (v3, v4) = bound_key<T0>(arg0, v2);
            let v5 = v4;
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::proof_signature_scheme(v1) == v3, 13906837627500625975);
            let v6 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::proof_runtime_generation(v1);
            let v7 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::transition_authorization_proof_signing_bytes(arg1, v2, &v6, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::proof_signature_scheme(v1));
            let v8 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::proof_signature(v1);
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::verify(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::proof_signature_scheme(v1), &v5, &v7, &v8), 13906837691925004341);
            v0 = v0 + 1;
        };
    }

    fun verify_time_evidence<T0>(arg0: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::ArenaTunnel<T0>, arg1: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::TimeEvidence, arg2: &vector<u8>, arg3: u64, arg4: &vector<u8>) {
        if (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::is_time_evidence_absent(arg1)) {
            return
        };
        let v0 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::time_evidence_time_authority(arg1);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::time_evidence_execution_id(arg1) == *arg2, 13906837206593962041);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::time_evidence_previous_nonce(arg1) == arg3, 13906837223773831225);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::time_evidence_previous_commitment(arg1) == *arg4, 13906837240953700409);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::time_evidence_authority_sequence(arg1) != 0, 13906837318263242811);
        let v1 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::time_evidence_deadline_ms(arg1);
        if (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::is_time_evidence_arrival(arg1)) {
            let v2 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::time_evidence_observed_at_ms(arg1);
            assert!(v2 != 0 && v2 <= v1, 13906837382687883325);
        } else if (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::is_time_evidence_lock(arg1)) {
            let v3 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::time_evidence_arrival_ms(arg1);
            assert!(v3 != 0 && v3 <= v1, 13906837417047621693);
            let v4 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::time_evidence_locked_at_ms(arg1);
            assert!(v4 >= v3 && v4 <= v1, 13906837455702458431);
        };
        let v5 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::find_role_public_key<T0>(arg0, &v0);
        let v6 = if (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::is_time_evidence_arrival(arg1)) {
            0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::arrival_evidence_signing_bytes(arg1)
        } else if (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::is_time_evidence_deadline(arg1)) {
            0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::deadline_evidence_signing_bytes(arg1)
        } else {
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::is_time_evidence_lock(arg1), 13906837511536640057);
            0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::lock_evidence_signing_bytes(arg1)
        };
        let v7 = v6;
        let v8 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::time_evidence_signature(arg1);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::verify(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor::find_role_signature_type<T0>(arg0, &v0), &v5, &v7, &v8), 13906837554486313017);
    }

    // decompiled from Move bytecode v7
}

