module 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire {
    struct TimeEvidence has copy, drop, store {
        tag: u8,
        execution_id: vector<u8>,
        request_digest: vector<u8>,
        previous_nonce: u64,
        previous_commitment: vector<u8>,
        time_authority: vector<u8>,
        authority_sequence: u64,
        observed_at_ms: u64,
        expired_at_ms: u64,
        arrival_ms: u64,
        locked_at_ms: u64,
        deadline_ms: u64,
        runtime_generation: vector<u8>,
        signature: vector<u8>,
    }

    struct Principal has copy, drop, store {
        tag: u8,
        seat: u16,
        role: vector<u8>,
    }

    struct ArtifactCommitmentWire has copy, drop, store {
        kind: u16,
        schema: u16,
        digest: vector<u8>,
        byte_length: u64,
    }

    struct AuthorizationProof has copy, drop, store {
        principal: Principal,
        runtime_generation: vector<u8>,
        signature_scheme: u8,
        signature: vector<u8>,
    }

    public fun arrival_evidence(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>) : TimeEvidence {
        TimeEvidence{
            tag                 : 0,
            execution_id        : arg0,
            request_digest      : arg1,
            previous_nonce      : arg2,
            previous_commitment : arg3,
            time_authority      : arg4,
            authority_sequence  : arg5,
            observed_at_ms      : arg6,
            expired_at_ms       : 0,
            arrival_ms          : 0,
            locked_at_ms        : 0,
            deadline_ms         : arg7,
            runtime_generation  : arg8,
            signature           : arg9,
        }
    }

    public fun arrival_evidence_signing_bytes(arg0: &TimeEvidence) : vector<u8> {
        let v0 = encode_arrival_payload(arg0);
        frame_signing_bytes(b"arena_tunnel::arrival_evidence", &v0)
    }

    public fun artifact_byte_length(arg0: &ArtifactCommitmentWire) : u64 {
        arg0.byte_length
    }

    public fun artifact_commitment(arg0: u16, arg1: u16, arg2: vector<u8>, arg3: u64) : ArtifactCommitmentWire {
        ArtifactCommitmentWire{
            kind        : arg0,
            schema      : arg1,
            digest      : arg2,
            byte_length : arg3,
        }
    }

    public fun artifact_digest(arg0: &ArtifactCommitmentWire) : vector<u8> {
        arg0.digest
    }

    public fun artifact_kind(arg0: &ArtifactCommitmentWire) : u16 {
        arg0.kind
    }

    public fun artifact_schema(arg0: &ArtifactCommitmentWire) : u16 {
        arg0.schema
    }

    public fun authorization_proof(arg0: Principal, arg1: vector<u8>, arg2: u8, arg3: vector<u8>) : AuthorizationProof {
        AuthorizationProof{
            principal          : arg0,
            runtime_generation : arg1,
            signature_scheme   : arg2,
            signature          : arg3,
        }
    }

    public fun deadline_evidence(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>) : TimeEvidence {
        TimeEvidence{
            tag                 : 1,
            execution_id        : arg0,
            request_digest      : arg1,
            previous_nonce      : arg2,
            previous_commitment : arg3,
            time_authority      : arg4,
            authority_sequence  : arg5,
            observed_at_ms      : 0,
            expired_at_ms       : arg6,
            arrival_ms          : 0,
            locked_at_ms        : 0,
            deadline_ms         : arg7,
            runtime_generation  : arg8,
            signature           : arg9,
        }
    }

    public fun deadline_evidence_signing_bytes(arg0: &TimeEvidence) : vector<u8> {
        let v0 = encode_deadline_payload(arg0);
        frame_signing_bytes(b"arena_tunnel::deadline_evidence", &v0)
    }

    public fun digest_transition_authorization(arg0: &vector<u8>) : vector<u8> {
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_framed(b"arena_tunnel::transition_authorization", arg0)
    }

    public fun digest_transition_receipt(arg0: &vector<u8>) : vector<u8> {
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_framed(b"arena_tunnel::transition_receipt", arg0)
    }

    fun encode_arrival_payload(arg0: &TimeEvidence) : vector<u8> {
        encode_variant_payload(arg0, 0)
    }

    public fun encode_authorization_payload(arg0: &vector<u8>, arg1: u16, arg2: &vector<u8>, arg3: &TimeEvidence) : vector<u8> {
        let v0 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(0x1::vector::length<u8>(arg0));
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(0x1::vector::length<u8>(arg2)));
        0x1::vector::append<u8>(&mut v0, *arg2);
        if (arg3.tag == 255) {
            0x1::vector::push_back<u8>(&mut v0, 0);
        } else {
            0x1::vector::push_back<u8>(&mut v0, 1);
            0x1::vector::push_back<u8>(&mut v0, arg3.tag);
            0x1::vector::append<u8>(&mut v0, encode_evidence_payload(arg3));
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<u8>(&arg3.signature) as u16)));
            0x1::vector::append<u8>(&mut v0, arg3.signature);
        };
        v0
    }

    public fun encode_candidate_transition(arg0: u16, arg1: &vector<u8>, arg2: u16, arg3: &vector<u8>, arg4: u64, arg5: &vector<u8>, arg6: u64, arg7: &vector<u8>, arg8: u8, arg9: u16, arg10: &vector<u8>, arg11: &vector<Principal>, arg12: &vector<ArtifactCommitmentWire>) : vector<u8> {
        let v0 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, *arg3);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg4));
        0x1::vector::append<u8>(&mut v0, *arg5);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg6));
        0x1::vector::append<u8>(&mut v0, *arg7);
        if (arg8 == 1) {
            0x1::vector::push_back<u8>(&mut v0, arg8);
            0x1::vector::append<u8>(&mut v0, *arg10);
        } else {
            0x1::vector::push_back<u8>(&mut v0, arg8);
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg9));
        };
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<Principal>(arg11) as u16)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<Principal>(arg11)) {
            let v2 = &mut v0;
            encode_principal(v2, 0x1::vector::borrow<Principal>(arg11, v1));
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<ArtifactCommitmentWire>(arg12) as u16)));
        let v3 = 0;
        while (v3 < 0x1::vector::length<ArtifactCommitmentWire>(arg12)) {
            let v4 = 0x1::vector::borrow<ArtifactCommitmentWire>(arg12, v3);
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(v4.kind));
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(v4.schema));
            0x1::vector::append<u8>(&mut v0, v4.digest);
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(v4.byte_length));
            v3 = v3 + 1;
        };
        v0
    }

    fun encode_deadline_payload(arg0: &TimeEvidence) : vector<u8> {
        encode_variant_payload(arg0, 1)
    }

    fun encode_evidence_payload(arg0: &TimeEvidence) : vector<u8> {
        encode_variant_payload(arg0, arg0.tag)
    }

    fun encode_lock_payload(arg0: &TimeEvidence) : vector<u8> {
        encode_variant_payload(arg0, 2)
    }

    fun encode_principal(arg0: &mut vector<u8>, arg1: &Principal) {
        if (arg1.tag == 0) {
            0x1::vector::push_back<u8>(arg0, 0);
            0x1::vector::append<u8>(arg0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg1.seat));
        } else {
            0x1::vector::push_back<u8>(arg0, 1);
            0x1::vector::append<u8>(arg0, arg1.role);
        };
    }

    public fun encode_transition_receipt(arg0: &vector<u8>, arg1: &vector<AuthorizationProof>) : vector<u8> {
        let v0 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(1);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(0x1::vector::length<u8>(arg0)));
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<AuthorizationProof>(arg1) as u16)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<AuthorizationProof>(arg1)) {
            let v2 = 0x1::vector::borrow<AuthorizationProof>(arg1, v1);
            let v3 = &mut v0;
            encode_principal(v3, &v2.principal);
            0x1::vector::append<u8>(&mut v0, v2.runtime_generation);
            0x1::vector::push_back<u8>(&mut v0, v2.signature_scheme);
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<u8>(&v2.signature) as u16)));
            0x1::vector::append<u8>(&mut v0, v2.signature);
            v1 = v1 + 1;
        };
        v0
    }

    fun encode_variant_payload(arg0: &TimeEvidence, arg1: u8) : vector<u8> {
        let v0 = arg0.execution_id;
        0x1::vector::append<u8>(&mut v0, arg0.request_digest);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg0.previous_nonce));
        0x1::vector::append<u8>(&mut v0, arg0.previous_commitment);
        0x1::vector::append<u8>(&mut v0, arg0.time_authority);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg0.authority_sequence));
        if (arg1 == 0) {
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg0.observed_at_ms));
        } else if (arg1 == 1) {
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg0.expired_at_ms));
        } else {
            assert!(arg1 == 2, 13906836420611932171);
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg0.arrival_ms));
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg0.locked_at_ms));
        };
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg0.deadline_ms));
        0x1::vector::append<u8>(&mut v0, arg0.runtime_generation);
        v0
    }

    fun frame_signing_bytes(arg0: vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(0x1::vector::length<u8>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(0x1::vector::length<u8>(arg1)));
        0x1::vector::append<u8>(&mut v0, *arg1);
        v0
    }

    fun is_lexicographically_less(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 != v5) {
                return v4 < v5
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    public fun is_time_evidence_absent(arg0: &TimeEvidence) : bool {
        arg0.tag == 255
    }

    public fun is_time_evidence_arrival(arg0: &TimeEvidence) : bool {
        arg0.tag == 0
    }

    public fun is_time_evidence_deadline(arg0: &TimeEvidence) : bool {
        arg0.tag == 1
    }

    public fun is_time_evidence_lock(arg0: &TimeEvidence) : bool {
        arg0.tag == 2
    }

    public fun lock_evidence(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: vector<u8>) : TimeEvidence {
        TimeEvidence{
            tag                 : 2,
            execution_id        : arg0,
            request_digest      : arg1,
            previous_nonce      : arg2,
            previous_commitment : arg3,
            time_authority      : arg4,
            authority_sequence  : arg5,
            observed_at_ms      : 0,
            expired_at_ms       : 0,
            arrival_ms          : arg6,
            locked_at_ms        : arg7,
            deadline_ms         : arg8,
            runtime_generation  : arg9,
            signature           : arg10,
        }
    }

    public fun lock_evidence_signing_bytes(arg0: &TimeEvidence) : vector<u8> {
        let v0 = encode_lock_payload(arg0);
        frame_signing_bytes(b"arena_tunnel::lock_evidence", &v0)
    }

    public fun no_time_evidence() : TimeEvidence {
        TimeEvidence{
            tag                 : 255,
            execution_id        : b"",
            request_digest      : b"",
            previous_nonce      : 0,
            previous_commitment : b"",
            time_authority      : b"",
            authority_sequence  : 0,
            observed_at_ms      : 0,
            expired_at_ms       : 0,
            arrival_ms          : 0,
            locked_at_ms        : 0,
            deadline_ms         : 0,
            runtime_generation  : b"",
            signature           : b"",
        }
    }

    public fun principal_equal(arg0: &Principal, arg1: &Principal) : bool {
        arg0.tag == arg1.tag && (arg0.tag == 0 && arg0.seat == arg1.seat || arg0.role == arg1.role)
    }

    public fun principal_is_less(arg0: &Principal, arg1: &Principal) : bool {
        if (arg0.tag != arg1.tag) {
            return arg0.tag < arg1.tag
        };
        arg0.tag == 0 && arg0.seat < arg1.seat || is_lexicographically_less(&arg0.role, &arg1.role)
    }

    public fun principal_role(arg0: &Principal) : vector<u8> {
        arg0.role
    }

    public fun principal_seat(arg0: &Principal) : u16 {
        arg0.seat
    }

    public fun principal_tag(arg0: &Principal) : u8 {
        arg0.tag
    }

    public fun proof_principal(arg0: &AuthorizationProof) : &Principal {
        &arg0.principal
    }

    public fun proof_runtime_generation(arg0: &AuthorizationProof) : vector<u8> {
        arg0.runtime_generation
    }

    public fun proof_signature(arg0: &AuthorizationProof) : vector<u8> {
        arg0.signature
    }

    public fun proof_signature_scheme(arg0: &AuthorizationProof) : u8 {
        arg0.signature_scheme
    }

    public fun role_principal(arg0: vector<u8>) : Principal {
        Principal{
            tag  : 1,
            seat : 0,
            role : arg0,
        }
    }

    public fun role_principal_tag() : u8 {
        1
    }

    public fun seat_principal(arg0: u16) : Principal {
        Principal{
            tag  : 0,
            seat : arg0,
            role : b"",
        }
    }

    public fun seat_principal_tag() : u8 {
        0
    }

    public fun time_evidence_arrival_ms(arg0: &TimeEvidence) : u64 {
        arg0.arrival_ms
    }

    public fun time_evidence_authority_sequence(arg0: &TimeEvidence) : u64 {
        arg0.authority_sequence
    }

    public fun time_evidence_deadline_ms(arg0: &TimeEvidence) : u64 {
        arg0.deadline_ms
    }

    public fun time_evidence_execution_id(arg0: &TimeEvidence) : vector<u8> {
        arg0.execution_id
    }

    public fun time_evidence_locked_at_ms(arg0: &TimeEvidence) : u64 {
        arg0.locked_at_ms
    }

    public fun time_evidence_observed_at_ms(arg0: &TimeEvidence) : u64 {
        arg0.observed_at_ms
    }

    public fun time_evidence_previous_commitment(arg0: &TimeEvidence) : vector<u8> {
        arg0.previous_commitment
    }

    public fun time_evidence_previous_nonce(arg0: &TimeEvidence) : u64 {
        arg0.previous_nonce
    }

    public fun time_evidence_request_digest(arg0: &TimeEvidence) : vector<u8> {
        arg0.request_digest
    }

    public fun time_evidence_signature(arg0: &TimeEvidence) : vector<u8> {
        arg0.signature
    }

    public fun time_evidence_tag(arg0: &TimeEvidence) : u8 {
        arg0.tag
    }

    public fun time_evidence_time_authority(arg0: &TimeEvidence) : vector<u8> {
        arg0.time_authority
    }

    public fun transition_authorization_proof_signing_bytes(arg0: &vector<u8>, arg1: &Principal, arg2: &vector<u8>, arg3: u8) : vector<u8> {
        let v0 = *arg0;
        let v1 = &mut v0;
        encode_principal(v1, arg1);
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x1::vector::push_back<u8>(&mut v0, arg3);
        frame_signing_bytes(b"arena_tunnel::transition_authorization", &v0)
    }

    // decompiled from Move bytecode v7
}

