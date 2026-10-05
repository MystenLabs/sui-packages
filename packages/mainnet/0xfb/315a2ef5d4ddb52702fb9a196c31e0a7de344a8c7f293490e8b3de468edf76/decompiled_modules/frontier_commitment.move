module 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::frontier_commitment {
    struct AdmittedRuntime has store {
        signature_type: u8,
        public_key: vector<u8>,
        generation: u64,
        retired: bool,
    }

    struct RevokedEpochKey has copy, drop, store {
        scope_kind: u8,
        scope_id: vector<u8>,
        epoch: u64,
    }

    struct FrontierCommitment has copy, drop, store {
        execution_id: vector<u8>,
        market_id: vector<u8>,
        window_id: vector<u8>,
        selection_anchor_revision: u64,
        frontier_digest: vector<u8>,
        runtime_generation: u64,
        published_at_ms: u64,
        consumed: bool,
    }

    struct FrontierCommitmentStore has key {
        id: 0x2::object::UID,
        module_version: u64,
        evidence_profile: u8,
        attestation_registry_id: 0x2::object::ID,
        admitted_runtimes: 0x2::table::Table<vector<u8>, AdmittedRuntime>,
        commitments: 0x2::table::Table<vector<u8>, FrontierCommitment>,
    }

    struct FenceEpochKey has copy, drop, store {
        scope_kind: u8,
        scope_id: vector<u8>,
        epoch: u64,
    }

    struct LiveFenceKey has copy, drop, store {
        scope_kind: u8,
        scope_id: vector<u8>,
    }

    struct LiveFenceV1 has copy, drop, store {
        epoch: u64,
        fresh_public_key: vector<u8>,
    }

    struct FrontierCommitmentAdmissionCap has key {
        id: 0x2::object::UID,
        store_id: 0x2::object::ID,
    }

    struct DeploymentIdentityKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DeploymentIdentity has copy, drop, store {
        chain_id: vector<u8>,
        environment_id: vector<u8>,
        package_id: vector<u8>,
    }

    struct FrontierCommitmentStoreCreated has copy, drop {
        store_id: 0x2::object::ID,
    }

    struct RuntimeAdmitted has copy, drop {
        store_id: 0x2::object::ID,
        execution_id: vector<u8>,
        signature_type: u8,
        public_key: vector<u8>,
        generation: u64,
    }

    struct RuntimeRetired has copy, drop {
        store_id: 0x2::object::ID,
        execution_id: vector<u8>,
    }

    struct FenceEpochRevoked has copy, drop {
        store_id: 0x2::object::ID,
        execution_id: vector<u8>,
        epoch: u64,
    }

    struct AttestationRegistryRotated has copy, drop {
        store_id: 0x2::object::ID,
        previous_registry_id: 0x2::object::ID,
        new_registry_id: 0x2::object::ID,
    }

    struct FrontierCommitted has copy, drop {
        store_id: 0x2::object::ID,
        execution_id: vector<u8>,
        market_id: vector<u8>,
        window_id: vector<u8>,
        selection_anchor_revision: u64,
        frontier_digest: vector<u8>,
        runtime_generation: u64,
        published_at_ms: u64,
    }

    struct FrontierCommitmentConsumed has copy, drop {
        store_id: 0x2::object::ID,
        execution_id: vector<u8>,
        market_id: vector<u8>,
        window_id: vector<u8>,
        selection_anchor_revision: u64,
        matched: bool,
    }

    struct FrontierCommitmentPruned has copy, drop {
        store_id: 0x2::object::ID,
        execution_id: vector<u8>,
        market_id: vector<u8>,
        window_id: vector<u8>,
        selection_anchor_revision: u64,
    }

    public fun is_admitted_version(arg0: &FrontierCommitmentStore) : bool {
        version_is_admitted(2, arg0.module_version)
    }

    fun admit_registered_runtime(arg0: &FrontierCommitmentAdmissionCap, arg1: &mut FrontierCommitmentStore, arg2: bool, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u64) {
        assert_bound_store(arg0, arg1);
        assert!(arg2, 13906837009024614444);
        assert_execution_id(&arg3);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_signature_type(arg4), 13906837017612845074);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_public_key_length(arg4, &arg5), 13906837030497878036);
        assert!(has_live_fence(arg1, 0, arg3), 13906837051973632034);
        assert!(arg5 == live_fence_key(arg1, 0, arg3), 13906837064858140700);
        assert!(arg6 == live_fence_epoch(arg1, 0, arg3), 13906837082038140958);
        assert!(!0x2::table::contains<vector<u8>, AdmittedRuntime>(&arg1.admitted_runtimes, arg3), 13906837090627551254);
        let v0 = AdmittedRuntime{
            signature_type : arg4,
            public_key     : arg5,
            generation     : arg6,
            retired        : false,
        };
        0x2::table::add<vector<u8>, AdmittedRuntime>(&mut arg1.admitted_runtimes, arg3, v0);
        let v1 = RuntimeAdmitted{
            store_id       : 0x2::object::id<FrontierCommitmentStore>(arg1),
            execution_id   : arg3,
            signature_type : arg4,
            public_key     : arg5,
            generation     : arg6,
        };
        0x2::event::emit<RuntimeAdmitted>(v1);
    }

    public fun admit_runtime(arg0: &FrontierCommitmentAdmissionCap, arg1: &mut FrontierCommitmentStore, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock) {
        assert_admitted_version(arg1);
        assert_attested_profile(arg1);
        assert_registry_is_canonical(arg1, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>>(arg2));
        let v0 = b"dopan180/predict-runtime-v1";
        admit_registered_runtime(arg0, arg1, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_nitro_registration(arg2, &arg5, &v0, 0x2::clock::timestamp_ms(arg7)), arg3, arg4, arg5, arg6);
    }

    public fun admit_runtime_local(arg0: &FrontierCommitmentAdmissionCap, arg1: &mut FrontierCommitmentStore, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock) {
        assert_admitted_version(arg1);
        assert_local_profile(arg1);
        assert_registry_is_canonical(arg1, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>>(arg2));
        let v0 = b"dopan180/predict-runtime-v1";
        admit_registered_runtime(arg0, arg1, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_local_registration(arg2, &arg5, &v0, 0x2::clock::timestamp_ms(arg7)), arg3, arg4, arg5, arg6);
        append_fence_epoch_key(arg1, 0, arg3, arg6, arg5);
    }

    public(friend) fun admitted_runtime_count(arg0: &FrontierCommitmentStore) : u64 {
        0x2::table::length<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes)
    }

    public(friend) fun admitted_signature_type(arg0: &FrontierCommitmentStore, arg1: vector<u8>) : u8 {
        assert!(0x2::table::contains<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes, arg1), 13906840109989691416);
        0x2::table::borrow<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes, arg1).signature_type
    }

    public(friend) fun append_fence_epoch_key(arg0: &mut FrontierCommitmentStore, arg1: u8, arg2: vector<u8>, arg3: u64, arg4: vector<u8>) {
        let v0 = &mut arg0.id;
        if (arg1 == 0) {
            let v1 = FenceEpochKey{
                scope_kind : arg1,
                scope_id   : arg2,
                epoch      : arg3,
            };
            if (!0x2::dynamic_field::exists_with_type<FenceEpochKey, vector<u8>>(v0, v1)) {
                0x2::dynamic_field::add<FenceEpochKey, vector<u8>>(v0, v1, arg4);
            };
        };
        let v2 = LiveFenceKey{
            scope_kind : arg1,
            scope_id   : arg2,
        };
        if (0x2::dynamic_field::exists_with_type<LiveFenceKey, LiveFenceV1>(v0, v2)) {
            if (0x2::dynamic_field::borrow<LiveFenceKey, LiveFenceV1>(v0, v2).epoch >= arg3) {
                return
            };
            let v3 = 0x2::dynamic_field::borrow_mut<LiveFenceKey, LiveFenceV1>(v0, v2);
            v3.epoch = arg3;
            v3.fresh_public_key = arg4;
        } else {
            let v4 = LiveFenceV1{
                epoch            : arg3,
                fresh_public_key : arg4,
            };
            0x2::dynamic_field::add<LiveFenceKey, LiveFenceV1>(v0, v2, v4);
        };
    }

    fun assert_admitted_unretired(arg0: &FrontierCommitmentStore, arg1: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes, arg1), 13906840135759495192);
        assert!(!0x2::table::borrow<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes, arg1).retired, 13906840140054593562);
    }

    public(friend) fun assert_admitted_version(arg0: &FrontierCommitmentStore) {
        assert!(is_admitted_version(arg0), 13906836506514620478);
    }

    public(friend) fun assert_attested_profile(arg0: &FrontierCommitmentStore) {
        assert!(arg0.evidence_profile == 0, 13906839422795448352);
    }

    fun assert_bound_store(arg0: &FrontierCommitmentAdmissionCap, arg1: &FrontierCommitmentStore) {
        assert!(arg0.store_id == 0x2::object::id<FrontierCommitmentStore>(arg1), 13906839160800870408);
    }

    fun assert_commitment_ids(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert_execution_id(arg0);
        assert!(0x1::vector::length<u8>(arg1) == 32, 13906839216635707404);
        assert!(0x1::vector::length<u8>(arg2) == 32, 13906839220930805774);
    }

    fun assert_execution_id(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13906839177980870666);
    }

    public(friend) fun assert_local_profile(arg0: &FrontierCommitmentStore) {
        assert!(arg0.evidence_profile == 1, 13906839439975317536);
    }

    public(friend) fun assert_registry_is_canonical(arg0: &FrontierCommitmentStore, arg1: 0x2::object::ID) {
        assert!(arg1 == arg0.attestation_registry_id, 13906839555939958824);
    }

    public(friend) fun assert_store_is_canonical(arg0: 0x2::object::ID, arg1: &FrontierCommitmentStore) {
        assert!(arg0 == 0x2::object::id<FrontierCommitmentStore>(arg1), 13906839512988188680);
    }

    public fun attestation_registry_id(arg0: &FrontierCommitmentStore) : 0x2::object::ID {
        arg0.attestation_registry_id
    }

    public fun commit_frontier(arg0: &mut FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u8, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>) {
        assert_admitted_version(arg0);
        assert_commitment_ids(&arg1, &arg2, &arg3);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906837820771598352);
        verify_admitted_runtime_signature(arg0, arg11, arg10, arg1, arg6, arg7, arg8, commitment_message(&arg1, &arg2, &arg3, arg4, &arg5, arg6), arg9);
        publish_commitment(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg10));
    }

    public fun commit_frontier_local(arg0: &mut FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u8, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>) {
        assert_admitted_version(arg0);
        assert_local_profile(arg0);
        assert_commitment_ids(&arg1, &arg2, &arg3);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906838039814930448);
        verify_admitted_runtime_signature_local(arg0, arg10, arg1, arg6, arg7, arg8, commitment_message(&arg1, &arg2, &arg3, arg4, &arg5, arg6), arg9);
        publish_commitment(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0);
    }

    public(friend) fun commitment_count(arg0: &FrontierCommitmentStore) : u64 {
        0x2::table::length<vector<u8>, FrontierCommitment>(&arg0.commitments)
    }

    fun commitment_key(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<vector<u8>>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        v0
    }

    fun commitment_message(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64, arg4: &vector<u8>, arg5: u64) : vector<u8> {
        let v0 = b"dopan622/frontier-commitment/v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        v0
    }

    public(friend) fun committed_frontier_digest(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) : vector<u8> {
        let v0 = commitment_key(&arg1, &arg2, &arg3, arg4);
        assert!(0x2::table::contains<vector<u8>, FrontierCommitment>(&arg0.commitments, v0), 13906841016229888056);
        0x2::table::borrow<vector<u8>, FrontierCommitment>(&arg0.commitments, v0).frontier_digest
    }

    public(friend) fun consume_for_reconciliation(arg0: &mut FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) : bool {
        let v0 = verify_frontier_status(arg0, arg1, arg2, arg3, arg4, arg5) == 0;
        let v1 = commitment_key(&arg1, &arg2, &arg3, arg4);
        if (0x2::table::contains<vector<u8>, FrontierCommitment>(&arg0.commitments, v1)) {
            0x2::table::borrow_mut<vector<u8>, FrontierCommitment>(&mut arg0.commitments, v1).consumed = true;
        };
        let v2 = FrontierCommitmentConsumed{
            store_id                  : 0x2::object::id<FrontierCommitmentStore>(arg0),
            execution_id              : arg1,
            market_id                 : arg2,
            window_id                 : arg3,
            selection_anchor_revision : arg4,
            matched                   : v0,
        };
        0x2::event::emit<FrontierCommitmentConsumed>(v2);
        v0
    }

    public fun create_local_store(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinIssuerCap, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::issuer_cap_ledger_id(arg0) == 0x2::object::id<0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger>(arg1), 13906836167208665096);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::frontier_store_id(arg1) == 0x2::object::id_from_address(@0x0), 13906836180093566984);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::local_frontier_store_id(arg1) == 0x2::object::id_from_address(@0x0), 13906836197275664426);
        let v0 = new_store(1, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>>(arg2), arg3, arg4, arg5);
        let v1 = 0x2::object::id<FrontierCommitmentStore>(&v0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::set_local_frontier_store_id(arg1, v1);
        mint_store_cap_and_share(v0, v1, arg5);
    }

    public fun create_store(arg0: &0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinIssuerCap, arg1: &mut 0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::assert_admitted_version(arg1);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::issuer_cap_ledger_id(arg0) == 0x2::object::id<0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::PlayCoinLedger>(arg1), 13906836008294875144);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::local_frontier_store_id(arg1) == 0x2::object::id_from_address(@0x0), 13906836034064678920);
        assert!(0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::frontier_store_id(arg1) == 0x2::object::id_from_address(@0x0), 13906836051246776362);
        let v0 = new_store(0, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>>(arg2), arg3, arg4, arg5);
        let v1 = 0x2::object::id<FrontierCommitmentStore>(&v0);
        0xfb315a2ef5d4ddb52702fb9a196c31e0a7de344a8c7f293490e8b3de468edf76::play_coin::set_frontier_store_id(arg1, v1);
        mint_store_cap_and_share(v0, v1, arg5);
    }

    public fun current_module_version() : u64 {
        2
    }

    public(friend) fun deployment_identity(arg0: &FrontierCommitmentStore) : DeploymentIdentity {
        let v0 = DeploymentIdentityKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<DeploymentIdentityKey, DeploymentIdentity>(&arg0.id, v0), 13906841913877397550);
        let v1 = DeploymentIdentityKey{dummy_field: false};
        *0x2::dynamic_field::borrow<DeploymentIdentityKey, DeploymentIdentity>(&arg0.id, v1)
    }

    public fun evidence_profile(arg0: &FrontierCommitmentStore) : u8 {
        arg0.evidence_profile
    }

    public(friend) fun fence_epoch_key(arg0: &FrontierCommitmentStore, arg1: u8, arg2: vector<u8>, arg3: u64) : 0x1::option::Option<vector<u8>> {
        let v0 = FenceEpochKey{
            scope_kind : arg1,
            scope_id   : arg2,
            epoch      : arg3,
        };
        if (0x2::dynamic_field::exists_with_type<FenceEpochKey, vector<u8>>(&arg0.id, v0)) {
            0x1::option::some<vector<u8>>(*0x2::dynamic_field::borrow<FenceEpochKey, vector<u8>>(&arg0.id, v0))
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public(friend) fun has_commitment(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) : bool {
        0x2::table::contains<vector<u8>, FrontierCommitment>(&arg0.commitments, commitment_key(&arg1, &arg2, &arg3, arg4))
    }

    public(friend) fun has_live_fence(arg0: &FrontierCommitmentStore, arg1: u8, arg2: vector<u8>) : bool {
        let v0 = LiveFenceKey{
            scope_kind : arg1,
            scope_id   : arg2,
        };
        0x2::dynamic_field::exists_with_type<LiveFenceKey, LiveFenceV1>(&arg0.id, v0)
    }

    public(friend) fun identity_chain_id(arg0: &DeploymentIdentity) : vector<u8> {
        arg0.chain_id
    }

    public(friend) fun identity_environment_id(arg0: &DeploymentIdentity) : vector<u8> {
        arg0.environment_id
    }

    public(friend) fun identity_package_id(arg0: &DeploymentIdentity) : vector<u8> {
        arg0.package_id
    }

    public(friend) fun install_deployment_identity(arg0: &mut FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) {
        assert_admitted_version(arg0);
        let v0 = DeploymentIdentity{
            chain_id       : arg1,
            environment_id : arg2,
            package_id     : arg3,
        };
        let v1 = DeploymentIdentityKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<DeploymentIdentityKey, DeploymentIdentity>(&arg0.id, v1)) {
            let v2 = DeploymentIdentityKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow<DeploymentIdentityKey, DeploymentIdentity>(&arg0.id, v2);
            let v4 = if (v3.chain_id == v0.chain_id) {
                if (v3.environment_id == v0.environment_id) {
                    v3.package_id == v0.package_id
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v4, 13906841866632888368);
            return
        };
        let v5 = DeploymentIdentityKey{dummy_field: false};
        0x2::dynamic_field::add<DeploymentIdentityKey, DeploymentIdentity>(&mut arg0.id, v5, v0);
    }

    public(friend) fun is_commitment_consumed(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) : bool {
        let v0 = commitment_key(&arg1, &arg2, &arg3, arg4);
        0x2::table::contains<vector<u8>, FrontierCommitment>(&arg0.commitments, v0) && 0x2::table::borrow<vector<u8>, FrontierCommitment>(&arg0.commitments, v0).consumed
    }

    public(friend) fun is_fence_epoch_revoked(arg0: &FrontierCommitmentStore, arg1: u8, arg2: vector<u8>, arg3: u64) : bool {
        let v0 = RevokedEpochKey{
            scope_kind : arg1,
            scope_id   : arg2,
            epoch      : arg3,
        };
        0x2::dynamic_field::exists_with_type<RevokedEpochKey, bool>(&arg0.id, v0)
    }

    public(friend) fun is_runtime_admitted(arg0: &FrontierCommitmentStore, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes, arg1)
    }

    public(friend) fun is_runtime_retired(arg0: &FrontierCommitmentStore, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes, arg1) && 0x2::table::borrow<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes, arg1).retired
    }

    public(friend) fun lineage_package_id() : vector<u8> {
        0x2::address::to_bytes(0x1::type_name::original_id<FrontierCommitmentStore>())
    }

    public(friend) fun live_fence_epoch(arg0: &FrontierCommitmentStore, arg1: u8, arg2: vector<u8>) : u64 {
        let v0 = LiveFenceKey{
            scope_kind : arg1,
            scope_id   : arg2,
        };
        assert!(0x2::dynamic_field::exists_with_type<LiveFenceKey, LiveFenceV1>(&arg0.id, v0), 13906839998321197090);
        0x2::dynamic_field::borrow<LiveFenceKey, LiveFenceV1>(&arg0.id, v0).epoch
    }

    public(friend) fun live_fence_key(arg0: &FrontierCommitmentStore, arg1: u8, arg2: vector<u8>) : vector<u8> {
        let v0 = LiveFenceKey{
            scope_kind : arg1,
            scope_id   : arg2,
        };
        assert!(0x2::dynamic_field::exists_with_type<LiveFenceKey, LiveFenceV1>(&arg0.id, v0), 13906840062745706530);
        0x2::dynamic_field::borrow<LiveFenceKey, LiveFenceV1>(&arg0.id, v0).fresh_public_key
    }

    public fun migrate_version(arg0: &mut FrontierCommitmentStore, arg1: &FrontierCommitmentAdmissionCap) : u64 {
        if (arg0.module_version == 2) {
            return 2
        };
        assert!(arg0.module_version < 2, 13906836588118999102);
        arg0.module_version = 2;
        2
    }

    fun mint_store_cap_and_share(arg0: FrontierCommitmentStore, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FrontierCommitmentAdmissionCap{
            id       : 0x2::object::new(arg2),
            store_id : arg1,
        };
        0x2::transfer::transfer<FrontierCommitmentAdmissionCap>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<FrontierCommitmentStore>(arg0);
        let v1 = FrontierCommitmentStoreCreated{store_id: arg1};
        0x2::event::emit<FrontierCommitmentStoreCreated>(v1);
    }

    public fun module_version(arg0: &FrontierCommitmentStore) : u64 {
        arg0.module_version
    }

    fun new_store(arg0: u8, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : FrontierCommitmentStore {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906836274585600050);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906836278880567346);
        let v0 = FrontierCommitmentStore{
            id                      : 0x2::object::new(arg4),
            module_version          : 2,
            evidence_profile        : arg0,
            attestation_registry_id : arg1,
            admitted_runtimes       : 0x2::table::new<vector<u8>, AdmittedRuntime>(arg4),
            commitments             : 0x2::table::new<vector<u8>, FrontierCommitment>(arg4),
        };
        let v1 = &mut v0;
        install_deployment_identity(v1, arg2, arg3, lineage_package_id());
        v0
    }

    public fun predict_runtime_role_tag() : vector<u8> {
        b"dopan180/predict-runtime-v1"
    }

    public fun prune_commitment(arg0: &FrontierCommitmentAdmissionCap, arg1: &mut FrontierCommitmentStore, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64) {
        assert_admitted_version(arg1);
        assert_bound_store(arg0, arg1);
        assert_commitment_ids(&arg2, &arg3, &arg4);
        let v0 = commitment_key(&arg2, &arg3, &arg4, arg5);
        assert!(0x2::table::contains<vector<u8>, FrontierCommitment>(&arg1.commitments, v0), 13906838946055651384);
        let v1 = 0x2::table::remove<vector<u8>, FrontierCommitment>(&mut arg1.commitments, v0);
        assert!(v1.consumed, 13906838954645717050);
        let v2 = FrontierCommitmentPruned{
            store_id                  : 0x2::object::id<FrontierCommitmentStore>(arg1),
            execution_id              : arg2,
            market_id                 : arg3,
            window_id                 : arg4,
            selection_anchor_revision : arg5,
        };
        0x2::event::emit<FrontierCommitmentPruned>(v2);
    }

    fun publish_commitment(arg0: &mut FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64) {
        let v0 = commitment_key(&arg1, &arg2, &arg3, arg4);
        if (0x2::table::contains<vector<u8>, FrontierCommitment>(&arg0.commitments, v0)) {
            assert!(0x2::table::borrow<vector<u8>, FrontierCommitment>(&arg0.commitments, v0).frontier_digest == arg5, 13906838258860752950);
            return
        };
        let v1 = FrontierCommitment{
            execution_id              : arg1,
            market_id                 : arg2,
            window_id                 : arg3,
            selection_anchor_revision : arg4,
            frontier_digest           : arg5,
            runtime_generation        : arg6,
            published_at_ms           : arg7,
            consumed                  : false,
        };
        let v2 = FrontierCommitted{
            store_id                  : 0x2::object::id<FrontierCommitmentStore>(arg0),
            execution_id              : v1.execution_id,
            market_id                 : v1.market_id,
            window_id                 : v1.window_id,
            selection_anchor_revision : v1.selection_anchor_revision,
            frontier_digest           : v1.frontier_digest,
            runtime_generation        : v1.runtime_generation,
            published_at_ms           : v1.published_at_ms,
        };
        0x2::event::emit<FrontierCommitted>(v2);
        0x2::table::add<vector<u8>, FrontierCommitment>(&mut arg0.commitments, v0, v1);
    }

    public(friend) fun requires_refund(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) : bool {
        verify_frontier_status(arg0, arg1, arg2, arg3, arg4, arg5) != 0
    }

    public fun retire_runtime(arg0: &FrontierCommitmentAdmissionCap, arg1: &mut FrontierCommitmentStore, arg2: vector<u8>) {
        assert_admitted_version(arg1);
        assert_bound_store(arg0, arg1);
        assert_execution_id(&arg2);
        assert!(0x2::table::contains<vector<u8>, AdmittedRuntime>(&arg1.admitted_runtimes, arg2), 13906837223771668504);
        let v0 = 0x2::table::borrow_mut<vector<u8>, AdmittedRuntime>(&mut arg1.admitted_runtimes, arg2);
        if (!v0.retired) {
            v0.retired = true;
            let v1 = RuntimeRetired{
                store_id     : 0x2::object::id<FrontierCommitmentStore>(arg1),
                execution_id : arg2,
            };
            0x2::event::emit<RuntimeRetired>(v1);
        };
    }

    public fun revoke_fence_epoch(arg0: &mut FrontierCommitmentStore, arg1: &FrontierCommitmentAdmissionCap, arg2: vector<u8>, arg3: u64) {
        assert_admitted_version(arg0);
        assert_bound_store(arg1, arg0);
        assert_execution_id(&arg2);
        assert!(has_live_fence(arg0, 0, arg2), 13906837408455917602);
        assert!(arg3 <= live_fence_epoch(arg0, 0, arg2), 13906837425635786786);
        let v0 = RevokedEpochKey{
            scope_kind : 0,
            scope_id   : arg2,
            epoch      : arg3,
        };
        if (0x2::dynamic_field::exists_with_type<RevokedEpochKey, bool>(&arg0.id, v0)) {
            return
        };
        0x2::dynamic_field::add<RevokedEpochKey, bool>(&mut arg0.id, v0, true);
        let v1 = FenceEpochRevoked{
            store_id     : 0x2::object::id<FrontierCommitmentStore>(arg0),
            execution_id : arg2,
            epoch        : arg3,
        };
        0x2::event::emit<FenceEpochRevoked>(v1);
    }

    public fun rotate_attestation_registry(arg0: &mut FrontierCommitmentStore, arg1: &FrontierCommitmentAdmissionCap, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>) {
        assert_admitted_version(arg0);
        assert_bound_store(arg1, arg0);
        assert_attested_profile(arg0);
        rotate_registry(arg0, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>>(arg2));
    }

    public fun rotate_attestation_registry_local(arg0: &mut FrontierCommitmentStore, arg1: &FrontierCommitmentAdmissionCap, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>) {
        assert_admitted_version(arg0);
        assert_bound_store(arg1, arg0);
        assert_local_profile(arg0);
        rotate_registry(arg0, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>>(arg2));
    }

    fun rotate_registry(arg0: &mut FrontierCommitmentStore, arg1: 0x2::object::ID) {
        arg0.attestation_registry_id = arg1;
        let v0 = AttestationRegistryRotated{
            store_id             : 0x2::object::id<FrontierCommitmentStore>(arg0),
            previous_registry_id : arg0.attestation_registry_id,
            new_registry_id      : arg1,
        };
        0x2::event::emit<AttestationRegistryRotated>(v0);
    }

    public(friend) fun scope_execution_kind() : u8 {
        0
    }

    public(friend) fun scope_wallet_kind() : u8 {
        1
    }

    public fun transfer_admission_cap(arg0: FrontierCommitmentAdmissionCap, arg1: address) {
        assert!(arg1 != @0x0, 13906835084880314428);
        0x2::transfer::transfer<FrontierCommitmentAdmissionCap>(arg0, arg1);
    }

    public(friend) fun uid(arg0: &FrontierCommitmentStore) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut FrontierCommitmentStore) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun verify_admitted_runtime_signature(arg0: &FrontierCommitmentStore, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: u64, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>) {
        assert_execution_id(&arg3);
        assert_attested_profile(arg0);
        assert_registry_is_canonical(arg0, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>>(arg1));
        assert_admitted_unretired(arg0, arg3);
        assert!(arg5 == admitted_signature_type(arg0, arg3), 13906840273198710812);
        assert!(has_live_fence(arg0, 0, arg3), 13906840277494071330);
        assert!(arg6 == live_fence_key(arg0, 0, arg3), 13906840290379104292);
        assert!(arg4 == live_fence_epoch(arg0, 0, arg3), 13906840307559104550);
        assert!(!is_fence_epoch_revoked(arg0, 0, arg3, arg4), 13906840333330612288);
        let v0 = b"dopan180/predict-runtime-v1";
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_nitro_registration(arg1, &arg6, &v0, 0x2::clock::timestamp_ms(arg2)), 13906840384868909100);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(arg5, &arg6, &arg7, &arg8), 13906840402049302580);
    }

    public(friend) fun verify_admitted_runtime_signature_local(arg0: &FrontierCommitmentStore, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg2: vector<u8>, arg3: u64, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>) {
        assert_execution_id(&arg2);
        assert_local_profile(arg0);
        assert_registry_is_canonical(arg0, 0x2::object::id<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>>(arg1));
        assert_admitted_unretired(arg0, arg2);
        let v0 = 0x2::table::borrow<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes, arg2);
        assert!(arg4 == v0.signature_type, 13906840509421912092);
        assert!(arg5 == v0.public_key, 13906840513716879388);
        assert!(arg3 == v0.generation, 13906840518011977758);
        assert!(!is_fence_epoch_revoked(arg0, 0, arg2, arg3), 13906840530899107904);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_admitted_version<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>(arg1), 13906840560962568236);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(arg4, &arg5, &arg6, &arg7), 13906840578142961716);
    }

    public(friend) fun verify_frontier_status(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) : u8 {
        assert_commitment_ids(&arg1, &arg2, &arg3);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906838538031136784);
        let v0 = commitment_key(&arg1, &arg2, &arg3, arg4);
        if (!0x2::table::contains<vector<u8>, FrontierCommitment>(&arg0.commitments, v0)) {
            return 1
        };
        if (0x2::table::borrow<vector<u8>, FrontierCommitment>(&arg0.commitments, v0).frontier_digest == arg5) {
            0
        } else {
            2
        }
    }

    public(friend) fun verify_match() : u8 {
        0
    }

    public(friend) fun verify_mismatch() : u8 {
        2
    }

    public(friend) fun verify_missing() : u8 {
        1
    }

    public(friend) fun verify_receipt_signature(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: u64, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) {
        assert_execution_id(&arg1);
        assert!(0x2::table::contains<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes, arg1), 13906840702695178264);
        assert!(arg3 == admitted_signature_type(arg0, arg1), 13906840706990407708);
        assert!(!is_runtime_retired(arg0, arg1), 13906840711285243930);
        assert!(!is_fence_epoch_revoked(arg0, 0, arg1, arg2), 13906840724172636224);
        let v0 = fence_epoch_key(arg0, 0, arg1, arg2);
        assert!(0x1::option::is_some<vector<u8>>(&v0), 13906840737055703076);
        assert!(*0x1::option::borrow<vector<u8>>(&v0) == arg4, 13906840741350670372);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(arg3, &arg4, &arg5, &arg6), 13906840754236620852);
    }

    public fun verify_status(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) : u8 {
        assert_admitted_version(arg0);
        verify_frontier_status(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun version_is_admitted(arg0: u64, arg1: u64) : bool {
        arg1 <= arg0
    }

    // decompiled from Move bytecode v7
}

