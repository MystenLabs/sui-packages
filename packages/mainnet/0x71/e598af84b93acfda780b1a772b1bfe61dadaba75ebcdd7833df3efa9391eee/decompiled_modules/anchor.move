module 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::anchor {
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
        action_authorization: vector<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>,
        hand_authorization: vector<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>,
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

    struct TunnelControl has copy, drop, store {
        module_version: u64,
        paused: bool,
        paused_at_ms: u64,
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
        control: TunnelControl,
    }

    struct TunnelState<phantom T0> has store {
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

    struct TunnelModuleVersionMigrated has copy, drop {
        tunnel_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct TunnelPauseChanged has copy, drop {
        tunnel_id: 0x2::object::ID,
        paused: bool,
        held_ms: u64,
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

    struct AdoptionMarker has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun action_authorization<T0>(arg0: &ArenaTunnel<T0>) : &vector<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal> {
        &arg0.outcome_records.action_authorization
    }

    public fun activation_nonce<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.nonce
    }

    public fun admitted_evidence_class<T0>(arg0: &ArenaTunnel<T0>) : u8 {
        arg0.admitted_evidence_class
    }

    fun adopt_checkpoint<T0>(arg0: 0x2::object::ID, arg1: &mut ArenaTunnel<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u16, arg8: vector<u64>, arg9: vector<u8>, arg10: vector<vector<u8>>) {
        assert_checkpoint_admissible<T0>(arg1, &arg2, arg3, &arg5, arg7, &arg8, &arg9);
        let v0 = terminal_payload_with_identity(arg0, &arg1.seats, arg2, arg3, arg4, arg5, arg6, arg7, &arg8, &arg9);
        let v1 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_checkpoint(&v0);
        verify_every_seat(&arg1.seats, &v1, &arg10);
        commit_checkpoint<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun adopt_disputed_checkpoint<T0>(arg0: &mut ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock) {
        assert_writable<T0>(arg0);
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        assert_standard_profile(arg0.verification_policy_version);
        adopt_disputed_checkpoint_inner<T0>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun adopt_disputed_checkpoint_inner<T0>(arg0: 0x2::object::ID, arg1: &mut ArenaTunnel<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u16, arg8: vector<u64>, arg9: vector<u8>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock) {
        assert!(arg1.status == 2, 13906844383488180340);
        adopt_checkpoint<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        emit_checkpoint_adopted<T0>(arg0, arg1, arg11);
    }

    public fun adopt_disputed_checkpoint_recovery<T0>(arg0: &mut ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: &0x2::clock::Clock) {
        assert_writable<T0>(arg0);
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        let v1 = terminal_payload_with_identity(v0, &arg0.seats, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, &arg8);
        verify_recovery_gate_with_identity(v0, &arg0.id, &arg0.execution_id, arg0.verification_policy_version, arg10, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::operation_adopt_disputed_checkpoint(), arg11, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_checkpoint(&v1), arg12, arg13);
        adopt_disputed_checkpoint_inner<T0>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg14);
    }

    public fun adopt_recovery_ownership<T0>(arg0: &mut ArenaTunnel<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_writable<T0>(arg0);
        assert!(is_recovery_profile<T0>(arg0), 13906839551651545228);
        assert!(arg0.status == 0, 13906839555941924934);
        assert!(!has_adopted_ownership<T0>(arg0), 13906839581716578448);
        assert!(arg0.funded_total == 0, 13906839620371153038);
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        let v1 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::encode_recovery_adoption(0x2::object::id_to_bytes(&v0), arg1, arg2, arg3);
        let v2 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::digest_recovery_adoption(&v1);
        verify_every_seat(&arg0.seats, &v2, &arg4);
        let v3 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::create(arg0.execution_id, v0, current_resolution_policy_digest<T0>(arg0), arg1, arg2, arg3, arg5);
        let v4 = 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership>(&v3);
        record_adopted_ownership<T0>(arg0, v4);
        0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::share(v3);
        v4
    }

    public fun adopted_ownership<T0>(arg0: &ArenaTunnel<T0>) : 0x1::option::Option<0x2::object::ID> {
        if (has_adopted_ownership<T0>(arg0)) {
            let v1 = AdoptionMarker{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<AdoptionMarker, 0x2::object::ID>(&arg0.id, v1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public(friend) fun advance_outcome_record_state<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u64, arg2: vector<u8>) {
        arg0.outcome_records.nonce = arg1;
        arg0.outcome_records.state_commitment = arg2;
    }

    public fun anchor_domain() : vector<u8> {
        0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::anchor_context_id()
    }

    fun append_authorization_principals(arg0: &mut vector<u8>, arg1: &vector<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>) {
        0x1::vector::append<u8>(arg0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes((0x1::vector::length<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>(arg1) as u16)));
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>(arg1)) {
            let v1 = 0x1::vector::borrow<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>(arg1, v0);
            0x1::vector::push_back<u8>(arg0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::principal_tag(v1));
            if (0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::principal_tag(v1) == 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::seat_principal_tag()) {
                0x1::vector::append<u8>(arg0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::principal_seat(v1)));
            } else {
                0x1::vector::append<u8>(arg0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::principal_role(v1));
            };
            v0 = v0 + 1;
        };
    }

    fun assert_admitted_evidence_class(arg0: u8, arg1: u8) {
        assert!(arg0 == arg1, 13906850387853770888);
    }

    fun assert_admitted_version<T0>(arg0: &ArenaTunnel<T0>) {
        assert!(is_admitted_version<T0>(arg0), 13906836261707514010);
    }

    fun assert_checkpoint_admissible<T0>(arg0: &ArenaTunnel<T0>, arg1: &vector<u8>, arg2: u64, arg3: &vector<u8>, arg4: u16, arg5: &vector<u64>, arg6: &vector<u8>) {
        assert_terminal_state_shape(0x1::vector::length<SeatDeclaration>(&arg0.seats), 0x2::balance::value<T0>(&arg0.escrow), arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(arg2 > arg0.terminal.nonce, 13906844894589026416);
    }

    fun assert_conserves(arg0: &vector<u64>, arg1: u64) {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            let v2 = *0x1::vector::borrow<u64>(arg0, v1);
            assert!(v2 <= v0, 13906847664842539114);
            v0 = v0 - v2;
            v1 = v1 + 1;
        };
        assert!(v0 == 0, 13906847677727441002);
    }

    fun assert_cooperative_signers_registered_local(arg0: &vector<SeatDeclaration>, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg2: u64) {
        let v0 = b"dopan180/role/seat-v1";
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(arg0)) {
            assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_local_registration(arg1, &0x1::vector::borrow<SeatDeclaration>(arg0, v1).participant_public_key, &v0, arg2), 13906848519542734980);
            v1 = v1 + 1;
        };
    }

    fun assert_cooperative_signers_registered_nitro(arg0: &vector<SeatDeclaration>, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg2: u64) {
        let v0 = b"dopan180/party-seat-v1";
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(arg0)) {
            assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_nitro_registration(arg1, &0x1::vector::borrow<SeatDeclaration>(arg0, v1).participant_public_key, &v0, arg2), 13906848455118225540);
            v1 = v1 + 1;
        };
    }

    public(friend) fun assert_outcome_record_predecessor<T0>(arg0: &ArenaTunnel<T0>, arg1: u64, arg2: &vector<u8>) {
        assert!(arg0.outcome_records.nonce == arg1 && arg0.outcome_records.state_commitment == *arg2, 13906853630548181038);
    }

    fun assert_referee_signer_registered_local(arg0: &vector<u8>, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg2: u64) {
        let v0 = b"dopan180/role/referee-v1";
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_local_registration(arg1, arg0, &v0, arg2), 13906848674161557636);
    }

    fun assert_referee_signer_registered_nitro(arg0: &vector<u8>, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg2: u64) {
        let v0 = b"dopan180/authority-referee-v1";
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_nitro_registration(arg1, arg0, &v0, arg2), 13906848601147113604);
    }

    fun assert_settlement_admissible(arg0: u64, arg1: u64, arg2: u64, arg3: &vector<u8>, arg4: u64, arg5: &vector<u8>, arg6: u16, arg7: &vector<u64>, arg8: &vector<u8>) {
        assert_terminal_state_shape(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8);
        assert!(arg4 >= arg2, 13906845019143078000);
    }

    public(friend) fun assert_standard_profile(arg0: u16) {
        assert!(arg0 != 2, 13906838894521417866);
    }

    fun assert_terminal_state_shape(arg0: u64, arg1: u64, arg2: &vector<u8>, arg3: u64, arg4: &vector<u8>, arg5: u16, arg6: &vector<u64>, arg7: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg2) == 32, 13906844752852090946);
        assert!(0x1::vector::length<u8>(arg4) == 32, 13906844757147058242);
        assert!(arg3 < 18446744073709551615, 13906844765740138610);
        assert!(0x1::vector::length<u64>(arg6) == arg0, 13906844770034712684);
        assert!(0x1::vector::length<u8>(arg7) <= 4096, 13906844782920925312);
        assert!(arg5 == 0 == 0x1::vector::is_empty<u8>(arg7), 13906844787216023682);
        assert_conserves(arg6, arg1);
    }

    public(friend) fun assert_tunnel_standard_profile<T0>(arg0: &ArenaTunnel<T0>) {
        assert_standard_profile(arg0.verification_policy_version);
    }

    public(friend) fun assert_tunnel_writable<T0>(arg0: &ArenaTunnel<T0>) {
        assert_writable<T0>(arg0);
    }

    fun assert_writable<T0>(arg0: &ArenaTunnel<T0>) {
        assert_admitted_version<T0>(arg0);
        assert!(!arg0.control.paused, 13906836291772416156);
    }

    public fun cancel_expired<T0>(arg0: ArenaTunnel<T0>, arg1: &0x2::clock::Clock) {
        assert_writable<T0>(&arg0);
        assert!(arg0.status == 0, 13906840200188067926);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.funding_deadline_ms, 13906840204482904148);
        assert!(!has_adopted_ownership<T0>(&arg0), 13906840208782327960);
        refund_and_delete_expired_opening<T0>(arg0, arg1);
    }

    public fun cancel_expired_recovery<T0>(arg0: ArenaTunnel<T0>, arg1: 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg2: &0x2::clock::Clock) {
        assert_writable<T0>(&arg0);
        assert!(arg0.status == 0, 13906840363396825174);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.funding_deadline_ms, 13906840367691661396);
        assert!(has_adopted_ownership<T0>(&arg0), 13906840384875593874);
        if (0x1::option::destroy_some<0x2::object::ID>(adopted_ownership<T0>(&arg0)) != 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership>(&arg1)) {
            abort 13906840393465528466
        };
        refund_and_delete_expired_opening<T0>(arg0, arg2);
        0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::destroy_disposed(arg1);
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

    fun commit_terminal_and_pay<T0>(arg0: 0x2::object::ID, arg1: TunnelState<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u16, arg8: vector<u64>, arg9: vector<u8>, arg10: u8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = TerminalState{
            state_commitment       : arg2,
            nonce                  : arg3,
            timestamp              : arg4,
            transcript_root        : arg5,
            receipt_count          : arg6,
            outcome_schema_version : arg7,
            outcome                : arg9,
            entitlements           : arg8,
        };
        arg1.terminal = v0;
        settle_escrow_and_publish_outcome_with_identity<T0>(arg0, arg1, arg10, arg11, arg12);
    }

    fun committed_terminal_payload_with_identity(arg0: 0x2::object::ID, arg1: &vector<SeatDeclaration>, arg2: &TerminalState) : vector<u8> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(arg1)) {
            0x1::vector::push_back<u16>(&mut v0, 0x1::vector::borrow<SeatDeclaration>(arg1, v1).seat);
            v1 = v1 + 1;
        };
        0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::encode_terminal_state(0x2::object::id_to_bytes(&arg0), arg2.state_commitment, arg2.nonce, arg2.timestamp, arg2.transcript_root, arg2.receipt_count, arg2.outcome_schema_version, &v0, &arg2.entitlements, &arg2.outcome)
    }

    fun compute_payout_plan(arg0: &vector<SeatDeclaration>, arg1: &vector<u64>, arg2: bool) : PayoutPlan {
        assert!(0x1::vector::length<SeatDeclaration>(arg0) == 0x1::vector::length<u64>(arg1), 13906847819461492844);
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
        assert!(0x1::vector::length<SeatDeclaration>(arg0) == 0x1::vector::length<bool>(arg1), 13906849576101412946);
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

    public fun create_and_share<T0>(arg0: u16, arg1: vector<u8>, arg2: u16, arg3: u16, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: vector<SeatDeclaration>, arg9: vector<RoleDeclaration>, arg10: vector<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>, arg11: vector<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>, arg12: u8, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 1, 13906837923853434936);
        assert!(arg12 == 0 || arg12 == 1, 13906837941038416006);
        assert!(arg3 == 1 || arg3 == 2, 13906838005463974038);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906838014048141374);
        assert!(arg2 != 0, 13906838018342846522);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906838022637944892);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906838026933174336);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 13906838031228272706);
        assert!(arg7 > 0x2::clock::timestamp_ms(arg13), 13906838035523371076);
        validate_roles(&arg9);
        validate_outcome_authorization(&arg10, &arg8, &arg9);
        validate_outcome_authorization(&arg11, &arg8, &arg9);
        let v0 = 0x1::vector::length<SeatDeclaration>(&arg8);
        assert!(v0 >= 2 && v0 <= 65535, 13906838074174930964);
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
        let v9 = TunnelControl{
            module_version : 1,
            paused         : false,
            paused_at_ms   : 0,
        };
        let v10 = ArenaTunnel<T0>{
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
            dispute_window_ms                : 10800000,
            referee_signature_type           : 0,
            referee_public_key               : b"",
            minimum_dispute_checkpoint_nonce : 0,
            dispute_started_ms               : 0,
            terminal                         : v8,
            admitted_evidence_class          : arg12,
            control                          : v9,
        };
        let v11 = ArenaTunnelCreated{
            tunnel_id                 : 0x2::object::id<ArenaTunnel<T0>>(&v10),
            execution_id              : v10.execution_id,
            participant_set_digest    : v10.participant_set_digest,
            execution_manifest_digest : v10.execution_manifest_digest,
            participant_count         : v4,
            required_total            : v1,
            funding_deadline_ms       : arg7,
        };
        0x2::event::emit<ArenaTunnelCreated>(v11);
        0x2::transfer::share_object<ArenaTunnel<T0>>(v10);
    }

    public fun current_module_version() : u64 {
        1
    }

    public fun current_resolution_policy_digest<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        let v1 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::encode_resolution_policy(0x2::object::id_to_bytes(&v0), arg0.dispute_window_ms, arg0.referee_signature_type, &arg0.referee_public_key);
        0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_resolution_policy(&v1)
    }

    public fun declare_resolution_policy<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u64, arg2: u8, arg3: vector<u8>, arg4: vector<vector<u8>>) {
        assert_writable<T0>(arg0);
        assert!(!arg0.policy_declared, 13906840719879635038);
        assert!(arg0.status == 0, 13906840724173029446);
        assert!(arg0.funded_total == 0, 13906840745649569888);
        assert!(arg1 >= 3600000 && arg1 <= 2592000000, 13906840762829570146);
        if (0x1::vector::length<u8>(&arg3) > 0) {
            assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_signature_type(arg2), 13906840775714603108);
            assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_public_key_length(arg2, &arg3), 13906840788599504996);
        };
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        let v1 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::encode_resolution_policy(0x2::object::id_to_bytes(&v0), arg1, arg2, &arg3);
        let v2 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_resolution_policy(&v1);
        verify_every_seat(&arg0.seats, &v2, &arg4);
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
        10800000
    }

    fun digest_execution_manifest(arg0: &vector<u8>) : vector<u8> {
        0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_framed(b"arena_tunnel::execution_manifest", arg0)
    }

    fun digest_participant_set(arg0: &vector<u8>) : vector<u8> {
        0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_framed(b"arena_tunnel::participant_set", arg0)
    }

    fun dispute_deadline_ms(arg0: u64, arg1: u64) : u64 {
        if (arg0 > 18446744073709551615 - arg1) {
            18446744073709551615
        } else {
            arg0 + arg1
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

    fun emit_checkpoint_adopted<T0>(arg0: 0x2::object::ID, arg1: &ArenaTunnel<T0>, arg2: &0x2::clock::Clock) {
        let v0 = ArenaCheckpointAdopted{
            tunnel_id     : arg0,
            nonce         : arg1.terminal.nonce,
            adopted_at_ms : 0x2::clock::timestamp_ms(arg2),
            deadline_ms   : dispute_deadline_ms(arg1.dispute_started_ms, arg1.dispute_window_ms),
        };
        0x2::event::emit<ArenaCheckpointAdopted>(v0);
    }

    fun emit_dispute_opened<T0>(arg0: 0x2::object::ID, arg1: &ArenaTunnel<T0>) {
        let v0 = ArenaDisputeOpened{
            tunnel_id    : arg0,
            nonce        : arg1.terminal.nonce,
            opened_at_ms : arg1.dispute_started_ms,
        };
        0x2::event::emit<ArenaDisputeOpened>(v0);
    }

    fun encode_execution_manifest<T0>(arg0: u16, arg1: &vector<u8>, arg2: u16, arg3: u16, arg4: &vector<u8>, arg5: &vector<u8>, arg6: &vector<u8>, arg7: u64, arg8: &vector<SeatDeclaration>, arg9: &vector<RoleDeclaration>, arg10: &vector<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>, arg11: &vector<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>) : vector<u8> {
        let v0 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, *arg4);
        0x1::vector::append<u8>(&mut v0, *arg5);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        let v2 = *0x1::ascii::as_bytes(0x1::type_name::as_string(&v1));
        0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::u64_to_be_bytes(0x1::vector::length<u8>(&v2)));
        0x1::vector::append<u8>(&mut v0, v2);
        0x1::vector::append<u8>(&mut v0, *arg6);
        0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::u64_to_be_bytes(arg7));
        0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes((0x1::vector::length<SeatDeclaration>(arg8) as u16)));
        let v3 = 0;
        while (v3 < 0x1::vector::length<SeatDeclaration>(arg8)) {
            let v4 = 0x1::vector::borrow<SeatDeclaration>(arg8, v3);
            0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes(v4.seat));
            0x1::vector::append<u8>(&mut v0, v4.participant_id);
            0x1::vector::push_back<u8>(&mut v0, v4.signature_type);
            0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes((0x1::vector::length<u8>(&v4.participant_public_key) as u16)));
            0x1::vector::append<u8>(&mut v0, v4.participant_public_key);
            0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(v4.funding_source));
            0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(v4.beneficiary));
            0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::u64_to_be_bytes(v4.required_deposit));
            v3 = v3 + 1;
        };
        let v5 = if (!0x1::vector::is_empty<RoleDeclaration>(arg9)) {
            true
        } else if (!0x1::vector::is_empty<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>(arg10)) {
            true
        } else {
            !0x1::vector::is_empty<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>(arg11)
        };
        if (v5) {
            0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes(1));
            0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes((0x1::vector::length<RoleDeclaration>(arg9) as u16)));
            let v6 = 0;
            while (v6 < 0x1::vector::length<RoleDeclaration>(arg9)) {
                let v7 = 0x1::vector::borrow<RoleDeclaration>(arg9, v6);
                0x1::vector::append<u8>(&mut v0, v7.role_id);
                0x1::vector::push_back<u8>(&mut v0, v7.signature_type);
                0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes((0x1::vector::length<u8>(&v7.public_key) as u16)));
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
        let v0 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes((0x1::vector::length<SeatDeclaration>(arg1) as u16)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(arg1)) {
            let v2 = 0x1::vector::borrow<SeatDeclaration>(arg1, v1);
            0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes(v2.seat));
            0x1::vector::append<u8>(&mut v0, v2.participant_id);
            0x1::vector::push_back<u8>(&mut v0, v2.signature_type);
            0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::u16_to_be_bytes((0x1::vector::length<u8>(&v2.participant_public_key) as u16)));
            0x1::vector::append<u8>(&mut v0, v2.participant_public_key);
            0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(v2.funding_source));
            0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(v2.beneficiary));
            0x1::vector::append<u8>(&mut v0, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::u64_to_be_bytes(v2.required_deposit));
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
        abort 13906853441569882162
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
        abort 13906853510290931786
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
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        assert_standard_profile(v2.verification_policy_version);
        force_close_after_timeout_inner<T0>(v0, v2, arg1, arg2);
    }

    fun force_close_after_timeout_inner<T0>(arg0: 0x2::object::ID, arg1: TunnelState<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 2, 13906845414280331380);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= dispute_deadline_ms(arg1.dispute_started_ms, arg1.dispute_window_ms), 13906845422870397046);
        settle_escrow_and_publish_outcome_with_identity<T0>(arg0, arg1, 1, v0, arg3);
    }

    public fun force_close_after_timeout_recovery<T0>(arg0: ArenaTunnel<T0>, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        let v3 = committed_terminal_payload_with_identity(v0, &v2.seats, &v2.terminal);
        verify_recovery_gate_with_identity(v0, &v2.id, &v2.execution_id, v2.verification_policy_version, arg1, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::operation_force_close_after_timeout(), arg2, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_checkpoint(&v3), arg3, arg4);
        force_close_after_timeout_inner<T0>(v0, v2, arg5, arg6);
    }

    public fun fund<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u16, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_writable<T0>(arg0);
        fund_seat_from_balance<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun fund_seat_from_balance<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u16, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg2 == arg0.execution_manifest_digest, 13906848772942921816);
        assert!(arg3 == current_resolution_policy_digest<T0>(arg0), 13906848815892725850);
        assert!(arg4 == arg0.admitted_evidence_class, 13906848880317366364);
        let v0 = is_recovery_profile<T0>(arg0) && !has_adopted_ownership<T0>(arg0);
        assert!(!v0, 13906848914680643730);
        assert!(arg0.status == 0, 13906848923265597510);
        assert!(0x2::clock::timestamp_ms(arg6) < arg0.funding_deadline_ms, 13906848927560695880);
        let v1 = seat_index<T0>(arg0, arg1);
        assert!(!*0x1::vector::borrow<bool>(&arg0.funded_seats, v1), 13906848940445859916);
        let v2 = 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v1);
        assert!(0x2::tx_context::sender(arg7) == v2.funding_source, 13906848949035925582);
        let v3 = 0x2::balance::value<T0>(&arg5);
        assert!(v3 == v2.required_deposit, 13906848957625991248);
        let v4 = validate_and_project_funding<T0>(arg0, v1, v3);
        0x2::balance::join<T0>(&mut arg0.escrow, arg5);
        *0x1::vector::borrow_mut<bool>(&mut arg0.funded_seats, v1) = true;
        arg0.funded_count = v4.projected_funded_count;
        arg0.funded_total = v4.projected_funded_total;
        let v5 = ArenaSeatFunded{
            tunnel_id      : 0x2::object::id<ArenaTunnel<T0>>(arg0),
            seat           : arg1,
            funding_source : v2.funding_source,
            amount         : v3,
            funded_count   : arg0.funded_count,
            funded_total   : arg0.funded_total,
        };
        0x2::event::emit<ArenaSeatFunded>(v5);
        if (v4.activates) {
            arg0.status = 1;
            let v6 = vector[];
            let v7 = 0;
            while (v7 < 0x1::vector::length<SeatDeclaration>(&arg0.seats)) {
                0x1::vector::push_back<u64>(&mut v6, 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v7).required_deposit);
                v7 = v7 + 1;
            };
            arg0.terminal.entitlements = v6;
            arg0.terminal.timestamp = 0x2::clock::timestamp_ms(arg6);
            let v8 = ArenaTunnelActivated{
                tunnel_id                 : 0x2::object::id<ArenaTunnel<T0>>(arg0),
                execution_id              : arg0.execution_id,
                execution_manifest_digest : arg0.execution_manifest_digest,
                participant_set_digest    : arg0.participant_set_digest,
                total_custody             : v4.projected_escrow_value,
                nonce                     : arg0.nonce,
                initial_state_commitment  : arg0.initial_state_commitment,
                activated_at_ms           : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<ArenaTunnelActivated>(v8);
        };
    }

    public fun fund_with_coin<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u16, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_writable<T0>(arg0);
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

    public(friend) fun hand_authorization<T0>(arg0: &ArenaTunnel<T0>) : &vector<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal> {
        &arg0.outcome_records.hand_authorization
    }

    fun has_adopted_ownership<T0>(arg0: &ArenaTunnel<T0>) : bool {
        let v0 = AdoptionMarker{dummy_field: false};
        0x2::dynamic_field::exists<AdoptionMarker>(&arg0.id, v0)
    }

    public fun has_referee<T0>(arg0: &ArenaTunnel<T0>) : bool {
        0x1::vector::length<u8>(&arg0.referee_public_key) > 0
    }

    public fun initial_state_commitment<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        arg0.initial_state_commitment
    }

    public fun is_admitted_version<T0>(arg0: &ArenaTunnel<T0>) : bool {
        version_is_admitted(1, arg0.control.module_version)
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

    public fun is_recovery_profile<T0>(arg0: &ArenaTunnel<T0>) : bool {
        arg0.verification_policy_version == 2
    }

    public fun live_status() : u8 {
        1
    }

    public fun migrate_version<T0>(arg0: &mut ArenaTunnel<T0>, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::RegistryAdminCap) {
        assert!(arg0.control.module_version + 1 == 1, 13906836360491761818);
        arg0.control.module_version = 1;
        let v0 = TunnelModuleVersionMigrated{
            tunnel_id    : 0x2::object::id<ArenaTunnel<T0>>(arg0),
            from_version : arg0.control.module_version,
            to_version   : 1,
        };
        0x2::event::emit<TunnelModuleVersionMigrated>(v0);
    }

    public fun minimum_dispute_checkpoint_nonce<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.minimum_dispute_checkpoint_nonce
    }

    public fun module_version<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.control.module_version
    }

    public fun open_dispute_from_committed_state<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u16, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_writable<T0>(arg0);
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        assert_standard_profile(arg0.verification_policy_version);
        open_dispute_from_committed_state_inner<T0>(v0, arg0, arg1, arg2, arg3, arg4);
    }

    fun open_dispute_from_committed_state_inner<T0>(arg0: 0x2::object::ID, arg1: &mut ArenaTunnel<T0>, arg2: u16, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 13906843017688842360);
        if (!is_declared_stakeholder<T0>(arg1, 0x2::tx_context::sender(arg5))) {
            let v0 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::encode_dispute_opening(0x2::object::id_to_bytes(&arg0), arg1.terminal.nonce);
            let v1 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_dispute_opening(&v0);
            let v2 = 0x1::vector::borrow<SeatDeclaration>(&arg1.seats, seat_index<T0>(arg1, arg2));
            assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(v2.signature_type, &v2.participant_public_key, &v1, &arg3), 13906843103587139688);
        };
        arg1.status = 2;
        start_dispute_clock<T0>(arg1, arg4);
        emit_dispute_opened<T0>(arg0, arg1);
    }

    public fun open_dispute_from_committed_state_recovery<T0>(arg0: &mut ArenaTunnel<T0>, arg1: u16, arg2: vector<u8>, arg3: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_writable<T0>(arg0);
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        let v1 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        let v2 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::encode_dispute_opening(0x2::object::id_to_bytes(&v1), arg0.terminal.nonce);
        verify_recovery_gate_with_identity(v0, &arg0.id, &arg0.execution_id, arg0.verification_policy_version, arg3, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::operation_open_dispute_from_committed_state(), arg4, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_dispute_opening(&v2), arg5, arg6);
        open_dispute_from_committed_state_inner<T0>(v0, arg0, arg1, arg2, arg7, arg8);
    }

    public fun open_dispute_with_checkpoint<T0>(arg0: &mut ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock) {
        assert_writable<T0>(arg0);
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        assert_standard_profile(arg0.verification_policy_version);
        open_dispute_with_checkpoint_inner<T0>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun open_dispute_with_checkpoint_inner<T0>(arg0: 0x2::object::ID, arg1: &mut ArenaTunnel<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u16, arg8: vector<u64>, arg9: vector<u8>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock) {
        assert!(arg1.status == 1, 13906843782193021048);
        assert!(arg3 >= arg1.minimum_dispute_checkpoint_nonce, 13906843786487464048);
        adopt_checkpoint<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        arg1.status = 2;
        arg1.minimum_dispute_checkpoint_nonce = arg3 + 1;
        start_dispute_clock<T0>(arg1, arg11);
        emit_dispute_opened<T0>(arg0, arg1);
    }

    public fun open_dispute_with_checkpoint_recovery<T0>(arg0: &mut ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: &0x2::clock::Clock) {
        assert_writable<T0>(arg0);
        let v0 = 0x2::object::id<ArenaTunnel<T0>>(arg0);
        let v1 = terminal_payload_with_identity(v0, &arg0.seats, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, &arg8);
        verify_recovery_gate_with_identity(v0, &arg0.id, &arg0.execution_id, arg0.verification_policy_version, arg10, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::operation_open_dispute_with_checkpoint(), arg11, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_checkpoint(&v1), arg12, arg13);
        open_dispute_with_checkpoint_inner<T0>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg14);
    }

    public fun participant_count<T0>(arg0: &ArenaTunnel<T0>) : u16 {
        arg0.participant_count
    }

    public fun participant_set_digest<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        arg0.participant_set_digest
    }

    public fun paused<T0>(arg0: &ArenaTunnel<T0>) : bool {
        arg0.control.paused
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

    fun record_adopted_ownership<T0>(arg0: &mut ArenaTunnel<T0>, arg1: 0x2::object::ID) {
        let v0 = AdoptionMarker{dummy_field: false};
        0x2::dynamic_field::add<AdoptionMarker, 0x2::object::ID>(&mut arg0.id, v0, arg1);
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

    public fun recovery_verification_policy_version() : u16 {
        2
    }

    public fun referee_public_key<T0>(arg0: &ArenaTunnel<T0>) : vector<u8> {
        arg0.referee_public_key
    }

    public fun referee_signature_type<T0>(arg0: &ArenaTunnel<T0>) : u8 {
        arg0.referee_signature_type
    }

    fun refund_and_delete_expired_opening<T0>(arg0: ArenaTunnel<T0>, arg1: &0x2::clock::Clock) {
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
            control                          : _,
        } = arg0;
        let v33 = v22;
        let v34 = 0;
        let v35 = 0;
        assert!(0x1::vector::length<address>(&v0.recipients) == 0x1::vector::length<u64>(&v0.amounts), 13906840509425451090);
        while (v35 < 0x1::vector::length<address>(&v0.recipients)) {
            let v36 = *0x1::vector::borrow<u64>(&v0.amounts, v35);
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut v33, v36), *0x1::vector::borrow<address>(&v0.recipients, v35));
            v34 = v34 + v36;
            v35 = v35 + 1;
        };
        assert!(v34 == v20, 13906840556670091346);
        assert!(v35 == (v21 as u64), 13906840560965058642);
        assert!(0x2::balance::value<T0>(&v33) == 0, 13906840565260025938);
        0x2::balance::destroy_zero<T0>(v33);
        0x2::object::delete(v1);
        let v37 = ArenaTunnelOpeningCancelled{
            tunnel_id                 : 0x2::object::id<ArenaTunnel<T0>>(&arg0),
            execution_id              : arg0.execution_id,
            execution_manifest_digest : arg0.execution_manifest_digest,
            participant_set_digest    : arg0.participant_set_digest,
            funded_count              : v21,
            refunded_total            : v34,
            cancelled_at_ms           : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ArenaTunnelOpeningCancelled>(v37);
    }

    public fun required_total<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.required_total
    }

    fun resolution_policy_digest_of<T0>(arg0: 0x2::object::ID, arg1: &TunnelState<T0>) : vector<u8> {
        let v0 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::encode_resolution_policy(0x2::object::id_to_bytes(&arg0), arg1.dispute_window_ms, arg1.referee_signature_type, &arg1.referee_public_key);
        0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_resolution_policy(&v0)
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
        abort 13906849168078995530
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

    public fun set_paused<T0>(arg0: &mut ArenaTunnel<T0>, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::RegistryAdminCap, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_admitted_version<T0>(arg0);
        if (arg0.control.paused == arg2) {
            return
        };
        let v0 = 0;
        if (arg2) {
            arg0.control.paused_at_ms = 0x2::clock::timestamp_ms(arg3);
        } else {
            let v1 = 0x2::clock::timestamp_ms(arg3) - arg0.control.paused_at_ms;
            v0 = v1;
            if (arg0.status == 0) {
                arg0.funding_deadline_ms = arg0.funding_deadline_ms + v1;
            };
            if (arg0.status == 2 && arg0.dispute_started_ms > 0) {
                arg0.dispute_started_ms = arg0.dispute_started_ms + v1;
            };
            arg0.control.paused_at_ms = 0;
        };
        arg0.control.paused = arg2;
        let v2 = TunnelPauseChanged{
            tunnel_id : 0x2::object::id<ArenaTunnel<T0>>(arg0),
            paused    : arg2,
            held_ms   : v0,
        };
        0x2::event::emit<TunnelPauseChanged>(v2);
    }

    public fun settle_by_referee<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        assert_standard_profile(v2.verification_policy_version);
        settle_by_referee_inner<T0>(v0, v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    fun settle_by_referee_inner<T0>(arg0: 0x2::object::ID, arg1: TunnelState<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u16, arg8: vector<u64>, arg9: vector<u8>, arg10: vector<u8>, arg11: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_admitted_evidence_class(arg1.admitted_evidence_class, 1);
        assert!(arg1.status == 2, 13906846054230458484);
        assert!(0x1::vector::length<u8>(&arg1.referee_public_key) > 0, 13906846058525950076);
        let v0 = 0x2::clock::timestamp_ms(arg12);
        assert!(v0 >= dispute_deadline_ms(arg1.dispute_started_ms, arg1.dispute_window_ms), 13906846067115491446);
        assert_settlement_admissible(0x1::vector::length<SeatDeclaration>(&arg1.seats), 0x2::balance::value<T0>(&arg1.escrow), arg1.terminal.nonce, &arg2, arg3, &arg5, arg7, &arg8, &arg9);
        let v1 = terminal_payload_with_identity(arg0, &arg1.seats, arg2, arg3, arg4, arg5, arg6, arg7, &arg8, &arg9);
        let v2 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_referee_disposition(&v1);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(arg1.referee_signature_type, &arg1.referee_public_key, &v2, &arg10), 13906846213144641658);
        assert_referee_signer_registered_nitro(&arg1.referee_public_key, arg11, v0);
        commit_terminal_and_pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 2, v0, arg13);
    }

    public fun settle_by_referee_local<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        assert_standard_profile(v2.verification_policy_version);
        settle_by_referee_local_inner<T0>(v0, v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    fun settle_by_referee_local_inner<T0>(arg0: 0x2::object::ID, arg1: TunnelState<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u16, arg8: vector<u64>, arg9: vector<u8>, arg10: vector<u8>, arg11: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_admitted_evidence_class(arg1.admitted_evidence_class, 0);
        assert!(arg1.status == 2, 13906846831619539060);
        assert!(0x1::vector::length<u8>(&arg1.referee_public_key) > 0, 13906846835915030652);
        let v0 = 0x2::clock::timestamp_ms(arg12);
        assert!(v0 >= dispute_deadline_ms(arg1.dispute_started_ms, arg1.dispute_window_ms), 13906846844504572022);
        assert_settlement_admissible(0x1::vector::length<SeatDeclaration>(&arg1.seats), 0x2::balance::value<T0>(&arg1.escrow), arg1.terminal.nonce, &arg2, arg3, &arg5, arg7, &arg8, &arg9);
        let v1 = terminal_payload_with_identity(arg0, &arg1.seats, arg2, arg3, arg4, arg5, arg6, arg7, &arg8, &arg9);
        let v2 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_referee_disposition(&v1);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(arg1.referee_signature_type, &arg1.referee_public_key, &v2, &arg10), 13906846990533722234);
        assert_referee_signer_registered_local(&arg1.referee_public_key, arg11, v0);
        commit_terminal_and_pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 2, v0, arg13);
    }

    public fun settle_by_referee_local_recovery<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        let v3 = terminal_payload_with_identity(v0, &v2.seats, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, &arg8);
        verify_recovery_gate_with_identity(v0, &v2.id, &v2.execution_id, v2.verification_policy_version, arg10, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::operation_settle_by_referee(), arg11, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_referee_disposition(&v3), arg12, arg13);
        settle_by_referee_local_inner<T0>(v0, v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg14, arg15, arg16);
    }

    public fun settle_by_referee_recovery<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        let v3 = terminal_payload_with_identity(v0, &v2.seats, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, &arg8);
        verify_recovery_gate_with_identity(v0, &v2.id, &v2.execution_id, v2.verification_policy_version, arg10, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::operation_settle_by_referee(), arg11, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_referee_disposition(&v3), arg12, arg13);
        settle_by_referee_inner<T0>(v0, v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg14, arg15, arg16);
    }

    public fun settle_cooperative<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        assert_standard_profile(v2.verification_policy_version);
        settle_cooperative_inner<T0>(v0, v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    fun settle_cooperative_inner<T0>(arg0: 0x2::object::ID, arg1: TunnelState<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u16, arg8: vector<u64>, arg9: vector<u8>, arg10: vector<vector<u8>>, arg11: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_admitted_evidence_class(arg1.admitted_evidence_class, 1);
        assert!(arg1.status == 1 || arg1.status == 2, 13906841441435189358);
        assert_settlement_admissible(0x1::vector::length<SeatDeclaration>(&arg1.seats), 0x2::balance::value<T0>(&arg1.escrow), arg1.terminal.nonce, &arg2, arg3, &arg5, arg7, &arg8, &arg9);
        let v0 = terminal_payload_with_identity(arg0, &arg1.seats, arg2, arg3, arg4, arg5, arg6, arg7, &arg8, &arg9);
        let v1 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_settlement(&v0);
        verify_every_seat(&arg1.seats, &v1, &arg10);
        let v2 = 0x2::clock::timestamp_ms(arg12);
        assert_cooperative_signers_registered_nitro(&arg1.seats, arg11, v2);
        commit_terminal_and_pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0, v2, arg13);
    }

    public fun settle_cooperative_local<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        assert_standard_profile(v2.verification_policy_version);
        settle_cooperative_local_inner<T0>(v0, v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    fun settle_cooperative_local_inner<T0>(arg0: 0x2::object::ID, arg1: TunnelState<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u16, arg8: vector<u64>, arg9: vector<u8>, arg10: vector<vector<u8>>, arg11: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_admitted_evidence_class(arg1.admitted_evidence_class, 0);
        assert!(arg1.status == 1 || arg1.status == 2, 13906842201644400750);
        assert_settlement_admissible(0x1::vector::length<SeatDeclaration>(&arg1.seats), 0x2::balance::value<T0>(&arg1.escrow), arg1.terminal.nonce, &arg2, arg3, &arg5, arg7, &arg8, &arg9);
        let v0 = terminal_payload_with_identity(arg0, &arg1.seats, arg2, arg3, arg4, arg5, arg6, arg7, &arg8, &arg9);
        let v1 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_settlement(&v0);
        verify_every_seat(&arg1.seats, &v1, &arg10);
        let v2 = 0x2::clock::timestamp_ms(arg12);
        assert_cooperative_signers_registered_local(&arg1.seats, arg11, v2);
        commit_terminal_and_pay<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0, v2, arg13);
    }

    public fun settle_cooperative_local_recovery<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        let v3 = terminal_payload_with_identity(v0, &v2.seats, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, &arg8);
        verify_recovery_gate_with_identity(v0, &v2.id, &v2.execution_id, v2.verification_policy_version, arg10, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::operation_settle_cooperative(), arg11, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_settlement(&v3), arg12, arg13);
        settle_cooperative_local_inner<T0>(v0, v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg14, arg15, arg16);
    }

    public fun settle_cooperative_recovery<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: vector<u64>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        let v3 = terminal_payload_with_identity(v0, &v2.seats, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, &arg8);
        verify_recovery_gate_with_identity(v0, &v2.id, &v2.execution_id, v2.verification_policy_version, arg10, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::operation_settle_cooperative(), arg11, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_settlement(&v3), arg12, arg13);
        settle_cooperative_inner<T0>(v0, v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg14, arg15, arg16);
    }

    fun settle_escrow_and_publish_outcome_with_identity<T0>(arg0: 0x2::object::ID, arg1: TunnelState<T0>, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 3) {
            let v0 = vector[];
            let v1 = 0;
            while (v1 < 0x1::vector::length<SeatDeclaration>(&arg1.seats)) {
                0x1::vector::push_back<u64>(&mut v0, 0x1::vector::borrow<SeatDeclaration>(&arg1.seats, v1).required_deposit);
                v1 = v1 + 1;
            };
            arg1.terminal.entitlements = v0;
            arg1.terminal.outcome_schema_version = 0;
            arg1.terminal.outcome = b"";
        };
        let v2 = arg1.terminal.entitlements;
        let v3 = compute_payout_plan(&arg1.seats, &v2, payout_returns_to_funders(arg2, arg1.terminal.nonce));
        assert_conserves(&v3.amounts, 0x2::balance::value<T0>(&arg1.escrow));
        let v4 = arg1.terminal;
        let TunnelState {
            id                               : v5,
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
            escrow                           : v26,
            status                           : _,
            policy_declared                  : _,
            dispute_window_ms                : _,
            referee_signature_type           : _,
            referee_public_key               : _,
            minimum_dispute_checkpoint_nonce : _,
            dispute_started_ms               : _,
            terminal                         : _,
            admitted_evidence_class          : _,
        } = arg1;
        let v36 = v26;
        let v37 = 0x2::balance::value<T0>(&v36);
        let v38 = 0;
        while (v38 < 0x1::vector::length<address>(&v3.recipients)) {
            let v39 = *0x1::vector::borrow<u64>(&v3.amounts, v38);
            if (v39 > 0) {
                0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut v36, v39), *0x1::vector::borrow<address>(&v3.recipients, v38));
            };
            v38 = v38 + 1;
        };
        assert!(0x2::balance::value<T0>(&v36) == 0, 13906848128699007082);
        0x2::balance::destroy_zero<T0>(v36);
        0x2::object::delete(v5);
        let v40 = SettledOutcomeRecord{
            id                          : 0x2::object::new(arg4),
            schema_version              : 2,
            tunnel_id                   : arg0,
            execution_id                : arg1.execution_id,
            execution_manifest_digest   : arg1.execution_manifest_digest,
            participant_set_digest      : arg1.participant_set_digest,
            protocol_version            : arg1.protocol_version,
            protocol_id                 : arg1.protocol_id,
            verification_policy_version : arg1.verification_policy_version,
            product_manifest_digest     : arg1.product_manifest_digest,
            resolution_policy_digest    : resolution_policy_digest_of<T0>(arg0, &arg1),
            disposition                 : arg2,
            terminal_nonce              : v4.nonce,
            terminal_timestamp          : v4.timestamp,
            terminal_state_commitment   : v4.state_commitment,
            transcript_root             : v4.transcript_root,
            receipt_count               : v4.receipt_count,
            outcome_schema_version      : v4.outcome_schema_version,
            outcome                     : v4.outcome,
            entitlements                : v2,
            total_settled               : v37,
            settled_at_ms               : arg3,
            evidence_class              : arg1.admitted_evidence_class,
        };
        let v41 = ArenaTunnelSettled{
            tunnel_id     : arg0,
            record_id     : 0x2::object::id<SettledOutcomeRecord>(&v40),
            disposition   : arg2,
            total_settled : v37,
            settled_at_ms : arg3,
        };
        0x2::event::emit<ArenaTunnelSettled>(v41);
        0x2::transfer::freeze_object<SettledOutcomeRecord>(v40);
    }

    public fun settled_outcome_record_schema_version() : u16 {
        2
    }

    public fun standard_verification_policy_version() : u16 {
        1
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

    fun terminal_payload_with_identity(arg0: 0x2::object::ID, arg1: &vector<SeatDeclaration>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u16, arg8: &vector<u64>, arg9: &vector<u8>) : vector<u8> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(arg1)) {
            0x1::vector::push_back<u16>(&mut v0, 0x1::vector::borrow<SeatDeclaration>(arg1, v1).seat);
            v1 = v1 + 1;
        };
        0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::encode_terminal_state(0x2::object::id_to_bytes(&arg0), arg2, arg3, arg4, arg5, arg6, arg7, &v0, arg8, arg9)
    }

    public fun terminal_state_timestamp<T0>(arg0: &ArenaTunnel<T0>) : u64 {
        arg0.terminal.timestamp
    }

    fun unpack_tunnel<T0>(arg0: ArenaTunnel<T0>) : (0x2::object::ID, TunnelState<T0>) {
        let ArenaTunnel {
            id                               : v0,
            contract_schema_version          : v1,
            wire_version                     : v2,
            execution_id                     : v3,
            protocol_version                 : v4,
            verification_policy_version      : v5,
            protocol_id                      : v6,
            product_manifest_digest          : v7,
            execution_manifest_digest        : v8,
            participant_set_digest           : v9,
            initial_state_commitment         : v10,
            nonce                            : v11,
            funding_deadline_ms              : v12,
            seats                            : v13,
            funded_seats                     : v14,
            roles                            : v15,
            outcome_records                  : v16,
            participant_count                : v17,
            required_total                   : v18,
            funded_total                     : v19,
            funded_count                     : v20,
            escrow                           : v21,
            status                           : v22,
            policy_declared                  : v23,
            dispute_window_ms                : v24,
            referee_signature_type           : v25,
            referee_public_key               : v26,
            minimum_dispute_checkpoint_nonce : v27,
            dispute_started_ms               : v28,
            terminal                         : v29,
            admitted_evidence_class          : v30,
            control                          : _,
        } = arg0;
        let v32 = TunnelState<T0>{
            id                               : v0,
            contract_schema_version          : v1,
            wire_version                     : v2,
            execution_id                     : v3,
            protocol_version                 : v4,
            verification_policy_version      : v5,
            protocol_id                      : v6,
            product_manifest_digest          : v7,
            execution_manifest_digest        : v8,
            participant_set_digest           : v9,
            initial_state_commitment         : v10,
            nonce                            : v11,
            funding_deadline_ms              : v12,
            seats                            : v13,
            funded_seats                     : v14,
            roles                            : v15,
            outcome_records                  : v16,
            participant_count                : v17,
            required_total                   : v18,
            funded_total                     : v19,
            funded_count                     : v20,
            escrow                           : v21,
            status                           : v22,
            policy_declared                  : v23,
            dispute_window_ms                : v24,
            referee_signature_type           : v25,
            referee_public_key               : v26,
            minimum_dispute_checkpoint_nonce : v27,
            dispute_started_ms               : v28,
            terminal                         : v29,
            admitted_evidence_class          : v30,
        };
        (0x2::object::id<ArenaTunnel<T0>>(&arg0), v32)
    }

    fun validate_activation_projection<T0>(arg0: &ArenaTunnel<T0>, arg1: u64, arg2: u16, arg3: u64, arg4: u64) {
        assert!(arg2 == arg0.participant_count, 13906849430072524882);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<SeatDeclaration>(&arg0.seats)) {
            assert!(v1 == arg1 || *0x1::vector::borrow<bool>(&arg0.funded_seats, v1), 13906849460137295954);
            v0 = v0 + 0x1::vector::borrow<SeatDeclaration>(&arg0.seats, v1).required_deposit;
            v1 = v1 + 1;
        };
        assert!(v0 == arg0.required_total, 13906849481612132434);
        assert!(arg3 == arg0.required_total, 13906849485907099730);
        assert!(arg4 == arg0.required_total, 13906849490202067026);
        assert!(arg4 == arg3, 13906849494497034322);
    }

    fun validate_and_project_funding<T0>(arg0: &ArenaTunnel<T0>, arg1: u64, arg2: u64) : FundingProjection {
        let v0 = 0x1::vector::length<SeatDeclaration>(&arg0.seats);
        assert!(v0 == 0x1::vector::length<bool>(&arg0.funded_seats), 13906849206734225490);
        assert!(v0 == (arg0.participant_count as u64), 13906849211029192786);
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
        assert!(v1 == (arg0.funded_count as u64), 13906849266863767634);
        assert!(v2 == arg0.funded_total, 13906849271158734930);
        assert!(0x2::balance::value<T0>(&arg0.escrow) == arg0.funded_total, 13906849275453702226);
        let v4 = arg0.funded_count + 1;
        let v5 = arg0.funded_total + arg2;
        let v6 = 0x2::balance::value<T0>(&arg0.escrow) + arg2;
        assert!(v4 <= arg0.participant_count, 13906849296928538706);
        assert!(v5 <= arg0.required_total, 13906849301223506002);
        assert!(v6 == v5, 13906849305518473298);
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
            assert!(0x1::vector::length<u8>(&v2.participant_id) == 32, 13906851861020344346);
            assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_signature_type(v2.signature_type), 13906851865315442716);
            assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_public_key_length(v2.signature_type, &v2.participant_public_key), 13906851891085377566);
            assert!(v2.required_deposit != 0, 13906851899676753972);
            assert!(v0 <= 18446744073709551615 - v2.required_deposit, 13906851903971852342);
            if (v1 != 0) {
                assert!(0x1::vector::borrow<SeatDeclaration>(arg0, v1 - 1).seat < v2.seat, 13906851916854657046);
            };
            let v3 = 0;
            while (v3 < v1) {
                assert!(0x1::vector::borrow<SeatDeclaration>(arg0, v3).participant_id != v2.participant_id, 13906851946919559192);
                v3 = v3 + 1;
            };
            v0 = v0 + v2.required_deposit;
            v1 = v1 + 1;
        };
        v0
    }

    fun validate_outcome_authorization(arg0: &vector<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>, arg1: &vector<SeatDeclaration>, arg2: &vector<RoleDeclaration>) {
        if (0x1::vector::is_empty<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>(arg0)) {
            return
        };
        assert!(0x1::vector::length<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>(arg0) >= 2, 13906851714992242726);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>(arg0)) {
            if (v0 != 0) {
                assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::principal_is_less(0x1::vector::borrow<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>(arg0, v0 - 1), 0x1::vector::borrow<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>(arg0, v0)), 13906851740762177576);
            };
            let v1 = 0x1::vector::borrow<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::Principal>(arg0, v0);
            let v2 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::principal_tag(v1);
            assert!(v2 == 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::seat_principal_tag() || v2 == 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::role_principal_tag(), 13906851775122178092);
            if (v2 == 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::seat_principal_tag()) {
                let v3 = 0;
                let v4;
                while (v3 < 0x1::vector::length<SeatDeclaration>(arg1)) {
                    if (0x1::vector::borrow<SeatDeclaration>(arg1, v3).seat == 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::principal_seat(v1)) {
                        v4 = true;
                        /* label 23 */
                        /* label 24 */
                        assert!(v4, 13906851813776752682);
                        v0 = v0 + 1;
                        /* goto 6 */
                        continue
                    };
                    v3 = v3 + 1;
                };
                v4 = false;
                /* goto 23 */
            } else {
                let v5 = 0;
                let v6;
                while (v5 < 0x1::vector::length<RoleDeclaration>(arg2)) {
                    if (0x1::vector::borrow<RoleDeclaration>(arg2, v5).role_id == 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::principal_role(v1)) {
                        v6 = true;
                        /* label 34 */
                        /* goto 24 */
                    } else {
                        v5 = v5 + 1;
                    };
                };
                v6 = false;
                /* goto 34 */
            };
        };
    }

    fun validate_roles(arg0: &vector<RoleDeclaration>) {
        assert!(0x1::vector::length<RoleDeclaration>(arg0) <= 64, 13906851599027994660);
        let v0 = 0;
        while (v0 < 0x1::vector::length<RoleDeclaration>(arg0)) {
            let v1 = 0x1::vector::borrow<RoleDeclaration>(arg0, v0);
            assert!(0x1::vector::length<u8>(&v1.role_id) == 32, 13906851620502568992);
            assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_signature_type(v1.signature_type), 13906851624797274140);
            assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_public_key_length(v1.signature_type, &v1.public_key), 13906851637682569250);
            if (v0 != 0) {
                assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::receipt_wire::is_lexicographically_less(&0x1::vector::borrow<RoleDeclaration>(arg0, v0 - 1).role_id, &v1.role_id), 13906851659158323248);
            };
            v0 = v0 + 1;
        };
    }

    public fun verification_policy_version<T0>(arg0: &ArenaTunnel<T0>) : u16 {
        arg0.verification_policy_version
    }

    fun verify_every_seat(arg0: &vector<SeatDeclaration>, arg1: &vector<u8>, arg2: &vector<vector<u8>>) {
        assert!(0x1::vector::length<vector<u8>>(arg2) == 0x1::vector::length<SeatDeclaration>(arg0), 13906848343447109734);
        let v0 = 0;
        while (v0 < 0x1::vector::length<SeatDeclaration>(arg0)) {
            let v1 = 0x1::vector::borrow<SeatDeclaration>(arg0, v0);
            assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(v1.signature_type, &v1.participant_public_key, arg1, 0x1::vector::borrow<vector<u8>>(arg2, v0)), 13906848386396913768);
            v0 = v0 + 1;
        };
    }

    public(friend) fun verify_recovery_gate_with_identity(arg0: 0x2::object::ID, arg1: &0x2::object::UID, arg2: &vector<u8>, arg3: u16, arg4: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>) {
        assert!(arg3 == 2, 13906839079205142668);
        assert!(arg6 == anchor_domain(), 13906839117860372628);
        let v0 = AdoptionMarker{dummy_field: false};
        assert!(0x2::dynamic_field::exists<AdoptionMarker>(arg1, v0), 13906839143630045330);
        let v1 = AdoptionMarker{dummy_field: false};
        if (*0x2::dynamic_field::borrow<AdoptionMarker, 0x2::object::ID>(arg1, v1) != 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership>(arg4)) {
            abort 13906839152219979922
        };
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::execution_id(arg4) == *arg2, 13906839190874685586);
        0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::verify_runtime_endorsement(arg4, arg0, anchor_domain(), arg5, arg7, arg8, arg9);
    }

    public(friend) fun verify_tunnel_recovery_gate<T0>(arg0: 0x2::object::ID, arg1: &ArenaTunnel<T0>, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>) {
        verify_recovery_gate_with_identity(arg0, &arg1.id, &arg1.execution_id, arg1.verification_policy_version, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun version_is_admitted(arg0: u64, arg1: u64) : bool {
        arg1 == arg0 || arg0 > 1 && arg1 == arg0 - 1
    }

    public fun void_by_referee<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        assert_standard_profile(v2.verification_policy_version);
        void_by_referee_inner<T0>(v0, v2, arg1, arg2, arg3);
    }

    fun void_by_referee_inner<T0>(arg0: 0x2::object::ID, arg1: TunnelState<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 2, 13906847407145156724);
        assert!(0x1::vector::length<u8>(&arg1.referee_public_key) > 0, 13906847411440648316);
        let v0 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::encode_void_disposition(0x2::object::id_to_bytes(&arg0));
        let v1 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_void_disposition(&v0);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(arg1.referee_signature_type, &arg1.referee_public_key, &v1, &arg2), 13906847454390452350);
        settle_escrow_and_publish_outcome_with_identity<T0>(arg0, arg1, 3, 0x2::clock::timestamp_ms(arg3), arg4);
    }

    public fun void_by_referee_recovery<T0>(arg0: ArenaTunnel<T0>, arg1: vector<u8>, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::ExecutionOwnership, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_writable<T0>(&arg0);
        let (v0, v1) = unpack_tunnel<T0>(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::encode_void_disposition(0x2::object::id_to_bytes(&v3));
        verify_recovery_gate_with_identity(v3, &v2.id, &v2.execution_id, v2.verification_policy_version, arg2, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::ownership::operation_void_by_referee(), arg3, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::terminal_wire::digest_void_disposition(&v4), arg4, arg5);
        void_by_referee_inner<T0>(v3, v2, arg1, arg6, arg7);
    }

    public fun wire_version<T0>(arg0: &ArenaTunnel<T0>) : u16 {
        arg0.wire_version
    }

    // decompiled from Move bytecode v7
}

