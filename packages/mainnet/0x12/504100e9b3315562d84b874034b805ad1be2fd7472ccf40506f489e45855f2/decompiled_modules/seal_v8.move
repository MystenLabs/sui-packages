module 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8 {
    struct MakerCompanionBindingWitnessV2 has drop {
        dummy_field: bool,
    }

    struct SealOriginalMarkerV8 has drop {
        dummy_field: bool,
    }

    struct SealCallableMarkerV8 has drop {
        dummy_field: bool,
    }

    struct SealSetupInstallWitnessV2 has drop {
        dummy_field: bool,
    }

    struct KeyServerRowV2 has copy, drop, store {
        key_server_id: 0x2::object::ID,
        weight: u16,
    }

    struct SealPolicyConfigV8 has key {
        id: 0x2::object::UID,
        version: u64,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        seal_original_package_id: 0x2::object::ID,
        seal_callable_package_id: 0x2::object::ID,
        seal_binding_commitment: vector<u8>,
        seal_authority_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        role: u8,
        finalized: bool,
        key_servers: vector<KeyServerRowV2>,
        threshold: u16,
        cipher_suite: 0x1::string::String,
        key_derivation: 0x1::string::String,
        ciphertext_format: 0x1::string::String,
        max_plaintext_bytes: u64,
        key_server_set_commitment: vector<u8>,
        encryption_policy_commitment: vector<u8>,
        commitment: vector<u8>,
        config_commitment: vector<u8>,
    }

    struct ProtectedAssetKeyV8 has copy, drop, store {
        scope_kind: u8,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
    }

    struct ProtectedAssetV8 has copy, drop, store {
        scope_kind: u8,
        scope_key: 0x1::string::String,
        scope_commitment: vector<u8>,
        asset_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
        ciphertext_blob_id: 0x1::string::String,
        ciphertext_sha256: vector<u8>,
        ciphertext_blob_commitment: vector<u8>,
        certification_commitment: vector<u8>,
        seal_id: vector<u8>,
    }

    struct ProtectedAssetSnapshotV8 has copy, drop, store {
        registry_id: 0x2::object::ID,
        registry_commitment: vector<u8>,
        runtime_revision: u64,
        runtime_commitment: vector<u8>,
        policy_config_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        scope_kind: u8,
        scope_key: 0x1::string::String,
        scope_commitment: vector<u8>,
        asset_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
        ciphertext_blob_id: 0x1::string::String,
        ciphertext_sha256: vector<u8>,
        ciphertext_blob_commitment: vector<u8>,
        certification_commitment: vector<u8>,
        seal_id: vector<u8>,
    }

    struct SealRegistryV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        policy_config_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
        expected_base_count: u64,
        expected_pack_count: u64,
        expected_complete_count: u64,
        base_count: u64,
        pack_count: u64,
        complete_count: u64,
        base_commitment: vector<u8>,
        pack_commitment: vector<u8>,
        complete_commitment: vector<u8>,
        revision: u64,
        commitment: vector<u8>,
        sealed: bool,
        keys: vector<ProtectedAssetKeyV8>,
        assets: 0x2::table::Table<ProtectedAssetKeyV8, ProtectedAssetV8>,
        runtime_revision: u64,
        runtime_keys: vector<ProtectedAssetKeyV8>,
        runtime_assets: 0x2::table::Table<ProtectedAssetKeyV8, ProtectedAssetV8>,
    }

    struct CiphertextCertificationV8 {
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        policy_config_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        scope_kind: u8,
        scope_key: 0x1::string::String,
        scope_commitment: vector<u8>,
        asset_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
        ciphertext_blob_id: 0x1::string::String,
        ciphertext_sha256: vector<u8>,
        ciphertext_blob_commitment: vector<u8>,
        certification_commitment: vector<u8>,
        seal_id: vector<u8>,
    }

    struct BaseDecryptProofV8 {
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        entitlement_id: 0x2::object::ID,
        entitlement_commitment: vector<u8>,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
        seal_id: vector<u8>,
    }

    struct PackDecryptProofV8 {
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        base_entitlement_id: 0x2::object::ID,
        base_entitlement_commitment: vector<u8>,
        pack_entitlement_id: 0x2::object::ID,
        pack_entitlement_commitment: vector<u8>,
        pack_release_id: 0x2::object::ID,
        pack_content_commitment: vector<u8>,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
        seal_id: vector<u8>,
    }

    struct CompleteDecryptProofV8 {
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        receipt_id: 0x2::object::ID,
        output_id: 0x2::object::ID,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        output_commitment: vector<u8>,
        receipt_commitment: vector<u8>,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
        seal_id: vector<u8>,
    }

    struct KeyServerSetCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        ordered_key_servers: vector<KeyServerRowV2>,
        threshold: u16,
    }

    struct EncryptionPolicyCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        cipher_suite: 0x1::string::String,
        key_derivation: 0x1::string::String,
        ciphertext_format: 0x1::string::String,
        max_plaintext_bytes: u64,
    }

    struct SealPolicyCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        policy_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        key_server_set_commitment: vector<u8>,
        encryption_policy_commitment: vector<u8>,
    }

    struct SealRegistryCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        policy_id: 0x2::object::ID,
        base_count: u64,
        pack_count: u64,
        complete_count: u64,
        base_commitment: vector<u8>,
        pack_commitment: vector<u8>,
        complete_commitment: vector<u8>,
        revision: u64,
        sealed: bool,
    }

    struct CiphertextCertificationCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        policy_commitment: vector<u8>,
        root_content_commitment: vector<u8>,
        maker_version: u64,
        scope_kind: u8,
        scope_key: 0x1::string::String,
        scope_commitment: vector<u8>,
        asset_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
        ciphertext_blob_id: 0x1::string::String,
        ciphertext_sha256: vector<u8>,
        ciphertext_blob_commitment: vector<u8>,
    }

    struct SealIdInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        product_binding_commitment: vector<u8>,
        policy_commitment: vector<u8>,
        root_content_commitment: vector<u8>,
        maker_version: u64,
        scope_kind: u8,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
    }

    struct CompleteInstanceCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        output_commitment: vector<u8>,
        receipt_commitment: vector<u8>,
    }

    struct SealPolicyCreatedV8 has copy, drop {
        config_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        threshold: u16,
        key_server_set_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct ProtectedAssetAppendedV8 has copy, drop {
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        sequence: u64,
        scope_kind: u8,
        seal_id: vector<u8>,
        rolling_commitment: vector<u8>,
    }

    struct SealRegistrySealedV8 has copy, drop {
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        total_count: u64,
        commitment: vector<u8>,
    }

    struct RuntimeProtectedAssetRegisteredV8 has copy, drop {
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        previous_revision: u64,
        new_revision: u64,
        scope_kind: u8,
        seal_id: vector<u8>,
        runtime_commitment: vector<u8>,
    }

    fun advance_scope_commitment(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: u64, arg5: vector<u8>, arg6: ProtectedAssetV8) : vector<u8> {
        assert_scope(arg3);
        assert!(arg6.scope_kind == arg3, 4);
        assert_hash(&arg5);
        assert_valid_row(&arg6);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::registry_advance_commitment_v2(arg0, arg3, arg4, arg5, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::registry_row_commitment_v2(arg0, arg1, arg2, arg3, arg4, 0x1::bcs::to_bytes<ProtectedAssetV8>(&arg6)))
    }

    public fun append_protected_asset_v8<T0>(arg0: &mut SealRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg3: &SealPolicyConfigV8, arg4: u64, arg5: CiphertextCertificationV8) : vector<u8> {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_registry_binding<T0>(arg0, arg1, arg3);
        assert!(!arg0.sealed, 9);
        assert!(arg4 == checked_total(arg0.base_count, arg0.pack_count, arg0.complete_count), 7);
        assert!(arg4 < checked_total(arg0.expected_base_count, arg0.expected_pack_count, arg0.expected_complete_count), 6);
        let v0 = consume_certification(arg5, arg0, arg3);
        assert_scope_count_available(arg0, v0.scope_kind);
        let v1 = ProtectedAssetKeyV8{
            scope_kind : v0.scope_kind,
            scope_key  : v0.scope_key,
            asset_key  : v0.asset_key,
        };
        assert!(!0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v1), 8);
        let v2 = if (v0.scope_kind == 0) {
            arg0.base_commitment
        } else if (v0.scope_kind == 1) {
            arg0.pack_commitment
        } else {
            arg0.complete_commitment
        };
        let v3 = advance_scope_commitment(0x2::object::id<SealRegistryV8>(arg0), arg0.root_id, arg0.maker_version, v0.scope_kind, arg4, v2, v0);
        let v4 = v0.seal_id;
        let v5 = v0.scope_kind;
        0x2::table::add<ProtectedAssetKeyV8, ProtectedAssetV8>(&mut arg0.assets, v1, v0);
        0x1::vector::push_back<ProtectedAssetKeyV8>(&mut arg0.keys, v1);
        if (v5 == 0) {
            arg0.base_count = arg0.base_count + 1;
            arg0.base_commitment = v3;
        } else if (v5 == 1) {
            arg0.pack_count = arg0.pack_count + 1;
            arg0.pack_commitment = v3;
        } else {
            arg0.complete_count = arg0.complete_count + 1;
            arg0.complete_commitment = v3;
        };
        refresh_registry_commitment(arg0);
        let v6 = ProtectedAssetAppendedV8{
            registry_id        : 0x2::object::id<SealRegistryV8>(arg0),
            root_id            : arg0.root_id,
            sequence           : arg4,
            scope_kind         : v5,
            seal_id            : v4,
            rolling_commitment : v3,
        };
        0x2::event::emit<ProtectedAssetAppendedV8>(v6);
        v4
    }

    fun approval_registry_valid<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>) : bool {
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg2);
        if (v0 != 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_draft_v8()) {
            let v2 = if (v0 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_active_v8()) {
                true
            } else if (v0 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_paused_v8()) {
                true
            } else {
                v0 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_archived_v8()
            };
            if (v2) {
                if (arg0.sealed) {
                    if (registry_binding_matches<T0>(arg0, arg2, arg1)) {
                        if (arg0.base_count == arg0.expected_base_count) {
                            if (arg0.pack_count >= arg0.expected_pack_count) {
                                if (arg0.complete_count >= arg0.expected_complete_count) {
                                    if (arg0.revision == arg0.runtime_revision) {
                                        arg0.commitment == derive_registry_commitment(0x2::object::id<SealRegistryV8>(arg0), arg0.root_id, arg0.maker_version, arg0.root_content_commitment, arg0.policy_config_id, arg0.base_count, arg0.pack_count, arg0.complete_count, arg0.base_commitment, arg0.pack_commitment, arg0.complete_commitment, arg0.revision, true)
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
                        }
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
        }
    }

    fun assert_catalog_root<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_product_release_catalog_v8<T0>(arg1, arg0);
    }

    fun assert_counts_exact(arg0: &SealRegistryV8) {
        assert!(arg0.base_count == arg0.expected_base_count, 6);
        assert!(arg0.pack_count == arg0.expected_pack_count, 6);
        assert!(arg0.complete_count == arg0.expected_complete_count, 6);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 2);
        let v0 = false;
        let v1 = 0;
        while (v1 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != 0) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 2);
    }

    fun assert_holder_and_proof_fields(arg0: address, arg1: &vector<u8>, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &vector<u8>) {
        assert!(arg0 != @0x0, 13);
        assert_hash(arg1);
        assert_hash(arg4);
        assert_semantic_key(arg2, 256);
        assert_semantic_key(arg3, 512);
    }

    fun assert_non_empty_bounded(arg0: &0x1::string::String, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 > 0 && v0 <= arg1, 5);
    }

    fun assert_policy_root<T0>(arg0: &SealPolicyConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>) {
        assert!(arg0.version == 8, 0);
        assert!(arg0.catalog_id == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_product_release_catalog_id_v8<T0>(arg1), 15);
        assert!(&arg0.product_binding_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_product_release_binding_commitment_v8<T0>(arg1), 1);
        assert!(&arg0.call_cap_set_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_product_release_call_cap_set_commitment_v8<T0>(arg1), 1);
    }

    fun assert_registry_binding<T0>(arg0: &SealRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &SealPolicyConfigV8) {
        assert!(registry_binding_matches<T0>(arg0, arg1, arg2), 1);
    }

    fun assert_role_witness<T0, T1, T2>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ExactPackageBindingV8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<T1>(arg1, &arg2, &arg3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<T2>(arg1, &arg2, &arg4);
    }

    fun assert_scope(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 4);
    }

    fun assert_scope_count_available(arg0: &SealRegistryV8, arg1: u8) {
        if (arg1 == 0) {
            assert!(arg0.base_count < arg0.expected_base_count, 6);
        } else if (arg1 == 1) {
            assert!(arg0.pack_count < arg0.expected_pack_count, 6);
        } else {
            assert!(arg0.complete_count < arg0.expected_complete_count, 6);
        };
    }

    fun assert_semantic_key(arg0: &0x1::string::String, arg1: u64) {
        assert_non_empty_bounded(arg0, arg1);
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            assert!(*0x1::vector::borrow<u8>(v0, v1) != 0, 5);
            v1 = v1 + 1;
        };
    }

    fun assert_valid_row(arg0: &ProtectedAssetV8) {
        assert_scope(arg0.scope_kind);
        assert_semantic_key(&arg0.scope_key, 256);
        assert_semantic_key(&arg0.asset_key, 512);
        assert_non_empty_bounded(&arg0.ciphertext_blob_id, 512);
        assert_hash(&arg0.scope_commitment);
        assert_hash(&arg0.asset_content_commitment);
        assert_hash(&arg0.ciphertext_sha256);
        assert_hash(&arg0.ciphertext_blob_commitment);
        assert_hash(&arg0.certification_commitment);
        assert_hash(&arg0.seal_id);
    }

    public fun asset_seal_id_v8(arg0: &SealRegistryV8, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String) : &vector<u8> {
        let v0 = ProtectedAssetKeyV8{
            scope_kind : arg1,
            scope_key  : arg2,
            asset_key  : arg3,
        };
        if (0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0)) {
            return &0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0).seal_id
        };
        &0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v0).seal_id
    }

    public fun bind_maker_seal_companion_v2<T0>(arg0: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg6: &SealPolicyConfigV8, arg7: &SealRegistryV8, arg8: &0x2::tx_context::TxContext) : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionBindingBuilderV2<T0> {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_companion_builder_root_v2<T0>(&arg0, arg1, arg2, arg8);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg3, arg4);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_replacement_current_v2(arg5, arg4);
        assert_catalog_root<T0>(arg4, arg1);
        assert_policy_root<T0>(arg6, arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_role_config_installation_v2(arg4, 1, 0x2::object::id<SealPolicyConfigV8>(arg6), &arg6.config_commitment);
        assert!(arg6.finalized, 0);
        assert_registry_binding<T0>(arg7, arg1, arg6);
        assert!(arg7.sealed, 10);
        assert_counts_exact(arg7);
        assert!(arg7.runtime_revision == 0 && 0x1::vector::is_empty<ProtectedAssetKeyV8>(&arg7.runtime_keys), 1);
        let v0 = MakerCompanionBindingWitnessV2{dummy_field: false};
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::append_seal_v2<T0, MakerCompanionBindingWitnessV2>(arg0, v0, arg3, arg4, arg5, 0x2::object::id<SealRegistryV8>(arg7), arg8)
    }

    public fun certify_base_entitlement_v8<T0, T1, T2>(arg0: T2, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: address, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>) : (T2, BaseDecryptProofV8) {
        assert_catalog_root<T0>(arg1, arg2);
        assert_role_witness<T0, T1, T2>(arg2, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg1), 2), b"runtime_v8", b"RuntimeOriginalMarkerV8", b"RuntimeBaseEntitlementWitnessV8");
        assert_holder_and_proof_fields(arg3, &arg5, &arg6, &arg7, &arg8);
        let v0 = BaseDecryptProofV8{
            root_id                 : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg2),
            maker_version           : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg2),
            root_content_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg2),
            holder                  : arg3,
            entitlement_id          : arg4,
            entitlement_commitment  : arg5,
            scope_key               : arg6,
            asset_key               : arg7,
            seal_id                 : arg8,
        };
        (arg0, v0)
    }

    public fun certify_ciphertext_v8<T0, T1, T2>(arg0: T2, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &SealPolicyConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: u8, arg6: 0x1::string::String, arg7: vector<u8>, arg8: 0x1::string::String, arg9: vector<u8>, arg10: 0x1::string::String, arg11: vector<u8>, arg12: vector<u8>) : (T2, CiphertextCertificationV8) {
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg4);
        assert!(v0 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_draft_v8() || v0 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_active_v8(), 14);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg4, arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg1, arg2);
        assert_role_witness<T0, T1, T2>(arg4, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg2), 6), b"release_v8", b"ReleaseOriginalMarkerV8", b"ReleaseTransportWitnessV8");
        assert_policy_root<T0>(arg3, arg4);
        assert_catalog_root<T0>(arg2, arg4);
        let v1 = arg3.catalog_id;
        let v2 = arg3.product_binding_commitment;
        let v3 = arg3.commitment;
        let v4 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg4);
        let v5 = *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg4);
        let v6 = CiphertextCertificationV8{
            catalog_id                 : v1,
            product_binding_commitment : v2,
            policy_config_id           : 0x2::object::id<SealPolicyConfigV8>(arg3),
            policy_commitment          : v3,
            root_id                    : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg4),
            maker_version              : v4,
            root_content_commitment    : v5,
            scope_kind                 : arg5,
            scope_key                  : arg6,
            scope_commitment           : arg7,
            asset_key                  : arg8,
            asset_content_commitment   : arg9,
            ciphertext_blob_id         : arg10,
            ciphertext_sha256          : arg11,
            ciphertext_blob_commitment : arg12,
            certification_commitment   : derive_ciphertext_certification_commitment_v8(v1, v2, v3, v5, v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12),
            seal_id                    : derive_seal_id_v8(v2, v3, v5, v4, arg5, arg6, arg8),
        };
        (arg0, v6)
    }

    public fun certify_complete_receipt_v8<T0, T1, T2>(arg0: T2, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: address, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: vector<u8>) : (T2, CompleteDecryptProofV8) {
        assert_catalog_root<T0>(arg1, arg2);
        assert_role_witness<T0, T1, T2>(arg2, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg1), 6), b"release_v8", b"ReleaseOriginalMarkerV8", b"ReleaseTransportWitnessV8");
        assert_holder_and_proof_fields(arg3, &arg9, &arg10, &arg11, &arg12);
        assert_hash(&arg6);
        assert_hash(&arg7);
        assert_hash(&arg8);
        let v0 = CompleteDecryptProofV8{
            root_id                 : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg2),
            maker_version           : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg2),
            root_content_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg2),
            holder                  : arg3,
            receipt_id              : arg4,
            output_id               : arg5,
            recipe_commitment       : arg6,
            render_commitment       : arg7,
            output_commitment       : arg8,
            receipt_commitment      : arg9,
            scope_key               : arg10,
            asset_key               : arg11,
            seal_id                 : arg12,
        };
        (arg0, v0)
    }

    public fun certify_pack_entitlement_v8<T0, T1, T2>(arg0: T2, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: address, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: 0x2::object::ID, arg7: vector<u8>, arg8: 0x2::object::ID, arg9: vector<u8>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: vector<u8>) : (T2, PackDecryptProofV8) {
        assert_catalog_root<T0>(arg1, arg2);
        assert_role_witness<T0, T1, T2>(arg2, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg1), 2), b"runtime_v8", b"RuntimeOriginalMarkerV8", b"RuntimePackEntitlementWitnessV8");
        assert_holder_and_proof_fields(arg3, &arg5, &arg10, &arg11, &arg12);
        assert_hash(&arg7);
        assert_hash(&arg9);
        let v0 = PackDecryptProofV8{
            root_id                     : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg2),
            maker_version               : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg2),
            root_content_commitment     : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg2),
            holder                      : arg3,
            base_entitlement_id         : arg4,
            base_entitlement_commitment : arg5,
            pack_entitlement_id         : arg6,
            pack_entitlement_commitment : arg7,
            pack_release_id             : arg8,
            pack_content_commitment     : arg9,
            scope_key                   : arg10,
            asset_key                   : arg11,
            seal_id                     : arg12,
        };
        (arg0, v0)
    }

    fun check_base_access<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &BaseDecryptProofV8, arg4: address, arg5: &vector<u8>) : bool {
        if (!approval_registry_valid<T0>(arg0, arg1, arg2)) {
            return false
        };
        if (!proof_root_matches<T0>(arg2, arg3.root_id, arg3.maker_version, &arg3.root_content_commitment)) {
            return false
        };
        let v0 = if (arg4 == @0x0) {
            true
        } else if (arg3.holder != arg4) {
            true
        } else {
            &arg3.seal_id != arg5
        };
        if (v0) {
            return false
        };
        if (0x1::vector::length<u8>(&arg3.entitlement_commitment) != 32) {
            return false
        };
        row_matches(arg0, 0, arg3.scope_key, arg3.asset_key, arg5, arg5, 0)
    }

    fun check_complete_access<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &CompleteDecryptProofV8, arg4: address, arg5: &vector<u8>) : bool {
        if (!approval_registry_valid<T0>(arg0, arg1, arg2)) {
            return false
        };
        if (!proof_root_matches<T0>(arg2, arg3.root_id, arg3.maker_version, &arg3.root_content_commitment)) {
            return false
        };
        let v0 = if (arg4 == @0x0) {
            true
        } else if (arg3.holder != arg4) {
            true
        } else {
            &arg3.seal_id != arg5
        };
        if (v0) {
            return false
        };
        let v1 = if (0x1::vector::length<u8>(&arg3.recipe_commitment) != 32) {
            true
        } else if (0x1::vector::length<u8>(&arg3.render_commitment) != 32) {
            true
        } else if (0x1::vector::length<u8>(&arg3.output_commitment) != 32) {
            true
        } else {
            0x1::vector::length<u8>(&arg3.receipt_commitment) != 32
        };
        if (v1) {
            return false
        };
        let v2 = complete_instance_commitment_v8(arg3.recipe_commitment, arg3.render_commitment, arg3.output_commitment, arg3.receipt_commitment);
        row_matches(arg0, 2, arg3.scope_key, arg3.asset_key, arg5, &v2, 3)
    }

    fun check_pack_access<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &PackDecryptProofV8, arg4: address, arg5: &vector<u8>) : bool {
        if (!approval_registry_valid<T0>(arg0, arg1, arg2)) {
            return false
        };
        if (!proof_root_matches<T0>(arg2, arg3.root_id, arg3.maker_version, &arg3.root_content_commitment)) {
            return false
        };
        let v0 = if (arg4 == @0x0) {
            true
        } else if (arg3.holder != arg4) {
            true
        } else {
            &arg3.seal_id != arg5
        };
        if (v0) {
            return false
        };
        let v1 = if (0x1::vector::length<u8>(&arg3.base_entitlement_commitment) != 32) {
            true
        } else if (0x1::vector::length<u8>(&arg3.pack_entitlement_commitment) != 32) {
            true
        } else {
            0x1::vector::length<u8>(&arg3.pack_content_commitment) != 32
        };
        if (v1) {
            return false
        };
        row_matches(arg0, 1, arg3.scope_key, arg3.asset_key, arg5, &arg3.pack_content_commitment, 1)
    }

    fun checked_total(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0, 6);
        let v1 = v0 + arg2;
        assert!(v1 >= v0, 6);
        v1
    }

    public fun complete_instance_commitment_v8(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        assert_hash(&arg0);
        assert_hash(&arg1);
        assert_hash(&arg2);
        assert_hash(&arg3);
        let v0 = CompleteInstanceCommitmentInputV2{
            domain             : 0x1::string::utf8(b"animacraft-fresh-v8/seal/complete-instance/v2"),
            schema_revision    : 2,
            recipe_commitment  : arg0,
            render_commitment  : arg1,
            output_commitment  : arg2,
            receipt_commitment : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<CompleteInstanceCommitmentInputV2>(&v0))
    }

    public fun consume_base_decrypt_proof_v8<T0>(arg0: vector<u8>, arg1: &SealRegistryV8, arg2: &SealPolicyConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: BaseDecryptProofV8, arg5: &0x2::tx_context::TxContext) {
        assert!(check_base_access<T0>(arg1, arg2, arg3, &arg4, 0x2::tx_context::sender(arg5), &arg0), 12);
        let BaseDecryptProofV8 {
            root_id                 : _,
            maker_version           : _,
            root_content_commitment : _,
            holder                  : _,
            entitlement_id          : _,
            entitlement_commitment  : _,
            scope_key               : _,
            asset_key               : _,
            seal_id                 : _,
        } = arg4;
    }

    fun consume_certification(arg0: CiphertextCertificationV8, arg1: &SealRegistryV8, arg2: &SealPolicyConfigV8) : ProtectedAssetV8 {
        let CiphertextCertificationV8 {
            catalog_id                 : v0,
            product_binding_commitment : v1,
            policy_config_id           : v2,
            policy_commitment          : v3,
            root_id                    : v4,
            maker_version              : v5,
            root_content_commitment    : v6,
            scope_kind                 : v7,
            scope_key                  : v8,
            scope_commitment           : v9,
            asset_key                  : v10,
            asset_content_commitment   : v11,
            ciphertext_blob_id         : v12,
            ciphertext_sha256          : v13,
            ciphertext_blob_commitment : v14,
            certification_commitment   : v15,
            seal_id                    : v16,
        } = arg0;
        assert!(v0 == arg1.catalog_id && v0 == arg2.catalog_id, 15);
        assert!(v1 == arg1.product_binding_commitment, 1);
        assert!(v2 == 0x2::object::id<SealPolicyConfigV8>(arg2) && v3 == arg2.commitment, 0);
        assert!(v4 == arg1.root_id && v5 == arg1.maker_version, 1);
        assert!(v6 == arg1.root_content_commitment, 1);
        assert!(v15 == derive_ciphertext_certification_commitment_v8(v0, v1, v3, v6, v5, v7, v8, v9, v10, v11, v12, v13, v14), 2);
        assert!(v16 == derive_seal_id_v8(v1, v3, v6, v5, v7, v8, v10), 2);
        ProtectedAssetV8{
            scope_kind                 : v7,
            scope_key                  : v8,
            scope_commitment           : v9,
            asset_key                  : v10,
            asset_content_commitment   : v11,
            ciphertext_blob_id         : v12,
            ciphertext_sha256          : v13,
            ciphertext_blob_commitment : v14,
            certification_commitment   : v15,
            seal_id                    : v16,
        }
    }

    public fun consume_complete_decrypt_proof_v8<T0>(arg0: vector<u8>, arg1: &SealRegistryV8, arg2: &SealPolicyConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: CompleteDecryptProofV8, arg5: &0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, vector<u8>, vector<u8>, vector<u8>, vector<u8>, 0x1::string::String, 0x1::string::String, vector<u8>) {
        assert!(check_complete_access<T0>(arg1, arg2, arg3, &arg4, 0x2::tx_context::sender(arg5), &arg0), 12);
        let CompleteDecryptProofV8 {
            root_id                 : _,
            maker_version           : _,
            root_content_commitment : _,
            holder                  : _,
            receipt_id              : v4,
            output_id               : v5,
            recipe_commitment       : v6,
            render_commitment       : v7,
            output_commitment       : v8,
            receipt_commitment      : v9,
            scope_key               : v10,
            asset_key               : v11,
            seal_id                 : v12,
        } = arg4;
        assert!(v12 == arg0, 13);
        (v4, v5, v6, v7, v8, v9, v10, v11, v12)
    }

    public fun consume_pack_decrypt_proof_v8<T0>(arg0: vector<u8>, arg1: &SealRegistryV8, arg2: &SealPolicyConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg4: PackDecryptProofV8, arg5: &0x2::tx_context::TxContext) {
        assert!(check_pack_access<T0>(arg1, arg2, arg3, &arg4, 0x2::tx_context::sender(arg5), &arg0), 12);
        let PackDecryptProofV8 {
            root_id                     : _,
            maker_version               : _,
            root_content_commitment     : _,
            holder                      : _,
            base_entitlement_id         : _,
            base_entitlement_commitment : _,
            pack_entitlement_id         : _,
            pack_entitlement_commitment : _,
            pack_release_id             : _,
            pack_content_commitment     : _,
            scope_key                   : _,
            asset_key                   : _,
            seal_id                     : _,
        } = arg4;
    }

    public fun derive_ciphertext_certification_commitment_v8(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u8, arg6: 0x1::string::String, arg7: vector<u8>, arg8: 0x1::string::String, arg9: vector<u8>, arg10: 0x1::string::String, arg11: vector<u8>, arg12: vector<u8>) : vector<u8> {
        assert_scope(arg5);
        assert_semantic_key(&arg6, 256);
        assert_semantic_key(&arg8, 512);
        assert_non_empty_bounded(&arg10, 512);
        assert_hash(&arg1);
        assert_hash(&arg2);
        assert_hash(&arg3);
        assert_hash(&arg7);
        assert_hash(&arg9);
        assert_hash(&arg11);
        assert_hash(&arg12);
        assert!(arg4 > 0, 1);
        let v0 = CiphertextCertificationCommitmentInputV2{
            domain                     : 0x1::string::utf8(b"animacraft-fresh-v8/seal/ciphertext-certification/v2"),
            schema_revision            : 2,
            catalog_id                 : arg0,
            product_binding_commitment : arg1,
            policy_commitment          : arg2,
            root_content_commitment    : arg3,
            maker_version              : arg4,
            scope_kind                 : arg5,
            scope_key                  : arg6,
            scope_commitment           : arg7,
            asset_key                  : arg8,
            asset_content_commitment   : arg9,
            ciphertext_blob_id         : arg10,
            ciphertext_sha256          : arg11,
            ciphertext_blob_commitment : arg12,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<CiphertextCertificationCommitmentInputV2>(&v0))
    }

    fun derive_encryption_policy_commitment(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64) : vector<u8> {
        let v0 = b"BonehFranklinBLS12381DemCCA/AesGcm256";
        let v1 = b"SHA3-256:SUI-SEAL-IBE-BLS12381-H2-00:SUI-SEAL-IBE-BLS12381-H3-00";
        let v2 = b"Seal/EncryptedObject/BCS/v0";
        let v3 = if (0x1::string::as_bytes(&arg0) == &v0) {
            if (0x1::string::as_bytes(&arg1) == &v1) {
                0x1::string::as_bytes(&arg2) == &v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 0);
        assert!(arg3 > 0 && arg3 <= 3145728, 0);
        let v4 = EncryptionPolicyCommitmentInputV2{
            domain              : 0x1::string::utf8(b"animacraft-fresh-v8/seal/encryption-policy/v2"),
            schema_revision     : 2,
            cipher_suite        : arg0,
            key_derivation      : arg1,
            ciphertext_format   : arg2,
            max_plaintext_bytes : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<EncryptionPolicyCommitmentInputV2>(&v4))
    }

    fun derive_key_server_set_commitment(arg0: vector<KeyServerRowV2>, arg1: u16) : vector<u8> {
        let v0 = KeyServerSetCommitmentInputV2{
            domain              : 0x1::string::utf8(b"animacraft-fresh-v8/seal/key-server-set/v2"),
            schema_revision     : 2,
            ordered_key_servers : arg0,
            threshold           : arg1,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<KeyServerSetCommitmentInputV2>(&v0))
    }

    fun derive_policy_commitment(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) : vector<u8> {
        assert_hash(&arg2);
        assert_hash(&arg3);
        assert_hash(&arg4);
        assert_hash(&arg5);
        let v0 = SealPolicyCommitmentInputV2{
            domain                       : 0x1::string::utf8(b"animacraft-fresh-v8/seal/policy/v2"),
            schema_revision              : 2,
            policy_id                    : arg0,
            catalog_id                   : arg1,
            package_tuple_commitment     : arg2,
            call_cap_set_commitment      : arg3,
            key_server_set_commitment    : arg4,
            encryption_policy_commitment : arg5,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SealPolicyCommitmentInputV2>(&v0))
    }

    fun derive_registry_commitment(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: bool) : vector<u8> {
        assert_hash(&arg3);
        assert_hash(&arg8);
        assert_hash(&arg9);
        assert_hash(&arg10);
        let v0 = SealRegistryCommitmentInputV2{
            domain                  : 0x1::string::utf8(b"animacraft-fresh-v8/seal/registry/v2"),
            schema_revision         : 2,
            registry_id             : arg0,
            root_id                 : arg1,
            maker_version           : arg2,
            root_content_commitment : arg3,
            policy_id               : arg4,
            base_count              : arg5,
            pack_count              : arg6,
            complete_count          : arg7,
            base_commitment         : arg8,
            pack_commitment         : arg9,
            complete_commitment     : arg10,
            revision                : arg11,
            sealed                  : arg12,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SealRegistryCommitmentInputV2>(&v0))
    }

    public fun derive_seal_id_v8(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String) : vector<u8> {
        assert_scope(arg4);
        assert_semantic_key(&arg5, 256);
        assert_semantic_key(&arg6, 512);
        assert_hash(&arg0);
        assert_hash(&arg1);
        assert_hash(&arg2);
        let v0 = SealIdInputV2{
            domain                     : 0x1::string::utf8(b"animacraft-fresh-v8/seal/ciphertext-id/v2"),
            schema_revision            : 2,
            product_binding_commitment : arg0,
            policy_commitment          : arg1,
            root_content_commitment    : arg2,
            maker_version              : arg3,
            scope_kind                 : arg4,
            scope_key                  : arg5,
            asset_key                  : arg6,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SealIdInputV2>(&v0))
    }

    fun lexicographically_less(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(arg0) == 0x1::vector::length<u8>(arg1), 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(arg0, v0) > *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun new_seal_policy_config_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::PackageCallCapV8<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::SealRoleV8>, arg4: vector<0x2::object::ID>, arg5: vector<u16>, arg6: u16, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : SealPolicyConfigV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_protocol_admin_v8(arg0, arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg0, arg2);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg2);
        let v1 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(v0, 1);
        let v2 = b"seal_v8";
        let v3 = b"SealSetupInstallWitnessV2";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<SealSetupInstallWitnessV2>(v1, &v2, &v3);
        let v4 = validate_key_servers(arg4, arg5, arg6);
        let v5 = derive_key_server_set_commitment(v4, arg6);
        let v6 = derive_encryption_policy_commitment(arg7, arg8, arg9, arg10);
        let v7 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg2);
        let v8 = *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(v0);
        let (v9, v10, _, _, _, v14) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::exact_binding_terms_v2(v1);
        let (_, _, _, _, v19, _) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_terms_v2(arg2);
        let v21 = *v19;
        let v22 = 0x2::object::new(arg11);
        let v23 = 0x2::object::uid_to_inner(&v22);
        let v24 = derive_policy_commitment(v23, v7, v8, v21, v5, v6);
        let v25 = SealSetupInstallWitnessV2{dummy_field: false};
        let v26 = SealPolicyConfigV8{
            id                           : v22,
            version                      : 8,
            protocol_config_id           : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_id_v8(arg0),
            protocol_config_revision     : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_revision_v8(arg0),
            catalog_id                   : v7,
            product_binding_commitment   : v8,
            seal_original_package_id     : v9,
            seal_callable_package_id     : v10,
            seal_binding_commitment      : *v14,
            seal_authority_id            : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_authority_id_v2(arg2, 0),
            call_cap_set_commitment      : v21,
            role                         : 1,
            finalized                    : true,
            key_servers                  : v4,
            threshold                    : arg6,
            cipher_suite                 : arg7,
            key_derivation               : arg8,
            ciphertext_format            : arg9,
            max_plaintext_bytes          : arg10,
            key_server_set_commitment    : v5,
            encryption_policy_commitment : v6,
            commitment                   : v24,
            config_commitment            : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::consume_seal_call_cap_v8<SealSetupInstallWitnessV2>(arg2, arg3, v25, v23, v24, v5, v6),
        };
        let v27 = SealPolicyCreatedV8{
            config_id                 : 0x2::object::id<SealPolicyConfigV8>(&v26),
            catalog_id                : v7,
            threshold                 : arg6,
            key_server_set_commitment : v5,
            commitment                : v24,
        };
        0x2::event::emit<SealPolicyCreatedV8>(v27);
        v26
    }

    public fun new_seal_registry_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &SealPolicyConfigV8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : SealRegistryV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_admin_v8<T0>(arg0, arg1);
        assert_policy_root<T0>(arg2, arg0);
        assert!(checked_total(arg3, arg4, arg5) <= 100000, 6);
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0);
        let v3 = *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0);
        let v4 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0);
        let v5 = 0x2::object::id<SealPolicyConfigV8>(arg2);
        let v6 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::registry_empty_commitment_v2(v1, v2, v4, 0);
        let v7 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::registry_empty_commitment_v2(v1, v2, v4, 1);
        let v8 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::registry_empty_commitment_v2(v1, v2, v4, 2);
        SealRegistryV8{
            id                         : v0,
            version                    : 8,
            root_id                    : v2,
            maker_version              : v4,
            root_content_commitment    : v3,
            catalog_id                 : arg2.catalog_id,
            product_binding_commitment : arg2.product_binding_commitment,
            policy_config_id           : v5,
            policy_commitment          : arg2.commitment,
            expected_base_count        : arg3,
            expected_pack_count        : arg4,
            expected_complete_count    : arg5,
            base_count                 : 0,
            pack_count                 : 0,
            complete_count             : 0,
            base_commitment            : v6,
            pack_commitment            : v7,
            complete_commitment        : v8,
            revision                   : 0,
            commitment                 : derive_registry_commitment(v1, v2, v4, v3, v5, 0, 0, 0, v6, v7, v8, 0, false),
            sealed                     : false,
            keys                       : 0x1::vector::empty<ProtectedAssetKeyV8>(),
            assets                     : 0x2::table::new<ProtectedAssetKeyV8, ProtectedAssetV8>(arg6),
            runtime_revision           : 0,
            runtime_keys               : 0x1::vector::empty<ProtectedAssetKeyV8>(),
            runtime_assets             : 0x2::table::new<ProtectedAssetKeyV8, ProtectedAssetV8>(arg6),
        }
    }

    public fun policy_call_cap_set_commitment_v8(arg0: &SealPolicyConfigV8) : &vector<u8> {
        &arg0.call_cap_set_commitment
    }

    public fun policy_catalog_id_v8(arg0: &SealPolicyConfigV8) : 0x2::object::ID {
        arg0.catalog_id
    }

    public fun policy_commitment_v8(arg0: &SealPolicyConfigV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun policy_encryption_commitment_v8(arg0: &SealPolicyConfigV8) : &vector<u8> {
        &arg0.encryption_policy_commitment
    }

    public fun policy_id_v8(arg0: &SealPolicyConfigV8) : 0x2::object::ID {
        0x2::object::id<SealPolicyConfigV8>(arg0)
    }

    public fun policy_key_server_count_v8(arg0: &SealPolicyConfigV8) : u64 {
        0x1::vector::length<KeyServerRowV2>(&arg0.key_servers)
    }

    public fun policy_key_server_id_v8(arg0: &SealPolicyConfigV8, arg1: u64) : 0x2::object::ID {
        0x1::vector::borrow<KeyServerRowV2>(&arg0.key_servers, arg1).key_server_id
    }

    public fun policy_key_server_set_commitment_v8(arg0: &SealPolicyConfigV8) : &vector<u8> {
        &arg0.key_server_set_commitment
    }

    public fun policy_key_server_weight_v8(arg0: &SealPolicyConfigV8, arg1: u64) : u16 {
        0x1::vector::borrow<KeyServerRowV2>(&arg0.key_servers, arg1).weight
    }

    public fun policy_seal_authority_id_v8(arg0: &SealPolicyConfigV8) : 0x2::object::ID {
        arg0.seal_authority_id
    }

    public fun policy_threshold_v8(arg0: &SealPolicyConfigV8) : u16 {
        arg0.threshold
    }

    fun proof_root_matches<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &vector<u8>) : bool {
        if (arg1 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0)) {
            if (arg2 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0)) {
                arg3 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun protected_asset_snapshot_v8<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: u8, arg4: 0x1::string::String, arg5: vector<u8>, arg6: 0x1::string::String, arg7: vector<u8>, arg8: 0x1::string::String, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>) : ProtectedAssetSnapshotV8 {
        assert_registry_binding<T0>(arg0, arg2, arg1);
        assert!(arg0.sealed, 10);
        let v0 = ProtectedAssetKeyV8{
            scope_kind : arg3,
            scope_key  : arg4,
            asset_key  : arg6,
        };
        let v1 = if (0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0)) {
            0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0)
        } else {
            assert!(0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v0), 11);
            0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v0)
        };
        assert!(v1.scope_commitment == arg5, 2);
        assert!(v1.asset_content_commitment == arg7, 2);
        assert!(v1.ciphertext_blob_id == arg8, 2);
        assert!(v1.ciphertext_sha256 == arg9, 2);
        assert!(v1.ciphertext_blob_commitment == arg10, 2);
        assert!(v1.certification_commitment == arg11, 2);
        assert!(v1.seal_id == arg12, 2);
        assert!(arg12 == derive_seal_id_v8(arg0.product_binding_commitment, arg0.policy_commitment, arg0.root_content_commitment, arg0.maker_version, v1.scope_kind, v1.scope_key, v1.asset_key), 2);
        ProtectedAssetSnapshotV8{
            registry_id                : 0x2::object::id<SealRegistryV8>(arg0),
            registry_commitment        : arg0.commitment,
            runtime_revision           : arg0.runtime_revision,
            runtime_commitment         : arg0.commitment,
            policy_config_id           : 0x2::object::id<SealPolicyConfigV8>(arg1),
            policy_commitment          : arg1.commitment,
            root_id                    : arg0.root_id,
            maker_version              : arg0.maker_version,
            root_content_commitment    : arg0.root_content_commitment,
            scope_kind                 : v1.scope_kind,
            scope_key                  : v1.scope_key,
            scope_commitment           : v1.scope_commitment,
            asset_key                  : v1.asset_key,
            asset_content_commitment   : v1.asset_content_commitment,
            ciphertext_blob_id         : v1.ciphertext_blob_id,
            ciphertext_sha256          : v1.ciphertext_sha256,
            ciphertext_blob_commitment : v1.ciphertext_blob_commitment,
            certification_commitment   : v1.certification_commitment,
            seal_id                    : v1.seal_id,
        }
    }

    fun protected_row_matches(arg0: &ProtectedAssetV8, arg1: &SealRegistryV8, arg2: &vector<u8>, arg3: &vector<u8>, arg4: u8) : bool {
        if (&arg0.seal_id != arg2) {
            return false
        };
        if (arg4 == 1 && &arg0.scope_commitment != arg3) {
            return false
        };
        if (arg4 == 2 && &arg0.asset_content_commitment != arg3) {
            return false
        };
        if (arg4 == 3 && &arg0.scope_commitment != arg3) {
            return false
        };
        arg0.seal_id == derive_seal_id_v8(arg1.product_binding_commitment, arg1.policy_commitment, arg1.root_content_commitment, arg1.maker_version, arg0.scope_kind, arg0.scope_key, arg0.asset_key)
    }

    fun refresh_registry_commitment(arg0: &mut SealRegistryV8) {
        arg0.commitment = derive_registry_commitment(0x2::object::id<SealRegistryV8>(arg0), arg0.root_id, arg0.maker_version, arg0.root_content_commitment, arg0.policy_config_id, arg0.base_count, arg0.pack_count, arg0.complete_count, arg0.base_commitment, arg0.pack_commitment, arg0.complete_commitment, arg0.revision, arg0.sealed);
    }

    public fun register_complete_ciphertext_v8<T0, T1, T2>(arg0: T2, arg1: &mut SealRegistryV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &SealPolicyConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: u64, arg6: CiphertextCertificationV8) : (T2, vector<u8>) {
        assert_catalog_root<T0>(arg4, arg2);
        assert_role_witness<T0, T1, T2>(arg2, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg4), 6), b"release_v8", b"ReleaseOriginalMarkerV8", b"ReleaseTransportWitnessV8");
        (arg0, register_runtime_asset<T0>(arg1, arg2, arg3, arg5, arg6, 2))
    }

    public fun register_pack_ciphertext_v8<T0, T1, T2>(arg0: T2, arg1: &mut SealRegistryV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &SealPolicyConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: u64, arg6: CiphertextCertificationV8) : (T2, vector<u8>) {
        assert_catalog_root<T0>(arg4, arg2);
        assert_role_witness<T0, T1, T2>(arg2, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg4), 2), b"runtime_v8", b"RuntimeOriginalMarkerV8", b"RuntimePackRegistrationWitnessV8");
        (arg0, register_runtime_asset<T0>(arg1, arg2, arg3, arg5, arg6, 1))
    }

    fun register_runtime_asset<T0>(arg0: &mut SealRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &SealPolicyConfigV8, arg3: u64, arg4: CiphertextCertificationV8, arg5: u8) : vector<u8> {
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg1) == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_active_v8(), 14);
        assert_registry_binding<T0>(arg0, arg1, arg2);
        assert!(arg0.sealed, 10);
        assert!(arg0.runtime_revision == arg3, 7);
        let v0 = consume_certification(arg4, arg0, arg2);
        assert!(v0.scope_kind == arg5, 4);
        let v1 = ProtectedAssetKeyV8{
            scope_kind : v0.scope_kind,
            scope_key  : v0.scope_key,
            asset_key  : v0.asset_key,
        };
        assert!(!0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v1) && !0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v1), 8);
        let v2 = v0.scope_kind;
        let v3 = if (v2 == 0) {
            arg0.base_commitment
        } else if (v2 == 1) {
            arg0.pack_commitment
        } else {
            arg0.complete_commitment
        };
        let v4 = v0.seal_id;
        0x2::table::add<ProtectedAssetKeyV8, ProtectedAssetV8>(&mut arg0.runtime_assets, v1, v0);
        0x1::vector::push_back<ProtectedAssetKeyV8>(&mut arg0.runtime_keys, v1);
        arg0.runtime_revision = arg3 + 1;
        arg0.revision = arg0.runtime_revision;
        if (v2 == 0) {
            arg0.base_count = arg0.base_count + 1;
            arg0.base_commitment = advance_scope_commitment(0x2::object::id<SealRegistryV8>(arg0), arg0.root_id, arg0.maker_version, v2, checked_total(arg0.base_count, arg0.pack_count, arg0.complete_count), v3, v0);
        } else if (v2 == 1) {
            arg0.pack_count = arg0.pack_count + 1;
            arg0.pack_commitment = advance_scope_commitment(0x2::object::id<SealRegistryV8>(arg0), arg0.root_id, arg0.maker_version, v2, checked_total(arg0.base_count, arg0.pack_count, arg0.complete_count), v3, v0);
        } else {
            arg0.complete_count = arg0.complete_count + 1;
            arg0.complete_commitment = advance_scope_commitment(0x2::object::id<SealRegistryV8>(arg0), arg0.root_id, arg0.maker_version, v2, checked_total(arg0.base_count, arg0.pack_count, arg0.complete_count), v3, v0);
        };
        refresh_registry_commitment(arg0);
        let v5 = RuntimeProtectedAssetRegisteredV8{
            registry_id        : 0x2::object::id<SealRegistryV8>(arg0),
            root_id            : arg0.root_id,
            previous_revision  : arg3,
            new_revision       : arg3 + 1,
            scope_kind         : v2,
            seal_id            : v4,
            runtime_commitment : arg0.commitment,
        };
        0x2::event::emit<RuntimeProtectedAssetRegisteredV8>(v5);
        v4
    }

    fun registry_binding_matches<T0>(arg0: &SealRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &SealPolicyConfigV8) : bool {
        if (arg0.version == 8) {
            if (arg0.root_id == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg1)) {
                if (arg0.maker_version == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg1)) {
                    if (&arg0.root_content_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg1)) {
                        if (arg0.catalog_id == arg2.catalog_id) {
                            if (arg0.product_binding_commitment == arg2.product_binding_commitment) {
                                if (arg0.policy_config_id == 0x2::object::id<SealPolicyConfigV8>(arg2)) {
                                    arg0.policy_commitment == arg2.commitment
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
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun registry_commitment_v8(arg0: &SealRegistryV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun registry_expected_count_v8(arg0: &SealRegistryV8) : u64 {
        checked_total(arg0.expected_base_count, arg0.expected_pack_count, arg0.expected_complete_count)
    }

    public fun registry_id_v8(arg0: &SealRegistryV8) : 0x2::object::ID {
        0x2::object::id<SealRegistryV8>(arg0)
    }

    public fun registry_observed_count_v8(arg0: &SealRegistryV8) : u64 {
        checked_total(arg0.base_count, arg0.pack_count, arg0.complete_count)
    }

    public fun registry_policy_config_id_v8(arg0: &SealRegistryV8) : 0x2::object::ID {
        arg0.policy_config_id
    }

    public fun registry_root_id_v8(arg0: &SealRegistryV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun registry_runtime_revision_v8(arg0: &SealRegistryV8) : u64 {
        arg0.runtime_revision
    }

    public fun registry_sealed_v8(arg0: &SealRegistryV8) : bool {
        arg0.sealed
    }

    fun row_matches(arg0: &SealRegistryV8, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &vector<u8>, arg5: &vector<u8>, arg6: u8) : bool {
        let v0 = ProtectedAssetKeyV8{
            scope_kind : arg1,
            scope_key  : arg2,
            asset_key  : arg3,
        };
        if (0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0)) {
            return protected_row_matches(0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0), arg0, arg4, arg5, arg6)
        };
        if (!0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v0)) {
            return false
        };
        protected_row_matches(0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v0), arg0, arg4, arg5, arg6)
    }

    public fun scope_base_v8() : u8 {
        0
    }

    public fun scope_complete_v8() : u8 {
        2
    }

    public fun scope_pack_v8() : u8 {
        1
    }

    public fun seal_registry_v8<T0>(arg0: &mut SealRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg3: &SealPolicyConfigV8) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_registry_binding<T0>(arg0, arg1, arg3);
        assert!(!arg0.sealed, 9);
        assert_counts_exact(arg0);
        arg0.sealed = true;
        refresh_registry_commitment(arg0);
        let v0 = SealRegistrySealedV8{
            registry_id : 0x2::object::id<SealRegistryV8>(arg0),
            root_id     : arg0.root_id,
            total_count : checked_total(arg0.base_count, arg0.pack_count, arg0.complete_count),
            commitment  : arg0.commitment,
        };
        0x2::event::emit<SealRegistrySealedV8>(v0);
    }

    public fun share_seal_policy_config_v8(arg0: SealPolicyConfigV8) {
        0x2::transfer::share_object<SealPolicyConfigV8>(arg0);
    }

    public fun share_seal_registry_v8(arg0: SealRegistryV8) {
        0x2::transfer::share_object<SealRegistryV8>(arg0);
    }

    public fun snapshot_asset_content_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.asset_content_commitment
    }

    public fun snapshot_asset_key_v8(arg0: &ProtectedAssetSnapshotV8) : &0x1::string::String {
        &arg0.asset_key
    }

    public fun snapshot_certification_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.certification_commitment
    }

    public fun snapshot_ciphertext_blob_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.ciphertext_blob_commitment
    }

    public fun snapshot_ciphertext_blob_id_v8(arg0: &ProtectedAssetSnapshotV8) : &0x1::string::String {
        &arg0.ciphertext_blob_id
    }

    public fun snapshot_ciphertext_sha256_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.ciphertext_sha256
    }

    public fun snapshot_maker_version_v8(arg0: &ProtectedAssetSnapshotV8) : u64 {
        arg0.maker_version
    }

    public fun snapshot_policy_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.policy_commitment
    }

    public fun snapshot_policy_config_id_v8(arg0: &ProtectedAssetSnapshotV8) : 0x2::object::ID {
        arg0.policy_config_id
    }

    public fun snapshot_registry_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.registry_commitment
    }

    public fun snapshot_registry_id_v8(arg0: &ProtectedAssetSnapshotV8) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun snapshot_root_content_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun snapshot_root_id_v8(arg0: &ProtectedAssetSnapshotV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun snapshot_runtime_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.runtime_commitment
    }

    public fun snapshot_runtime_revision_v8(arg0: &ProtectedAssetSnapshotV8) : u64 {
        arg0.runtime_revision
    }

    public fun snapshot_scope_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.scope_commitment
    }

    public fun snapshot_scope_key_v8(arg0: &ProtectedAssetSnapshotV8) : &0x1::string::String {
        &arg0.scope_key
    }

    public fun snapshot_scope_kind_v8(arg0: &ProtectedAssetSnapshotV8) : u8 {
        arg0.scope_kind
    }

    public fun snapshot_seal_id_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.seal_id
    }

    fun validate_key_servers(arg0: vector<0x2::object::ID>, arg1: vector<u16>, arg2: u16) : vector<KeyServerRowV2> {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg0);
        let v1 = if (v0 > 0) {
            if (v0 <= 64) {
                v0 == 0x1::vector::length<u16>(&arg1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        let v2 = 0x1::vector::empty<KeyServerRowV2>();
        let v3 = 0;
        let v4 = 0;
        let v5 = b"";
        while (v4 < v0) {
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&arg0, v4);
            let v7 = *0x1::vector::borrow<u16>(&arg1, v4);
            v5 = 0x2::object::id_to_bytes(&v6);
            assert!(0x2::object::id_to_address(&v6) != @0x0 && v7 > 0, 3);
            if (v4 > 0) {
                assert!(lexicographically_less(&v5, &v5), 3);
            };
            v3 = v3 + (v7 as u64);
            let v8 = KeyServerRowV2{
                key_server_id : v6,
                weight        : v7,
            };
            0x1::vector::push_back<KeyServerRowV2>(&mut v2, v8);
            v4 = v4 + 1;
        };
        let v9 = if (v3 <= 254) {
            if (arg2 > 0) {
                (arg2 as u64) <= v3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v9, 3);
        v2
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

