module 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment {
    struct AdmittedRuntime has store {
        signature_type: u8,
        public_key: vector<u8>,
        generation: u64,
        retired: bool,
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
        admitted_runtimes: 0x2::table::Table<vector<u8>, AdmittedRuntime>,
        commitments: 0x2::table::Table<vector<u8>, FrontierCommitment>,
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

    fun admit_registered_runtime(arg0: &FrontierCommitmentAdmissionCap, arg1: &mut FrontierCommitmentStore, arg2: bool, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u64) {
        assert_bound_store(arg0, arg1);
        assert!(arg2, 13906835707648671775);
        assert_execution_id(&arg3);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_signature_type(arg4), 13906835716237688849);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_public_key_length(arg4, &arg5), 13906835729122721811);
        assert!(!0x2::table::contains<vector<u8>, AdmittedRuntime>(&arg1.admitted_runtimes, arg3), 13906835737712787477);
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
        let v0 = b"dopan180/predict-runtime-v1";
        admit_registered_runtime(arg0, arg1, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_nitro_registration(arg2, &arg5, &v0, 0x2::clock::timestamp_ms(arg7)), arg3, arg4, arg5, arg6);
    }

    public fun admit_runtime_local(arg0: &FrontierCommitmentAdmissionCap, arg1: &mut FrontierCommitmentStore, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::LocalEvidence>, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock) {
        let v0 = b"dopan180/predict-runtime-v1";
        admit_registered_runtime(arg0, arg1, 0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_local_registration(arg2, &arg5, &v0, 0x2::clock::timestamp_ms(arg7)), arg3, arg4, arg5, arg6);
    }

    public(friend) fun admitted_runtime_count(arg0: &FrontierCommitmentStore) : u64 {
        0x2::table::length<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes)
    }

    fun assert_bound_store(arg0: &FrontierCommitmentAdmissionCap, arg1: &FrontierCommitmentStore) {
        assert!(arg0.store_id == 0x2::object::id<FrontierCommitmentStore>(arg1), 13906837026202058759);
    }

    fun assert_commitment_ids(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert_execution_id(arg0);
        assert!(0x1::vector::length<u8>(arg1) == 32, 13906837082036895755);
        assert!(0x1::vector::length<u8>(arg2) == 32, 13906837086331994125);
    }

    fun assert_execution_id(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13906837043382059017);
    }

    public fun commit_frontier(arg0: &mut FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u8, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x2::clock::Clock) {
        assert_commitment_ids(&arg1, &arg2, &arg3);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906836012590301199);
        let v0 = commitment_message(&arg1, &arg2, &arg3, arg4, &arg5, arg6);
        verify_admitted_runtime_signature(arg0, arg1, arg6, arg7, arg8, &v0, &arg9);
        let v1 = commitment_key(&arg1, &arg2, &arg3, arg4);
        if (0x2::table::contains<vector<u8>, FrontierCommitment>(&arg0.commitments, v1)) {
            assert!(0x2::table::borrow<vector<u8>, FrontierCommitment>(&arg0.commitments, v1).frontier_digest == arg5, 13906836132851089449);
            return
        };
        let v2 = FrontierCommitment{
            execution_id              : arg1,
            market_id                 : arg2,
            window_id                 : arg3,
            selection_anchor_revision : arg4,
            frontier_digest           : arg5,
            runtime_generation        : arg6,
            published_at_ms           : 0x2::clock::timestamp_ms(arg10),
            consumed                  : false,
        };
        let v3 = FrontierCommitted{
            store_id                  : 0x2::object::id<FrontierCommitmentStore>(arg0),
            execution_id              : v2.execution_id,
            market_id                 : v2.market_id,
            window_id                 : v2.window_id,
            selection_anchor_revision : v2.selection_anchor_revision,
            frontier_digest           : v2.frontier_digest,
            runtime_generation        : v2.runtime_generation,
            published_at_ms           : v2.published_at_ms,
        };
        0x2::event::emit<FrontierCommitted>(v3);
        0x2::table::add<vector<u8>, FrontierCommitment>(&mut arg0.commitments, v1, v2);
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
        assert!(0x2::table::contains<vector<u8>, FrontierCommitment>(&arg0.commitments, v0), 13906837575960231979);
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

    public fun create_store(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906835273857368101);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906835278152335397);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = FrontierCommitmentStore{
            id                : v0,
            admitted_runtimes : 0x2::table::new<vector<u8>, AdmittedRuntime>(arg2),
            commitments       : 0x2::table::new<vector<u8>, FrontierCommitment>(arg2),
        };
        let v3 = &mut v2;
        install_deployment_identity(v3, arg0, arg1, lineage_package_id());
        let v4 = FrontierCommitmentAdmissionCap{
            id       : 0x2::object::new(arg2),
            store_id : v1,
        };
        0x2::transfer::transfer<FrontierCommitmentAdmissionCap>(v4, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<FrontierCommitmentStore>(v2);
        let v5 = FrontierCommitmentStoreCreated{store_id: v1};
        0x2::event::emit<FrontierCommitmentStoreCreated>(v5);
    }

    public(friend) fun deployment_identity(arg0: &FrontierCommitmentStore) : DeploymentIdentity {
        let v0 = DeploymentIdentityKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<DeploymentIdentityKey, DeploymentIdentity>(&arg0.id, v0), 13906838439248003105);
        let v1 = DeploymentIdentityKey{dummy_field: false};
        *0x2::dynamic_field::borrow<DeploymentIdentityKey, DeploymentIdentity>(&arg0.id, v1)
    }

    public(friend) fun has_commitment(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) : bool {
        0x2::table::contains<vector<u8>, FrontierCommitment>(&arg0.commitments, commitment_key(&arg1, &arg2, &arg3, arg4))
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = FrontierCommitmentAdmissionCap{
            id       : 0x2::object::new(arg0),
            store_id : v1,
        };
        0x2::transfer::transfer<FrontierCommitmentAdmissionCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = FrontierCommitmentStore{
            id                : v0,
            admitted_runtimes : 0x2::table::new<vector<u8>, AdmittedRuntime>(arg0),
            commitments       : 0x2::table::new<vector<u8>, FrontierCommitment>(arg0),
        };
        0x2::transfer::share_object<FrontierCommitmentStore>(v3);
        let v4 = FrontierCommitmentStoreCreated{store_id: v1};
        0x2::event::emit<FrontierCommitmentStoreCreated>(v4);
    }

    public(friend) fun install_deployment_identity(arg0: &mut FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) {
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
            assert!(v4, 13906838392003493923);
            return
        };
        let v5 = DeploymentIdentityKey{dummy_field: false};
        0x2::dynamic_field::add<DeploymentIdentityKey, DeploymentIdentity>(&mut arg0.id, v5, v0);
    }

    public(friend) fun is_commitment_consumed(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) : bool {
        let v0 = commitment_key(&arg1, &arg2, &arg3, arg4);
        0x2::table::contains<vector<u8>, FrontierCommitment>(&arg0.commitments, v0) && 0x2::table::borrow<vector<u8>, FrontierCommitment>(&arg0.commitments, v0).consumed
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

    public fun predict_runtime_role_tag() : vector<u8> {
        b"dopan180/predict-runtime-v1"
    }

    public fun prune_commitment(arg0: &FrontierCommitmentAdmissionCap, arg1: &mut FrontierCommitmentStore, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64) {
        assert_bound_store(arg0, arg1);
        assert_commitment_ids(&arg2, &arg3, &arg4);
        let v0 = commitment_key(&arg2, &arg3, &arg4, arg5);
        assert!(0x2::table::contains<vector<u8>, FrontierCommitment>(&arg1.commitments, v0), 13906836811456053291);
        let v1 = 0x2::table::remove<vector<u8>, FrontierCommitment>(&mut arg1.commitments, v0);
        assert!(v1.consumed, 13906836820046118957);
        let v2 = FrontierCommitmentPruned{
            store_id                  : 0x2::object::id<FrontierCommitmentStore>(arg1),
            execution_id              : arg2,
            market_id                 : arg3,
            window_id                 : arg4,
            selection_anchor_revision : arg5,
        };
        0x2::event::emit<FrontierCommitmentPruned>(v2);
    }

    public(friend) fun requires_refund(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) : bool {
        verify_frontier_status(arg0, arg1, arg2, arg3, arg4, arg5) != 0
    }

    public fun retire_runtime(arg0: &FrontierCommitmentAdmissionCap, arg1: &mut FrontierCommitmentStore, arg2: vector<u8>) {
        assert_bound_store(arg0, arg1);
        assert_execution_id(&arg2);
        assert!(0x2::table::contains<vector<u8>, AdmittedRuntime>(&arg1.admitted_runtimes, arg2), 13906835866561937431);
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

    public fun transfer_admission_cap(arg0: FrontierCommitmentAdmissionCap, arg1: address) {
        assert!(arg1 != @0x0, 13906834702627373103);
        0x2::transfer::transfer<FrontierCommitmentAdmissionCap>(arg0, arg1);
    }

    public(friend) fun uid(arg0: &FrontierCommitmentStore) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut FrontierCommitmentStore) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun verify_admitted_runtime_signature(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: u64, arg3: u8, arg4: vector<u8>, arg5: &vector<u8>, arg6: &vector<u8>) {
        assert_execution_id(&arg1);
        assert!(0x2::table::contains<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes, arg1), 13906837279606177815);
        let v0 = 0x2::table::borrow<vector<u8>, AdmittedRuntime>(&arg0.admitted_runtimes, arg1);
        assert!(!v0.retired, 13906837288196243481);
        assert!(arg4 == v0.public_key, 13906837292491341851);
        assert!(arg3 == v0.signature_type, 13906837296786309147);
        assert!(arg2 == v0.generation, 13906837301081407517);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(arg3, &arg4, arg5, arg6), 13906837313966964775);
    }

    public(friend) fun verify_frontier_status(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) : u8 {
        assert_commitment_ids(&arg1, &arg2, &arg3);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906836407727292431);
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

    public fun verify_status(arg0: &FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) : u8 {
        verify_frontier_status(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

