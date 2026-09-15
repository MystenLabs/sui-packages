module 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::anchor {
    struct SeatDeclaration has copy, drop, store {
        seat: u16,
        participant_id: vector<u8>,
        signature_type: u8,
        participant_public_key: vector<u8>,
        funding_source: address,
        beneficiary: address,
        required_deposit: u64,
    }

    struct RoleDeclaration has copy, drop, store {
        role_id: vector<u8>,
        signature_type: u8,
        public_key: vector<u8>,
    }

    struct OutcomeRecordPolicy has drop, store {
        action_authorization: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>,
        hand_authorization: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>,
        nonce: u64,
        state_commitment: vector<u8>,
    }

    struct TerminalState has copy, drop, store {
        state_commitment: vector<u8>,
        nonce: u64,
        timestamp: u64,
        transcript_root: vector<u8>,
        receipt_count: u64,
        outcome_schema_version: u16,
        outcome: vector<u8>,
        entitlements: vector<u64>,
    }

    struct ArenaTunnel<phantom T0> has key {
        id: 0x2::object::UID,
        contract_schema_version: u16,
        wire_version: u16,
        execution_id: vector<u8>,
        protocol_version: u16,
        verification_policy_version: u16,
        protocol_id: vector<u8>,
        product_manifest_digest: vector<u8>,
        execution_manifest_digest: vector<u8>,
        participant_set_digest: vector<u8>,
        initial_state_commitment: vector<u8>,
        nonce: u64,
        funding_deadline_ms: u64,
        seats: vector<SeatDeclaration>,
        funded_seats: vector<bool>,
        roles: vector<RoleDeclaration>,
        outcome_records: OutcomeRecordPolicy,
        participant_count: u16,
        required_total: u64,
        funded_total: u64,
        funded_count: u16,
        escrow: 0x2::balance::Balance<T0>,
        status: u8,
        policy_declared: bool,
        dispute_window_ms: u64,
        referee_signature_type: u8,
        referee_public_key: vector<u8>,
        minimum_dispute_checkpoint_nonce: u64,
        dispute_started_ms: u64,
        terminal: TerminalState,
        admitted_evidence_class: u8,
    }

    struct SettledOutcomeRecord has key {
        id: 0x2::object::UID,
        schema_version: u16,
        tunnel_id: 0x2::object::ID,
        execution_id: vector<u8>,
        execution_manifest_digest: vector<u8>,
        participant_set_digest: vector<u8>,
        protocol_version: u16,
        protocol_id: vector<u8>,
        verification_policy_version: u16,
        product_manifest_digest: vector<u8>,
        resolution_policy_digest: vector<u8>,
        disposition: u8,
        terminal_nonce: u64,
        terminal_timestamp: u64,
        terminal_state_commitment: vector<u8>,
        transcript_root: vector<u8>,
        receipt_count: u64,
        outcome_schema_version: u16,
        outcome: vector<u8>,
        entitlements: vector<u64>,
        total_settled: u64,
        settled_at_ms: u64,
        evidence_class: u8,
    }

    struct ArenaTunnelSettled has copy, drop {
        tunnel_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        disposition: u8,
        total_settled: u64,
        settled_at_ms: u64,
    }

    struct ArenaDisputeOpened has copy, drop {
        tunnel_id: 0x2::object::ID,
        nonce: u64,
        opened_at_ms: u64,
    }

    struct ArenaCheckpointAdopted has copy, drop {
        tunnel_id: 0x2::object::ID,
        nonce: u64,
        adopted_at_ms: u64,
        deadline_ms: u64,
    }

    struct ArenaTunnelCreated has copy, drop {
        tunnel_id: 0x2::object::ID,
        execution_id: vector<u8>,
        participant_set_digest: vector<u8>,
        execution_manifest_digest: vector<u8>,
        participant_count: u16,
        required_total: u64,
        funding_deadline_ms: u64,
    }

    struct ArenaSeatFunded has copy, drop {
        tunnel_id: 0x2::object::ID,
        seat: u16,
        funding_source: address,
        amount: u64,
        funded_count: u16,
        funded_total: u64,
    }

    struct ArenaTunnelActivated has copy, drop {
        tunnel_id: 0x2::object::ID,
        execution_id: vector<u8>,
        execution_manifest_digest: vector<u8>,
        participant_set_digest: vector<u8>,
        total_custody: u64,
        nonce: u64,
        initial_state_commitment: vector<u8>,
        activated_at_ms: u64,
    }

    struct ArenaTunnelOpeningCancelled has copy, drop {
        tunnel_id: 0x2::object::ID,
        execution_id: vector<u8>,
        execution_manifest_digest: vector<u8>,
        participant_set_digest: vector<u8>,
        funded_count: u16,
        refunded_total: u64,
        cancelled_at_ms: u64,
    }

    struct FundingProjection has copy, drop {
        projected_funded_count: u16,
        projected_funded_total: u64,
        projected_escrow_value: u64,
        activates: bool,
    }

    struct PayoutPlan has copy, drop {
        recipients: vector<address>,
        amounts: vector<u64>,
    }

    public(friend) fun action_authorization<T0>(arg0: &ArenaTunnel<T0>) : &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal> {
        &arg0.outcome_records.action_authorization
    }

    public fun activation_nonce<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.nonce
    }

    public fun admitted_evidence_class<T0>(arg0: &ArenaTunnel<T0>) : u8 {
        arg0.admitted_evidence_class
    }

    fun adopt_checkpoint<T0>(arg0: &mut ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock) {
        assert_checkpoint_admissible<T0>(arg0, &arg1, arg2, &arg4, arg6, &arg7, &arg8);
        let v0 = terminal_payload<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, &arg8);
        let v1 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_checkpoint(&v0);
        verify_every_seat<T0>(arg0, &v1, &arg9);
        commit_checkpoint<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun adopt_disputed_checkpoint<T0>(arg0: &mut ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock) {
        assert!(arg0.status == 2, 13906838727016185971);
        adopt_checkpoint<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        emit_checkpoint_adopted<T0>(arg0, arg10);
    }

    public(friend) fun advance_outcome_record_state<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u64, arg2: vector<u8>) {
        arg0.outcome_records.nonce = arg1;
        arg0.outcome_records.state_commitment = arg2;
    }

    fun append_authorization_principals(arg0: &mut vector<u8>, arg1: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>) {
        0x1::vector::append<u8>(arg0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg1) as u16)));
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg1)) {
            let v1 = 0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg1, v0);
            0x1::vector::push_back<u8>(arg0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_tag(v1));
            if (0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_tag(v1) == 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::seat_principal_tag()) {
                0x1::vector::append<u8>(arg0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_seat(v1)));
            } else {
                0x1::vector::append<u8>(arg0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_role(v1));
            };
            v0 = v0 + 1;
        };
    }

    fun assert_admitted_evidence_class<T0>(arg0: &ArenaTunnel<T0>, arg1: u8) {
        assert!(arg0.admitted_evidence_class == arg1, 13906843258207993991);
    }

    fun assert_checkpoint_admissible<T0>(arg0: &ArenaTunnel<T0>, arg1: &vector<u8>, arg2: u64, arg3: &vector<u8>, arg4: u16, arg5: &vector<u64>, arg6: &vector<u8>) {
        assert_terminal_state_shape<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(arg2 > arg0.terminal.nonce, 13906839225232130159);
    }

    fun assert_conserves(arg0: &vector<u64>, arg1: u64) {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            let v2 = *0x1::vector::borrow<u64>(arg0, v1);
            assert!(v2 <= v0, 13906840608211206249);
            v0 = v0 - v2;
            v1 = v1 + 1;
        };
        assert!(v0 == 0, 13906840621096108137);
    }

    fun assert_cooperative_signers_registered_local<T0>(arg0: &ArenaTunnel<T0>, arg1: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::AttestationRegistry<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::LocalEvidence>, arg2: u64) {
        let v0 = b"dopan180/role/seat-v1";
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(&arg0.seats)) {
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::is_current_local_registration(arg1, &0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v1).participant_public_key, &v0, arg2), 13906841458616434819);
            v1 = v1 + 1;
        };
    }

    fun assert_cooperative_signers_registered_nitro<T0>(arg0: &ArenaTunnel<T0>, arg1: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::AttestationRegistry<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::NitroEvidence>, arg2: u64) {
        let v0 = b"dopan180/party-seat-v1";
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(&arg0.seats)) {
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::is_current_nitro_registration(arg1, &0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v1).participant_public_key, &v0, arg2), 13906841394191925379);
            v1 = v1 + 1;
        };
    }

    public(friend) fun assert_outcome_record_predecessor<T0>(arg0: &ArenaTunnel<T0>, arg1: u64, arg2: &vector<u8>) {
        assert!(arg0.outcome_records.nonce == arg1 && arg0.outcome_records.state_commitment == *arg2, 13906846556736978989);
    }

    fun assert_referee_signer_registered_local<T0>(arg0: &ArenaTunnel<T0>, arg1: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::AttestationRegistry<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::LocalEvidence>, arg2: u64) {
        let v0 = b"dopan180/role/referee-v1";
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::is_current_local_registration(arg1, &arg0.referee_public_key, &v0, arg2), 13906841613235257475);
    }

    fun assert_referee_signer_registered_nitro<T0>(arg0: &ArenaTunnel<T0>, arg1: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::AttestationRegistry<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::NitroEvidence>, arg2: u64) {
        let v0 = b"dopan180/authority-referee-v1";
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::is_current_nitro_registration(arg1, &arg0.referee_public_key, &v0, arg2), 13906841540220813443);
    }

    fun assert_settlement_admissible<T0>(arg0: &ArenaTunnel<T0>, arg1: &vector<u8>, arg2: u64, arg3: &vector<u8>, arg4: u16, arg5: &vector<u64>, arg6: &vector<u8>) {
        assert_terminal_state_shape<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(arg2 >= arg0.terminal.nonce, 13906839336901279855);
    }

    fun assert_terminal_state_shape<T0>(arg0: &ArenaTunnel<T0>, arg1: &vector<u8>, arg2: u64, arg3: &vector<u8>, arg4: u16, arg5: &vector<u64>, arg6: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 32, 13906839087790161985);
        assert!(0x1::vector::length<u8>(arg3) == 32, 13906839092085129281);
        assert!(arg2 < 18446744073709551615, 13906839100678209649);
        assert!(0x1::vector::length<u64>(arg5) == 0x1::vector::length<SeatDeclaration>(&arg0.seats), 13906839104972783723);
        assert!(0x1::vector::length<u8>(arg6) <= 4096, 13906839117858996351);
        assert!(arg4 == 0 == 0x1::vector::is_empty<u8>(arg6), 13906839122154094721);
        assert_conserves(arg5, 0x2::balance::value<T0>(&arg0.escrow));
    }

    public fun cancel_expired<T0>(arg0: ArenaTunnel<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 13906837013322268757);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.funding_deadline_ms, 13906837017617104979);
        let v0 = compute_refund_plan(&arg0.seats, &arg0.funded_seats);
        let ArenaTunnel {
            id                               : v1,
            contract_schema_version          : _,
            wire_version                     : _,
            execution_id                     : _,
            protocol_version                 : _,
            verification_policy_version      : _,
            protocol_id                      : _,
            product_manifest_digest          : _,
            execution_manifest_digest        : _,
            participant_set_digest           : _,
            initial_state_commitment         : _,
            nonce                            : _,
            funding_deadline_ms              : _,
            seats                            : _,
            funded_seats                     : _,
            roles                            : _,
            outcome_records                  : _,
            participant_count                : _,
            required_total                   : _,
            funded_total                     : v20,
            funded_count                     : v21,
            escrow                           : v22,
            status                           : _,
            policy_declared                  : _,
            dispute_window_ms                : _,
            referee_signature_type           : _,
            referee_public_key               : _,
            minimum_dispute_checkpoint_nonce : _,
            dispute_started_ms               : _,
            terminal                         : _,
            admitted_evidence_class          : _,
        } = arg0;
        let v32 = v22;
        let v33 = 0;
        let v34 = 0;
        assert!(0x1::vector::length<address>(&v0.recipients) == 0x1::vector::length<u64>(&v0.amounts), 13906837086336450641);
        while (v34 < 0x1::vector::length<address>(&v0.recipients)) {
            let v35 = *0x1::vector::borrow<u64>(&v0.amounts, v34);
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut v32, v35), *0x1::vector::borrow<address>(&v0.recipients, v34));
            v33 = v33 + v35;
            v34 = v34 + 1;
        };
        assert!(v33 == v20, 13906837133581090897);
        assert!(v34 == (v21 as u64), 13906837137876058193);
        assert!(0x2::balance::value<T0>(&v32) == 0, 13906837142171025489);
        0x2::balance::destroy_zero<T0>(v32);
        0x2::object::delete(v1);
        let v36 = ArenaTunnelOpeningCancelled{
            tunnel_id                 : 0x2::object::id<ArenaTunnel<T0>>(&arg0),
            execution_id              : arg0.execution_id,
            execution_manifest_digest : arg0.execution_manifest_digest,
            participant_set_digest    : arg0.participant_set_digest,
            funded_count              : v21,
            refunded_total            : v33,
            cancelled_at_ms           : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ArenaTunnelOpeningCancelled>(v36);
    }

    fun commit_checkpoint<T0>(arg0: &mut ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>) {
        let v0 = TerminalState{
            state_commitment       : arg1,
            nonce                  : arg2,
            timestamp              : arg3,
            transcript_root        : arg4,
            receipt_count          : arg5,
            outcome_schema_version : arg6,
            outcome                : arg8,
            entitlements           : arg7,
        };
        arg0.terminal = v0;
    }

    fun commit_terminal_and_pay<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: u8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = TerminalState{
            state_commitment       : arg1,
            nonce                  : arg2,
            timestamp              : arg3,
            transcript_root        : arg4,
            receipt_count          : arg5,
            outcome_schema_version : arg6,
            outcome                : arg8,
            entitlements           : arg7,
        };
        arg0.terminal = v0;
        settle_escrow_and_publish_outcome<T0>(arg0, arg9, arg10, arg11);
    }

    fun compute_payout_plan(arg0: &vector<SeatDeclaration>, arg1: &vector<u64>, arg2: bool) : PayoutPlan {
        assert!(0x1::vector::length<SeatDeclaration>(arg0) == 0x1::vector::length<u64>(arg1), 13906840762830159979);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(arg0)) {
            let v2 = if (arg2) {
                0x1::vector::borrow<SeatDeclaration>(arg0, v1).funding_source
            } else {
                0x1::vector::borrow<SeatDeclaration>(arg0, v1).beneficiary
            };
            0x1::vector::push_back<address>(&mut v0, v2);
            v1 = v1 + 1;
        };
        PayoutPlan{
            recipients : v0,
            amounts    : *arg1,
        }
    }

    fun compute_refund_plan(arg0: &vector<SeatDeclaration>, arg1: &vector<bool>) : PayoutPlan {
        assert!(0x1::vector::length<SeatDeclaration>(arg0) == 0x1::vector::length<bool>(arg1), 13906842480815374417);
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<SeatDeclaration>(arg0)) {
            if (*0x1::vector::borrow<bool>(arg1, v2)) {
                let v3 = 0x1::vector::borrow<SeatDeclaration>(arg0, v2);
                0x1::vector::push_back<address>(&mut v0, v3.funding_source);
                0x1::vector::push_back<u64>(&mut v1, v3.required_deposit);
            };
            v2 = v2 + 1;
        };
        PayoutPlan{
            recipients : v0,
            amounts    : v1,
        }
    }

    public fun contract_schema_version<T0>(arg0: &ArenaTunnel<T0>) : u16 {
        arg0.contract_schema_version
    }

    public fun create_and_share<T0>(arg0: u16, arg1: vector<u8>, arg2: u16, arg3: u16, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: vector<SeatDeclaration>, arg9: vector<RoleDeclaration>, arg10: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>, arg11: vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>, arg12: u8, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 1, 13906836330420502583);
        assert!(arg12 == 0 || arg12 == 1, 13906836347605483653);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906836356190699581);
        assert!(arg2 != 0, 13906836360485404729);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906836364780503099);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906836369075732543);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 13906836373370830913);
        assert!(arg7 > 0x2::clock::timestamp_ms(arg13), 13906836377665929283);
        validate_roles(&arg9);
        validate_outcome_authorization(&arg10, &arg8, &arg9);
        validate_outcome_authorization(&arg11, &arg8, &arg9);
        let v0 = 0x1::vector::length<SeatDeclaration>(&arg8);
        assert!(v0 >= 2 && v0 <= 65535, 13906836416317489171);
        let v1 = validate_declarations(&arg8);
        let v2 = encode_participant_set(arg0, &arg8);
        let v3 = encode_execution_manifest<T0>(arg0, &arg1, arg2, arg3, &arg4, &arg5, &arg6, arg7, &arg8, &arg9, &arg10, &arg11);
        let v4 = (v0 as u16);
        let v5 = vector[];
        let v6 = 0;
        while (v6 < v0) {
            0x1::vector::push_back<bool>(&mut v5, false);
            v6 = v6 + 1;
        };
        let v7 = OutcomeRecordPolicy{
            action_authorization : arg10,
            hand_authorization   : arg11,
            nonce                : 0,
            state_commitment     : arg6,
        };
        let v8 = TerminalState{
            state_commitment       : arg6,
            nonce                  : 0,
            timestamp              : 0,
            transcript_root        : x"0000000000000000000000000000000000000000000000000000000000000000",
            receipt_count          : 0,
            outcome_schema_version : 0,
            outcome                : b"",
            entitlements           : vector[],
        };
        let v9 = ArenaTunnel<T0>{
            id                               : 0x2::object::new(arg14),
            contract_schema_version          : 1,
            wire_version                     : arg0,
            execution_id                     : arg1,
            protocol_version                 : arg2,
            verification_policy_version      : arg3,
            protocol_id                      : arg4,
            product_manifest_digest          : arg5,
            execution_manifest_digest        : digest_execution_manifest(&v3),
            participant_set_digest           : digest_participant_set(&v2),
            initial_state_commitment         : arg6,
            nonce                            : 0,
            funding_deadline_ms              : arg7,
            seats                            : arg8,
            funded_seats                     : v5,
            roles                            : arg9,
            outcome_records                  : v7,
            participant_count                : v4,
            required_total                   : v1,
            funded_total                     : 0,
            funded_count                     : 0,
            escrow                           : 0x2::balance::zero<T0>(),
            status                           : 0,
            policy_declared                  : false,
            dispute_window_ms                : 86400000,
            referee_signature_type           : 0,
            referee_public_key               : b"",
            minimum_dispute_checkpoint_nonce : 0,
            dispute_started_ms               : 0,
            terminal                         : v8,
            admitted_evidence_class          : arg12,
        };
        let v10 = ArenaTunnelCreated{
            tunnel_id                 : 0x2::object::id<ArenaTunnel<T0>>(&v9),
            execution_id              : v9.execution_id,
            participant_set_digest    : v9.participant_set_digest,
            execution_manifest_digest : v9.execution_manifest_digest,
            participant_count         : v4,
            required_total            : v1,
            funding_deadline_ms       : arg7,
        };
        0x2::event::emit<ArenaTunnelCreated>(v10);
        0x2::transfer::share_object<ArenaTunnel<T0>>(v9);
    }

    public fun current_resolution_policy_digest<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        let v1 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::encode_resolution_policy(0x2::object::id_to_bytes(&v0), arg0.dispute_window_ms, arg0.referee_signature_type, &arg0.referee_public_key);
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_resolution_policy(&v1)
    }

    public fun declare_resolution_policy<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u64, arg2: u8, arg3: vector<u8>, arg4: vector<vector<u8>>) {
        assert!(!arg0.policy_declared, 13906837262430896221);
        assert!(arg0.status == 0, 13906837266724290629);
        assert!(arg0.funded_total == 0, 13906837288200831071);
        assert!(arg1 >= 3600000 && arg1 <= 2592000000, 13906837305380831329);
        if (0x1::vector::length<u8>(&arg3) > 0) {
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::is_valid_signature_type(arg2), 13906837318265864291);
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::is_valid_public_key_length(arg2, &arg3), 13906837331150766179);
        };
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        let v1 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::encode_resolution_policy(0x2::object::id_to_bytes(&v0), arg1, arg2, &arg3);
        let v2 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_resolution_policy(&v1);
        verify_every_seat<T0>(arg0, &v2, &arg4);
        arg0.dispute_window_ms = arg1;
        arg0.referee_signature_type = arg2;
        arg0.referee_public_key = arg3;
        arg0.policy_declared = true;
    }

    public fun declared_role_count<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        0x1::vector::length<RoleDeclaration>(&arg0.roles)
    }

    public fun declared_role_id<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : vector<u8> {
        0x1::vector::borrow<RoleDeclaration>(&arg0.roles, arg1).role_id
    }

    public fun declared_role_public_key<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : vector<u8> {
        0x1::vector::borrow<RoleDeclaration>(&arg0.roles, arg1).public_key
    }

    public fun declared_role_signature_type<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : u8 {
        0x1::vector::borrow<RoleDeclaration>(&arg0.roles, arg1).signature_type
    }

    public fun default_dispute_window_ms() : u64 {
        86400000
    }

    fun digest_execution_manifest(arg0: &vector<u8>) : vector<u8> {
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_framed(b"arena_tunnel::execution_manifest", arg0)
    }

    fun digest_participant_set(arg0: &vector<u8>) : vector<u8> {
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_framed(b"arena_tunnel::participant_set", arg0)
    }

    fun dispute_deadline_ms<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        if (arg0.dispute_started_ms > 18446744073709551615 - arg0.dispute_window_ms) {
            18446744073709551615
        } else {
            arg0.dispute_started_ms + arg0.dispute_window_ms
        }
    }

    public fun dispute_started_ms<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.dispute_started_ms
    }

    public fun dispute_window_ms<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.dispute_window_ms
    }

    public fun disputed_status() : u8 {
        2
    }

    fun emit_checkpoint_adopted<T0>(arg0: &ArenaTunnel<T0>, arg1: &0x2::clock::Clock) {
        let v0 = ArenaCheckpointAdopted{
            tunnel_id     : 0x2::object::id<ArenaTunnel<T0>>(arg0),
            nonce         : arg0.terminal.nonce,
            adopted_at_ms : 0x2::clock::timestamp_ms(arg1),
            deadline_ms   : dispute_deadline_ms<T0>(arg0),
        };
        0x2::event::emit<ArenaCheckpointAdopted>(v0);
    }

    fun emit_dispute_opened<T0>(arg0: &ArenaTunnel<T0>) {
        let v0 = ArenaDisputeOpened{
            tunnel_id    : 0x2::object::id<ArenaTunnel<T0>>(arg0),
            nonce        : arg0.terminal.nonce,
            opened_at_ms : arg0.dispute_started_ms,
        };
        0x2::event::emit<ArenaDisputeOpened>(v0);
    }

    fun encode_execution_manifest<T0>(arg0: u16, arg1: &vector<u8>, arg2: u16, arg3: u16, arg4: &vector<u8>, arg5: &vector<u8>, arg6: &vector<u8>, arg7: u64, arg8: &vector<SeatDeclaration>, arg9: &vector<RoleDeclaration>, arg10: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>, arg11: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>) : vector<u8> {
        let v0 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, *arg4);
        0x1::vector::append<u8>(&mut v0, *arg5);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        let v2 = *0x1::ascii::as_bytes(0x1::type_name::as_string(&v1));
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(0x1::vector::length<u8>(&v2)));
        0x1::vector::append<u8>(&mut v0, v2);
        0x1::vector::append<u8>(&mut v0, *arg6);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg7));
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<SeatDeclaration>(arg8) as u16)));
        let v3 = 0;
        while (v3 < 0x1::vector::length<SeatDeclaration>(arg8)) {
            let v4 = 0x1::vector::borrow<SeatDeclaration>(arg8, v3);
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(v4.seat));
            0x1::vector::append<u8>(&mut v0, v4.participant_id);
            0x1::vector::push_back<u8>(&mut v0, v4.signature_type);
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<u8>(&v4.participant_public_key) as u16)));
            0x1::vector::append<u8>(&mut v0, v4.participant_public_key);
            0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(v4.funding_source));
            0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(v4.beneficiary));
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(v4.required_deposit));
            v3 = v3 + 1;
        };
        let v5 = if (!0x1::vector::is_empty<RoleDeclaration>(arg9)) {
            true
        } else if (!0x1::vector::is_empty<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg10)) {
            true
        } else {
            !0x1::vector::is_empty<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg11)
        };
        if (v5) {
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(1));
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<RoleDeclaration>(arg9) as u16)));
            let v6 = 0;
            while (v6 < 0x1::vector::length<RoleDeclaration>(arg9)) {
                let v7 = 0x1::vector::borrow<RoleDeclaration>(arg9, v6);
                0x1::vector::append<u8>(&mut v0, v7.role_id);
                0x1::vector::push_back<u8>(&mut v0, v7.signature_type);
                0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<u8>(&v7.public_key) as u16)));
                0x1::vector::append<u8>(&mut v0, v7.public_key);
                v6 = v6 + 1;
            };
            let v8 = &mut v0;
            append_authorization_principals(v8, arg10);
            let v9 = &mut v0;
            append_authorization_principals(v9, arg11);
        };
        v0
    }

    fun encode_participant_set(arg0: u16, arg1: &vector<SeatDeclaration>) : vector<u8> {
        let v0 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<SeatDeclaration>(arg1) as u16)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(arg1)) {
            let v2 = 0x1::vector::borrow<SeatDeclaration>(arg1, v1);
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes(v2.seat));
            0x1::vector::append<u8>(&mut v0, v2.participant_id);
            0x1::vector::push_back<u8>(&mut v0, v2.signature_type);
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::u16_to_be_bytes((0x1::vector::length<u8>(&v2.participant_public_key) as u16)));
            0x1::vector::append<u8>(&mut v0, v2.participant_public_key);
            0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(v2.funding_source));
            0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(v2.beneficiary));
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(v2.required_deposit));
            v1 = v1 + 1;
        };
        v0
    }

    public fun escrow_value<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun evidence_class_local() : u8 {
        0
    }

    public fun evidence_class_nitro() : u8 {
        1
    }

    public fun execution_id<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        arg0.execution_id
    }

    public fun execution_manifest_digest<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        arg0.execution_manifest_digest
    }

    fun find_role_declaration<T0>(arg0: &ArenaTunnel<T0>, arg1: &vector<u8>) : RoleDeclaration {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RoleDeclaration>(&arg0.roles)) {
            let v1 = 0x1::vector::borrow<RoleDeclaration>(&arg0.roles, v0);
            if (v1.role_id == *arg1) {
                return *v1
            };
            v0 = v0 + 1;
        };
        abort 13906846367758680113
    }

    public fun find_role_public_key<T0>(arg0: &ArenaTunnel<T0>, arg1: &vector<u8>) : vector<u8> {
        let v0 = find_role_declaration<T0>(arg0, arg1);
        v0.public_key
    }

    public fun find_role_signature_type<T0>(arg0: &ArenaTunnel<T0>, arg1: &vector<u8>) : u8 {
        let v0 = find_role_declaration<T0>(arg0, arg1);
        v0.signature_type
    }

    fun find_seat_declaration<T0>(arg0: &ArenaTunnel<T0>, arg1: u16) : SeatDeclaration {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SeatDeclaration>(&arg0.seats)) {
            let v1 = 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v0);
            if (v1.seat == arg1) {
                return *v1
            };
            v0 = v0 + 1;
        };
        abort 13906846436479729737
    }

    public fun find_seat_public_key<T0>(arg0: &ArenaTunnel<T0>, arg1: u16) : vector<u8> {
        let v0 = find_seat_declaration<T0>(arg0, arg1);
        v0.participant_public_key
    }

    public fun find_seat_signature_type<T0>(arg0: &ArenaTunnel<T0>, arg1: u16) : u8 {
        let v0 = find_seat_declaration<T0>(arg0, arg1);
        v0.signature_type
    }

    public fun force_close_after_timeout<T0>(arg0: ArenaTunnel<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 13906839512995201139);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= dispute_deadline_ms<T0>(&arg0), 13906839521585266805);
        settle_escrow_and_publish_outcome<T0>(arg0, 1, v0, arg2);
    }

    public fun fund<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u16, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        fund_seat_from_balance<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun fund_seat_from_balance<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u16, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg2 == arg0.execution_manifest_digest, 13906841712016621655);
        assert!(arg3 == current_resolution_policy_digest<T0>(arg0), 13906841754966425689);
        assert!(arg4 == arg0.admitted_evidence_class, 13906841819391066203);
        assert!(arg0.status == 0, 13906841827979558981);
        assert!(0x2::clock::timestamp_ms(arg6) < arg0.funding_deadline_ms, 13906841832274657351);
        let v0 = seat_index<T0>(arg0, arg1);
        assert!(!*0x1::vector::borrow<bool>(&arg0.funded_seats, v0), 13906841845159821387);
        let v1 = 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v0);
        assert!(0x2::tx_context::sender(arg7) == v1.funding_source, 13906841853749887053);
        let v2 = 0x2::balance::value<T0>(&arg5);
        assert!(v2 == v1.required_deposit, 13906841862339952719);
        let v3 = validate_and_project_funding<T0>(arg0, v0, v2);
        0x2::balance::join<T0>(&mut arg0.escrow, arg5);
        *0x1::vector::borrow_mut<bool>(&mut arg0.funded_seats, v0) = true;
        arg0.funded_count = v3.projected_funded_count;
        arg0.funded_total = v3.projected_funded_total;
        let v4 = ArenaSeatFunded{
            tunnel_id      : 0x2::object::id<ArenaTunnel<T0>>(arg0),
            seat           : arg1,
            funding_source : v1.funding_source,
            amount         : v2,
            funded_count   : arg0.funded_count,
            funded_total   : arg0.funded_total,
        };
        0x2::event::emit<ArenaSeatFunded>(v4);
        if (v3.activates) {
            arg0.status = 1;
            let v5 = vector[];
            let v6 = 0;
            while (v6 < 0x1::vector::length<SeatDeclaration>(&arg0.seats)) {
                0x1::vector::push_back<u64>(&mut v5, 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v6).required_deposit);
                v6 = v6 + 1;
            };
            arg0.terminal.entitlements = v5;
            arg0.terminal.timestamp = 0x2::clock::timestamp_ms(arg6);
            let v7 = ArenaTunnelActivated{
                tunnel_id                 : 0x2::object::id<ArenaTunnel<T0>>(arg0),
                execution_id              : arg0.execution_id,
                execution_manifest_digest : arg0.execution_manifest_digest,
                participant_set_digest    : arg0.participant_set_digest,
                total_custody             : v3.projected_escrow_value,
                nonce                     : arg0.nonce,
                initial_state_commitment  : arg0.initial_state_commitment,
                activated_at_ms           : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<ArenaTunnelActivated>(v7);
        };
    }

    public fun fund_with_coin<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u16, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        fund_seat_from_balance<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), arg6, arg7);
    }

    public fun funded_count<T0>(arg0: &ArenaTunnel<T0>) : u16 {
        arg0.funded_count
    }

    public fun funded_total<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.funded_total
    }

    public fun funding_deadline_ms<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.funding_deadline_ms
    }

    public(friend) fun hand_authorization<T0>(arg0: &ArenaTunnel<T0>) : &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal> {
        &arg0.outcome_records.hand_authorization
    }

    public fun has_referee<T0>(arg0: &ArenaTunnel<T0>) : bool {
        0x1::vector::length<u8>(&arg0.referee_public_key) > 0
    }

    public fun initial_state_commitment<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        arg0.initial_state_commitment
    }

    fun is_declared_stakeholder<T0>(arg0: &ArenaTunnel<T0>, arg1: address) : bool {
        let v0 = &arg0.seats;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<SeatDeclaration>(v0)) {
            let v3 = 0x1::vector::borrow<SeatDeclaration>(v0, v1);
            if (v3.funding_source == arg1 || v3.beneficiary == arg1) {
                v2 = true;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = false;
        v2
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

    public fun live_status() : u8 {
        1
    }

    public fun minimum_dispute_checkpoint_nonce<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.minimum_dispute_checkpoint_nonce
    }

    public fun open_dispute_from_committed_state<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u16, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 13906838203030438007);
        if (!is_declared_stakeholder<T0>(arg0, 0x2::tx_context::sender(arg4))) {
            let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
            let v1 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::encode_dispute_opening(0x2::object::id_to_bytes(&v0), arg0.terminal.nonce);
            let v2 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_dispute_opening(&v1);
            let v3 = 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, seat_index<T0>(arg0, arg1));
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::verify(v3.signature_type, &v3.participant_public_key, &v2, &arg2), 13906838288928735335);
        };
        arg0.status = 2;
        start_dispute_clock<T0>(arg0, arg3);
        emit_dispute_opened<T0>(arg0);
    }

    public fun open_dispute_with_checkpoint<T0>(arg0: &mut ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock) {
        assert!(arg0.status == 1, 13906838546627821687);
        assert!(arg2 >= arg0.minimum_dispute_checkpoint_nonce, 13906838550922264687);
        adopt_checkpoint<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        arg0.status = 2;
        arg0.minimum_dispute_checkpoint_nonce = arg2 + 1;
        start_dispute_clock<T0>(arg0, arg10);
        emit_dispute_opened<T0>(arg0);
    }

    public fun participant_count<T0>(arg0: &ArenaTunnel<T0>) : u16 {
        arg0.participant_count
    }

    public fun participant_set_digest<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        arg0.participant_set_digest
    }

    fun payout_returns_to_funders(arg0: u8, arg1: u64) : bool {
        arg0 == 1 && arg1 == 0 || arg0 == 3
    }

    public fun pending_funding_status() : u8 {
        0
    }

    public fun policy_declared<T0>(arg0: &ArenaTunnel<T0>) : bool {
        arg0.policy_declared
    }

    public fun product_manifest_digest<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        arg0.product_manifest_digest
    }

    public fun protocol_id<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        arg0.protocol_id
    }

    public fun protocol_version<T0>(arg0: &ArenaTunnel<T0>) : u16 {
        arg0.protocol_version
    }

    public fun record_disposition(arg0: &SettledOutcomeRecord) : u8 {
        arg0.disposition
    }

    public fun record_entitlements(arg0: &SettledOutcomeRecord) : vector<u64> {
        arg0.entitlements
    }

    public fun record_evidence_class(arg0: &SettledOutcomeRecord) : u8 {
        arg0.evidence_class
    }

    public fun record_execution_id(arg0: &SettledOutcomeRecord) : vector<u8> {
        arg0.execution_id
    }

    public fun record_execution_manifest_digest(arg0: &SettledOutcomeRecord) : vector<u8> {
        arg0.execution_manifest_digest
    }

    public(friend) fun record_index_uid<T0>(arg0: &mut ArenaTunnel<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun record_outcome(arg0: &SettledOutcomeRecord) : vector<u8> {
        arg0.outcome
    }

    public fun record_outcome_schema_version(arg0: &SettledOutcomeRecord) : u16 {
        arg0.outcome_schema_version
    }

    public fun record_participant_set_digest(arg0: &SettledOutcomeRecord) : vector<u8> {
        arg0.participant_set_digest
    }

    public fun record_product_manifest_digest(arg0: &SettledOutcomeRecord) : vector<u8> {
        arg0.product_manifest_digest
    }

    public fun record_protocol_id(arg0: &SettledOutcomeRecord) : vector<u8> {
        arg0.protocol_id
    }

    public fun record_protocol_version(arg0: &SettledOutcomeRecord) : u16 {
        arg0.protocol_version
    }

    public fun record_receipt_count(arg0: &SettledOutcomeRecord) : u64 {
        arg0.receipt_count
    }

    public fun record_resolution_policy_digest(arg0: &SettledOutcomeRecord) : vector<u8> {
        arg0.resolution_policy_digest
    }

    public fun record_schema_version(arg0: &SettledOutcomeRecord) : u16 {
        arg0.schema_version
    }

    public fun record_settled_at_ms(arg0: &SettledOutcomeRecord) : u64 {
        arg0.settled_at_ms
    }

    public fun record_terminal_nonce(arg0: &SettledOutcomeRecord) : u64 {
        arg0.terminal_nonce
    }

    public fun record_terminal_state_commitment(arg0: &SettledOutcomeRecord) : vector<u8> {
        arg0.terminal_state_commitment
    }

    public fun record_terminal_timestamp(arg0: &SettledOutcomeRecord) : u64 {
        arg0.terminal_timestamp
    }

    public fun record_total_settled(arg0: &SettledOutcomeRecord) : u64 {
        arg0.total_settled
    }

    public fun record_transcript_root(arg0: &SettledOutcomeRecord) : vector<u8> {
        arg0.transcript_root
    }

    public fun record_tunnel_id(arg0: &SettledOutcomeRecord) : 0x2::object::ID {
        arg0.tunnel_id
    }

    public fun record_verification_policy_version(arg0: &SettledOutcomeRecord) : u16 {
        arg0.verification_policy_version
    }

    public fun referee_public_key<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        arg0.referee_public_key
    }

    public fun referee_signature_type<T0>(arg0: &ArenaTunnel<T0>) : u8 {
        arg0.referee_signature_type
    }

    public fun required_total<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.required_total
    }

    public fun role_declaration(arg0: vector<u8>, arg1: u8, arg2: vector<u8>) : RoleDeclaration {
        RoleDeclaration{
            role_id        : arg0,
            signature_type : arg1,
            public_key     : arg2,
        }
    }

    public fun role_tag_referee() : vector<u8> {
        b"dopan180/role/referee-v1"
    }

    public fun role_tag_referee_nitro() : vector<u8> {
        b"dopan180/authority-referee-v1"
    }

    public fun role_tag_seat() : vector<u8> {
        b"dopan180/role/seat-v1"
    }

    public fun role_tag_seat_nitro() : vector<u8> {
        b"dopan180/party-seat-v1"
    }

    public fun seat_beneficiary<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : address {
        0x1::vector::borrow<SeatDeclaration>(&arg0.seats, arg1).beneficiary
    }

    public fun seat_declaration(arg0: u16, arg1: vector<u8>, arg2: u8, arg3: vector<u8>, arg4: address, arg5: address, arg6: u64) : SeatDeclaration {
        SeatDeclaration{
            seat                   : arg0,
            participant_id         : arg1,
            signature_type         : arg2,
            participant_public_key : arg3,
            funding_source         : arg4,
            beneficiary            : arg5,
            required_deposit       : arg6,
        }
    }

    public fun seat_funded<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : bool {
        *0x1::vector::borrow<bool>(&arg0.funded_seats, arg1)
    }

    public fun seat_funding_source<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : address {
        0x1::vector::borrow<SeatDeclaration>(&arg0.seats, arg1).funding_source
    }

    public fun seat_id<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : u16 {
        0x1::vector::borrow<SeatDeclaration>(&arg0.seats, arg1).seat
    }

    fun seat_index<T0>(arg0: &ArenaTunnel<T0>, arg1: u16) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SeatDeclaration>(&arg0.seats)) {
            if (0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v0).seat == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 13906842072792957001
    }

    public fun seat_participant_id<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : vector<u8> {
        0x1::vector::borrow<SeatDeclaration>(&arg0.seats, arg1).participant_id
    }

    public fun seat_participant_public_key<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : vector<u8> {
        0x1::vector::borrow<SeatDeclaration>(&arg0.seats, arg1).participant_public_key
    }

    public fun seat_required_deposit<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<SeatDeclaration>(&arg0.seats, arg1).required_deposit
    }

    public fun seat_signature_type<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : u8 {
        0x1::vector::borrow<SeatDeclaration>(&arg0.seats, arg1).signature_type
    }

    public fun settle_by_referee<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<u8>, arg10: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::AttestationRegistry<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::NitroEvidence>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_admitted_evidence_class<T0>(&arg0, 1);
        assert!(arg0.status == 2, 13906839697678794867);
        assert!(0x1::vector::length<u8>(&arg0.referee_public_key) > 0, 13906839701974286459);
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(v0 >= dispute_deadline_ms<T0>(&arg0), 13906839710563827829);
        assert_settlement_admissible<T0>(&arg0, &arg1, arg2, &arg4, arg6, &arg7, &arg8);
        let v1 = terminal_payload<T0>(&arg0, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, &arg8);
        let v2 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_referee_disposition(&v1);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::verify(arg0.referee_signature_type, &arg0.referee_public_key, &v2, &arg9), 13906839843708076153);
        assert_referee_signer_registered_nitro<T0>(&arg0, arg10, v0);
        commit_terminal_and_pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 2, v0, arg12);
    }

    public fun settle_by_referee_local<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<u8>, arg10: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::AttestationRegistry<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::LocalEvidence>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_admitted_evidence_class<T0>(&arg0, 0);
        assert!(arg0.status == 2, 13906840006916440179);
        assert!(0x1::vector::length<u8>(&arg0.referee_public_key) > 0, 13906840011211931771);
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(v0 >= dispute_deadline_ms<T0>(&arg0), 13906840019801473141);
        assert_settlement_admissible<T0>(&arg0, &arg1, arg2, &arg4, arg6, &arg7, &arg8);
        let v1 = terminal_payload<T0>(&arg0, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, &arg8);
        let v2 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_referee_disposition(&v1);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::verify(arg0.referee_signature_type, &arg0.referee_public_key, &v2, &arg9), 13906840152945721465);
        assert_referee_signer_registered_local<T0>(&arg0, arg10, v0);
        commit_terminal_and_pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 2, v0, arg12);
    }

    public fun settle_cooperative<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::AttestationRegistry<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::NitroEvidence>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_admitted_evidence_class<T0>(&arg0, 1);
        assert!(arg0.status == 1 || arg0.status == 2, 13906837502950113389);
        assert_settlement_admissible<T0>(&arg0, &arg1, arg2, &arg4, arg6, &arg7, &arg8);
        let v0 = terminal_payload<T0>(&arg0, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, &arg8);
        let v1 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_settlement(&v0);
        verify_every_seat<T0>(&arg0, &v1, &arg9);
        let v2 = 0x2::clock::timestamp_ms(arg11);
        assert_cooperative_signers_registered_nitro<T0>(&arg0, arg10, v2);
        commit_terminal_and_pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, v2, arg12);
    }

    public fun settle_cooperative_local<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::AttestationRegistry<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::attestation_registry::LocalEvidence>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_admitted_evidence_class<T0>(&arg0, 0);
        assert!(arg0.status == 1 || arg0.status == 2, 13906837777828020333);
        assert_settlement_admissible<T0>(&arg0, &arg1, arg2, &arg4, arg6, &arg7, &arg8);
        let v0 = terminal_payload<T0>(&arg0, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, &arg8);
        let v1 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_settlement(&v0);
        verify_every_seat<T0>(&arg0, &v1, &arg9);
        let v2 = 0x2::clock::timestamp_ms(arg11);
        assert_cooperative_signers_registered_local<T0>(&arg0, arg10, v2);
        commit_terminal_and_pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, v2, arg12);
    }

    fun settle_escrow_and_publish_outcome<T0>(arg0: ArenaTunnel<T0>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 3) {
            let v0 = vector[];
            let v1 = 0;
            while (v1 < 0x1::vector::length<SeatDeclaration>(&arg0.seats)) {
                0x1::vector::push_back<u64>(&mut v0, 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v1).required_deposit);
                v1 = v1 + 1;
            };
            arg0.terminal.entitlements = v0;
            arg0.terminal.outcome_schema_version = 0;
            arg0.terminal.outcome = b"";
        };
        let v2 = arg0.terminal.entitlements;
        let v3 = compute_payout_plan(&arg0.seats, &v2, payout_returns_to_funders(arg1, arg0.terminal.nonce));
        assert_conserves(&v3.amounts, 0x2::balance::value<T0>(&arg0.escrow));
        let v4 = 0x2::object::id<ArenaTunnel<T0>>(&arg0);
        let v5 = arg0.terminal;
        let ArenaTunnel {
            id                               : v6,
            contract_schema_version          : _,
            wire_version                     : _,
            execution_id                     : _,
            protocol_version                 : _,
            verification_policy_version      : _,
            protocol_id                      : _,
            product_manifest_digest          : _,
            execution_manifest_digest        : _,
            participant_set_digest           : _,
            initial_state_commitment         : _,
            nonce                            : _,
            funding_deadline_ms              : _,
            seats                            : _,
            funded_seats                     : _,
            roles                            : _,
            outcome_records                  : _,
            participant_count                : _,
            required_total                   : _,
            funded_total                     : _,
            funded_count                     : _,
            escrow                           : v27,
            status                           : _,
            policy_declared                  : _,
            dispute_window_ms                : _,
            referee_signature_type           : _,
            referee_public_key               : _,
            minimum_dispute_checkpoint_nonce : _,
            dispute_started_ms               : _,
            terminal                         : _,
            admitted_evidence_class          : _,
        } = arg0;
        let v37 = v27;
        let v38 = 0x2::balance::value<T0>(&v37);
        let v39 = 0;
        while (v39 < 0x1::vector::length<address>(&v3.recipients)) {
            let v40 = *0x1::vector::borrow<u64>(&v3.amounts, v39);
            if (v40 > 0) {
                0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut v37, v40), *0x1::vector::borrow<address>(&v3.recipients, v39));
            };
            v39 = v39 + 1;
        };
        assert!(0x2::balance::value<T0>(&v37) == 0, 13906841067772706921);
        0x2::balance::destroy_zero<T0>(v37);
        0x2::object::delete(v6);
        let v41 = SettledOutcomeRecord{
            id                          : 0x2::object::new(arg3),
            schema_version              : 2,
            tunnel_id                   : v4,
            execution_id                : arg0.execution_id,
            execution_manifest_digest   : arg0.execution_manifest_digest,
            participant_set_digest      : arg0.participant_set_digest,
            protocol_version            : arg0.protocol_version,
            protocol_id                 : arg0.protocol_id,
            verification_policy_version : arg0.verification_policy_version,
            product_manifest_digest     : arg0.product_manifest_digest,
            resolution_policy_digest    : current_resolution_policy_digest<T0>(&arg0),
            disposition                 : arg1,
            terminal_nonce              : v5.nonce,
            terminal_timestamp          : v5.timestamp,
            terminal_state_commitment   : v5.state_commitment,
            transcript_root             : v5.transcript_root,
            receipt_count               : v5.receipt_count,
            outcome_schema_version      : v5.outcome_schema_version,
            outcome                     : v5.outcome,
            entitlements                : v2,
            total_settled               : v38,
            settled_at_ms               : arg2,
            evidence_class              : arg0.admitted_evidence_class,
        };
        let v42 = ArenaTunnelSettled{
            tunnel_id     : v4,
            record_id     : 0x2::object::id<SettledOutcomeRecord>(&v41),
            disposition   : arg1,
            total_settled : v38,
            settled_at_ms : arg2,
        };
        0x2::event::emit<ArenaTunnelSettled>(v42);
        0x2::transfer::freeze_object<SettledOutcomeRecord>(v41);
    }

    public fun settled_outcome_record_schema_version() : u16 {
        2
    }

    fun start_dispute_clock<T0>(arg0: &mut ArenaTunnel<T0>, arg1: &0x2::clock::Clock) {
        if (arg0.dispute_started_ms == 0) {
            arg0.dispute_started_ms = 0x2::clock::timestamp_ms(arg1);
        };
    }

    public fun status<T0>(arg0: &ArenaTunnel<T0>) : u8 {
        arg0.status
    }

    public fun terminal_entitlement<T0>(arg0: &ArenaTunnel<T0>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.terminal.entitlements, arg1)
    }

    public fun terminal_entitlement_total<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.terminal.entitlements)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0.terminal.entitlements, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun terminal_nonce<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.terminal.nonce
    }

    public fun terminal_outcome<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        arg0.terminal.outcome
    }

    public fun terminal_outcome_schema_version<T0>(arg0: &ArenaTunnel<T0>) : u16 {
        arg0.terminal.outcome_schema_version
    }

    fun terminal_payload<T0>(arg0: &ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: &vector<u64>, arg8: &vector<u8>) : vector<u8> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(&arg0.seats)) {
            0x1::vector::push_back<u16>(&mut v0, 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v1).seat);
            v1 = v1 + 1;
        };
        let v2 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::encode_terminal_state(0x2::object::id_to_bytes(&v2), arg1, arg2, arg3, arg4, arg5, arg6, &v0, arg7, arg8)
    }

    public fun terminal_state_timestamp<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.terminal.timestamp
    }

    fun validate_activation_projection<T0>(arg0: &ArenaTunnel<T0>, arg1: u64, arg2: u16, arg3: u64, arg4: u64) {
        assert!(arg2 == arg0.participant_count, 13906842334786486353);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(&arg0.seats)) {
            assert!(v1 == arg1 || *0x1::vector::borrow<bool>(&arg0.funded_seats, v1), 13906842364851257425);
            v0 = v0 + 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v1).required_deposit;
            v1 = v1 + 1;
        };
        assert!(v0 == arg0.required_total, 13906842386326093905);
        assert!(arg3 == arg0.required_total, 13906842390621061201);
        assert!(arg4 == arg0.required_total, 13906842394916028497);
        assert!(arg4 == arg3, 13906842399210995793);
    }

    fun validate_and_project_funding<T0>(arg0: &ArenaTunnel<T0>, arg1: u64, arg2: u64) : FundingProjection {
        let v0 = 0x1::vector::length<SeatDeclaration>(&arg0.seats);
        assert!(v0 == 0x1::vector::length<bool>(&arg0.funded_seats), 13906842111448186961);
        assert!(v0 == (arg0.participant_count as u64), 13906842115743154257);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            if (*0x1::vector::borrow<bool>(&arg0.funded_seats, v3)) {
                v1 = v1 + 1;
                v2 = v2 + 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v3).required_deposit;
            };
            v3 = v3 + 1;
        };
        assert!(v1 == (arg0.funded_count as u64), 13906842171577729105);
        assert!(v2 == arg0.funded_total, 13906842175872696401);
        assert!(0x2::balance::value<T0>(&arg0.escrow) == arg0.funded_total, 13906842180167663697);
        let v4 = arg0.funded_count + 1;
        let v5 = arg0.funded_total + arg2;
        let v6 = 0x2::balance::value<T0>(&arg0.escrow) + arg2;
        assert!(v4 <= arg0.participant_count, 13906842201642500177);
        assert!(v5 <= arg0.required_total, 13906842205937467473);
        assert!(v6 == v5, 13906842210232434769);
        let v7 = v4 == arg0.participant_count;
        if (v7) {
            validate_activation_projection<T0>(arg0, arg1, v4, v5, v6);
        };
        FundingProjection{
            projected_funded_count : v4,
            projected_funded_total : v5,
            projected_escrow_value : v6,
            activates              : v7,
        }
    }

    fun validate_declarations(arg0: &vector<SeatDeclaration>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(arg0)) {
            let v2 = 0x1::vector::borrow<SeatDeclaration>(arg0, v1);
            assert!(0x1::vector::length<u8>(&v2.participant_id) == 32, 13906844787209142297);
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::is_valid_signature_type(v2.signature_type), 13906844791504240667);
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::is_valid_public_key_length(v2.signature_type, &v2.participant_public_key), 13906844817274175517);
            assert!(v2.required_deposit != 0, 13906844825865551923);
            assert!(v0 <= 18446744073709551615 - v2.required_deposit, 13906844830160650293);
            if (v1 != 0) {
                assert!(0x1::vector::borrow<SeatDeclaration>(arg0, v1 - 1).seat < v2.seat, 13906844843043454997);
            };
            let v3 = 0;
            while (v3 < v1) {
                assert!(0x1::vector::borrow<SeatDeclaration>(arg0, v3).participant_id != v2.participant_id, 13906844873108357143);
                v3 = v3 + 1;
            };
            v0 = v0 + v2.required_deposit;
            v1 = v1 + 1;
        };
        v0
    }

    fun validate_outcome_authorization(arg0: &vector<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>, arg1: &vector<SeatDeclaration>, arg2: &vector<RoleDeclaration>) {
        if (0x1::vector::is_empty<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0)) {
            return
        };
        assert!(0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0) >= 2, 13906844568166596645);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0)) {
            if (v0 != 0) {
                assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_is_less(0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0, v0 - 1), 0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0, v0)), 13906844593936531495);
            };
            let v1 = 0x1::vector::borrow<0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::Principal>(arg0, v0);
            let v2 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_tag(v1);
            assert!(v2 == 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::seat_principal_tag() || v2 == 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::role_principal_tag(), 13906844628296532011);
            if (v2 == 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::seat_principal_tag()) {
                let v3 = 0;
                let v4;
                while (v3 < 0x1::vector::length<SeatDeclaration>(arg1)) {
                    if (0x1::vector::borrow<SeatDeclaration>(arg1, v3).seat == 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_seat(v1)) {
                        v4 = true;
                        /* label 24 */
                        /* label 25 */
                        assert!(v4, 13906844666951106601);
                        v0 = v0 + 1;
                        /* goto 7 */
                        continue
                    };
                    v3 = v3 + 1;
                };
                v4 = false;
                /* goto 24 */
            } else {
                let v5 = 0;
                let v6;
                while (v5 < 0x1::vector::length<RoleDeclaration>(arg2)) {
                    if (0x1::vector::borrow<RoleDeclaration>(arg2, v5).role_id == 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::receipt_wire::principal_role(v1)) {
                        v6 = true;
                        /* label 35 */
                        /* goto 25 */
                    } else {
                        v5 = v5 + 1;
                    };
                };
                v6 = false;
                /* goto 35 */
            };
        };
    }

    fun validate_roles(arg0: &vector<RoleDeclaration>) {
        assert!(0x1::vector::length<RoleDeclaration>(arg0) <= 64, 13906844452202348579);
        let v0 = 0;
        while (v0 < 0x1::vector::length<RoleDeclaration>(arg0)) {
            let v1 = 0x1::vector::borrow<RoleDeclaration>(arg0, v0);
            assert!(0x1::vector::length<u8>(&v1.role_id) == 32, 13906844473676922911);
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::is_valid_signature_type(v1.signature_type), 13906844477971628059);
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::is_valid_public_key_length(v1.signature_type, &v1.public_key), 13906844490856923169);
            if (v0 != 0) {
                assert!(is_lexicographically_less(&0x1::vector::borrow<RoleDeclaration>(arg0, v0 - 1).role_id, &v1.role_id), 13906844512332677167);
            };
            v0 = v0 + 1;
        };
    }

    public fun verification_policy_version<T0>(arg0: &ArenaTunnel<T0>) : u16 {
        arg0.verification_policy_version
    }

    fun verify_every_seat<T0>(arg0: &ArenaTunnel<T0>, arg1: &vector<u8>, arg2: &vector<vector<u8>>) {
        assert!(0x1::vector::length<vector<u8>>(arg2) == 0x1::vector::length<SeatDeclaration>(&arg0.seats), 13906841282520809573);
        let v0 = 0;
        while (v0 < 0x1::vector::length<SeatDeclaration>(&arg0.seats)) {
            let v1 = 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v0);
            assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::verify(v1.signature_type, &v1.participant_public_key, arg1, 0x1::vector::borrow<vector<u8>>(arg2, v0)), 13906841325470613607);
            v0 = v0 + 1;
        };
    }

    public fun void_by_referee<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 13906840363398725747);
        assert!(0x1::vector::length<u8>(&arg0.referee_public_key) > 0, 13906840367694217339);
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(&arg0);
        let v1 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::encode_void_disposition(0x2::object::id_to_bytes(&v0));
        let v2 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire::digest_void_disposition(&v1);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::verify(arg0.referee_signature_type, &arg0.referee_public_key, &v2, &arg1), 13906840410644021373);
        settle_escrow_and_publish_outcome<T0>(arg0, 3, 0x2::clock::timestamp_ms(arg2), arg3);
    }

    public fun wire_version<T0>(arg0: &ArenaTunnel<T0>) : u16 {
        arg0.wire_version
    }

    // decompiled from Move bytecode v7
}

