module 0x9498606724aa4c03dd0e50ce508b3f5555c4915d3f8d0d4525c0f98dd1737eb1::attestation_registry {
    struct NitroEvidence has drop {
        dummy_field: bool,
    }

    struct LocalEvidence has drop {
        dummy_field: bool,
    }

    struct LocalAttestationEvidence has drop {
        durable_public_key: vector<u8>,
        role_tag: vector<u8>,
        pcrs: vector<PcrPolicy>,
        evidence_hash: vector<u8>,
        nonce: vector<u8>,
        observed_at_ms: u64,
    }

    struct PcrPolicy has copy, drop, store {
        index: u8,
        value: vector<u8>,
    }

    struct Registration has copy, drop, store {
        durable_public_key: vector<u8>,
        evidence_hash: vector<u8>,
        nonce: vector<u8>,
        role_tag: vector<u8>,
        pcrs: vector<PcrPolicy>,
        document_timestamp_ms: u64,
        matched_set: u8,
        admitted_configuration_version: u64,
        evidence_refreshed_at_ms: u64,
        revoked: bool,
    }

    struct AttestationRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        configuration_version: u64,
        current_pcrs: vector<PcrPolicy>,
        incoming_pcrs: 0x1::option::Option<vector<PcrPolicy>>,
        accepted_role_tags: vector<vector<u8>>,
        maximum_document_age_ms: u64,
        registrations: vector<Registration>,
        trusted: bool,
    }

    struct RegistryAdminCap has key {
        id: 0x2::object::UID,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        evidence_kind: u8,
        trusted: bool,
        configuration_version: u64,
    }

    struct RegistryPolicyUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        configuration_version: u64,
        pcr_policy_count: u64,
        role_tag_count: u64,
        maximum_document_age_ms: u64,
    }

    struct MeasurementTransitionOpened has copy, drop {
        registry_id: 0x2::object::ID,
        configuration_version: u64,
        incoming_pcr_count: u64,
    }

    struct MeasurementTransitionClosed has copy, drop {
        registry_id: 0x2::object::ID,
        configuration_version: u64,
    }

    struct MeasurementTransitionAborted has copy, drop {
        registry_id: 0x2::object::ID,
        configuration_version: u64,
    }

    struct RegistryVersionMigrated has copy, drop {
        registry_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct AttestationRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        durable_public_key: vector<u8>,
        evidence_hash: vector<u8>,
        nonce: vector<u8>,
        role_tag: vector<u8>,
        pcrs: vector<PcrPolicy>,
        document_timestamp_ms: u64,
        matched_set: u8,
        configuration_version: u64,
    }

    struct AttestationRefreshed has copy, drop {
        registry_id: 0x2::object::ID,
        durable_public_key: vector<u8>,
        evidence_hash: vector<u8>,
        nonce: vector<u8>,
        role_tag: vector<u8>,
        pcrs: vector<PcrPolicy>,
        document_timestamp_ms: u64,
        matched_set: u8,
        configuration_version: u64,
    }

    struct AttestationRevoked has copy, drop {
        registry_id: 0x2::object::ID,
        durable_public_key: vector<u8>,
        configuration_version: u64,
    }

    struct SeatKey has copy, drop, store {
        durable_public_key: vector<u8>,
    }

    struct SeatKeyRecord has copy, drop, store {
        role_tag: vector<u8>,
        document_timestamp_ms: u64,
        revoked: bool,
    }

    struct SeatKeyReleased has copy, drop {
        registry_id: 0x2::object::ID,
        durable_public_key: vector<u8>,
    }

    public fun abort_measurement_transition(arg0: &RegistryAdminCap, arg1: &mut AttestationRegistry<NitroEvidence>) {
        assert_current_nitro_registry(arg1);
        assert!(0x1::option::is_some<vector<PcrPolicy>>(&arg1.incoming_pcrs), 13906836008297496624);
        0x1::option::extract<vector<PcrPolicy>>(&mut arg1.incoming_pcrs);
        arg1.configuration_version = arg1.configuration_version + 1;
        let v0 = 0;
        while (v0 < 0x1::vector::length<Registration>(&arg1.registrations)) {
            let v1 = 0x1::vector::borrow_mut<Registration>(&mut arg1.registrations, v0);
            if (v1.matched_set == 1) {
                v1.matched_set = 2;
            };
            v0 = v0 + 1;
        };
        let v2 = MeasurementTransitionAborted{
            registry_id           : 0x2::object::uid_to_inner(&arg1.id),
            configuration_version : arg1.configuration_version,
        };
        0x2::event::emit<MeasurementTransitionAborted>(v2);
    }

    public fun accepted_role_tags<T0>(arg0: &AttestationRegistry<T0>) : vector<vector<u8>> {
        arg0.accepted_role_tags
    }

    fun admit_local_seat_key(arg0: &mut AttestationRegistry<LocalEvidence>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<PcrPolicy>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64) {
        assert_possession_proof(&arg6, &arg1, &arg7);
        admit_local_seat_key_claims(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
    }

    fun admit_local_seat_key_claims(arg0: &mut AttestationRegistry<LocalEvidence>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<PcrPolicy>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: u64) {
        let v0 = SeatKey{durable_public_key: arg1};
        if (!0x2::dynamic_field::exists<SeatKey>(&arg0.id, v0)) {
            let v1 = find_registration<LocalEvidence>(arg0, &arg1);
            if (v1 < 0x1::vector::length<Registration>(&arg0.registrations)) {
                let v2 = 0x1::vector::borrow<Registration>(&arg0.registrations, v1);
                assert!(!v2.revoked, 13906837180823306284);
                assert!(arg5 > v2.document_timestamp_ms, 13906837185118142506);
                0x1::vector::remove<Registration>(&mut arg0.registrations, v1);
            };
            let v3 = SeatKeyRecord{
                role_tag              : arg2,
                document_timestamp_ms : arg5,
                revoked               : false,
            };
            0x2::dynamic_field::add<SeatKey, SeatKeyRecord>(&mut arg0.id, v0, v3);
            let v4 = AttestationRegistered{
                registry_id           : 0x2::object::uid_to_inner(&arg0.id),
                durable_public_key    : arg1,
                evidence_hash         : arg6,
                nonce                 : arg4,
                role_tag              : arg2,
                pcrs                  : arg3,
                document_timestamp_ms : arg5,
                matched_set           : assert_claims_admitted<LocalEvidence>(arg0, &arg1, &arg2, &arg3, &arg4, arg5, &arg6, arg7, arg8),
                configuration_version : arg0.configuration_version,
            };
            0x2::event::emit<AttestationRegistered>(v4);
        } else {
            let v5 = 0x2::dynamic_field::borrow_mut<SeatKey, SeatKeyRecord>(&mut arg0.id, v0);
            assert!(!v5.revoked, 13906837292492455980);
            assert!(arg5 > v5.document_timestamp_ms, 13906837296787292202);
            v5.role_tag = arg2;
            v5.document_timestamp_ms = arg5;
            let v6 = AttestationRefreshed{
                registry_id           : 0x2::object::uid_to_inner(&arg0.id),
                durable_public_key    : arg1,
                evidence_hash         : arg6,
                nonce                 : arg4,
                role_tag              : arg2,
                pcrs                  : arg3,
                document_timestamp_ms : arg5,
                matched_set           : assert_claims_admitted<LocalEvidence>(arg0, &arg1, &arg2, &arg3, &arg4, arg5, &arg6, arg7, arg8),
                configuration_version : arg0.configuration_version,
            };
            0x2::event::emit<AttestationRefreshed>(v6);
        };
    }

    fun admit_normalized<T0>(arg0: &mut AttestationRegistry<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<PcrPolicy>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: u64) {
        let v0 = find_registration<T0>(arg0, &arg1);
        if (v0 == 0x1::vector::length<Registration>(&arg0.registrations)) {
            assert_registration_capacity<T0>(arg0);
            let v1 = Registration{
                durable_public_key             : arg1,
                evidence_hash                  : arg6,
                nonce                          : arg4,
                role_tag                       : arg2,
                pcrs                           : arg3,
                document_timestamp_ms          : arg5,
                matched_set                    : assert_claims_admitted<T0>(arg0, &arg1, &arg2, &arg3, &arg4, arg5, &arg6, arg7, arg8),
                admitted_configuration_version : arg0.configuration_version,
                evidence_refreshed_at_ms       : arg7,
                revoked                        : false,
            };
            0x1::vector::push_back<Registration>(&mut arg0.registrations, v1);
            let v2 = 0x1::vector::borrow<Registration>(&arg0.registrations, 0x1::vector::length<Registration>(&arg0.registrations) - 1);
            let v3 = AttestationRegistered{
                registry_id           : 0x2::object::uid_to_inner(&arg0.id),
                durable_public_key    : v2.durable_public_key,
                evidence_hash         : v2.evidence_hash,
                nonce                 : v2.nonce,
                role_tag              : v2.role_tag,
                pcrs                  : v2.pcrs,
                document_timestamp_ms : v2.document_timestamp_ms,
                matched_set           : v2.matched_set,
                configuration_version : arg0.configuration_version,
            };
            0x2::event::emit<AttestationRegistered>(v3);
        } else {
            let v4 = 0x1::vector::borrow_mut<Registration>(&mut arg0.registrations, v0);
            assert!(!v4.revoked, 13906840500833026092);
            assert!(arg5 > v4.document_timestamp_ms, 13906840505127862314);
            v4.evidence_hash = arg6;
            v4.role_tag = arg2;
            v4.pcrs = arg3;
            v4.nonce = arg4;
            v4.document_timestamp_ms = arg5;
            v4.matched_set = assert_claims_admitted<T0>(arg0, &arg1, &arg2, &arg3, &arg4, arg5, &arg6, arg7, arg8);
            v4.admitted_configuration_version = arg0.configuration_version;
            v4.evidence_refreshed_at_ms = arg7;
            let v5 = AttestationRefreshed{
                registry_id           : 0x2::object::uid_to_inner(&arg0.id),
                durable_public_key    : v4.durable_public_key,
                evidence_hash         : v4.evidence_hash,
                nonce                 : v4.nonce,
                role_tag              : v4.role_tag,
                pcrs                  : v4.pcrs,
                document_timestamp_ms : v4.document_timestamp_ms,
                matched_set           : v4.matched_set,
                configuration_version : arg0.configuration_version,
            };
            0x2::event::emit<AttestationRefreshed>(v5);
        };
    }

    fun admit_verified_claims<T0>(arg0: &mut AttestationRegistry<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<PcrPolicy>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64) {
        assert_possession_proof(&arg6, &arg1, &arg7);
        admit_normalized<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
    }

    fun assert_bundle_sizes(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13906839976845705240);
        assert!(0x1::vector::length<u8>(arg1) == 32, 13906839981140934684);
        assert!(0x1::vector::length<u8>(arg2) == 64, 13906839985436033054);
    }

    fun assert_claims_admitted<T0>(arg0: &AttestationRegistry<T0>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<PcrPolicy>, arg4: &vector<u8>, arg5: u64, arg6: &vector<u8>, arg7: u64, arg8: u64) : u8 {
        assert!(0x1::vector::length<u8>(arg6) == 32, 13906840234543743000);
        assert!(0x1::vector::length<u8>(arg1) == 32, 13906840238838972444);
        assert_not_debug_measurements(arg3);
        assert_role_is_accepted(&arg0.accepted_role_tags, arg2);
        assert_registration_nonce<T0>(arg0, arg1, arg4, arg8);
        assert_fresh(arg5, arg7, arg0.maximum_document_age_ms);
        match_admitted_pcrs<T0>(arg0, arg3)
    }

    public fun assert_current_local_registry(arg0: &AttestationRegistry<LocalEvidence>) {
        assert!(is_admitted_version<LocalEvidence>(arg0), 13906841230975369228);
        assert!(!arg0.trusted, 13906841235270467598);
    }

    public fun assert_current_nitro_registry(arg0: &AttestationRegistry<NitroEvidence>) {
        assert!(is_admitted_version<NitroEvidence>(arg0), 13906841200910598156);
        assert!(arg0.trusted, 13906841205205696526);
    }

    fun assert_fresh(arg0: u64, arg1: u64, arg2: u64) {
        assert!(document_is_current(arg0, arg1, arg2), 13906840960394264616);
    }

    fun assert_not_debug_measurements(arg0: &vector<PcrPolicy>) {
        assert!(pcr_is_present_and_nonzero(arg0, 0), 13906840780005376036);
        assert!(pcr_is_present_and_nonzero(arg0, 1), 13906840784300343332);
        assert!(pcr_is_present_and_nonzero(arg0, 2), 13906840788595310628);
    }

    fun assert_possession_proof(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert_bundle_sizes(arg0, arg1, arg2);
        let v0 = possession_proof_message(arg0);
        assert!(0x2::ed25519::ed25519_verify(arg2, arg1, &v0), 13906840036975771680);
    }

    public(friend) fun assert_registration_capacity<T0>(arg0: &AttestationRegistry<T0>) {
        assert!(0x1::vector::length<Registration>(&arg0.registrations) < 1024, 13906841724897263638);
    }

    fun assert_registration_nonce<T0>(arg0: &AttestationRegistry<T0>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) {
        assert!(0x1::vector::length<u8>(arg2) == 32, 13906841003343020058);
        let v0 = 0x2::object::uid_to_bytes(&arg0.id);
        if (*arg2 == registration_nonce(&v0, arg1, arg3)) {
            return
        } else {
            if (arg3 > 0) {
                if (*arg2 == registration_nonce(&v0, arg1, arg3 - 1)) {
                    return
                };
            };
            abort 13906841037702758426
        };
    }

    fun assert_role_is_accepted(arg0: &vector<vector<u8>>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            if (*0x1::vector::borrow<vector<u8>>(arg0, v0) == *arg1) {
                return
            };
            v0 = v0 + 1;
        };
        abort 13906840878789754918
    }

    fun assert_valid_pcr_policies(arg0: &vector<PcrPolicy>) {
        assert!(0x1::vector::length<PcrPolicy>(arg0) > 0 && 0x1::vector::length<PcrPolicy>(arg0) <= 32, 13906841836566020112);
        let v0 = 0;
        while (v0 < 0x1::vector::length<PcrPolicy>(arg0)) {
            let v1 = 0x1::vector::borrow<PcrPolicy>(arg0, v0);
            assert!(v1.index <= 31, 13906841853745889296);
            assert!(0x1::vector::length<u8>(&v1.value) > 0 && 0x1::vector::length<u8>(&v1.value) <= 64, 13906841858040856592);
            assert!(has_nonzero_byte(&v1.value), 13906841862335823888);
            let v2 = 0;
            while (v2 < v0) {
                assert!(0x1::vector::borrow<PcrPolicy>(arg0, v2).index != v1.index, 13906841875220725776);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun assert_valid_policy(arg0: &vector<PcrPolicy>, arg1: &vector<vector<u8>>, arg2: u64) {
        assert_valid_pcr_policies(arg0);
        assert!(0x1::vector::length<vector<u8>>(arg1) > 0 && 0x1::vector::length<vector<u8>>(arg1) <= 16, 13906841763551707154);
        assert!(arg2 > 0, 13906841767846805524);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg1)) {
            let v1 = 0x1::vector::borrow<vector<u8>>(arg1, v0);
            assert!(0x1::vector::length<u8>(v1) > 0 && 0x1::vector::length<u8>(v1) <= 128, 13906841789321510930);
            let v2 = 0;
            while (v2 < v0) {
                assert!(*0x1::vector::borrow<vector<u8>>(arg1, v2) != *v1, 13906841802206412818);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun bump_registry_version<T0>(arg0: &mut AttestationRegistry<T0>) {
        arg0.version = 2;
        let v0 = RegistryVersionMigrated{
            registry_id  : 0x2::object::uid_to_inner(&arg0.id),
            from_version : arg0.version,
            to_version   : 2,
        };
        0x2::event::emit<RegistryVersionMigrated>(v0);
    }

    public fun close_measurement_transition(arg0: &RegistryAdminCap, arg1: &mut AttestationRegistry<NitroEvidence>) {
        assert_current_nitro_registry(arg1);
        assert!(0x1::option::is_some<vector<PcrPolicy>>(&arg1.incoming_pcrs), 13906835892333379632);
        arg1.current_pcrs = 0x1::option::extract<vector<PcrPolicy>>(&mut arg1.incoming_pcrs);
        arg1.configuration_version = arg1.configuration_version + 1;
        let v0 = 0;
        while (v0 < 0x1::vector::length<Registration>(&arg1.registrations)) {
            let v1 = 0x1::vector::borrow_mut<Registration>(&mut arg1.registrations, v0);
            if (v1.matched_set == 0) {
                v1.matched_set = 2;
            } else if (v1.matched_set == 1) {
                v1.matched_set = 0;
            };
            v0 = v0 + 1;
        };
        let v2 = MeasurementTransitionClosed{
            registry_id           : 0x2::object::uid_to_inner(&arg1.id),
            configuration_version : arg1.configuration_version,
        };
        0x2::event::emit<MeasurementTransitionClosed>(v2);
    }

    public fun configuration_version<T0>(arg0: &AttestationRegistry<T0>) : u64 {
        arg0.configuration_version
    }

    public fun create_and_share_local_registry(arg0: vector<PcrPolicy>, arg1: vector<vector<u8>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_policy(&arg0, &arg1, arg2);
        let v0 = AttestationRegistry<LocalEvidence>{
            id                      : 0x2::object::new(arg3),
            version                 : 2,
            configuration_version   : 1,
            current_pcrs            : arg0,
            incoming_pcrs           : 0x1::option::none<vector<PcrPolicy>>(),
            accepted_role_tags      : arg1,
            maximum_document_age_ms : arg2,
            registrations           : 0x1::vector::empty<Registration>(),
            trusted                 : false,
        };
        let v1 = RegistryCreated{
            registry_id           : 0x2::object::uid_to_inner(&v0.id),
            evidence_kind         : 1,
            trusted               : false,
            configuration_version : 1,
        };
        0x2::event::emit<RegistryCreated>(v1);
        0x2::transfer::share_object<AttestationRegistry<LocalEvidence>>(v0);
    }

    public fun create_and_share_trusted_nitro_registry(arg0: &RegistryAdminCap, arg1: vector<PcrPolicy>, arg2: vector<vector<u8>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_policy(&arg1, &arg2, arg3);
        let v0 = AttestationRegistry<NitroEvidence>{
            id                      : 0x2::object::new(arg4),
            version                 : 2,
            configuration_version   : 1,
            current_pcrs            : arg1,
            incoming_pcrs           : 0x1::option::none<vector<PcrPolicy>>(),
            accepted_role_tags      : arg2,
            maximum_document_age_ms : arg3,
            registrations           : 0x1::vector::empty<Registration>(),
            trusted                 : true,
        };
        let v1 = RegistryCreated{
            registry_id           : 0x2::object::uid_to_inner(&v0.id),
            evidence_kind         : 0,
            trusted               : true,
            configuration_version : 1,
        };
        0x2::event::emit<RegistryCreated>(v1);
        0x2::transfer::share_object<AttestationRegistry<NitroEvidence>>(v0);
    }

    public fun current_pcrs<T0>(arg0: &AttestationRegistry<T0>) : vector<PcrPolicy> {
        arg0.current_pcrs
    }

    public fun current_version() : u64 {
        2
    }

    fun document_is_current(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 <= arg1 && arg1 - arg0 <= arg2
    }

    public fun expected_pcrs<T0>(arg0: &AttestationRegistry<T0>) : vector<PcrPolicy> {
        arg0.current_pcrs
    }

    fun find_registration<T0>(arg0: &AttestationRegistry<T0>, arg1: &vector<u8>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Registration>(&arg0.registrations)) {
            if (0x1::vector::borrow<Registration>(&arg0.registrations, v0).durable_public_key == *arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun has_nonzero_byte(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != 0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistryAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RegistryAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_admitted_version<T0>(arg0: &AttestationRegistry<T0>) : bool {
        version_is_admitted(2, arg0.version)
    }

    public fun is_current_local_registration(arg0: &AttestationRegistry<LocalEvidence>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) : bool {
        if (!is_admitted_version<LocalEvidence>(arg0)) {
            return false
        };
        if (0x1::vector::length<u8>(arg1) != 32) {
            return false
        };
        let v0 = SeatKey{durable_public_key: *arg1};
        if (0x2::dynamic_field::exists<SeatKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow<SeatKey, SeatKeyRecord>(&arg0.id, v0);
            return if (v1.role_tag == *arg2) {
                if (!v1.revoked) {
                    document_is_current(v1.document_timestamp_ms, arg3, arg0.maximum_document_age_ms)
                } else {
                    false
                }
            } else {
                false
            }
        };
        is_current_registration_record<LocalEvidence>(arg0, arg1, arg2, arg3)
    }

    public fun is_current_nitro_registration(arg0: &AttestationRegistry<NitroEvidence>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) : bool {
        if (!is_admitted_version<NitroEvidence>(arg0) || !arg0.trusted) {
            return false
        };
        is_current_registration_record<NitroEvidence>(arg0, arg1, arg2, arg3)
    }

    fun is_current_registration_record<T0>(arg0: &AttestationRegistry<T0>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) : bool {
        if (0x1::vector::length<u8>(arg1) != 32) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<Registration>(&arg0.registrations)) {
            let v1 = 0x1::vector::borrow<Registration>(&arg0.registrations, v0);
            let v2 = if (v1.durable_public_key == *arg1) {
                if (v1.role_tag == *arg2) {
                    if (!v1.revoked) {
                        if (matched_set_is_admitted<T0>(arg0, v1.matched_set)) {
                            document_is_current(v1.document_timestamp_ms, arg3, arg0.maximum_document_age_ms)
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
            if (v2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_current_version<T0>(arg0: &AttestationRegistry<T0>) : bool {
        arg0.version == 2
    }

    public fun is_trusted_nitro_registry(arg0: &AttestationRegistry<NitroEvidence>) : bool {
        arg0.trusted
    }

    public fun local_attestation_evidence(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<PcrPolicy>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64) : LocalAttestationEvidence {
        LocalAttestationEvidence{
            durable_public_key : arg0,
            role_tag           : arg1,
            pcrs               : arg2,
            evidence_hash      : arg3,
            nonce              : arg4,
            observed_at_ms     : arg5,
        }
    }

    fun match_admitted_pcrs<T0>(arg0: &AttestationRegistry<T0>, arg1: &vector<PcrPolicy>) : u8 {
        if (pcrs_equal(&arg0.current_pcrs, arg1)) {
            return 0
        } else {
            if (0x1::option::is_some<vector<PcrPolicy>>(&arg0.incoming_pcrs)) {
                if (pcrs_equal(0x1::option::borrow<vector<PcrPolicy>>(&arg0.incoming_pcrs), arg1)) {
                    return 1
                };
            };
            abort 13906840655451193378
        };
    }

    public fun matched_current() : u8 {
        0
    }

    public fun matched_incoming() : u8 {
        1
    }

    public fun matched_retired() : u8 {
        2
    }

    fun matched_set_is_admitted<T0>(arg0: &AttestationRegistry<T0>, arg1: u8) : bool {
        if (arg1 == 0) {
            return true
        };
        if (arg1 == 1 && 0x1::option::is_some<vector<PcrPolicy>>(&arg0.incoming_pcrs)) {
            return true
        };
        false
    }

    public fun maximum_document_age_ms<T0>(arg0: &AttestationRegistry<T0>) : u64 {
        arg0.maximum_document_age_ms
    }

    public fun maximum_registration_count() : u64 {
        1024
    }

    public fun migrate_local_version(arg0: &RegistryAdminCap, arg1: &mut AttestationRegistry<LocalEvidence>) {
        assert_current_local_registry(arg1);
        assert!(arg1.version + 1 == 2, 13906841544507981836);
        bump_registry_version<LocalEvidence>(arg1);
    }

    public fun migrate_version(arg0: &RegistryAdminCap, arg1: &mut AttestationRegistry<NitroEvidence>) {
        assert!(arg1.version + 1 == 2, 13906841445723734028);
        bump_registry_version<NitroEvidence>(arg1);
    }

    public fun new_pcr_policy(arg0: u8, arg1: vector<u8>) : PcrPolicy {
        PcrPolicy{
            index : arg0,
            value : arg1,
        }
    }

    fun normalize_native_document(arg0: &0x2::nitro_attestation::NitroAttestationDocument) : (vector<u8>, vector<u8>, vector<PcrPolicy>, vector<u8>, u64) {
        let v0 = 0x1::vector::empty<PcrPolicy>();
        let v1 = 0x2::nitro_attestation::pcrs(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::nitro_attestation::PCREntry>(v1)) {
            let v3 = 0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(v1, v2);
            let v4 = PcrPolicy{
                index : 0x2::nitro_attestation::index(v3),
                value : *0x2::nitro_attestation::value(v3),
            };
            0x1::vector::push_back<PcrPolicy>(&mut v0, v4);
            v2 = v2 + 1;
        };
        normalize_nitro_claims(*0x2::nitro_attestation::public_key(arg0), *0x2::nitro_attestation::user_data(arg0), *0x2::nitro_attestation::nonce(arg0), v0, *0x2::nitro_attestation::timestamp(arg0))
    }

    fun normalize_nitro_claims(arg0: 0x1::option::Option<vector<u8>>, arg1: 0x1::option::Option<vector<u8>>, arg2: 0x1::option::Option<vector<u8>>, arg3: vector<PcrPolicy>, arg4: u64) : (vector<u8>, vector<u8>, vector<PcrPolicy>, vector<u8>, u64) {
        assert!(0x1::option::is_some<vector<u8>>(&arg0), 13906839895241588764);
        assert!(0x1::option::is_some<vector<u8>>(&arg1), 13906839899537211430);
        assert!(0x1::option::is_some<vector<u8>>(&arg2), 13906839903831392282);
        let v0 = *0x1::option::borrow<vector<u8>>(&arg2);
        assert!(0x1::vector::length<u8>(&v0) == 32, 13906839912421326874);
        (*0x1::option::borrow<vector<u8>>(&arg0), *0x1::option::borrow<vector<u8>>(&arg1), arg3, v0, arg4)
    }

    public fun open_measurement_transition(arg0: &RegistryAdminCap, arg1: &mut AttestationRegistry<NitroEvidence>, arg2: vector<PcrPolicy>) {
        assert_current_nitro_registry(arg1);
        assert!(0x1::option::is_none<vector<PcrPolicy>>(&arg1.incoming_pcrs), 13906835815023837230);
        assert_valid_pcr_policies(&arg2);
        arg1.incoming_pcrs = 0x1::option::some<vector<PcrPolicy>>(arg2);
        arg1.configuration_version = arg1.configuration_version + 1;
        let v0 = MeasurementTransitionOpened{
            registry_id           : 0x2::object::uid_to_inner(&arg1.id),
            configuration_version : arg1.configuration_version,
            incoming_pcr_count    : 0x1::vector::length<PcrPolicy>(0x1::option::borrow<vector<PcrPolicy>>(&arg1.incoming_pcrs)),
        };
        0x2::event::emit<MeasurementTransitionOpened>(v0);
    }

    public fun pcr_index(arg0: &PcrPolicy) : u8 {
        arg0.index
    }

    fun pcr_is_present_and_nonzero(arg0: &vector<PcrPolicy>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PcrPolicy>(arg0)) {
            let v1 = 0x1::vector::borrow<PcrPolicy>(arg0, v0);
            if (v1.index == arg1) {
                return has_nonzero_byte(&v1.value)
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun pcr_value(arg0: &PcrPolicy) : vector<u8> {
        arg0.value
    }

    fun pcrs_equal(arg0: &vector<PcrPolicy>, arg1: &vector<PcrPolicy>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PcrPolicy>(arg0)) {
            let v1 = 0x1::vector::borrow<PcrPolicy>(arg0, v0);
            let v2 = false;
            let v3 = 0;
            while (v3 < 0x1::vector::length<PcrPolicy>(arg1)) {
                let v4 = 0x1::vector::borrow<PcrPolicy>(arg1, v3);
                if (v1.index == v4.index && v1.value == v4.value) {
                    v2 = true;
                };
                v3 = v3 + 1;
            };
            if (!v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun possession_proof_message(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"dopan180/key-possession-v1";
        0x1::vector::append<u8>(&mut v0, *arg0);
        v0
    }

    public fun raw_document_hash(arg0: &vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(*arg0)
    }

    public fun register_local(arg0: &mut AttestationRegistry<LocalEvidence>, arg1: LocalAttestationEvidence, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_current_local_registry(arg0);
        let LocalAttestationEvidence {
            durable_public_key : v0,
            role_tag           : v1,
            pcrs               : v2,
            evidence_hash      : v3,
            nonce              : v4,
            observed_at_ms     : v5,
        } = arg1;
        admit_local_seat_key(arg0, v0, v1, v2, v4, v5, v3, arg2, 0x2::clock::timestamp_ms(arg3), 0x2::tx_context::epoch(arg4));
    }

    public fun register_nitro(arg0: &mut AttestationRegistry<NitroEvidence>, arg1: 0x2::nitro_attestation::NitroAttestationDocument, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_current_nitro_registry(arg0);
        let (v0, v1, v2, v3, v4) = normalize_native_document(&arg1);
        admit_verified_claims<NitroEvidence>(arg0, v0, v1, v2, v3, v4, arg2, arg3, 0x2::clock::timestamp_ms(arg4), 0x2::tx_context::epoch(arg5));
    }

    public fun registration_count<T0>(arg0: &AttestationRegistry<T0>) : u64 {
        0x1::vector::length<Registration>(&arg0.registrations)
    }

    public fun registration_nonce(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13906836463564161074);
        assert!(0x1::vector::length<u8>(arg1) == 32, 13906836467857686556);
        let v0 = b"dopan180/registration-nonce-v1";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::hash::sha2_256(v0)
    }

    public fun registry_version<T0>(arg0: &AttestationRegistry<T0>) : u64 {
        arg0.version
    }

    fun retire_current_matched_registrations<T0>(arg0: &mut AttestationRegistry<T0>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Registration>(&arg0.registrations)) {
            let v1 = 0x1::vector::borrow_mut<Registration>(&mut arg0.registrations, v0);
            if (v1.matched_set == 0) {
                v1.matched_set = 2;
            };
            v0 = v0 + 1;
        };
    }

    public fun revoke_nitro_registration(arg0: &RegistryAdminCap, arg1: &mut AttestationRegistry<NitroEvidence>, arg2: vector<u8>) {
        assert_current_nitro_registry(arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906837584549183516);
        let v0 = find_registration<NitroEvidence>(arg1, &arg2);
        if (v0 == 0x1::vector::length<Registration>(&arg1.registrations)) {
            return
        };
        let v1 = 0x1::vector::borrow_mut<Registration>(&mut arg1.registrations, v0);
        if (!v1.revoked) {
            v1.revoked = true;
            let v2 = AttestationRevoked{
                registry_id           : 0x2::object::uid_to_inner(&arg1.id),
                durable_public_key    : arg2,
                configuration_version : arg1.configuration_version,
            };
            0x2::event::emit<AttestationRevoked>(v2);
        };
    }

    public fun sweep_expired_local(arg0: &mut AttestationRegistry<LocalEvidence>, arg1: vector<vector<u8>>, arg2: &0x2::clock::Clock) : u64 {
        assert_current_local_registry(arg0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(&arg1, v1);
            v1 = v1 + 1;
            let v3 = SeatKey{durable_public_key: v2};
            if (!0x2::dynamic_field::exists<SeatKey>(&arg0.id, v3)) {
                continue
            };
            let v4 = 0x2::dynamic_field::borrow<SeatKey, SeatKeyRecord>(&arg0.id, v3);
            if (v4.revoked) {
                continue
            };
            if (document_is_current(v4.document_timestamp_ms, 0x2::clock::timestamp_ms(arg2), arg0.maximum_document_age_ms)) {
                continue
            };
            let SeatKeyRecord {
                role_tag              : _,
                document_timestamp_ms : _,
                revoked               : _,
            } = 0x2::dynamic_field::remove<SeatKey, SeatKeyRecord>(&mut arg0.id, v3);
            let v8 = SeatKeyReleased{
                registry_id        : 0x2::object::uid_to_inner(&arg0.id),
                durable_public_key : v2,
            };
            0x2::event::emit<SeatKeyReleased>(v8);
            v0 = v0 + 1;
        };
        v0
    }

    public fun update_nitro_policy(arg0: &RegistryAdminCap, arg1: &mut AttestationRegistry<NitroEvidence>, arg2: vector<PcrPolicy>, arg3: vector<vector<u8>>, arg4: u64) {
        assert_current_nitro_registry(arg1);
        assert!(0x1::option::is_none<vector<PcrPolicy>>(&arg1.incoming_pcrs), 13906835716239589422);
        assert_valid_policy(&arg2, &arg3, arg4);
        arg1.current_pcrs = arg2;
        arg1.accepted_role_tags = arg3;
        arg1.maximum_document_age_ms = arg4;
        arg1.configuration_version = arg1.configuration_version + 1;
        retire_current_matched_registrations<NitroEvidence>(arg1);
        let v0 = RegistryPolicyUpdated{
            registry_id             : 0x2::object::uid_to_inner(&arg1.id),
            configuration_version   : arg1.configuration_version,
            pcr_policy_count        : 0x1::vector::length<PcrPolicy>(&arg1.current_pcrs),
            role_tag_count          : 0x1::vector::length<vector<u8>>(&arg1.accepted_role_tags),
            maximum_document_age_ms : arg1.maximum_document_age_ms,
        };
        0x2::event::emit<RegistryPolicyUpdated>(v0);
    }

    public fun version_is_admitted(arg0: u64, arg1: u64) : bool {
        arg1 == arg0 || arg0 > 1 && arg1 == arg0 - 1
    }

    // decompiled from Move bytecode v7
}

